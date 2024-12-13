package fun.redamancyxun.eqmaster.backend.dto;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import fun.redamancyxun.eqmaster.backend.entity.User;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.List;

/**
 * session缓存实体
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ApiModel("SessionData 会话实体")
public class SessionData  implements Serializable {

    @ApiModelProperty("id")
    private String id;

    @ApiModelProperty("用户名")
    private String username;

//    @ApiModelProperty("性别(0男，1女，2其他)")
//    @TableField(value = "gender")
//    private Integer gender;
//
//    @ApiModelProperty("年龄")
//    @TableField(value = "age")
//    private Integer age;
//
//    @ApiModelProperty("国籍")
//    @TableField(value = "nation")
//    private String nation;

    @ApiModelProperty("手机号")
    private String telephone;

    @ApiModelProperty("头像")
    private String portrait;

//    @ApiModelProperty("身份(0是学生，1是老师)")
//    @TableField(value = "role")
//    private Integer role;

    @ApiModelProperty("个性签名")
    private String signature;

    @ApiModelProperty("获赞数")
    private Integer likeCount;

    @ApiModelProperty("评论数")
    private Integer commentCount;

    @ApiModelProperty("收藏数")
    private Integer starCount;

    @ApiModelProperty("转发数")
    private Integer shareCount;

    @ApiModelProperty("性别(0男,1女,2未知)")
    private Integer gender;

    @ApiModelProperty("年龄")
    private Integer age;

    @ApiModelProperty("身份(0是超级管理员，1是管理员，2是已认证用户，3是同意协议用户，4是未同意协议用户)")
    private Integer role;

    @ApiModelProperty("国籍")
    private String nation;

    @ApiModelProperty("省份")
    private String province;

    @ApiModelProperty("城市")
    private String city;


//    public SessionData(User user, List<ScoreAction> history) {
//        this.id = user.getId();
//        this.username = user.getUsername();
//        this.gender = user.getGender();
//        this.age = user.getAge();
//        this.nation = user.getNation();
//        this.telephone = user.getTelephone();
//        this.portrait = user.getPortrait();
//        this.role = user.getRole();
//        this.advice = user.getAdvice();
//
//        this.history = history;
//    }

    public SessionData(User user) {
        this.id = user.getId();
        this.username = user.getUsername();
        this.telephone = user.getTelephone();
        this.portrait = user.getPortrait();
        this.commentCount = user.getCommentCount();
        this.starCount = user.getStarCount();
        this.shareCount = user.getShareCount();
        this.gender = user.getGender();
        this.age = user.getAge();
        this.role = user.getRole();
        this.nation = user.getNation();
        this.province = user.getProvince();
        this.city = user.getCity();
        this.signature = user.getSignature();
        this.likeCount = user.getLikeCount();

    }

}
