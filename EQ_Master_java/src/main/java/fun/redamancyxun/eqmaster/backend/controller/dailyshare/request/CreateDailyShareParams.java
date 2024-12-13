package fun.redamancyxun.eqmaster.backend.controller.dailyshare.request;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
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
@ApiModel("CreateDailyShareParams")
public class CreateDailyShareParams {

    @ApiModelProperty("id")
    private String id;

    @ApiModelProperty("类型")
    private String type;

    @ApiModelProperty("主题")
    private String title;

    @ApiModelProperty("内容")
    private String context;

    @ApiModelProperty("图片")
    private String picture;
}
