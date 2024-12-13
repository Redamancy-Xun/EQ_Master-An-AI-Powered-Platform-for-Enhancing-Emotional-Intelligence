package fun.redamancyxun.eqmaster.backend.service.impl;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import fun.redamancyxun.eqmaster.backend.common.CommonConstants;
import fun.redamancyxun.eqmaster.backend.common.Page;
import fun.redamancyxun.eqmaster.backend.controller.dailyshare.request.CreateDailyShareParams;
import fun.redamancyxun.eqmaster.backend.controller.dailyshare.response.DailyShareInfo;
import fun.redamancyxun.eqmaster.backend.entity.DailyShare;
import fun.redamancyxun.eqmaster.backend.entity.Comment;
import fun.redamancyxun.eqmaster.backend.entity.Reply;
import fun.redamancyxun.eqmaster.backend.entity.User;
import fun.redamancyxun.eqmaster.backend.exception.EnumExceptionType;
import fun.redamancyxun.eqmaster.backend.exception.MyException;
import fun.redamancyxun.eqmaster.backend.mapper.DailyShareMapper;
import fun.redamancyxun.eqmaster.backend.mapper.CommentMapper;
import fun.redamancyxun.eqmaster.backend.mapper.ReplyMapper;
import fun.redamancyxun.eqmaster.backend.mapper.UserMapper;
import fun.redamancyxun.eqmaster.backend.service.*;
import fun.redamancyxun.eqmaster.backend.util.PageUtils;
import fun.redamancyxun.eqmaster.backend.util.SessionUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.*;

/**
 * @author Redamancy
 * @description 针对表【DailyShare（每日分享）】的数据库操作Service实现
 * @createDate 2024-04-03 22:39:04
 */
@Service
public class DailyShareServiceImpl implements DailyShareService {

    //TO-DO
    //创建了每日分享、有评论和回复之后发送notice

    @Autowired
    private DailyShareMapper dailyShareMapper;

    @Autowired
    private CommentMapper commentMapper;

    @Autowired
    private ReplyMapper replyMapper;

    @Autowired
    private SessionUtils sessionUtils;

    @Autowired
    private UserService userService;

    @Autowired
    private NoticeService noticeService;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private ViewService viewService;

    @Autowired
    private LikeService likeService;

    @Autowired
    private StarService starService;

    @Autowired
    private ShareService shareService;

    /**
     * 人为创建一个每日分享
     * @param createDailyShareParams 每日分享参数
     * @return 每日分享信息
     * @throws MyException 通用异常
     */
    @Transactional(rollbackFor = MyException.class)
    @Override
    public DailyShareInfo createDailyShare(CreateDailyShareParams createDailyShareParams) throws MyException {
        User user = userService.getUserById(sessionUtils.getUserId());

        DailyShare dailyShare = DailyShare.builder()
                .context(createDailyShareParams.getContext())
                .createTime(LocalDateTime.now())
                .commentCount(0)
                .likes(0)
                .favorite(0)
                .view(0L)
                .picture(createDailyShareParams.getPicture())
                .type(createDailyShareParams.getType())
                .title(createDailyShareParams.getTitle())
                .id(createDailyShareParams.getId())
                .deleteTime(null)
                .share(0)
                .build();
        dailyShareMapper.insert(dailyShare);

        return new DailyShareInfo(dailyShare, false, false, false);
    }

    /**
     * 每天创建一个每日分享
     * @return 每日分享信息
     */
    // TODO 使用定时任务，根据excel表读取数据插入数据库
    @Scheduled(cron = "0 0 0 * * ? ")
    public DailyShareInfo createDailyShare() throws MyException {
        // TODO 添加每日分享到数据库
        return null;
    }

