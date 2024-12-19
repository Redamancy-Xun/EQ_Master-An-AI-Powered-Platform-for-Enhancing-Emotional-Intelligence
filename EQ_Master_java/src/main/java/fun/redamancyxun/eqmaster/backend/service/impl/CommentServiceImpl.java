package fun.redamancyxun.eqmaster.backend.service.impl;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import fun.redamancyxun.eqmaster.backend.common.Page;
import fun.redamancyxun.eqmaster.backend.controller.dailyshare.request.CreateCommentParams;
import fun.redamancyxun.eqmaster.backend.controller.dailyshare.response.CommentInfo;
import fun.redamancyxun.eqmaster.backend.entity.Comment;
import fun.redamancyxun.eqmaster.backend.entity.DailyShare;
import fun.redamancyxun.eqmaster.backend.entity.Reply;
import fun.redamancyxun.eqmaster.backend.entity.User;
import fun.redamancyxun.eqmaster.backend.exception.EnumExceptionType;
import fun.redamancyxun.eqmaster.backend.exception.MyException;
import fun.redamancyxun.eqmaster.backend.mapper.CommentMapper;
import fun.redamancyxun.eqmaster.backend.mapper.DailyShareMapper;
import fun.redamancyxun.eqmaster.backend.mapper.ReplyMapper;
import fun.redamancyxun.eqmaster.backend.mapper.UserMapper;
import fun.redamancyxun.eqmaster.backend.service.CommentService;
import fun.redamancyxun.eqmaster.backend.service.DailyShareService;
import fun.redamancyxun.eqmaster.backend.service.LikeService;
import fun.redamancyxun.eqmaster.backend.service.UserService;
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
 * @description 针对表【comment（评论）】的服务接口实现
 * @createDate 2024-04-03 22:39:04
 */
@Service
public class CommentServiceImpl implements CommentService {

    @Autowired
    private UserService userService;

    @Autowired
    private SessionUtils sessionUtils;

    @Autowired
    private CommentMapper commentMapper;

    @Autowired
    private ReplyMapper replyMapper;

    @Autowired
    private LikeService likeService;

    @Autowired
    private DailyShareService dailyShareService;

    @Autowired
    private DailyShareMapper dailyShareMapper;

    @Autowired
    private UserMapper userMapper;

    /**
     * 创建评论
     * @param createCommentParams 评论参数
     * @return 评论信息
     * @throws MyException 通用异常
     */
    @Transactional(rollbackFor = MyException.class)
    @Override
    public CommentInfo createComment(CreateCommentParams createCommentParams) throws MyException{
        User user = userService.getUserById(sessionUtils.getUserId());

        String picture = JSON.toJSONString(createCommentParams.getPicture());

        Comment comment = Comment.builder()
                .userId(sessionUtils.getUserId())
                .dailyShareId(createCommentParams.getDailyShareId())
                .content(createCommentParams.getContent())
                .createTime(LocalDateTime.now())
                .deleteTime(null)
                .picture(picture)
                .likes(0)
                .reply(0)
                .top(0)
                .build();;

        commentMapper.insert(comment);

//        String content = comment.getContent();
//        if (content.length() >= 30) {
//            content = content.substring(0, 30);
//            content += "...";
//        }
//        if (!createCommentParams.getPicture().isEmpty()) {
//            content += "[图片]";
//        }
//
//        noticeService.SysSend(article.getId(), article.getUserId(), 4,  content, user.getOpenId());

        user.setCommentCount(user.getCommentCount() + 1);
        if (userMapper.updateById(user) == 0) {
            throw new MyException(EnumExceptionType.UPDATE_FAILED);
        }

        return new CommentInfo(comment, user, false);
    }

    /**
     * 获取评论列表
     * @param dailyShareId 每日分享id
     * @param page 页码
     * @param pageSize 每页数量
     * @param orderByPopularity 是否按照热度排序 true为最热 false为最新
     * @return 评论列表
     * @throws MyException 通用异常
     */
    @Override
    public List<CommentInfo> getCommentList(String dailyShareId, Integer page, Integer pageSize, Boolean orderByPopularity) throws MyException {
        if (page == null || page < 1) {
            page = 1;
        }
        if (pageSize == null || pageSize < 1) {
            pageSize = 10;
        }
        if (orderByPopularity == null) {
            orderByPopularity = false;
        }

        List<Comment> comments = new ArrayList<>();
        PageHelper.startPage(page, pageSize);
        if (!orderByPopularity) {
            QueryWrapper<Comment> commentQueryWrapper = new QueryWrapper<>();
            commentQueryWrapper.eq("daily_share_id", dailyShareId);
            commentQueryWrapper.isNull("delete_time");
            commentQueryWrapper.orderByDesc("top");
            commentQueryWrapper.orderByDesc("create_time");
            comments = new Page<>(new PageInfo<>(commentMapper.selectList(commentQueryWrapper))).getItems();
        } else {
            comments = new Page<>(new PageInfo<>(commentMapper.selectByPopularity(dailyShareId))).getItems();
        }

        List<CommentInfo> commentInfos = new ArrayList<>();
        for (Comment comment : comments) {
            User user = userService.getUserById(comment.getUserId());
            Boolean isLike = likeService.check(comment.getId(), 1);
            commentInfos.add(new CommentInfo(comment, user, isLike));
        }

        return commentInfos;
    }

