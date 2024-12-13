package fun.redamancyxun.eqmaster.backend.controller.user.response;

import com.baomidou.mybatisplus.annotation.TableField;
import fun.redamancyxun.eqmaster.backend.entity.EmotionalIntelligence;
import fun.redamancyxun.eqmaster.backend.entity.TestScore;
import fun.redamancyxun.eqmaster.backend.entity.User;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Slf4j
@ApiModel("详细用户信息")
public class UserInfoResponse {

    @ApiModelProperty("id")
    private String id;
    
    @ApiModelProperty("用户名")
    private String username;

    @ApiModelProperty("手机号")
    private String telephone;

    @ApiModelProperty("头像")
    private String portrait;

    @ApiModelProperty("个性签名")
    private String signature;

    @ApiModelProperty("获赞数")
    private Integer likeCount;

    @ApiModelProperty("评论数")
    private Integer commentCount;

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

    @ApiModelProperty("SessionId")
    private String sessionId;

    @ApiModelProperty("情商记录")
    private List<EmotionalIntelligence> EQHistory;

    @ApiModelProperty("测评记录")
    private List<TestScore> testScoreHistory;


    public UserInfoResponse(User user, List<EmotionalIntelligence> EQHistory, List<TestScore> testScoreHistory) {
        this.id = user.getId();
        this.username = user.getUsername();
        this.telephone = user.getTelephone();
        this.portrait = user.getPortrait();
        this.commentCount = user.getCommentCount();
        this.likeCount = user.getLikeCount();
        this.signature = user.getSignature();
        this.gender = user.getGender();
        this.role = user.getRole();
        this.nation = user.getNation();
        this.province = user.getProvince();
        this.city = user.getCity();
        this.age = user.getAge();
        this.EQHistory = EQHistory;
        this.testScoreHistory = testScoreHistory;

        this.sessionId = null;
    }

    public UserInfoResponse(User user) {
        this.id = user.getId();
        this.username = user.getUsername();
        this.telephone = user.getTelephone();
        this.portrait = user.getPortrait();
        this.commentCount = user.getCommentCount();
        this.likeCount = user.getLikeCount();
        this.signature = user.getSignature();
        this.gender = user.getGender();
        this.role = user.getRole();
        this.nation = user.getNation();
        this.province = user.getProvince();
        this.city = user.getCity();
        this.age = user.getAge();

        this.EQHistory = null;
        this.testScoreHistory = null;
        this.sessionId = null;
    }

    public UserInfoResponse(User user, String sessionId) {
        this.id = user.getId();
        this.username = user.getUsername();
        this.telephone = user.getTelephone();
        this.portrait = user.getPortrait();
        this.commentCount = user.getCommentCount();
        this.likeCount = user.getLikeCount();
        this.signature = user.getSignature();
        this.gender = user.getGender();
        this.role = user.getRole();
        this.nation = user.getNation();
        this.province = user.getProvince();
        this.city = user.getCity();
        this.age = user.getAge();
        this.sessionId = sessionId;

        this.EQHistory = null;
        this.testScoreHistory = null;
    }
}
