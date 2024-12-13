package fun.redamancyxun.eqmaster.backend.service;

import fun.redamancyxun.eqmaster.backend.controller.dailyshare.response.NoticeInfo;
import fun.redamancyxun.eqmaster.backend.exception.MyException;

import java.util.Map;

/**
 * @author Redamancy
 * @description 针对表【notice（消息）】的数据库操作Service实现
 * @createDate 2024-04-03 22:39:04
 */
public interface NoticeService {

    // 给全体用户发送系统消息
    Boolean SysSend(String msg);

    // 给指定用户发送系统消息
    Boolean SysSend(String msg, String receiverId);

    // 发送消息
    Boolean SysSend(Object objectId, String receiverId, Integer type, String message, String senderId);

    // 获取未读消息
    Map<String, Integer> hasUnread();

    // 获取消息列表
    Map<String, Object> getNoticesInfo(Integer type, Integer page, Integer pageSize);

    // 删除消息
    void deleteNotice(Integer noticeId);

    // 查看信息详情
    public NoticeInfo getNoticeById(Integer id) throws MyException;

}