    /**
     * 获取评论详情
     * @param commentId 评论id
     * @return 评论
     * @throws MyException 通用异常
     */
    @Override
    public CommentInfo getCommentById(Integer commentId) throws MyException {
        Comment comment = commentMapper.selectById(commentId);
        User user = userService.getUserById(comment.getUserId());
        Boolean isLike = likeService.check(comment.getId(), 1);

        return new CommentInfo(comment, user, isLike);
    }

    /**
     * 根据用户id获取评论
     * @param userId 用户id
     * @param page 页码
     * @param pageSize 每页数量
     * @return 评论列表
     * @throws MyException 通用异常
     */
    @Override
    public List<Object> getCommentByUserId(String userId, Integer page, Integer pageSize) throws MyException {
        if (page == null || page < 1) {
            page = 1;
        }
        if (pageSize == null || pageSize < 1) {
            pageSize = 10;
        }

        PageHelper.startPage(page, pageSize);

        QueryWrapper<Comment> commentQueryWrapper = new QueryWrapper<>();
        commentQueryWrapper.eq("user_id", userId);
        commentQueryWrapper.isNull("delete_time");
        commentQueryWrapper.orderByDesc("top");
        commentQueryWrapper.orderByDesc("create_time");

        List<Comment> comments = new Page<>(new PageInfo<>(commentMapper.selectList(commentQueryWrapper))).getItems();
        List<Object> commentInfos = new ArrayList<>();
        for (Comment comment : comments) {
            DailyShare dailyShare = dailyShareMapper.selectById(comment.getDailyShareId());
            List<Object> commentInfo = new ArrayList<>();
            User user = userService.getUserById(userId);
            Boolean isLike = likeService.check(Long.valueOf(comment.getId()), 1);
            commentInfo.add(new CommentInfo(comment, user, isLike));
            commentInfo.add(dailyShare);
            commentInfos.add(commentInfo);
        }

        return commentInfos;
    }

    /**
     * 获取用户自己的评论列表
     * @param page 页码
     * @param pageSize 每页数量
     * @return 评论列表
     * @throws MyException 通用异常
     */
    @Override
    public List<Object> getUserComment(Integer page, Integer pageSize) throws MyException {
        if (page == null || page < 1) {
            page = 1;
        }
        if (pageSize == null || pageSize < 1) {
            pageSize = 10;
        }

        String userId = sessionUtils.getUserId();

        PageHelper.startPage(page, pageSize);

        QueryWrapper<Comment> commentQueryWrapper = new QueryWrapper<>();
        commentQueryWrapper.eq("user_id", userId);
        commentQueryWrapper.isNull("delete_time");
        commentQueryWrapper.orderByDesc("top");
        commentQueryWrapper.orderByDesc("create_time");

        List<Comment> comments = new Page<>(new PageInfo<>(commentMapper.selectList(commentQueryWrapper))).getItems();
        List<Object> commentInfos = new ArrayList<>();
        for (Comment comment : comments) {
            DailyShare dailyShare = dailyShareMapper.selectById(comment.getDailyShareId());
            List<Object> commentInfo = new ArrayList<>();
            User user = userService.getUserById(userId);
            Boolean isLike = likeService.check(Long.valueOf(comment.getId()), 1);
            commentInfo.add(new CommentInfo(comment, user, isLike));
            commentInfo.add(dailyShare);
            commentInfos.add(commentInfo);
        }

        return commentInfos;
    }

    /**
     * 删除评论
     * @param commentId 评论id
     * @throws MyException 通用异常
     */
    @Override
    public void deleteComment(Integer commentId) throws MyException {
        User user = userService.getUserById(sessionUtils.getUserId());

        Comment comment = commentMapper.selectById(commentId);

        // 检查评论是否存在
        if (comment.getDeleteTime() != null) {
            throw new MyException(EnumExceptionType.COMMENT_NOT_EXIST);
        }

        // 检查是否有权限删除
        if (user.getRole() >= 2 && !Objects.equals(comment.getUserId(), user.getId())) {
            throw new MyException(EnumExceptionType.PERMISSION_DENIED);
        }

        User commentOwner = userService.getUserById(comment.getUserId());
        if (user.getRole() - commentOwner.getRole() >= 1) {
            throw new MyException(EnumExceptionType.PERMISSION_DENIED);
        }

        likeService.unlikeAll(commentId, 1);

        QueryWrapper<Reply> replyQueryWrapper = new QueryWrapper<>();
        replyQueryWrapper.isNull("delete_time");
        replyQueryWrapper.eq("comment_id", commentId);
        List<Reply> replies = replyMapper.selectList(replyQueryWrapper);
        for (Reply reply : replies) {
            reply.setDeleteTime(LocalDateTime.now());
            if (replyMapper.updateById(reply) == 0) {
                throw new MyException(EnumExceptionType.UPDATE_FAILED);
            }

            likeService.unlikeAll(Long.valueOf(reply.getId()), 2);
        }

        DailyShare dailyShare = dailyShareMapper.selectById(comment.getDailyShareId());
        dailyShare.setCommentCount(dailyShare.getCommentCount() - comment.getReply() - 1);
        if (dailyShareMapper.updateById(dailyShare) == 0) {
            throw new MyException(EnumExceptionType.UPDATE_FAILED);
        }

        comment.setDeleteTime(LocalDateTime.now());
        if (commentMapper.updateById(comment) == 0) {
            throw new MyException(EnumExceptionType.UPDATE_FAILED);
        }

        user.setCommentCount(user.getCommentCount() - 1);
        if (userMapper.updateById(user) == 0) {
            throw new MyException(EnumExceptionType.UPDATE_FAILED);
        }
    }


}







