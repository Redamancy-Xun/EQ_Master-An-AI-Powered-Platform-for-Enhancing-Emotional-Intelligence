package fun.redamancyxun.eqmaster.backend.service.impl;

import fun.redamancyxun.eqmaster.backend.mapper.DailyShareMapper;
import fun.redamancyxun.eqmaster.backend.service.ViewService;
import fun.redamancyxun.eqmaster.backend.util.RedisUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

import static fun.redamancyxun.eqmaster.backend.common.CommonConstants.VIEW;

/**
 * @author Redamancy
 * @description 针对浏览量的服务接口实现
 * @createDate 2024-04-03 22:39:04
 */
@Service
public class ViewServiceImpl implements ViewService {

    @Autowired
    private RedisUtils redisUtils;

    @Autowired
    private DailyShareMapper dailyShareMapper;

    /**
     * 生成redis中的key
     * @param objectId 对象id
     * @return redis中的key
     */
    private String VIEW_COUNT(String objectId) {
        return objectId;
    }

    /**
     * 从redis中获取浏览量
     * @param dailyShareId 帖子id
     * @return 浏览量
     */
    private Long getViewsFromRedis(String dailyShareId) {
        try {
            return (Long)redisUtils.hget(VIEW, VIEW_COUNT(dailyShareId));
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 增加浏览量
     * @param dailyShareId 帖子id
     * @return 增加后的浏览量
     */
    @Override
    public Long addView(String dailyShareId) {
        Long views = getView(dailyShareId);
        Map<String, Object> viewCount = new HashMap<>();
        viewCount.put(VIEW_COUNT(dailyShareId), views + 1);
        redisUtils.hmset(VIEW, viewCount);

        return views + 1 ;
    }

    /**
     * 获取浏览量
     * @param dailyShareId 帖子id
     * @return 浏览量
     */
    @Override
    public Long getView(String dailyShareId) {
        Long views = getViewsFromRedis(dailyShareId);
        if (views != null) return views;
        views = dailyShareMapper.selectById(dailyShareId).getView();
        Map<String, Object> viewCount = new HashMap<>();
        viewCount.put(VIEW_COUNT(dailyShareId), views);
        redisUtils.hmset(VIEW, viewCount);

        return views;
    }

}