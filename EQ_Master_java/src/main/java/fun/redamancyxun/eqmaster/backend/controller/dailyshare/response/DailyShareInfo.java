package fun.redamancyxun.eqmaster.backend.controller.dailyshare.response;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import fun.redamancyxun.eqmaster.backend.common.CommonConstants;
import fun.redamancyxun.eqmaster.backend.entity.DailyShare;
import fun.redamancyxun.eqmaster.backend.entity.User;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Data
@NoArgsConstructor
@ApiModel("articleInfo")
public class DailyShareInfo {

    @ApiModelProperty("id")
    private String id;
//
//    @ApiModelProperty("创建时间")
//    private LocalDateTime createTime;
//
//    @ApiModelProperty("删除时间")
//    private LocalDateTime deleteTime;

    @ApiModelProperty("是否点赞")
    private Boolean isLike;

    @ApiModelProperty("是否收藏")
    private Boolean isStar;

    @ApiModelProperty("是否转发")
    private Boolean isShare;

    @ApiModelProperty("类型")
    private String type;

    @ApiModelProperty("主题")
    private String title;

    @ApiModelProperty("内容")
    private String context;

    @ApiModelProperty("图片")
    private String picture;

    @ApiModelProperty("点赞数")
    private Integer likes;

    @ApiModelProperty("浏览数")
    private Long view;

    @ApiModelProperty("评论数")
    private Integer commentCount;

    @ApiModelProperty("收藏数")
    private Integer favorite;

    @ApiModelProperty("分享数")
    private Integer share;

    public DailyShareInfo(DailyShare dailyShare, Boolean isLike, Boolean isStar, Boolean isShare){
        this.id = dailyShare.getId();
//        this.createTime = dailyShare.getCreateTime();
//        this.deleteTime = dailyShare.getDeleteTime();
        this.context = dailyShare.getContext();
        this.view = dailyShare.getView();
        this.likes = dailyShare.getLikes();
        this.favorite = dailyShare.getFavorite();
        this.commentCount = dailyShare.getCommentCount();
        this.share = dailyShare.getShare();
        this.type = dailyShare.getType();
        this.title = dailyShare.getTitle();
        this.picture = dailyShare.getPicture();

        this.isLike = isLike;
        this.isStar = isStar;
        this.isShare = isShare;
    }
}







