package fun.redamancyxun.eqmaster.backend.service;

/**
 * @author Redamancy
 * @description 针对表【share（分享）】的数据库操作Service实现
 * @createDate 2024-04-03 22:39:04
 */
public interface ShareService {

    // 分享每日分享
    Boolean shareDailyShare(String dailyShareId);

    // 检查是否分享
    Boolean check(String dailyShareId, String userId);
}
