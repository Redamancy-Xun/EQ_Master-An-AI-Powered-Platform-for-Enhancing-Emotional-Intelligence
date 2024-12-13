package fun.redamancyxun.eqmaster.backend.config;

import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

/**
 * 服务熔断配置
 *
 * @author miracle
 * @since 2021/11/22 17:57
 */
@Setter
@Configuration
@ConfigurationProperties("server-fuse")
public class ServerFuseConfig {

    /** 服务熔断（限流）总开关 */
    private Boolean fuse = Boolean.FALSE;
    /** 并发达到峰值时，是否允许继续执行程序，默认值false */
    private Boolean process = Boolean.FALSE;

    /** 接口并发数量 */
    private Integer concurrency = 10;
    /** 自定义接口并发数配置 */
    private Map<String, Integer> customConcurrencyMap = new HashMap<>(16);

    public Boolean getFuse() {
        return Optional.ofNullable(fuse).orElse(Boolean.FALSE);
    }

    public Boolean getProcess() {
        return Optional.ofNullable(process).orElse(Boolean.FALSE);
    }

    public Integer getConcurrency() {
        return Optional.ofNullable(concurrency).orElse(10);
    }

    public Map<String, Integer> getCustomConcurrencyMap() {
        return Optional.ofNullable(customConcurrencyMap).orElseGet(HashMap::new);
    }

}
