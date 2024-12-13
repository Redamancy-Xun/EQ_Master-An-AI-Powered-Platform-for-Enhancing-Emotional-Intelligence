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

@ApiModel("likes 点赞")
@TableName(value ="likes")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Likes implements Serializable {

    @ApiModelProperty("点赞id")
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty("点赞者id")
    @TableField(value = "user_id")
    private String userId;

    @ApiModelProperty("点赞对象id")
    @TableField(value = "object_id")
    private String objectId;

    @ApiModelProperty("0-每日分享 1-评论每日分享 2-回复每日分享评论 3-帖子 4-评论帖子 5-回复帖子评论")
    @TableField(value = "type")
    private Integer type;

    @ApiModelProperty("创建时间")
    @TableField(value = "create_time",fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @ApiModelProperty("被点赞者id")
    @TableField(value = "to_user_id")
    private String toUserId;

    @ApiModelProperty("删除时间")
    @TableField(value = "delete_time")
    private LocalDateTime deleteTime;

}