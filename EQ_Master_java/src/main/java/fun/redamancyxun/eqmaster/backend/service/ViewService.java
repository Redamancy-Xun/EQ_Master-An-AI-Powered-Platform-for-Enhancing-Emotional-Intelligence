package fun.redamancyxun.eqmaster.backend.service;

/**
 * @author Redamancy
 * @description 针对浏览量的实现
 * @createDate 2024-04-03 22:39:04
 */
public interface ViewService {

    // 增加浏览量
    Long addView(String dailyShareId);

    // 获取浏览量
    Long getView(String dailyShareId);
}
