package fun.redamancyxun.eqmaster.backend.controller.dailyshare.response;

import fun.redamancyxun.eqmaster.backend.common.CommonConstants;
import fun.redamancyxun.eqmaster.backend.entity.Notice;
import fun.redamancyxun.eqmaster.backend.entity.User;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ApiModel("NoticeDto 通知")
public class NoticeInfo {

    @ApiModelProperty("通知id")
    private Integer id;

    @ApiModelProperty("发送者id")
    private String senderId;

    @ApiModelProperty("接收者id")
    private String receiverId;

    @ApiModelProperty("objectId")
    private Object objectId;

    @ApiModelProperty("操作对象object")
    private Object object;

    @ApiModelProperty("通知内容")
    private String content;

    @ApiModelProperty("信息对象类型（0:系统(可以细分，或者就直接只给文字信息) 1:给每日分享点赞  2:给每日分享的评论点赞 3:给每日分享评论的回复点赞  4:  5:给每日分享的评论回复 6:给每日分享评论的回复回复 7:每日分享被收藏 8:  9: ）")
    private Integer type;

    @ApiModelProperty("发送时间")
    private LocalDateTime createTime;

    @ApiModelProperty("删除时间")
    private LocalDateTime deleteTime;

    @ApiModelProperty("发送者用户昵称")
    private String userName;

    @ApiModelProperty("发送者用户头像")
    private String userAvatar;

    @ApiModelProperty("是否已读")
    private Integer isRead;

    public NoticeInfo(Notice notice, User user, Object object){
        this.content = notice.getContent();
        this.deleteTime = notice.getDeleteTime();
        this.id = notice.getId();
        this.objectId = Long.valueOf(notice.getObjectId());
        this.receiverId = notice.getReceiverId();
        this.createTime = notice.getCreateTime();
        this.senderId = notice.getSenderId();
        this.type = notice.getType();
        this.isRead = notice.getIsRead();

        this.userAvatar = user.getPortrait();
        this.userName = user.getUsername();

        this.object = object;
    }

    public NoticeInfo(Notice notice, User user){
        this.content = notice.getContent();
        this.deleteTime = notice.getDeleteTime();
        this.id = notice.getId();
        this.objectId = Long.valueOf(notice.getObjectId());
        this.receiverId = notice.getReceiverId();
        this.createTime = notice.getCreateTime();
        this.senderId = notice.getSenderId();
        this.type = notice.getType();
        this.isRead = notice.getIsRead();

        this.userAvatar = user.getPortrait();
        this.userName = user.getUsername();
    }

    public NoticeInfo(Notice notice) {
        this.content = notice.getContent();
        this.deleteTime = notice.getDeleteTime();
        this.id = notice.getId();
        this.objectId = Long.valueOf(notice.getObjectId());
        this.receiverId = notice.getReceiverId();
        this.createTime = notice.getCreateTime();
        this.senderId = notice.getSenderId();
        this.type = notice.getType();
        this.isRead = notice.getIsRead();
    }
}
