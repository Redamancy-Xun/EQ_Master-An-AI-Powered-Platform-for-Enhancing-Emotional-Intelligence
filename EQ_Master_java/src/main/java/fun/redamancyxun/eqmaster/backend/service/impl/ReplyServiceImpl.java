package fun.redamancyxun.eqmaster.backend.service.impl;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import fun.redamancyxun.eqmaster.backend.common.Page;
import fun.redamancyxun.eqmaster.backend.controller.dailyshare.request.CreateReplyParams;
import fun.redamancyxun.eqmaster.backend.controller.dailyshare.response.ReplyInfo;
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
import fun.redamancyxun.eqmaster.backend.util.SessionUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * @author Redamancy
 * @description 针对表【reply（回复）】的服务接口实现
 * @createDate 2024-04-03 22:39:04
 */
@Service
public class ReplyServiceImpl implements ReplyService {

    @Autowired
    private UserService userService;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private ReplyMapper replyMapper;

    @Autowired
    private SessionUtils sessionUtils;

    @Autowired
    private DailyShareMapper dailyShareMapper;

    @Autowired
    private CommentMapper commentMapper;

    @Autowired
    private CommentService commentService;

    @Autowired
    private NoticeService noticeService;

    @Autowired
    private LikeService likeService;

    /**
     * 创建回复
     * @param createReplyParams 回复参数
     * @return 回复
     */
    @Transactional(rollbackFor = MyException.class)
    @Override
    public Reply createReply(CreateReplyParams createReplyParams) {
        User user = userService.getUserById(sessionUtils.getUserId());

        String picture = JSON.toJSONString(createReplyParams.getPicture());

        Reply reply = Reply.builder()
                .userId(sessionUtils.getUserId())
                .createTime(LocalDateTime.now())
                .deleteTime(null)
                .likes(0)
                .replyId(createReplyParams.getReplyId())
                .commentId(createReplyParams.getCommentId())
                .content(createReplyParams.getContent())
                .type(createReplyParams.getType())
                .picture(picture)
                .build();

        Comment comment = commentMapper.selectById(reply.getCommentId());
        if (comment == null) {
            throw new MyException(EnumExceptionType.COMMENT_NOT_EXIST);
        }
        comment.setReply(comment.getReply() + 1);
        if (commentMapper.updateById(comment) == 0) {
            throw new MyException(EnumExceptionType.UPDATE_FAILED);
        }

        reply.setDailyShareId(comment.getDailyShareId());
        replyMapper.insert(reply);

        DailyShare dailyShare = dailyShareMapper.selectById(comment.getDailyShareId());
        dailyShare.setCommentCount(dailyShare.getCommentCount() + 1);
        if (dailyShareMapper.updateById(dailyShare) == 0) {
            throw new MyException(EnumExceptionType.UPDATE_FAILED);
        }

        String content = reply.getContent();
        if (content.length() >= 30) {
            content = content.substring(0, 30);
            content += "...";
        }
        if (!createReplyParams.getPicture().isEmpty()) {
            content += "[图片]";
        }

        // 按回复类型获取toUserId并发送通知信息
        if (createReplyParams.getType() == 1) {
            Reply toReply = replyMapper.selectById(createReplyParams.getReplyId());
            reply.setToUserId(toReply.getUserId());
            if (replyMapper.updateById(reply) == 0) {
                throw new MyException(EnumExceptionType.UPDATE_FAILED);
            }
            noticeService.SysSend(reply.getReplyId(), reply.getToUserId(), 6, content, reply.getUserId());
        } else {
            Comment toComment = commentMapper.selectById(reply.getCommentId());
            reply.setToUserId(toComment.getUserId());
            if (replyMapper.updateById(reply) == 0) {
                throw new MyException(EnumExceptionType.UPDATE_FAILED);
            }
            noticeService.SysSend(reply.getCommentId(), reply.getToUserId(), 5, content, reply.getUserId());
        }

        return reply;
    }

    /**
     * 根据评论id获取回复
     * @param commentId 评论id
     * @param orderByPopularity 是否根据热度排列 true为最热 false为最新
     * @param page 页数
     * @param pageSize 每页数量
     * @return 回复列表
     */
    @Override
    public List<ReplyInfo> getReplyList(Integer commentId, Boolean orderByPopularity, Integer page, Integer pageSize) {
        if (page == null || page < 1) {
            page = 1;
        }
        if (pageSize == null || pageSize < 1) {
            pageSize = 10;
        }
        if (orderByPopularity == null) {
            orderByPopularity = false;
        }

        QueryWrapper<Reply> replyQueryWrapper = new QueryWrapper<>();
        replyQueryWrapper.eq("comment_id", commentId);
        replyQueryWrapper.isNull("delete_time");
        if (!orderByPopularity) {
            replyQueryWrapper.orderByDesc("create_time");
        } else {
            replyQueryWrapper.orderByDesc("likes");
            replyQueryWrapper.orderByDesc("create_time");
        }

        PageHelper.startPage(page, pageSize);
        List<Reply> replies = new Page<>(new PageInfo<>(replyMapper.selectList(replyQueryWrapper))).getItems();
        List<ReplyInfo> replyInfos = new ArrayList<>();
        for (Reply reply : replies) {
            User user = userService.getUserById(reply.getUserId());
            Boolean isLike = likeService.check(Long.valueOf(reply.getId()), 2);
            User replyUser = userService.getUserById(reply.getToUserId());
            replyInfos.add(new ReplyInfo(reply, user, replyUser, isLike));
        }

        return replyInfos;
    }

