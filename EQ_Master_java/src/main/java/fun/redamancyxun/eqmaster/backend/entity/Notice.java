package fun.redamancyxun.eqmaster.backend.entity;

import com.baomidou.mybatisplus.annotation.*;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.time.LocalDateTime;

@ApiModel("notice 通知")
@TableName(value ="notice")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Notice implements Serializable {

    @ApiModelProperty("信息id")
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty("信息发送者id")
    @TableField(value = "sender_id")
    private String senderId;

    @ApiModelProperty("信息接收人id")
    @TableField(value = "receiver_id")
    private String receiverId;

    @ApiModelProperty("信息对象id")
    @TableField(value = "object_id")
    private String objectId;

    @ApiModelProperty("信息内容")
    @TableField(value = "content")
    private String content;

    @ApiModelProperty("信息对象类型（0:系统(可以细分，或者就直接只给文字信息) 1:给每日分享点赞  2:给每日分享的评论点赞 3:给每日分享评论的回复点赞  4:  5:给每日分享的评论回复 6:给每日分享评论的回复回复 7:每日分享被收藏 8:  9: ）")
    @TableField(value = "type")
    private Integer type;

    @ApiModelProperty("信息发送时间")
    @TableField(value = "create_time",fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @ApiModelProperty("信息删除时间")
    @TableField(value = "delete_time")
    private LocalDateTime deleteTime;

    @ApiModelProperty("信息是否已读（0为已读，1为未读）")
    @TableField(value = "is_read")
    private Integer isRead;

}