package fun.redamancyxun.eqmaster.backend.service;

import fun.redamancyxun.eqmaster.backend.controller.dailyshare.response.DailyShareInfo;

import java.util.List;

/**
 * @author Redamancy
 * @description 针对表【share（分享）】的数据库操作Service实现
 * @createDate 2024-04-03 22:39:04
 */
public interface StarService {

    // 收藏帖子
    Boolean starDailyShare(String dailyShareId);

    // 取消收藏帖子
    Boolean unstarDailyShare(String dailyShareId);

    // 检查是否收藏
    Boolean check(String dailyShareId, String userId);

    // 获取收藏列表
    List<DailyShareInfo> getStarList(Integer page, Integer pageSize);
}
