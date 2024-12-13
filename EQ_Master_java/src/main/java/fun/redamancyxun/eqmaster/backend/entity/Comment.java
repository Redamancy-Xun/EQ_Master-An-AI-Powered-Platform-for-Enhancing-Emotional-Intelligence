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

@ApiModel("comment 评论")
@TableName(value ="comment")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Comment implements Serializable {

    @ApiModelProperty("评论id")
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty("评论者id")
    @TableField(value = "user_id")
    private String userId;

    @ApiModelProperty("评论时间")
    @TableField(value = "create_time",fill = FieldFill.INSERT)
    private LocalDateTime createTime;

//    @ApiModelProperty("被回复者id")
//    @TableField(value = "to_user_id")
//    private String toUserId;

    @ApiModelProperty("点赞数")
    @TableField(value = "likes")
    private Integer likes;

    @ApiModelProperty("评论数")
    @TableField(value = "reply")
    private Integer reply;

    @ApiModelProperty("评论内容(表情包的实现暂时不清楚、先认为可以和文章混在一起)")
    @TableField(value = "content")
    private String content;

    @ApiModelProperty("评论图片")
    @TableField(value = "picture")
    private String picture;

    @ApiModelProperty("删除时间")
    @TableField(value = "delete_time")
    private LocalDateTime deleteTime;

    @ApiModelProperty("评论的每日分享id")
    @TableField(value = "daily_share_id")
    private String dailyShareId;

    @ApiModelProperty("置顶(0默认,1置顶)")
    @TableField(value = "top")
    private Integer top;

}