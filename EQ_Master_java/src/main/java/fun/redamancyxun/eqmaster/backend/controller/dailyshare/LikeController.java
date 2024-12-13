package fun.redamancyxun.eqmaster.backend.controller.dailyshare;

import fun.redamancyxun.eqmaster.backend.annotation.Checked;
import fun.redamancyxun.eqmaster.backend.common.Result;
import fun.redamancyxun.eqmaster.backend.exception.MyException;
import fun.redamancyxun.eqmaster.backend.service.LikeService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.constraints.NotNull;

@RestController
@Slf4j
@Validated
@Api("LikeController")
@RequestMapping("/like")
public class LikeController {

    @Autowired
    private LikeService likeService;

    /**
     * 类型 0-每日分享 1-评论每日分享 2-回复每日分享评论 3-帖子 4-评论帖子 5-回复帖子评论
     * @param id
     * @param type 类型 0-每日分享 1-评论每日分享 2-回复每日分享评论 3-帖子 4-评论帖子 5-回复帖子评论
     * @return
     */
    @Checked
    @PostMapping(value = "/like", produces = "application/json")
    @ApiOperation(value = "点赞 0-每日分享 1-评论每日分享 2-回复每日分享评论 3-帖子 4-评论帖子 5-回复帖子评论")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id", value = "id", required = true, paramType = "query", dataType = "Object"),
            @ApiImplicitParam(name = "type", value = "type", required = true, paramType = "query", dataType = "Integer")
    })
    public Result likePost(@NotNull @RequestParam("id") Object id,
                           @NotNull @RequestParam("type") Integer type) {
        try {
            return Result.success(likeService.like(id, type));
        } catch (MyException e) {
            return Result.result(e.getEnumExceptionType());
        }
    }

    /**
     * 取消点赞 0-每日分享 1-评论每日分享 2-回复每日分享评论 3-帖子 4-评论帖子 5-回复帖子评论
     * @param id
     * @param type 类型 0-每日分享 1-评论每日分享 2-回复每日分享评论 3-帖子 4-评论帖子 5-回复帖子评论
     * @return
     */
    @Checked
    @PostMapping(value = "/unlike", produces = "application/json")
    @ApiOperation(value = "取消点赞 0-每日分享 1-评论每日分享 2-回复每日分享评论 3-帖子 4-评论帖子 5-回复帖子评论")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id", value = "id", required = true, paramType = "query", dataType = "Object"),
            @ApiImplicitParam(name = "type", value = "type", required = true, paramType = "query", dataType = "Integer")
    })
    public Result unlikePost(@NotNull @RequestParam("id") Object id,
                             @NotNull @RequestParam("type") Integer type) {
        try {
            return Result.success(likeService.unlike(id, type));
        } catch (MyException e) {
            return Result.result(e.getEnumExceptionType());
        }
    }
}
