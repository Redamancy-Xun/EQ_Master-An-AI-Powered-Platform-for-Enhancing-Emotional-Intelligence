package fun.redamancyxun.eqmaster.backend.service;

/**
 * @author Redamancy
 * @description 针对表【like（点赞）】的数据库操作Service实现
 * @createDate 2024-04-03 22:39:04
 */
public interface LikeService {

    // 点赞
    Boolean like(Object objectId, Integer type);

    // 取消点赞
    Boolean unlike(Object objectId, Integer type);

    // 检查是否点赞
    Boolean check(Object objectId, Integer type);

    // 取消所有点赞
    void unlikeAll(Object objectId, Integer type);
}
