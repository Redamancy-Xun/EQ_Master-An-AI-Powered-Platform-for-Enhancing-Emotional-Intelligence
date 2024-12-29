package fun.redamancyxun.eqmaster.backend.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import fun.redamancyxun.eqmaster.backend.common.Page;
//import fun.redamancyxun.eqmaster.backend.controller.express.response.ExpressOrderInfo;
import fun.redamancyxun.eqmaster.backend.controller.dailyshare.response.*;
import fun.redamancyxun.eqmaster.backend.entity.Notice;
import fun.redamancyxun.eqmaster.backend.entity.User;
import fun.redamancyxun.eqmaster.backend.exception.EnumExceptionType;
import fun.redamancyxun.eqmaster.backend.exception.MyException;
import fun.redamancyxun.eqmaster.backend.mapper.NoticeMapper;
import fun.redamancyxun.eqmaster.backend.mapper.UserMapper;
import fun.redamancyxun.eqmaster.backend.service.*;
import fun.redamancyxun.eqmaster.backend.util.RedisUtils;
import fun.redamancyxun.eqmaster.backend.util.SessionUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.*;

/**
 * @author Redamancy
 * @description 针对表【notice（消息）】的服务接口实现
 * @createDate 2024-04-03 22:39:04
 */
@Service
public class NoticeServiceImpl implements NoticeService {

    @Autowired
    private NoticeMapper noticeMapper;

    @Autowired
    private UserService userService;

    @Autowired
    private DailyShareService dailyShareService;

    @Autowired
    private CommentService commentService;

    @Autowired
    private ReplyService replyService;

//    @Autowired
//    private ExpressOrderService expressOrderService;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private SessionUtils sessionUtils;

    @Autowired
    private RedisUtils redisUtils;

    /**
     * 获取redis的key
     * @param receiverId 接收者id
     * @param type 类型
     * @return key
     */
    private String getKey(String receiverId, Integer type) {
        return receiverId + ":" + type ;
    }

    /**
     * 手动给全体成员发送系统消息
     * @param message 消息内容
     * @return 是否发送成功
     */
    @Override
    public Boolean SysSend(String message) {
        return SysSend(null, null, 0, message, null);
    }

    /**
     * 手动给某一个用户发送系统消息
     * @param message 消息内容
     * @param receiverId 接收者id
     * @return 是否发送成功
     */
    @Override
    public Boolean SysSend(String message, String receiverId) {
        return SysSend(null, receiverId, 0, message, null);
    }

    /**
     * 发送消息
     * @param: objectId: 对象id
     * @param: receiverId: 接收者id
     * @param: type: 类型
     * @param: message: 消息内容
     * @param: senderId: 发送者id
     * type: （0:系统(可以细分，或者就直接只给文字信息) 1:  2:给每日分享的评论点赞 3:给每日分享评论的回复点赞  4:  5:给每日分享的评论回复 6:给每日分享评论的回复回复 7:  8:  9: ）
     * @return: 是否发送成功
     */
    @Transactional(rollbackFor = MyException.class)
    @Override
    public Boolean SysSend(Object objectId, String receiverId, Integer type, String message, String senderId) {
        if (type < 0 || type > 9) {
            throw new MyException(EnumExceptionType.PARAMETER_ERROR);
        }
        if (receiverId != null && userService.getUserById(receiverId) == null) {
            throw new MyException(EnumExceptionType.USER_NOT_EXIST);
        }
        // 如果是给自己发点赞、评论、回复、收藏消息，就不发了
        if (Objects.equals(receiverId, senderId) && type >= 2 && type <= 6) {
            return false;
        }

        // 如果是点赞消息，且之前已经发过了，就不发了
        if (type >= 2 && type <= 3) {
            QueryWrapper<Notice> wrapper = new QueryWrapper<>();
            wrapper.eq("object_id", objectId)
                    .eq("type", type)
                    .eq("sender_id", senderId)
                    .eq("receiver_id", receiverId)
                    .isNull("delete_time");
            if (noticeMapper.selectCount(wrapper) > 0) {
                return false;
            }
        }

        if (receiverId == null) {
            List<String> ids = userMapper.selectAllUserId();
            for (String id : ids) {
                createAndSendNotice(objectId, message, id, type, senderId);
            }
        } else {
            //否则就给指定人发
            createAndSendNotice(objectId, message, receiverId, type, senderId);
        }

        return true;
    }

