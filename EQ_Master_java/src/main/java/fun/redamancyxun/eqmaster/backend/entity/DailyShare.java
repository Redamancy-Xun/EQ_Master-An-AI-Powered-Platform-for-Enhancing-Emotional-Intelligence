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

@ApiModel("daily_share 每日分享")
@TableName(value ="daily_share")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DailyShare implements Serializable {

    @ApiModelProperty("每日分享id")
    @TableId(value = "id")
    private String id;

    @ApiModelProperty("发布时间")
    @TableField(value = "create_time",fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @ApiModelProperty("类型")
    @TableField(value = "type")
    private String type;

    @ApiModelProperty("主题")
    @TableField(value = "title")
    private String title;

    @ApiModelProperty("内容")
    @TableField(value = "context")
    private String context;

    @ApiModelProperty("图片")
    @TableField(value = "picture")
    private String picture;
//
//    @ApiModelProperty("联系方式")
//    @TableField(value = "contact")
//    private String contact;

    @ApiModelProperty("点赞数")
    @TableField(value = "likes")
    private Integer likes;

    @ApiModelProperty("浏览数")
    @TableField(value = "view")
    private Long view;

    @ApiModelProperty("分享交互数")
    @TableField(value = "interaction")
    private Integer interaction;

    @ApiModelProperty("收藏数")
    @TableField(value = "favorite")
    private Integer favorite;

    @ApiModelProperty("分享数")
    @TableField(value = "share")
    private Integer share;

    @ApiModelProperty("热度值")
    @TableField(value = "hot")
    private Double hot;

    @ApiModelProperty("状态" +
            "【" +
            "0：可见 " +
            "1：不可见" +
            "】")
    @TableField(value = "status")
    private Integer status;

    @ApiModelProperty("删除时间")
    @TableField(value = "delete_time")
    private LocalDateTime deleteTime;

    @ApiModelProperty("置顶状态" +
            "【" +
            "0：默认 " +
            "1：置顶" +
            "】")
    @TableField(value = "top")
    private Integer top;

}