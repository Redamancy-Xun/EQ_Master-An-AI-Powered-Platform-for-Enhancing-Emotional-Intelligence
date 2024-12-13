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

@ApiModel("share 转发")
@TableName(value ="share")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Share implements Serializable {

    @ApiModelProperty("每日分享id")
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty("转发的每日分享id")
    @TableField(value = "daily_share_id")
    private String dailyShareId;

    @ApiModelProperty("用户id")
    @TableField(value = "user_id")
    private String userId;

    @ApiModelProperty("创建时间")
    @TableField(value = "create_time",fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @ApiModelProperty("删除时间")
    @TableField(value = "delete_time")
    private LocalDateTime deleteTime;

}