    /**
     * 创建并发送消息
     * @param objectId 对象id
     * @param message 消息内容
     * @param receiverId 接收者id
     * @param type 类型
     * @param senderId 发送者id
     */
    @Transactional(rollbackFor = MyException.class)
    public void createAndSendNotice(Object objectId, String message, String receiverId, Integer type, String senderId) {

        Notice notice = Notice.builder()
                .createTime(LocalDateTime.now())
                .deleteTime(null)
                .receiverId(receiverId)
                .type(type)
                .senderId(senderId)
                .content(message)
                .isRead(0)
                .build();

        if (objectId == null) {
            notice.setObjectId(null);
        } else {
            notice.setObjectId(objectId.toString());
        }

        noticeMapper.insert(notice);

        // 特定类型的消息未读消息数 + 1
        String key = getKey(receiverId, type);
        if (redisUtils.get(key) == null) {
            if (!redisUtils.set(key, 1)){
                throw new MyException(EnumExceptionType.REDIS_ERROR);
            }
        } else {
            redisUtils.incr(key, 1);
        }
    }

    /**
     * 获取未读消息数
     * @return 未读消息数
     * @throws MyException 通用异常
     */
    @Override
    public Map<String, Integer> hasUnread() throws MyException {

        int total = 0;
        Map<Integer, Integer> map = new HashMap<>();
        String userId = sessionUtils.getUserId();

        // 遍历所有类型的消息
        for (int x = 0; x < 7; x++) {
            String key = getKey(userId, x);
            Object obj = redisUtils.get(key);
            if (obj == null) {
                map.put(x, 0);
            } else {
                int num = (Integer) obj;
                map.put(x, num);
                total += num;
            }
        }
        map.put(-1, total);

        Map<String, Integer> result = new HashMap<>();
        result.put("total", total);
        result.put("system", map.get(0));
        result.put("like", map.get(3) + map.get(5));
        result.put("reply", map.get(2) + map.get(6));
//        result.put("star", map.get(7));
//        result.put("order", map.get(8));
//        result.put("carpool", map.get(9));

        return result;
    }

    /**
     * 获取消息列表内容
     * @param type 消息类型(0为点赞 1为评论 2为系统信息)
     * @param page 页码
     * @param pageSize 每页大小
     * @return 消息详情
     */
    @Override
    public Map<String, Object> getNoticesInfo(Integer type, Integer page, Integer pageSize) {

        Map<String, Object> result = new HashMap<>();

        // 未读信息统计
        Map<String, Integer> unread = hasUnread();
        result.put("unread", unread);

        // 获得消息列表
        if (type < 0 || type > 2) {
            throw new MyException(EnumExceptionType.PARAMETER_ERROR);
        }
        if (page == null || page < 1) {
            page = 1;
        }
        if (pageSize == null || pageSize < 1) {
            pageSize = 10;
        }

        String userId = sessionUtils.getUserId();
        QueryWrapper<Notice> noticeQueryWrapper = new QueryWrapper<>();
        noticeQueryWrapper.eq("receiver_id", userId);
        noticeQueryWrapper.isNull("delete_time");

        // 根据消息类型筛选并且删除redis中的未读消息数
        if (type == 0) {
            for (int i = 2; i <= 3; i++) {
                String key = getKey(userId, i);
                if (redisUtils.get(key) != null) {
                    redisUtils.del(key);
                }
            }
            noticeQueryWrapper.in("type", 2, 3);
        } else if (type == 1) {
            for (int i = 5; i <= 6; i++) {
                String key = getKey(userId, i);
                if (redisUtils.get(key) != null) {
                    redisUtils.del(key);
                }
            }
            noticeQueryWrapper.in("type", 5, 6);
        } else {
            String key = getKey(userId, 0);
            if (redisUtils.get(key) != null) {
                redisUtils.del(key);
            }
            noticeQueryWrapper.eq("type", 0);
        }
//        else if (type == 2) {
//            String key = getKey(userId, 7);
//            if (redisUtils.get(key) != null) {
//                redisUtils.del(key);
//            }
//            noticeQueryWrapper.eq("type", 7);
//        }
//        else if (type == 3) {
//            String key = getKey(userId, 8);
//            if (redisUtils.get(key) != null) {
//                redisUtils.del(key);
//            }
//            noticeQueryWrapper.eq("type", 8);
//        } else {
//            String key = getKey(userId, 9);
//            if (redisUtils.get(key) != null) {
//                redisUtils.del(key);
//            }
//            noticeQueryWrapper.eq("type", 9);
//        }

        noticeQueryWrapper.orderByDesc("create_time");
        PageHelper.startPage(page, pageSize);
        List<Notice> notices = new Page<>(new PageInfo<>(noticeMapper.selectList(noticeQueryWrapper))).getItems();
        List<NoticeInfo> noticeInfos = new ArrayList<>();

        // 获取消息的发送者和对象
        for (Notice notice : notices) {
            // 获取发送者
            if (notice.getSenderId() == null) {
                noticeInfos.add(new NoticeInfo(notice));
                continue;
            }
            User user = userService.getUserById(notice.getSenderId());
            Object object = null;
            // 获取对象
            if (notice.getObjectId() != null) {
//                if (notice.getType() == 1 || notice.getType() == 4) {
//                    // 点赞、回复、收藏帖子
//                    object = dailyShareService.getDailyShareById(notice.getObjectId());
                if (notice.getType() == 2 || notice.getType() == 5) {
                    // 点赞、回复评论
                    CommentInfo commentInfo = commentService.getCommentById(Integer.valueOf(notice.getObjectId()));
                    DailyShareInfo dailyShareInfo = dailyShareService.getDailyShareById(commentInfo.getDailyShareId());
                    List<Object> list = new ArrayList<>();
                    list.add(dailyShareInfo);
                    list.add(commentInfo);
                    object = list;
                } else if (notice.getType() == 3 || notice.getType() == 6) {
                    // 点赞、回复回复
                    List<Object> list = new ArrayList<>();
                    ReplyInfo replyInfo = replyService.getReplyById(Integer.valueOf(notice.getObjectId()));
                    DailyShareInfo dailyShareInfo = dailyShareService.getDailyShareById(replyInfo.getDailyShareId());
                    if (replyInfo.getType() == 0) {
                        CommentInfo commentInfo = commentService.getCommentById(replyInfo.getCommentId());
                        list.add(commentInfo);
                    } else {
                        ReplyInfo replyInfo2 = replyService.getReplyById(replyInfo.getReplyId());
                        list.add(replyInfo2);
                    }
                    list.add(dailyShareInfo);
                    object = list;
                }
//                else if (notice.getType() == 8) {
//                    // 订单消息
//                    object = expressOrderService.getOrderById(notice.getObjectId());
//                } else if (notice.getType() == 9) {
////                    // 拼车消息
////                    object = carpoolService.getCarpoolById(notice.getObjectId());
//                }
            }
            noticeInfos.add(new NoticeInfo(notice, user, object));

            // 设置消息已读
            notice.setIsRead(1);
            noticeMapper.updateById(notice);
        }

        result.put("notices", noticeInfos);

        return result;
    }

