package fun.redamancyxun.eqmaster.backend.config;

import org.springframework.boot.autoconfigure.ImportAutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.web.socket.server.standard.ServerEndpointExporter;

@ImportAutoConfiguration//尝试在测试类中排除 WebSocket 相关的配置。使用 @ImportAutoConfiguration 注解来排除特定的自动配置类或者属性文件，从而避免加载 WebSocket 相关的配置。
//@Configuration
public class WebSocketConfig {
    /**
     * 	注入ServerEndpointExporter，
     * 	这个bean会自动注册使用了@ServerEndpoint注解声明的Websocket endpoint
     */
    @Bean
    public ServerEndpointExporter serverEndpointExporter() {
        return new ServerEndpointExporter();
    }
}