package fun.redamancyxun.eqmaster.backend.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import fun.redamancyxun.eqmaster.backend.entity.*;
import fun.redamancyxun.eqmaster.backend.exception.EnumExceptionType;
import fun.redamancyxun.eqmaster.backend.exception.MyException;
import fun.redamancyxun.eqmaster.backend.mapper.*;
import fun.redamancyxun.eqmaster.backend.service.LikeService;
//import fun.redamancyxun.eqmaster.backend.service.NoticeService;
import fun.redamancyxun.eqmaster.backend.service.NoticeService;
import fun.redamancyxun.eqmaster.backend.util.SessionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

/**
 * @author Redamancy
 * @description 针对表【likes（点赞）】的服务接口实现
 * @createDate 2024-04-03 22:39:04
 */
@Service
public class LikeServiceImpl implements LikeService {

    @Autowired
    private LikeMapper likeMapper;

    @Autowired
    private DailyShareMapper dailyShareMapper;

    @Autowired
    private CommentMapper commentMapper;

    @Autowired
    private ReplyMapper replyMapper;

    @Autowired
    private SessionUtils sessionUtils;

    @Autowired
    private NoticeService noticeService;

    @Autowired
    private UserMapper userMapper;

    /**
     * 点赞
     * @param objectId 对象id
     * @param type 类型 0-每日分享 1-评论每日分享 2-回复每日分享评论 3-帖子 4-评论帖子 5-回复帖子评论
     * @return 点赞是否成功
     * @throws MyException 通用异常
     */
    @Transactional(rollbackFor = MyException.class)
    @Override
    public Boolean like(Object objectId, Integer type) throws MyException {
        String userId = sessionUtils.getUserId();

        Likes likes = Likes.builder()
                .createTime(LocalDateTime.now())
                .deleteTime(null)
                .userId(userId)
                .objectId((String) objectId)
                .type(type)
                .build();

        // 判断是否已经点赞
        QueryWrapper<Likes> likesQueryWrapper = new QueryWrapper<>();
        likesQueryWrapper.eq("user_id", userId)
                .eq("object_id", (String) objectId)
                .eq("type", type)
                .isNull("delete_time");
        if (likeMapper.selectCount(likesQueryWrapper) != 0) {
            throw new MyException(EnumExceptionType.LIKE_EXIST);
        }

        // 0-每日分享 1-评论每日分享 2-回复每日分享评论 3-帖子 4-评论帖子 5-回复帖子评论
        if (type == 0) {
            DailyShare dailyShare = dailyShareMapper.selectById((String) objectId);
            if (dailyShare == null || dailyShare.getDeleteTime() != null) {
                throw new MyException(EnumExceptionType.DAILYSHARE_NOT_EXIST);
            }
            dailyShare.setLikes(dailyShare.getLikes() + 1);
            if (dailyShareMapper.updateById(dailyShare) == 0) {
                throw new MyException(EnumExceptionType.UPDATE_FAILED);
            }
            likes.setToUserId(null);

//            String message = userMapper.selectById(userId).getUsername() + "点赞了你的帖子";
//
//            noticeService.SysSend(Math.toIntExact(objectId), dailyShare.getUserId(), 1, message, userId);
        } else if (type == 1) {
            Comment comment = commentMapper.selectById((Serializable) objectId);
            if (comment == null || comment.getDeleteTime() != null) {
                throw new MyException(EnumExceptionType.COMMENT_NOT_FOUND);
            }
            comment.setLikes(comment.getLikes() + 1);
            if (commentMapper.updateById(comment) == 0) {
                throw new MyException(EnumExceptionType.UPDATE_FAILED);
            }
            likes.setToUserId(comment.getUserId());

            String message = userMapper.selectById(userId).getUsername() + "点赞了你的评论";

            noticeService.SysSend(objectId, comment.getUserId(), 2, message, userId);

            User user = userMapper.selectById(comment.getUserId());
            user.setLikeCount(user.getLikeCount() + 1);
            if (userMapper.updateById(user) == 0) {
                throw new MyException(EnumExceptionType.UPDATE_FAILED);
            }
        } else if (type == 2) {
            Reply reply = replyMapper.selectById((Serializable) objectId);
            if (reply == null || reply.getDeleteTime() != null) {
                throw new MyException(EnumExceptionType.REPLY_NOT_FOUND);
            }
            reply.setLikes(reply.getLikes() + 1);
            if (replyMapper.updateById(reply) == 0) {
                throw new MyException(EnumExceptionType.UPDATE_FAILED);
            }
            likes.setToUserId(reply.getUserId());

            String message = userMapper.selectById(userId).getUsername() + "点赞了你的回复";

            noticeService.SysSend(objectId, reply.getUserId(), 3, message, userId);

            User user = userMapper.selectById(reply.getUserId());
            user.setLikeCount(user.getLikeCount() + 1);
            if (userMapper.updateById(user) == 0) {
                throw new MyException(EnumExceptionType.UPDATE_FAILED);
            }
        } else {
            throw new MyException(EnumExceptionType.PARAMETER_ERROR);
        }

        likeMapper.insert(likes);
        return true;
    }