    /**
     * 删除消息
     * @param noticeId 消息id
     * @throws MyException 通用异常
     */
    @Override
    public void deleteNotice(Integer noticeId) throws MyException {
        Notice notice = noticeMapper.selectById(noticeId);
        if (notice == null) {
            throw new MyException(EnumExceptionType.NOTICE_NOT_EXIST);
        }
        if (!Objects.equals(notice.getReceiverId(), sessionUtils.getUserId())) {
            throw new MyException(EnumExceptionType.PERMISSION_DENIED);
        }
        notice.setDeleteTime(LocalDateTime.now());
        noticeMapper.updateById(notice);
    }

    /**
     * 查看信息详情
     * @param id 通知id
     * @return 通知详情
     * @throws MyException 通用异常
     * type: （0:系统(可以细分，或者就直接只给文字信息) 1:给每日分享点赞  2:给每日分享的评论点赞 3:给每日分享评论的回复点赞  4:  5:给每日分享的评论回复 6:给每日分享评论的回复回复 7:  8:  9: ）
     */
    @Override
    public NoticeInfo getNoticeById(Integer id) {
        Notice notice = noticeMapper.selectById(id);
        User sender = userMapper.selectById(notice.getSenderId());

//        // 如果是点赞或评论消息，就需要获取帖子或评论信息
//        if (notice.getType() == 1 || notice.getType() == 4) {
//            DailyShareInfo post = dailyShareService.getDailyShareById((String) notice.getObjectId());
//            return new NoticeInfo(notice, sender, post);
//        }
        if (notice.getType() == 2 || notice.getType() == 5) {
            // 如果是点赞或评论消息，就需要获取评论信息
            CommentInfo comment = commentService.getCommentById(Integer.valueOf(notice.getObjectId()));
            return new NoticeInfo(notice, sender, comment);
        }
        else if (notice.getType() == 3 || notice.getType() == 6) {
            // 如果是点赞或评论消息，就需要获取回复信息
            ReplyInfo reply = replyService.getReplyById(Integer.valueOf(notice.getObjectId()));
            return new NoticeInfo(notice, sender, reply);
        } else if (notice.getType() == 0) {
            return new NoticeInfo(notice);
        }
//        else if (notice.getType() == 8) {
//            // 如果是订单消息，就需要获取订单信息
//            ExpressOrderInfo expressOrderInfo = expressOrderService.getOrderById(notice.getObjectId());
//            return new NoticeInfo(notice, sender, expressOrderInfo);
//        }
//        else if (notice.getType() == 9) {
//            // 如果是拼车消息，就需要获取拼车信息
//        }

        return new NoticeInfo(notice, sender);
    }
}