    /**
     * 根据回复id获取回复，包括已删除的
     * @param replyId 回复id
     * @return 回复
     */
    @Override
    public ReplyInfo getReplyById(Integer replyId) {
        Reply reply = getReplyByReplyId(replyId);
        User user = userService.getUserById(reply.getUserId());
        Boolean isLike = likeService.check(Long.valueOf(reply.getId()),2);
        User replyUser = userService.getUserById(reply.getToUserId());
        return new ReplyInfo(reply, user, replyUser, isLike);
    }

    /**
     * 根据用户id获取回复
     * @param userId 用户id
     * @param page 页数
     * @param pageSize 每页数量
     * @return 回复列表
     */
    @Override
    public List<Object> getReplyByUserId(String userId, Integer page, Integer pageSize) {
        if (page == null || page < 1) {
            page = 1;
        }
        if (pageSize == null || pageSize < 1) {
            pageSize = 10;
        }

        PageHelper.startPage(page, pageSize);

        QueryWrapper<Reply> replyQueryWrapper = new QueryWrapper<>();
        replyQueryWrapper.eq("user_id",userId);
        replyQueryWrapper.isNull("delete_time");
        replyQueryWrapper.orderByDesc("create_time");

        List<Reply> replies = new Page<>(new PageInfo<>(replyMapper.selectList(replyQueryWrapper))).getItems();
        List<Object> replyInfos = new ArrayList<>();
        for (Reply reply : replies) {
            DailyShare dailyShare = dailyShareMapper.selectById(reply.getDailyShareId());
//            if ((dailyShare.getCancel() != null && dailyShare.getCancel().isBefore(LocalDateTime.now())) || dailyShare.getStatus() == 1) {
//                continue;
//            }
            List<Object> replyInfo = new ArrayList<>();
            User user = userService.getUserById(reply.getUserId());
            Boolean isLike = likeService.check(Long.valueOf(reply.getId()),2);
            User replyUser = userService.getUserById(reply.getToUserId());
            replyInfo.add(new ReplyInfo(reply, user, replyUser, isLike));
            if (reply.getType() == 1) {
                replyInfo.add(getReplyById(reply.getReplyId()));
            } else {
                replyInfo.add(commentService.getCommentById(reply.getCommentId()));
            }
            replyInfo.add(dailyShare);
            replyInfos.add(replyInfo);
        }

        return replyInfos;
    }

    /**
     * 根据回复id删除回复
     * @param replyId 回复id
     * @throws MyException 通用异常
     */
    @Override
    public void deleteReply(Integer replyId) throws MyException {
        User user = userService.getUserById(sessionUtils.getUserId());

        Reply reply = getReplyByReplyId(replyId);

        //检查是否有权限删除
        if (user.getRole() <= 2 && !Objects.equals(reply.getUserId(), user.getId())) {
            throw new MyException(EnumExceptionType.PERMISSION_DENIED);
        }

        User replyOwner = userService.getUserById(reply.getUserId());
        if (user.getRole() - replyOwner.getRole() >= 1) {
            throw new MyException(EnumExceptionType.PERMISSION_DENIED);
        }

        likeService.unlikeAll(replyId, 2);

        Comment comment = commentMapper.selectById(reply.getCommentId());
        comment.setReply(comment.getReply() - 1);
        if (commentMapper.updateById(comment) == 0) {
            throw new MyException(EnumExceptionType.UPDATE_FAILED);
        }

        DailyShare dailyShare = dailyShareMapper.selectById(comment.getDailyShareId());
        dailyShare.setCommentCount(dailyShare.getCommentCount() - 1);
        if (dailyShareMapper.updateById(dailyShare) == 0) {
            throw new MyException(EnumExceptionType.UPDATE_FAILED);
        }

        reply.setDeleteTime(LocalDateTime.now());
        if (replyMapper.updateById(reply) == 0) {
            throw new MyException(EnumExceptionType.UPDATE_FAILED);
        }
    }

    /**
     * 根据回复id获取回复
     * @param replyId 回复id
     * @return 回复
     * @throws MyException 通用异常
     */
    public Reply getReplyByReplyId(Integer replyId) throws MyException {
        if (replyId == null) {
            throw new MyException(EnumExceptionType.PARAMETER_ERROR);
        }
        return replyMapper.selectById(replyId);
    }

}