package fun.redamancyxun.eqmaster.backend.controller.dailyshare;

import fun.redamancyxun.eqmaster.backend.annotation.Auth;
import fun.redamancyxun.eqmaster.backend.annotation.Checked;
import fun.redamancyxun.eqmaster.backend.common.Result;
import fun.redamancyxun.eqmaster.backend.controller.dailyshare.request.CreateCommentParams;
import fun.redamancyxun.eqmaster.backend.exception.MyException;
import fun.redamancyxun.eqmaster.backend.service.CommentService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.NotNull;

@RestController
@Slf4j
@Validated
@Api("CommentController")
@RequestMapping("/comment")
public class CommentController {

    @Autowired
    private CommentService commentService;

    /**
     * 创建一个评论
     * @param createCommentParams
     * @return Result
     */
    @Checked
    @PostMapping(value = "/createComment", produces = "application/json")
    @ApiOperation(value = "创建一个评论")
    public Result createComment(@NotNull @RequestBody CreateCommentParams createCommentParams) {
        try {
            return Result.success(commentService.createComment(createCommentParams));
        } catch (MyException e) {
            return Result.result(e.getEnumExceptionType());
        }
    }

    /**
     * 获取评论列表
     * @param dailyShareId
     * @param page
     * @param pageSize
     * @param orderByPopularity 是否按照热度排序 true为最热 false为最新
     * @return Result
     */
    @Auth
    @GetMapping(value = "/getCommentList", produces = "application/json")
    @ApiOperation(value = "获取评论列表 true为最热 false为最新")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "dailyShareId", value = "dailyShareId", required = true, paramType = "query", dataType = "String"),
            @ApiImplicitParam(name = "page", value = "page", required = true, paramType = "query", dataType = "Integer"),
            @ApiImplicitParam(name = "pageSize", value = "pageSize", required = true, paramType = "query", dataType = "Integer"),
            @ApiImplicitParam(name = "orderByPopularity", value = "orderByPopularity",  paramType = "query", dataType = "Boolean")
    })
    public Result getCommentList(@NotNull @RequestParam("dailyShareId") String dailyShareId,
                                 @NotNull @RequestParam("page") Integer page,
                                 @NotNull @RequestParam("pageSize") Integer pageSize,
                                 @RequestParam("orderByPopularity") Boolean orderByPopularity) {
        try {
            return Result.success(commentService.getCommentList(dailyShareId, page, pageSize, orderByPopularity));
        } catch (MyException e) {
            return Result.result(e.getEnumExceptionType());
        }
    }

    /**
     * 获取用户的评论列表
     * @param userId
     * @param page
     * @param pageSize
     * @return Result
     */
    @Auth
    @GetMapping(value = "/getCommentByUserId", produces = "application/json")
    @ApiOperation(value = "获取用户的评论列表")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "userId", value = "userId", required = true, paramType = "query", dataType = "String"),
            @ApiImplicitParam(name = "page", value = "page", required = true, paramType = "query", dataType = "Integer"),
            @ApiImplicitParam(name = "pageSize", value = "pageSize", required = true, paramType = "query", dataType = "Integer"),
    })
    public Result getCommentByUserId(@NotNull @RequestParam("userId") String userId,
                                     @NotNull @RequestParam("page") Integer page,
                                     @NotNull @RequestParam("pageSize") Integer pageSize) {
        try {
            return Result.success(commentService.getCommentByUserId(userId, page, pageSize));
        } catch (MyException e) {
            return Result.result(e.getEnumExceptionType());
        }
    }

    /**
     * 获取评论详情
     * @param commentId
     * @return Result
     */
    @Auth
    @GetMapping(value = "/getById", produces = "application/json")
    @ApiOperation(value = "获取评论详情")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "commentId", value = "commentId", required = true, paramType = "query", dataType = "Integer"),
    })
    public Result getCommentByUserId(@NotNull @RequestParam("commentId") Integer commentId) {
        try {
            return Result.success(commentService.getCommentById(commentId));
        } catch (MyException e) {
            return Result.result(e.getEnumExceptionType());
        }
    }

    /**
     * 删除评论
     * @param commentId
     * @return Result
     */
    @Checked
    @PostMapping(value = "/deleteComment", produces = "application/json")
    @ApiOperation(value = "只有评论的作者和管理员可以删除评论，自动判断当前是否为作者或管理员")
    @ApiImplicitParams ({
            @ApiImplicitParam(name = "commentId", value = "commentId", required = true, paramType = "query", dataType = "Integer"),
    })
    public Result deleteComment(@NotNull @RequestParam("commentId") Integer commentId) {
        try {
            commentService.deleteComment(commentId);
            return Result.success("删除成功");
        } catch (MyException e) {
            return Result.result(e.getEnumExceptionType());
        }
    }
}