    /**
     * 获取最新or最热每日分享专栏列表
     * @param type 类型
     * @param page 页码
     * @param pageSize 每页大小
     * @param orderByPopularity 是否按照热度排序
     * @return 每日分享列表
     * @throws MyException 通用异常
     */
    @Override
    public List<DailyShareInfo> getDailyShareList(String type, Integer page, Integer pageSize, Boolean orderByPopularity) throws MyException {
        if (page == null || page < 1) {
            page = 1;
        }
        if (pageSize == null || pageSize < 1) {
            pageSize = 10;
        }
        if (orderByPopularity == null) {
            orderByPopularity = false;
        }

        Page<DailyShare> dailyShares;

        // top为1的每日分享置顶
        if (!orderByPopularity) {
            // 按照时间和置顶排序
            // PageHelper.startPage(page, pageSize, "top desc , create_time desc"); 不可用？
            // 利用QueryWrapper实现多条件排序
            QueryWrapper<DailyShare> dailyShareQueryWrapper = new QueryWrapper<>();
            dailyShareQueryWrapper.isNull("delete_time");
//            dailyShareQueryWrapper.ge("cancel", LocalDateTime.now());
//            dailyShareQueryWrapper.orderByDesc("top");
            dailyShareQueryWrapper.orderByDesc("create_time");
            dailyShareQueryWrapper.eq("type", type);
//            dailyShareQueryWrapper.eq("status", 0);
            PageHelper.startPage(page, pageSize);
            dailyShares = new Page<>(new PageInfo<>(dailyShareMapper.selectList(dailyShareQueryWrapper)));
        } else {
            // 按照热度排序三天内的每日分享（top desc , likes+comment+view+share+favorite desc , create_time desc）
            // PageHelper.startPage(page, pageSize, "top desc , likes+comments+views+stars desc , create_time desc"); 不可用？
            // 利用自定义SQL实现多条件排序
            PageHelper.startPage(page, pageSize);
            dailyShares = new Page<>(new PageInfo<>(dailyShareMapper.selectListByPopularity()));
        }

        List<DailyShareInfo> dailyShareInfos = new ArrayList<>();
        String userId = sessionUtils.getUserId();

        for (DailyShare dailyShare : dailyShares.getItems()) {
            dailyShare.setView(viewService.getView(dailyShare.getId()));
//            User user = userService.getUserById(dailyShare.getUserId());
            Boolean isLike = likeService.check(dailyShare.getId(),0);
            Boolean isStar = starService.check(dailyShare.getId(), userId);
            Boolean isShare = shareService.check(dailyShare.getId(), userId);
            dailyShareInfos.add(new DailyShareInfo(dailyShare, isLike, isStar, isShare));
        }
        return dailyShareInfos;
    }

    /**
     * 获取最新or最热每日分享预览列表
     * @param page 页码
     * @param pageSize 每页大小
     * @return 每日分享列表
     * @throws MyException 通用异常
     */
    @Override
    public List<List<DailyShareInfo>> getDailyShareList(Integer page, Integer pageSize) throws MyException {
        if (page == null || page < 1) {
            page = 1;
        }
        if (pageSize == null || pageSize < 1) {
            pageSize = 10;
        }

        List<List<DailyShareInfo>> dailyShareInfos = new ArrayList<>();

        for (String type : CommonConstants.DAILY_SHARE_TYPE) {
            List<DailyShareInfo> dailyShareInfoList = getDailyShareList(type, page, pageSize, false);
            dailyShareInfos.add(dailyShareInfoList);
        }

        return dailyShareInfos;
    }


