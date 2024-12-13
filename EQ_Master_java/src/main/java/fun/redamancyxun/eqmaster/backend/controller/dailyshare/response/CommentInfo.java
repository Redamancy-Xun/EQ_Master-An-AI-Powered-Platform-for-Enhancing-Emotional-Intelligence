package fun.redamancyxun.eqmaster.backend.controller.dailyshare.response;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import fun.redamancyxun.eqmaster.backend.entity.Comment;
import fun.redamancyxun.eqmaster.backend.entity.User;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Data
@NoArgsConstructor
@ApiModel("CommentInfo")
public class CommentInfo {

    @ApiModelProperty("评论id")
    private Integer id;

    @ApiModelProperty("每日分享Id")
    private String dailyShareId;

    @ApiModelProperty("用户id")
    private String userId;

    @ApiModelProperty("用户昵称")
    private String userName;

    @ApiModelProperty("用户头像")
    private String userAvatar;

    @ApiModelProperty("评论时间")
    private LocalDateTime createTime;

    @ApiModelProperty("删除时间")
    private LocalDateTime deleteTime;

    @ApiModelProperty("评论内容")
    private String content;

    @ApiModelProperty("评论图片")
    private List<String> picture;

    @ApiModelProperty("评论点赞数")
    private Integer likes;

    @ApiModelProperty("评论回复数")
    private Integer reply;

    @ApiModelProperty("是否点赞")
    private Boolean isLike;

    public CommentInfo(Comment comment, User user, Boolean isLike){
        this.id = comment.getId();
        this.dailyShareId = comment.getDailyShareId();
        this.userId = comment.getUserId();
        this.createTime = comment.getCreateTime();
        this.deleteTime = comment.getDeleteTime();
        this.content = comment.getContent();
        this.likes = comment.getLikes();
        this.reply = comment.getReply();

        this.userName = user.getUsername();
        this.userAvatar = user.getPortrait();

        this.isLike = isLike;

        String picture = comment.getPicture();
        this.picture = JSON.parseObject(picture, new TypeReference<List<String>>(){});
    }
}



