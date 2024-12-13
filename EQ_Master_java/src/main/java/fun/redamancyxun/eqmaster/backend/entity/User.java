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

    @ApiModelProperty("密码")
    @TableField(value = "password")
    private String password;

    @ApiModelProperty("用户名")
    @TableField(value = "username")
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
    @TableField(value = "telephone")
    private String telephone;

    @ApiModelProperty("头像")
    @TableField(value = "portrait")
    private String portrait;

//    @ApiModelProperty("身份(0是学生，1是老师)")
//    @TableField(value = "role")
//    private Integer role;

    @ApiModelProperty("个性签名")
    @TableField(value = "signature")
    private String signature;

    @ApiModelProperty("获赞数")
    @TableField(value = "like_count")
    private Integer likeCount;

    @ApiModelProperty("评论数")
    @TableField(value = "comment_count")
    private Integer commentCount;

    @ApiModelProperty("收藏数")
    @TableField(value = "star_count")
    private Integer starCount;

    @ApiModelProperty("转发数")
    @TableField(value = "share_count")
    private Integer shareCount;

    @ApiModelProperty("性别(0男,1女,2未知)")
    @TableField(value = "gender")
    private Integer gender;

    @ApiModelProperty("年龄")
    @TableField(value = "age")
    private Integer age;

    @ApiModelProperty("身份(0是超级管理员，1是管理员，2是已认证用户，3是同意协议用户，4是未同意协议用户)")
    @TableField(value = "role")
    private Integer role;

    @ApiModelProperty("国籍")
    @TableField(value = "nation")
    private String nation;

    @ApiModelProperty("省份")
    @TableField(value = "province")
    private String province;

    @ApiModelProperty("城市")
    @TableField(value = "city")
    private String city;
}