package fun.redamancyxun.eqmaster.backend.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

import java.util.concurrent.TimeUnit;

//复杂服务的redis工具类
@Component
public class RedisUtilComplex {

    @Autowired
    private RedisTemplate redisTemplate;

    @Autowired
    private RedisUtil redisUtil;

    //设置过期时间为时刻
    public boolean set(String key, Object value, Long timeMillis){

        Long expire_time = timeMillis - System.currentTimeMillis();

        try {
            if (expire_time > 0) {
                redisTemplate.opsForValue().set(key, value, expire_time, TimeUnit.MILLISECONDS);
            } else {
                redisUtil.set(key, value);
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}
