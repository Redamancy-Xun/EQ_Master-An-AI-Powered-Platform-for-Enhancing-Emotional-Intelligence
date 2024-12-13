package fun.redamancyxun.eqmaster.backend.controller.dailyshare;

import fun.redamancyxun.eqmaster.backend.annotation.Auth;
import fun.redamancyxun.eqmaster.backend.annotation.Checked;
import fun.redamancyxun.eqmaster.backend.common.Result;
import fun.redamancyxun.eqmaster.backend.controller.dailyshare.request.CreateReplyParams;
import fun.redamancyxun.eqmaster.backend.exception.MyException;
import fun.redamancyxun.eqmaster.backend.service.ReplyService;
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
@Api("ReplyController")
@RequestMapping("/reply")
public class ReplyController {

    @Autowired
    private ReplyService replyService;

    /**
     * 创建回复
     * @param createReplyParams
     * @return Result
     */
    @Checked
    @PostMapping(value = "/createReply", produces = "application/json")
    @ApiOperation(value = "创建回复")
    public Result createReply(@NotNull @RequestBody CreateReplyParams createReplyParams) {
        try {
            return Result.success(replyService.createReply(createReplyParams));
        } catch (MyException e) {
            return Result.result(e.getEnumExceptionType());
        }
    }

    /**
     * 获取回复列表
     * @param commentId
     * @param page
     * @param pageSize
     * @param orderByPopularity 是否按照热度排序 true为最热 false为最新
     * @return Result
     */
    @Auth
    @GetMapping(value = "/getReplyList", produces = "application/json")
    @ApiOperation(value = "获取回复列表 true为最热 false为最新")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "commentId", value = "commentId", required = true, paramType = "query", dataType = "Integer"),
            @ApiImplicitParam(name = "page", value = "page" ,paramType = "query", dataType = "Integer"),
            @ApiImplicitParam(name = "pageSize", value = "pageSize", paramType = "query", dataType = "Integer"),
            @ApiImplicitParam(name = "orderByPopularity", value = "orderByPopularity",  paramType = "query", dataType = "Boolean")
    })
    public Result getReplyList(@NotNull @RequestParam("commentId") Integer commentId,
                               @RequestParam("page") Integer page,
                               @RequestParam("pageSize") Integer pageSize,
                               @RequestParam("orderByPopularity") Boolean orderByPopularity) {
        try {
            return Result.success(replyService.getReplyList(commentId, orderByPopularity, page, pageSize));
        } catch (MyException e) {
            return Result.result(e.getEnumExceptionType());
        }
    }

    /**
     * 获取用户回复列表
     * @param userId
     * @param page
     * @param pageSize
     * @return
     */
    @Auth
    @GetMapping(value = "/getReplyByUserId", produces = "application/json")
    @ApiOperation(value = "获取用户回复列表")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "userId", value = "userId", required = true, paramType = "query", dataType = "String"),
            @ApiImplicitParam(name = "page", value = "page" ,paramType = "query", dataType = "Integer"),
            @ApiImplicitParam(name = "pageSize", value = "pageSize", paramType = "query", dataType = "Integer"),
    })
    public Result getReplyByUserId(@NotNull @RequestParam("userId") String userId,
                                   @RequestParam("page") Integer page,
                                   @RequestParam("pageSize") Integer pageSize) {
        try {
            return Result.success(replyService.getReplyByUserId(userId, page, pageSize));
        } catch (MyException e) {
            return Result.result(e.getEnumExceptionType());
        }
    }

    /**
     * 获取回复详情
     * @param replyId
     * @return
     */
    @Auth
    @GetMapping(value = "/getById", produces = "application/json")
    @ApiOperation(value = "获取回复详情，即使是被删除的回复也可以获取到")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "replyId", value = "replyId", required = true, paramType = "query", dataType = "Integer"),
    })
    public Result getReplyByUserId(@NotNull @RequestParam("replyId") Integer replyId) {
        try {
            return Result.success(replyService.getReplyById(replyId));
        } catch (MyException e) {
            return Result.result(e.getEnumExceptionType());
        }
    }

    /**
     * 删除回复
     * @param replyId
     * @return
     */
    @Checked
    @PostMapping(value = "/deleteReply", produces = "application/json")
    @ApiOperation(value = "删除回复")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "replyId", value = "replyId", required = true, paramType = "query", dataType = "Integer"),
    })
    public Result deleteReply(@NotNull @RequestParam("replyId") Integer replyId){
        try {
            replyService.deleteReply(replyId);
            return Result.success("删除成功");
        } catch (MyException e) {
            return Result.result(e.getEnumExceptionType());
        }
    }

}
