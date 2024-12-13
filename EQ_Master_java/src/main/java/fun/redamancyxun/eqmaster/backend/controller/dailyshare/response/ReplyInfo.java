package fun.redamancyxun.eqmaster.backend.controller.dailyshare.response;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import fun.redamancyxun.eqmaster.backend.common.CommonConstants;
import fun.redamancyxun.eqmaster.backend.entity.Reply;
import fun.redamancyxun.eqmaster.backend.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ApiModel("ReplyDto 回复")
public class ReplyInfo {

    @ApiModelProperty("id")
    private Integer id;

    @ApiModelProperty("commentId")
    private Integer commentId;

    @ApiModelProperty("回复的回复id")
    private Integer replyId;

    @ApiModelProperty("用户id")
    private String userId;

    @ApiModelProperty("用户名字")
    private String userName;

    @ApiModelProperty("用户头像")
    private String userAvatar;

    @ApiModelProperty("被回复的用户id")
    private String toUserId;

    @ApiModelProperty("被回复的用户头像")
    private String replyUserAvatar;

    @ApiModelProperty("被回复的用户名字")
    private String replyUserName;

    @ApiModelProperty("dailyShareId")
    private String dailyShareId;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @ApiModelProperty("创建时间")
    private LocalDateTime createTime;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @ApiModelProperty("删除时间")
    private LocalDateTime deleteTime;

    @ApiModelProperty("内容")
    private String content;

    @ApiModelProperty("图片")
    private List<String> picture;

    @ApiModelProperty("回复类型(0为评论，1为回复)")
    private Integer type;

    @ApiModelProperty("点赞数")
    private Integer like;

    @ApiModelProperty("是否点赞")
    private Boolean isLike;

    public ReplyInfo(Reply reply, User user, User replyUser, Boolean isLike) {
        this.id = reply.getId();
        this.commentId = reply.getCommentId();
        this.replyId = reply.getReplyId();
        this.userId = reply.getUserId();
        this.toUserId = reply.getToUserId();
        this.dailyShareId = reply.getDailyShareId();
        this.createTime = reply.getCreateTime();
        this.deleteTime = reply.getDeleteTime();
        this.content = reply.getContent();
        this.like = reply.getLikes();
        this.type = reply.getType();

        this.userName = user.getUsername();
        this.userAvatar = user.getPortrait();

        this.replyUserAvatar = replyUser.getPortrait();
        this.replyUserName = replyUser.getUsername();

        this.isLike = isLike;

        String picture = reply.getPicture();
        this.picture = JSON.parseObject(picture, new TypeReference<List<String>>(){});
    }

    public ReplyInfo(Reply reply, User user, Boolean isLike) {
        this.id = reply.getId();
        this.commentId = reply.getCommentId();
        this.replyId = reply.getReplyId();
        this.userId = reply.getUserId();
        this.toUserId = reply.getToUserId();
        this.dailyShareId = reply.getDailyShareId();
        this.createTime = reply.getCreateTime();
        this.deleteTime = reply.getDeleteTime();
        this.content = reply.getContent();
        this.like = reply.getLikes();
        this.type = reply.getType();

        this.userName = user.getUsername();
        this.userAvatar = user.getPortrait();

        this.isLike = isLike;

        String picture = reply.getPicture();
        this.picture = JSON.parseObject(picture, new TypeReference<List<String>>(){});

//        //如果image里面有对象 给picture中的每一个对象加上IMAGE_PATH前缀
//        if (this.picture != null && this.picture.size() > 0){
//            for (int i = 0; i < this.picture.size(); i++) {
//                this.picture.set(i, CommonConstants.IMAGE_PATH + this.picture.get(i));
//            }
//        }
    }
}
