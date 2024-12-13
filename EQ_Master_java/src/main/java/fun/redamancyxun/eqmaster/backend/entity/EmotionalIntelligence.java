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

@ApiModel("EmotionalIntelligence 情商")
@TableName(value ="emotional_intelligence")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EmotionalIntelligence implements Serializable {

    @ApiModelProperty("情商id")
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty("用户id")
    @TableField(value = "user_id")
    private String userId;

    @ApiModelProperty("情商值")
    @TableField(value = "emotional_intelligence")
    private Double emotionalIntelligence;

    @ApiModelProperty("创建时间")
    @TableField(value = "create_time",fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @ApiModelProperty("删除时间")
    @TableField(value = "delete_time")
    private LocalDateTime deleteTime;
}