    /**
     * 取消点赞
     * @param objectId 对象id
     * @param type 类型 0-每日分享 1-评论每日分享 2-回复每日分享评论 3-帖子 4-评论帖子 5-回复帖子评论
     * @return 取消点赞是否成功
     * @throws MyException 通用异常
     */
    @Transactional(rollbackFor = MyException.class)
    @Override
    public Boolean unlike(Object objectId, Integer type) throws MyException {
        // 判断是否已经取消点赞
        QueryWrapper<Likes> likesQueryWrapper = new QueryWrapper<>();
        likesQueryWrapper.eq("user_id", sessionUtils.getUserId())
                .eq("object_id", (String) objectId)
                .eq("type", type)
                .isNull("delete_time");
        if (likeMapper.selectCount(likesQueryWrapper) == 0) {
            throw new MyException(EnumExceptionType.LIKE_UNEXIST);
        }

        //类型 0-每日分享 1-评论每日分享 2-回复每日分享评论 3-帖子 4-评论帖子 5-回复帖子评论
        if (type == 0) {
            DailyShare dailyShare = dailyShareMapper.selectById((String) objectId);
            if (dailyShare == null || dailyShare.getDeleteTime() != null) {
                throw new MyException(EnumExceptionType.DAILYSHARE_NOT_EXIST);
            }
            dailyShare.setLikes(dailyShare.getLikes() - 1);
            if (dailyShareMapper.updateById(dailyShare) == 0) {
                throw new MyException(EnumExceptionType.UPDATE_FAILED);
            }
        } else if (type == 1) {
            Comment comment = commentMapper.selectById(((Serializable) objectId));
            if (comment == null || comment.getDeleteTime() != null) {
                throw new MyException(EnumExceptionType.COMMENT_NOT_FOUND);
            }
            comment.setLikes(comment.getLikes() - 1);
            if (commentMapper.updateById(comment) == 0) {
                throw new MyException(EnumExceptionType.UPDATE_FAILED);
            }

            User user = userMapper.selectById(comment.getUserId());
            user.setLikeCount(user.getLikeCount() - 1);
            if (userMapper.updateById(user) == 0) {
                throw new MyException(EnumExceptionType.UPDATE_FAILED);
            }
        } else if (type == 2) {
            Reply reply = replyMapper.selectById((Serializable) objectId);
            if (reply == null || reply.getDeleteTime() != null) {
                throw new MyException(EnumExceptionType.REPLY_NOT_FOUND);
            }
            reply.setLikes(reply.getLikes() - 1);
            if (replyMapper.updateById(reply) == 0) {
                throw new MyException(EnumExceptionType.UPDATE_FAILED);
            }

            User user = userMapper.selectById(reply.getUserId());
            user.setLikeCount(user.getLikeCount() - 1);
            if (userMapper.updateById(user) == 0) {
                throw new MyException(EnumExceptionType.UPDATE_FAILED);
            }
        } else {
            throw new MyException(EnumExceptionType.PARAMETER_ERROR);
        }

        QueryWrapper<Likes> likeQueryWrapper = new QueryWrapper<>();
        likeQueryWrapper.isNull("delete_time")
                .eq("user_id", sessionUtils.getUserId())
                .eq("object_id", objectId)
                .eq("type", type);

        Likes likes = likeMapper.selectOne(likeQueryWrapper);
        likes.setDeleteTime(LocalDateTime.now());

        if (likeMapper.updateById(likes) == 0) {
            throw new MyException(EnumExceptionType.UPDATE_FAILED);
        }
        return true;
    }

    /**
     * 检查是否点赞
     * @param objectId 对象id
     * @param type 类型 0-每日分享 1-评论每日分享 2-回复每日分享评论 3-帖子 4-评论帖子 5-回复帖子评论
     * @return 是否点赞
     * @throws MyException 通用异常
     */
    @Override
    public Boolean check(Object objectId, Integer type) throws MyException {
        QueryWrapper<Likes> likesQueryWrapper = new QueryWrapper<>();
        likesQueryWrapper.isNull("delete_time")
                .eq("user_id", sessionUtils.getUserId())
                .eq("object_id", objectId)
                .eq("type", type);

        return likeMapper.selectCount(likesQueryWrapper) > 0;
    }

    /**
     * 取消所有点赞
     * @param objectId 对象id
     * @param type 类0-每日分享 1-评论每日分享 2-回复每日分享评论 3-帖子 4-评论帖子 5-回复帖子评论
     * @throws MyException 通用异常
     */
    @Override
    public void unlikeAll(Object objectId, Integer type) {
        QueryWrapper<Likes> likeQueryWrapper = new QueryWrapper<>();
        likeQueryWrapper.isNull("delete_time")
                .eq("object_id", objectId)
                .eq("type", type);

        List<Likes> likes = likeMapper.selectList(likeQueryWrapper);
        for (Likes like : likes) {
            like.setDeleteTime(LocalDateTime.now());
            if (likeMapper.updateById(like) == 0) {
                throw new MyException(EnumExceptionType.UPDATE_FAILED);
            }
        }
    }
}











