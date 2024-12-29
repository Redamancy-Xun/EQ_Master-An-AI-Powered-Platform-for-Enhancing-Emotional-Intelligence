package fun.redamancyxun.eqmaster.backend.controller.notice;

import fun.redamancyxun.eqmaster.backend.annotation.Auth;
import fun.redamancyxun.eqmaster.backend.common.Result;
import fun.redamancyxun.eqmaster.backend.exception.MyException;
import fun.redamancyxun.eqmaster.backend.service.NoticeService;
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
@Api("NoticeController")
@RequestMapping("/notice")
public class NoticeController {

    @Autowired
    private NoticeService noticeService;

    /**
     * 获取对应类型的通知列表并清空未读消息，返回通知列表
     * @param type 消息类型(0为点赞 1为评论 2为系统信息)
     * @param page
     * @param pageSize
     * @return
     */
    @Auth
    @GetMapping(value = "/notices", produces = "application/json")
    @ApiOperation(value = "获取对应类型的通知列表并清空未读消息，返回通知列表。type 0为点赞 1为评论 2为系统信息")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "type", value = "type", required = true, paramType = "query", dataType = "Integer"),
            @ApiImplicitParam(name = "page", value = "page", required = true, paramType = "query", dataType = "Integer"),
            @ApiImplicitParam(name = "pageSize", value = "pageSize", required = true, paramType = "query", dataType = "Integer")
    })
    public Result getNoticesInfo(@NotNull @RequestParam("type") Integer type,
                                 @NotNull @RequestParam("page") Integer page,
                                 @NotNull @RequestParam("pageSize") Integer pageSize) {
        try {
            return Result.success(noticeService.getNoticesInfo(type, page, pageSize));
        } catch (MyException e) {
            return Result.result(e.getEnumExceptionType());
        }
    }

    /**
     * 给指定用户发送系统通知
     * @param userId
     * @param msg
     * @return
     */
    @PostMapping(value = "/send", produces = "application/json")
    @ApiOperation(value = "给指定用户发送系统通知")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "userId", value = "userId", required = true, paramType = "query", dataType = "String"),
            @ApiImplicitParam(name = "msg", value = "msg", required = true, paramType = "query", dataType = "String")
    })
    public Result send(@NotNull @RequestParam("userId") String userId,
                       @NotNull @RequestParam("msg") String msg) {
        try {
            return Result.success(noticeService.SysSend(msg, userId));
        } catch (MyException e) {
            return Result.result(e.getEnumExceptionType());
        }
    }

    /**
     * 给所有用户发送系统通知
     * @param msg
     * @return Result
     */
    @PostMapping(value = "/sendAll", produces = "application/json")
    @ApiOperation(value = "给所有用户发送系统通知")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "msg", value = "msg", required = true, paramType = "query", dataType = "String")
    })
    public Result sendAll(@NotNull @RequestParam("msg") String msg) {
        try {
            return Result.success(noticeService.SysSend(msg));
        } catch (MyException e) {
            return Result.result(e.getEnumExceptionType());
        }
    }

    /**
     * 删除通知
     * @param noticeId
     * @return Result
     * @throws MyException
     */
    @Auth
    @PostMapping(value = "/delete", produces = "application/json")
    @ApiOperation(value = "删除通知")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "noticeId", value = "noticeId", required = true, paramType = "query", dataType = "Integer")
    })
    public Result delete(@NotNull @RequestParam("noticeId") Integer noticeId) {
        try {
            noticeService.deleteNotice(noticeId);
            return Result.success("删除成功");
        } catch (MyException e) {
            return Result.result(e.getEnumExceptionType());
        }
    }

    /**
     * 查看消息详情
     * @param id
     * @return Result
     * @throws MyException
     */
    @Auth
    @GetMapping(value = "/getNoticesById", produces = "application/json")
    @ApiOperation(value = "查看消息详情")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id", value = "id", required = true, paramType = "query", dataType = "Integer"),
    })
    public Result getNoticeById(@NotNull @RequestParam("id") Integer id) {
        try {
            return Result.success(noticeService.getNoticeById(id));
        } catch (MyException e) {
            return Result.result(e.getEnumExceptionType());
        }
    }
}