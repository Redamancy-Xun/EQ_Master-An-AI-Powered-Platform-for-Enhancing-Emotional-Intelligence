package fun.redamancyxun.eqmaster.backend.service;

import fun.redamancyxun.eqmaster.backend.controller.dailyshare.request.CreateReplyParams;
import fun.redamancyxun.eqmaster.backend.controller.dailyshare.response.ReplyInfo;
import fun.redamancyxun.eqmaster.backend.entity.Reply;

import java.util.List;

/**
 * @author Redamancy
 * @description 针对表【reply（回复）】的数据库操作Service实现
 * @createDate 2024-04-03 22:39:04
 */
public interface ReplyService {

    // 创建一个回复
    Reply createReply(CreateReplyParams createReplyParams);

    // 获得回复列表
    List<ReplyInfo> getReplyList(Integer commentId, Boolean orderByDesc, Integer page, Integer pageSize);

    // 获取回复详情
    ReplyInfo getReplyById(Integer replyId);

    // 获取用户的回复列表
    List<Object> getReplyByUserId(String userId, Integer page, Integer pageSize);

    // 删除回复
    void deleteReply(Integer replyId);

}
