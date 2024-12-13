package fun.redamancyxun.eqmaster.backend.config;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

@Slf4j
@Component
public class MyMetaObjectHandler implements MetaObjectHandler {
    @Override
    public void insertFill(MetaObject metaObject) {
        if (this.getFieldValByName("createTime",metaObject) == null)
            this.setFieldValByName("createTime", LocalDateTime.now(),metaObject);
    }

    @Override
    public void updateFill(MetaObject metaObject) {
        if (this.getFieldValByName("updateTime",metaObject) == null)
            this.setFieldValByName("updateTime", LocalDateTime.now(),metaObject);
    }
}
