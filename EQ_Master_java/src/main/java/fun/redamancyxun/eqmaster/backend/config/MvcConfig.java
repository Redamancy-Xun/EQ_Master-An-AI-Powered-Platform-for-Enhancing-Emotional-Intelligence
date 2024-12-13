package fun.redamancyxun.eqmaster.backend.config;


import fun.redamancyxun.eqmaster.backend.util.SpringInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
class MvcConfig implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {

        registry.addInterceptor(new SpringInterceptor()).addPathPatterns("/**");
    }
}