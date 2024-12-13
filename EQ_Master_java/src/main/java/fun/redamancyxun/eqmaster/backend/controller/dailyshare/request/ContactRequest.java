package fun.redamancyxun.eqmaster.backend.controller.dailyshare.request;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ApiModel("ContactRequest")
public class ContactRequest {

    @ApiModelProperty("内容")
    private String content;

    @ApiModelProperty("图片")
    private List<String> images;
}