    /**
     * 根据标签和时间区间精确获取每日分享列表
     * @param type 类型
     * @param startTime 开始时间
     * @param endTime 结束时间
     * @param page 页码
     * @param pageSize 每页大小
     * @param orderByPopularity 是否按照热度排序
     * @return 每日分享列表
     * @throws MyException 通用异常
     */
    @Override
    public List<DailyShareInfo> getDailyShareListByTag(String type, Integer page, Integer pageSize, String startTime, String endTime, Boolean orderByPopularity) throws MyException {
        if (page == null || page < 1) {
            page = 1;
        }
        if (pageSize == null || pageSize < 1) {
            pageSize = 10;
        }

        QueryWrapper<DailyShare> dailyShareQueryWrapper = new QueryWrapper<>();
        dailyShareQueryWrapper.isNull("delete_time");
//        dailyShareQueryWrapper.eq("status", 0);
//        dailyShareQueryWrapper.ge("cancel", LocalDateTime.now());
//        // 多标签查询 AND
//        for (int i = 0; i < tag.size(); i++) {
//            int x = i;
//            dailyShareQueryWrapper.and(a -> a.like("tag","\"" + tag.get(x) + "\""));
//        }
//        // 时间区间查询(0为三天之内，1为一周之内，2为一个月之内，3为三个月之内，4为三个月以上)
//        if (time == null || time < 0 || time > 4) {
//            time = -1;
//        }
//        switch (time) {
//            case 0:
//                dailyShareQueryWrapper.ge("create_time", LocalDateTime.now().minusDays(3));
//                break;
//            case 1:
//                dailyShareQueryWrapper.ge("create_time", LocalDateTime.now().minusWeeks(1));
//                break;
//            case 2:
//                dailyShareQueryWrapper.ge("create_time", LocalDateTime.now().minusMonths(1));
//                break;
//            case 3:
//                dailyShareQueryWrapper.ge("create_time", LocalDateTime.now().minusMonths(3));
//                break;
//            case 4:
//                dailyShareQueryWrapper.lt("create_time", LocalDateTime.now().minusMonths(3));
//                break;
//            default:
//                break;
//        }


        if (type != null) {
            dailyShareQueryWrapper.eq("type", type);
        }
        // TODO 确定一下startTime, endTime的数据类型
        if (startTime != null && endTime != null) {
            dailyShareQueryWrapper.between("create_time", startTime, endTime);
        }

        // 按照热度排序
        // PageHelper.startPage(page, pageSize, "top desc , likes+comment+view+share+favorite desc , create_time"); 不可用？
        // 根据top desc , likes+comment+view+share+favorite desc , create_time desc排序
        List<DailyShare> dailyShares = dailyShareMapper.selectList(dailyShareQueryWrapper);
        dailyShares.sort((o1, o2) -> {
            if (o1.getLikes() + o1.getCommentCount() + o1.getView() + o1.getShare() + o1.getFavorite() >
                    o2.getLikes() + o2.getCommentCount() + o2.getView() + o2.getShare() + o2.getFavorite()) {
                return -1;
            } else if (o1.getLikes() + o1.getCommentCount() + o1.getView() + o1.getShare() + o1.getFavorite() <
                    o2.getLikes() + o2.getCommentCount() + o2.getView() + o2.getShare() + o2.getFavorite()) {
                return 1;
            } else {
                return o1.getCreateTime().compareTo(o2.getCreateTime());
            }
        });
        PageUtils.splitList(page, pageSize, dailyShares);

        List<DailyShareInfo> dailyShareInfos = new ArrayList<>();
        String userId = sessionUtils.getUserId();

        for (DailyShare dailyShare : dailyShares) {
            dailyShare.setView(viewService.getView(dailyShare.getId()));
//            User user = userService.getUserById(dailyShare.getUserId());
            Boolean isLike = likeService.check(dailyShare.getId(), 0);
            Boolean isStar = starService.check(dailyShare.getId(), userId);
            Boolean isShare = shareService.check(dailyShare.getId(), userId);
            dailyShareInfos.add(new DailyShareInfo(dailyShare, isLike, isStar, isShare));
        }
        return dailyShareInfos;
    }

    /**
     * 根据文章内容关键词模糊搜索每日分享
     * @param type 类型
     * @param page 页码
     * @param pageSize 每页大小
     * @param keyword 关键词
     * @return 每日分享列表
     */
    @Override
    public List<DailyShareInfo> searchDailyShare(String type, Integer page, Integer pageSize, String keyword) {
        if (page == null || page < 1) {
            page = 1;
        }
        if (pageSize == null || pageSize < 1) {
            pageSize = 10;
        }

        PageHelper.startPage(page, pageSize);
        Page<DailyShare> dailyShares = new Page<>(new PageInfo<>(dailyShareMapper.selectListByKeyword(keyword, type)));
        List<DailyShareInfo> dailyShareInfos = new ArrayList<>();
        String userId = sessionUtils.getUserId();

        for (DailyShare dailyShare : dailyShares.getItems()) {
            dailyShare.setView(viewService.getView(dailyShare.getId()));
//            User user = userService.getUserById(dailyShare.getUserId());
            Boolean isLike = likeService.check(dailyShare.getId(),0);
            Boolean isStar = starService.check(dailyShare.getId(), userId);
            Boolean isShare = shareService.check(dailyShare.getId(), userId);
            dailyShareInfos.add(new DailyShareInfo(dailyShare, isLike, isStar, isShare));
        }
        return dailyShareInfos;
    }

