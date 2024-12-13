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

@ApiModel("reply 回复")
@TableName(value ="reply")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Reply implements Serializable {

    @ApiModelProperty("回复id")
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty("回复的评论id")
    @TableField(value = "comment_id")
    private Integer commentId;

    @ApiModelProperty("回复的回复id")
    @TableField(value = "reply_id")
    private Integer replyId;

    @ApiModelProperty("回复者id")
    @TableField(value = "user_id")
    private String userId;

    @ApiModelProperty("被回复者id")
    @TableField(value = "to_user_id")
    private String toUserId;

    @ApiModelProperty("回复的每日分享id")
    @TableField(value = "daily_share_id")
    private String dailyShareId;

    @ApiModelProperty("回复时间")
    @TableField(value = "create_time",fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @ApiModelProperty("删除时间")
    @TableField(value = "delete_time")
    private LocalDateTime deleteTime;

    @ApiModelProperty("评论内容(表情包的实现暂时不清楚、先认为可以和文章混在一起)")
    @TableField(value = "content")
    private String content;

    @ApiModelProperty("点赞数")
    @TableField(value = "likes")
    private Integer likes;

    @ApiModelProperty("评论图片")
    @TableField(value = "picture")
    private String picture;

    @ApiModelProperty("回复类型(0为评论，1为回复)")
    @TableField(value = "type")
    private Integer type;

}