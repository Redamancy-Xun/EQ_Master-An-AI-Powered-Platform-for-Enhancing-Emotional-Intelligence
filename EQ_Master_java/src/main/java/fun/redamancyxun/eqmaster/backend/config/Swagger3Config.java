package fun.redamancyxun.eqmaster.backend.config;//package fun.redamancyxun.chinese.backend.config;
//
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import springfox.documentation.builders.ApiInfoBuilder;
//import springfox.documentation.oas.annotations.EnableOpenApi;
//import springfox.documentation.service.*;
//import springfox.documentation.spi.DocumentationType;
//import springfox.documentation.spi.service.contexts.SecurityContext;
//import springfox.documentation.spring.web.plugins.Docket;
//
//import java.util.ArrayList;
//import java.util.Collections;
//import java.util.List;
//
//@Configuration
//@EnableOpenApi
//public class Swagger3Config {
//
//    @Bean
//    public Docket docket() {
//        return new Docket(DocumentationType.OAS_30).apiInfo(apiInfo())
//                .securitySchemes(securitySchemes())
//                .securityContexts(Collections.singletonList(securityContext()));
//    }
//
//    private ApiInfo apiInfo() {
//        return new ApiInfoBuilder()
//                .title("漫游城——citywalker社群平台先行者")
//                .description("接口文档")
//                //.termsOfServiceUrl("http://localhost:8080/swagger-ui.html")//数据源
//                .version("1.0")
//                .build();
//    }
//    private List<SecurityScheme> securitySchemes() {
//        List<SecurityScheme> apiKeyList= new ArrayList<>();
//        //注意，这里应对应登录token鉴权对应的k-v
//        apiKeyList.add(new ApiKey("session", "session", "header"));
//        return apiKeyList;
//    }
//
//    /**
//     * 这里设置 swagger2 认证的安全上下文
//     */
//    private SecurityContext securityContext() {
//        return SecurityContext.builder()
//                .securityReferences(Collections.singletonList(new SecurityReference("session", scopes())))
//                .build();
//    }
//
//    /**
//     * 这里是写允许认证的scope
//     */
//    private AuthorizationScope[] scopes() {
//        return new AuthorizationScope[]{
//                new AuthorizationScope("web", "All scope is trusted!")
//        };
//    }
//}