    /**
     * 获取每日分享详情
     * @param dailyShareId 每日分享id
     * @return 每日分享详情
     * @throws MyException 通用异常
     */
    @Override
    public DailyShareInfo getDailyShareById(String dailyShareId) throws MyException {
        DailyShare dailyShare = dailyShareMapper.selectById(dailyShareId);
        if (dailyShare == null || dailyShare.getDeleteTime() != null) {
            throw new MyException(EnumExceptionType.DAILYSHARE_NOT_EXIST);
        }

        Long view = viewService.addView(dailyShareId);
        dailyShare.setView(view);
        String userId = sessionUtils.getUserId();

        Boolean isLike = likeService.check(dailyShare.getId(), 0);
        Boolean isStar = starService.check(dailyShare.getId(), userId);
        Boolean isShare = shareService.check(dailyShare.getId(), userId);

        if (dailyShareMapper.updateById(dailyShare) == 0) {
            throw new MyException(EnumExceptionType.UPDATE_FAILED);
        }

        return new DailyShareInfo(dailyShare, isLike, isStar, isShare);
    }

//    /**
//     * 获取用户每日分享列表
//     * @param userId 用户id
//     * @param page 页码
//     * @param pageSize 每页大小
//     * @return 每日分享列表
//     * @throws MyException 通用异常
//     */
//    @Override
//    public List<DailyShareInfo> getDailyShareByUserId(String userId, Integer page, Integer pageSize) throws MyException {
//        if (page == null || page < 1) {
//            page = 1;
//        }
//        if (pageSize == null || pageSize < 1) {
//            pageSize = 10;
//        }
//
//        User user = userService.getUserById(userId);
//
//        PageHelper.startPage(page, pageSize);
//        List<DailyShare> dailyShares = new Page<>(new PageInfo<>(dailyShareMapper.selectListByUserId(userId))).getItems();
//        List<DailyShareInfo> dailyShareInfos = new ArrayList<>();
//        for (DailyShare dailyShare : dailyShares) {
//            dailyShare.setView(viewService.getView(dailyShare.getId()));
//            Boolean isLike = likeService.check(dailyShare.getId(), 0);
//            Boolean isStar = starService.check(dailyShare.getId(), userId);
//            Boolean isShare = shareService.check(Long.valueOf(dailyShare.getId()), userId);
//            dailyShareInfos.add(new DailyShareInfo(dailyShare, isLike, isStar, isShare));
//        }
//        return dailyShareInfos;
//    }
//
//    /**
//     * 删除每日分享
//     * @param dailyShareId 每日分享id
//     * @return 是否成功
//     */
//    @Override
//    public Boolean deleteDailyShare(Integer dailyShareId) {
//        User user = userService.getUserById(sessionUtils.getUserId());
//
//        DailyShare dailyShare = dailyShareMapper.selectById(dailyShareId);
//        if (dailyShare == null || dailyShare.getDeleteTime() != null) {
//            throw new MyException(EnumExceptionType.DAILYSHARE_NOT_EXIST);
//        }
//        if (user.getRole() >= 2 && !Objects.equals(dailyShare.getUserId(), user.getOpenId())) {
//            throw new MyException(EnumExceptionType.PERMISSION_DENIED);
//        }
//
//        User dailyShareOwner = userService.getUserById(dailyShare.getUserId());
//        if (user.getRole() - dailyShareOwner.getRole() >= 1) {
//            throw new MyException(EnumExceptionType.PERMISSION_DENIED);
//        }
//
//        likeService.unlikeAll(Long.valueOf(dailyShareId), 0);
//
//        Set<Long> commentIds = new HashSet<>();
//        QueryWrapper<Comment> commentQueryWrapper = new QueryWrapper<>();
//        commentQueryWrapper.isNull("delete_time");
//        commentQueryWrapper.eq("DailyShare_id", dailyShareId);
//        List<Comment> comments = commentMapper.selectList(commentQueryWrapper);
//        for (Comment comment : comments) {
//            commentIds.add(Long.valueOf(comment.getId()));
//            comment.setDeleteTime(LocalDateTime.now());
//            if (commentMapper.updateById(comment) == 0) {
//                throw new MyException(EnumExceptionType.UPDATE_FAILED);
//            }
//
//            likeService.unlikeAll(Long.valueOf(comment.getId()), 1);
//        }
//
//        QueryWrapper<Reply> replyQueryWrapper = new QueryWrapper<>();
//        replyQueryWrapper.isNull("delete_time");
//        replyQueryWrapper.in("comment_id", commentIds);
//        List<Reply> replies = replyMapper.selectList(replyQueryWrapper);
//        for (Reply reply : replies){
//            reply.setDeleteTime(LocalDateTime.now());
//            if (replyMapper.updateById(reply) == 0) {
//                throw new MyException(EnumExceptionType.UPDATE_FAILED);
//            }
//
//            likeService.unlikeAll(Long.valueOf(reply.getId()), 2);
//        }
//
//        dailyShare.setDeleteTime(LocalDateTime.now());
//        if (dailyShareMapper.updateById(dailyShare) == 0){
//            throw new MyException(EnumExceptionType.UPDATE_FAILED);
//        }
//
//        return true;
//    }
//
//    /**
//     * 置顶每日分享
//     * @param dailyShareId 每日分享id
//     * @return 是否成功
//     */
//    @Override
//    public Boolean topDailyShare(Integer dailyShareId) {
//        User user = userService.getUserById(sessionUtils.getUserId());
//
//        DailyShare dailyShare = dailyShareMapper.selectById(dailyShareId);
//        if (dailyShare == null || dailyShare.getDeleteTime() != null) {
//            throw new MyException(EnumExceptionType.DailyShare_NOT_EXIST);
//        }
//        if (user.getRole() >= 2) {
//            throw new MyException(EnumExceptionType.PERMISSION_DENIED);
//        }
//
//        dailyShare.setTop(1);
//        if (dailyShareMapper.updateById(dailyShare) == 0){
//            throw new MyException(EnumExceptionType.UPDATE_FAILED);
//        }
//
//        return true;
//    }
//
//    /**
//     * 取消置顶每日分享
//     * @param dailyShareId 每日分享id
//     * @return 是否成功
//     */
//    @Override
//    public Boolean untopDailyShare(Integer dailyShareId) {
//        User user = userService.getUserById(sessionUtils.getUserId());
//
//        DailyShare dailyShare = dailyShareMapper.selectById(dailyShareId);
//        if (dailyShare == null || dailyShare.getDeleteTime() != null) {
//            throw new MyException(EnumExceptionType.DailyShare_NOT_EXIST);
//        }
//        if (user.getRole() >= 2) {
//            throw new MyException(EnumExceptionType.PERMISSION_DENIED);
//        }
//
//        dailyShare.setTop(0);
//        if (dailyShareMapper.updateById(dailyShare) == 0){
//            throw new MyException(EnumExceptionType.UPDATE_FAILED);
//        }
//
//        return true;
//    }
//
//    /**
//     * 把每日分享设为私密
//     * @param dailyShareId 每日分享id
//     * @return 是否成功
//     */
//    @Override
//    public Boolean privateDailyShare(Integer dailyShareId) {
//        User user = userService.getUserById(sessionUtils.getUserId());
//
//        DailyShare dailyShare = dailyShareMapper.selectById(dailyShareId);
//        if (dailyShare == null || dailyShare.getDeleteTime() != null) {
//            throw new MyException(EnumExceptionType.DailyShare_NOT_EXIST);
//        }
//        if (!Objects.equals(dailyShare.getUserId(), user.getOpenId())) {
//            throw new MyException(EnumExceptionType.PERMISSION_DENIED);
//        }
//
//        dailyShare.setStatus(1);
//        if (dailyShareMapper.updateById(dailyShare) == 0){
//            throw new MyException(EnumExceptionType.UPDATE_FAILED);
//        }
//
//        return true;
//    }
//
//    /**
//     * 把每日分享设为公开
//     * @param dailyShareId 每日分享id
//     * @return 是否成功
//     */
//    @Override
//    public Boolean publicDailyShare(Integer dailyShareId) {
//        User user = userService.getUserById(sessionUtils.getUserId());
//
//        DailyShare dailyShare = dailyShareMapper.selectById(dailyShareId);
//        if (dailyShare == null || dailyShare.getDeleteTime() != null) {
//            throw new MyException(EnumExceptionType.DailyShare_NOT_EXIST);
//        }
//        if (!Objects.equals(dailyShare.getUserId(), user.getOpenId())) {
//            throw new MyException(EnumExceptionType.PERMISSION_DENIED);
//        }
//
//        dailyShare.setStatus(0);
//        if (dailyShareMapper.updateById(dailyShare) == 0){
//            throw new MyException(EnumExceptionType.UPDATE_FAILED);
//        }
//
//        return true;
//    }
}








