package fun.redamancyxun.eqmaster.backend.service;

import fun.redamancyxun.eqmaster.backend.controller.dailyshare.request.CreateCommentParams;
import fun.redamancyxun.eqmaster.backend.controller.dailyshare.response.CommentInfo;

import java.util.List;

/**
 * @author Redamancy
 * @description 针对表【comment（评论）】的数据库操作Service实现
 * @createDate 2024-04-03 22:39:04
 */
public interface CommentService {

    // 创建一个评论
    CommentInfo createComment(CreateCommentParams createCommentParams);

    // 获得评论列表
    List<CommentInfo> getCommentList(String dailyShareId, Integer page, Integer pageSize, Boolean orderByPopularity);

    // 获取评论详情
    CommentInfo getCommentById(Integer commentId);

    // 获取用户的评论列表
    List<Object> getCommentByUserId(String userId, Integer page, Integer pageSize);

    // 删除评论
    void deleteComment(Integer commentId);
}
