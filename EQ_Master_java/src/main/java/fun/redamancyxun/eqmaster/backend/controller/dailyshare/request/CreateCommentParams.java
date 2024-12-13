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
@ApiModel("CreateCommentParams")
public class CreateCommentParams {

    @ApiModelProperty("每日分享id")
    private String dailyShareId;

    @ApiModelProperty("评论内容")
    private String content;

    @ApiModelProperty("评论图片")
    private List<String> picture;
}
