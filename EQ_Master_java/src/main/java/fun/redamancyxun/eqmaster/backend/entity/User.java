package fun.redamancyxun.eqmaster.backend.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.List;

@ApiModel("user 用户信息")
@TableName(value ="user")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User implements Serializable {

    @ApiModelProperty("id")
    @TableId(value = "id")
    private String id;

    @ApiModelProperty("邮箱")
    @TableField(value = "email")
    private String email;

    @ApiModelProperty("密码")
    @TableField(value = "password")
    private String password;

    @ApiModelProperty("用户名")
    @TableField(value = "username")
    private String username;

    @ApiModelProperty("头像")
    @TableField(value = "portrait")
    private String portrait;

    @ApiModelProperty("个性签名")
    @TableField(value = "signature")
    private String signature;

    @ApiModelProperty("性别" +
            "【" +
            "0：未知 " +
            "1：男 " +
            "2：女" +
            "】")
    @TableField(value = "gender")
    private Integer gender;

    @ApiModelProperty("年龄" +
            "【" +
            "0：未知" +
            "】")
    @TableField(value = "age")
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
    @TableField(value = "profession")
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
    @TableField(value = "work_communication_difficulty")
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
    @TableField(value = "life_communication_difficulty")
    private Integer lifeCommunicationDifficulty;

    @ApiModelProperty("点赞数")
    @TableField(value = "like_count")
    private Integer likeCount;

    @ApiModelProperty("收藏数")
    @TableField(value = "star_count")
    private Integer starCount;

    @ApiModelProperty("分享交互数")
    @TableField(value = "interaction_count")
    private Integer interactionCount;

    @ApiModelProperty("身份(0是超级管理员，1是管理员，2是已认证用户，3是同意协议用户，4是未同意协议用户)")
    @TableField(value = "role")
    private Integer role;
}