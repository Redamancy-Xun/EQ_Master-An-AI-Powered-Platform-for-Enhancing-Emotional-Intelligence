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

    @ApiModelProperty("邮箱")
    private String email;

    @ApiModelProperty("头像")
    private String portrait;

    @ApiModelProperty("个性签名")
    private String signature;

    @ApiModelProperty("点赞数")
    private Integer likeCount;

    @ApiModelProperty("收藏数")
    private Integer starCount;

    @ApiModelProperty("分享交互数")
    private Integer interactionCount;

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

    @ApiModelProperty("身份(0是超级管理员，1是管理员，2是已认证用户，3是同意协议用户，4是未同意协议用户)")
    private Integer role;

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

    @ApiModelProperty("SessionId")
    private String sessionId;

    @ApiModelProperty("情商记录")
    private List<EmotionalIntelligence> EQHistory;

    @ApiModelProperty("测评记录")
    private List<TestScore> testScoreHistory;


    public UserInfoResponse(User user, List<EmotionalIntelligence> EQHistory, List<TestScore> testScoreHistory) {
        this.id = user.getId();
        this.username = user.getUsername();
        this.email = user.getEmail();
        this.portrait = user.getPortrait();
        this.likeCount = user.getLikeCount();
        this.starCount = user.getStarCount();
        this.interactionCount = user.getInteractionCount();
        this.signature = user.getSignature();
        this.gender = user.getGender();
        this.role = user.getRole();
        this.profession = user.getProfession();
        this.workCommunicationDifficulty = user.getWorkCommunicationDifficulty();
        this.lifeCommunicationDifficulty = user.getLifeCommunicationDifficulty();
        this.age = user.getAge();
        this.EQHistory = EQHistory;
        this.testScoreHistory = testScoreHistory;

        this.sessionId = null;
    }

    public UserInfoResponse(User user) {
        this.id = user.getId();
        this.username = user.getUsername();
        this.email = user.getEmail();
        this.portrait = user.getPortrait();
        this.likeCount = user.getLikeCount();
        this.starCount = user.getStarCount();
        this.interactionCount = user.getInteractionCount();
        this.signature = user.getSignature();
        this.gender = user.getGender();
        this.role = user.getRole();
        this.profession = user.getProfession();
        this.workCommunicationDifficulty = user.getWorkCommunicationDifficulty();
        this.lifeCommunicationDifficulty = user.getLifeCommunicationDifficulty();
        this.age = user.getAge();

        this.EQHistory = null;
        this.testScoreHistory = null;
        this.sessionId = null;
    }

    public UserInfoResponse(User user, String sessionId) {
        this.id = user.getId();
        this.username = user.getUsername();
        this.email = user.getEmail();
        this.portrait = user.getPortrait();
        this.likeCount = user.getLikeCount();
        this.starCount = user.getStarCount();
        this.interactionCount = user.getInteractionCount();
        this.signature = user.getSignature();
        this.gender = user.getGender();
        this.role = user.getRole();
        this.profession = user.getProfession();
        this.workCommunicationDifficulty = user.getWorkCommunicationDifficulty();
        this.lifeCommunicationDifficulty = user.getLifeCommunicationDifficulty();
        this.age = user.getAge();
        this.sessionId = sessionId;

        this.EQHistory = null;
        this.testScoreHistory = null;
    }
}
