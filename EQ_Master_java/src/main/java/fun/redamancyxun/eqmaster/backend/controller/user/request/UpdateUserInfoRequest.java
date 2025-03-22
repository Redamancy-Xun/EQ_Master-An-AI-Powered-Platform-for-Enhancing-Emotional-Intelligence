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

    @ApiModelProperty("性别" +
            "【" +
            "0：未知 " +
            "1：男 " +
            "2：女" +
            "】")
    private Integer gender;

    @ApiModelProperty("年龄" +
            "【" +
            "0：未知" +
            "】")
    private Integer age;

    @ApiModelProperty("职业" +
            "【" +
            "0：未知 " +
            "1：学生（中学生、本科生、研究生） " +
            "2：上班族 " +
            "3：企业家/创业者 " +
            "4：自由职业者 " +
            "5：公务员/事业单位工作人员" +
            "】")
    private Integer profession;

    @ApiModelProperty("工作沟通困难对象身份" +
            "【" +
            "0：未知 " +
            "1：上级 " +
            "2：同事 " +
            "3：下级 " +
            "4：客户 " +
            "5：老师 " +
            "6：同学" +
            "】")
    private Integer workCommunicationDifficulty;

    @ApiModelProperty("生活沟通困难对象身份" +
            "【" +
            "0：未知 " +
            "1：子女、其他后辈 " +
            "2：父母、其他长辈 " +
            "3：兄弟/姐妹 " +
            "4：伴侣 " +
            "5：朋友 " +
            "6：陌生人" +
            "】")
    private Integer lifeCommunicationDifficulty;
}
