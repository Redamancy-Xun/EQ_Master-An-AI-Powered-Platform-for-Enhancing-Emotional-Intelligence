package fun.redamancyxun.eqmaster.backend.service.impl;

import fun.redamancyxun.eqmaster.backend.entity.DailyShare;
import fun.redamancyxun.eqmaster.backend.exception.EnumExceptionType;
import fun.redamancyxun.eqmaster.backend.exception.MyException;
import fun.redamancyxun.eqmaster.backend.mapper.DailyShareMapper;
import fun.redamancyxun.eqmaster.backend.service.ViewService;
import fun.redamancyxun.eqmaster.backend.util.RedisUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

import static fun.redamancyxun.eqmaster.backend.common.CommonConstants.VIEW;

/**
 * @author Redamancy
 * @description 储存的服务接口实现
 * @createDate 2024-04-03 22:39:04
 */
@Service
@Slf4j
public class ScheduledTasks {

    @Autowired
    private RedisUtils redisUtils;

    @Autowired
    private DailyShareMapper dailyShareMapper;

    @Autowired
    private ViewService viewService;

    /**
     * 浏览量入mysql库
     * @throws MyException 通用异常
     */
    @Transactional(rollbackFor = MyException.class)
    // 从午夜开始每12小时执行一次
    @Scheduled(cron = "0 0 0/12 * * ? ")
    public void views2database() throws MyException {
        Map<Object, Object> viewCount = redisUtils.hmget(VIEW);

        // 如果redis中没有浏览量 不做处理
        if (viewCount == null || viewCount.isEmpty()) {
            return;
        }

        // 遍历redis中的浏览量
        for (Map.Entry<Object, Object> entry : viewCount.entrySet()) {
            if (!(entry.getKey() instanceof Long) || !(entry.getValue() instanceof Long)) {
                throw new MyException(EnumExceptionType.VIEW_COUNT_ERROR);
            }

            // 更新数据库中的浏览量
            DailyShare dailyShare = dailyShareMapper.selectById((Long) entry.getKey());
            dailyShare.setView((Long) entry.getValue());
            if (dailyShareMapper.updateById(dailyShare) == 0) {
                throw new MyException(EnumExceptionType.UPDATE_FAILED);
            }
        }

        // 5秒后删除redis中的浏览量
        try {
            Thread.sleep(1000 * 5);
            redisUtils.del(VIEW);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
