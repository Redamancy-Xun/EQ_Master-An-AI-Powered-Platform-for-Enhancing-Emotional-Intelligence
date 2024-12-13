package fun.redamancyxun.eqmaster.backend.controller.testscore.response;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
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
@ApiModel("TestScoreInfo")
public class TestScoreInfo {

    @ApiModelProperty("测验id")
    private String testId;

    @ApiModelProperty("测验分数")
    private Double score;

    @ApiModelProperty("创建时间")
    private LocalDateTime createTime;

}
