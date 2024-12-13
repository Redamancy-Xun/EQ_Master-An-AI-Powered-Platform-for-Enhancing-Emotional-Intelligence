package fun.redamancyxun.eqmaster.backend.config;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class JsonConfig {

    //将Bean命名为json,调用时创建一个Gson对象
    @Bean("json")
    public Gson json(){
        return new GsonBuilder().serializeNulls().create();
    }

}
