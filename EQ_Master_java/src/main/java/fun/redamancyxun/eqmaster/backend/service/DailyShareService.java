package fun.redamancyxun.eqmaster.backend.service;

import fun.redamancyxun.eqmaster.backend.controller.dailyshare.request.CreateDailyShareParams;
import fun.redamancyxun.eqmaster.backend.controller.dailyshare.response.DailyShareInfo;

import java.util.List;

/**
 * @author Redamancy
 * @description 针对表【DailyShare（帖子）】的数据库操作Service实现
 * @createDate 2024-04-03 22:39:04
 */
public interface DailyShareService {

    // 人为创建一个每日分享
    DailyShareInfo createDailyShare(CreateDailyShareParams createDailyShareParams);

    // 每天创建一个每日分享
    DailyShareInfo createDailyShare();

    // 获取最新or最热每日分享专栏列表
    List<DailyShareInfo> getDailyShareList(String type, Integer page, Integer pageSize, Boolean orderByPopularity);

    // 获取最新or最热每日分享预览列表
    List<List<DailyShareInfo>> getDailyShareList(Integer page, Integer pageSize);

    // 根据专栏类型和时间区间获取每日分享列表
    List<DailyShareInfo> getDailyShareListByTag(String type, Integer page, Integer pageSize, String startTime, String endTime, Boolean orderByPopularity);

    // 根据每日分享内容关键词搜索每日分享
    List<DailyShareInfo> searchDailyShare(String type, Integer page, Integer pageSize, String keyword);

    // 获取每日分享详情
    DailyShareInfo getDailyShareById(String dailyShareId);

//    // 获取用户的帖子列表
//    List<DailyShareInfo> getDailyShareByUserId(String userId, Integer page, Integer pageSize);
//
//    // 删除每日分享
//    Boolean deleteDailyShare(String dailyShareId);
//
//    // 把帖子置顶
//    Boolean topDailyShare(Integer DailyShareId);
//
//    // 把帖子取消置顶
//    Boolean untopDailyShare(Integer DailyShareId);
//
//    // 把帖子设为私密
//    Boolean privateDailyShare(Integer DailyShareId);
//
//    // 把帖子设为公开
//    Boolean publicDailyShare(Integer DailyShareId);
}
