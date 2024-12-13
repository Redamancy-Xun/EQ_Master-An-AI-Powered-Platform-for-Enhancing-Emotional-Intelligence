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
@ApiModel("CreateReplyParams")
public class CreateReplyParams {

    @ApiModelProperty("回复的评论id")
    private Integer commentId;

    @ApiModelProperty("回复的回复id")
    private Integer replyId;

    @ApiModelProperty("内容")
    private String content;

    @ApiModelProperty("图片")
    private List<String> picture;

    @ApiModelProperty("回复类型(0为评论，1为回复)")
    private Integer type;
}
