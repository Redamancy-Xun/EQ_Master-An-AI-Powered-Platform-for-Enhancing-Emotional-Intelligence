package fun.redamancyxun.eqmaster.backend.controller.user.request;

import com.baomidou.mybatisplus.annotation.TableField;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Slf4j
@ApiModel("更新用户信息请求")
public class UpdateUserInfoRequest {

    @ApiModelProperty("用户名")
    private String username;

    @ApiModelProperty("个性签名")
    private String signature;

    @ApiModelProperty("性别(0男,1女,2未知)")
    private Integer gender;

    @ApiModelProperty("年龄")
    private Integer age;

    @ApiModelProperty("国籍")
    private String nation;

    @ApiModelProperty("省份")
    private String province;

    @ApiModelProperty("城市")
    private String city;
}
