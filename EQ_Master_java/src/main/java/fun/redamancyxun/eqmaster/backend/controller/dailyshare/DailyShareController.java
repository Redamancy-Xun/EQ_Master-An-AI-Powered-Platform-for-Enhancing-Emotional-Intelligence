package fun.redamancyxun.eqmaster.backend.controller.dailyshare;

import fun.redamancyxun.eqmaster.backend.annotation.Admin;
import fun.redamancyxun.eqmaster.backend.annotation.Auth;
import fun.redamancyxun.eqmaster.backend.annotation.Checked;
import fun.redamancyxun.eqmaster.backend.common.Result;
import fun.redamancyxun.eqmaster.backend.controller.dailyshare.request.CreateDailyShareParams;
import fun.redamancyxun.eqmaster.backend.exception.MyException;
import fun.redamancyxun.eqmaster.backend.service.DailyShareService;
import fun.redamancyxun.eqmaster.backend.util.SessionUtils;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.NotNull;
import java.util.List;

@RestController
@Slf4j
@Validated
@Api("DailyShareController")
@RequestMapping("/dailyShare")
public class DailyShareController {

    @Autowired
    private DailyShareService dailyShareService;

    @Autowired
    private SessionUtils sessionUtils;

    /**
     * 人为创建一个每日分享
     * @param createDailyShareParams
     * @return Result
     */
    @Checked
    @PostMapping(value = "/createDailyShare", produces = "application/json")
    @ApiOperation(value = "人为创建一个每日分享")
    public Result createDailyShare(@NotNull @RequestBody CreateDailyShareParams createDailyShareParams) {
        try {
            return Result.success(dailyShareService.createDailyShare(createDailyShareParams));
        } catch (MyException e) {
            return Result.result(e.getEnumExceptionType());
        }
    }

    /**
     * 获取最新or最热每日分享专栏列表
     * @param type
     * @param page
     * @param pageSize
     * @param orderByPopularity
     * @return
     */
    @Auth
    @GetMapping(value = "/getDailyShareTypeList", produces = "application/json")
    @ApiOperation(value = "获取最新or最热每日分享专栏列表(true为按热度排序，false为按时间排序)")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "type", value = "type", required = true, paramType = "query", dataType = "String"),
            @ApiImplicitParam(name = "page", value = "page",paramType = "query", dataType = "Integer"),
            @ApiImplicitParam(name = "pageSize", value = "pageSize",  paramType = "query", dataType = "Integer"),
            @ApiImplicitParam(name = "orderByPopularity", value = "orderByPopularity",  paramType = "query", dataType = "Boolean")
    })
    public Result getDailyShareList(@RequestParam("type") String type,
                                    @RequestParam("page") Integer page,
                                    @RequestParam("pageSize") Integer pageSize,
                                    @RequestParam("orderByPopularity") Boolean orderByPopularity) {
        try {
            return Result.success(dailyShareService.getDailyShareList(type, page, pageSize, orderByPopularity));
        } catch (MyException e) {
            return Result.result(e.getEnumExceptionType());
        }
    }

    /**
     * 获取最新or最热每日分享预览列表
     * @param page
     * @param pageSize
     * @return
     */
    @Auth
    @GetMapping(value = "/getDailyShareTotalList", produces = "application/json")
    @ApiOperation(value = "获取最新or最热每日分享预览列表")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "page", value = "page",paramType = "query", dataType = "Integer"),
            @ApiImplicitParam(name = "pageSize", value = "pageSize",  paramType = "query", dataType = "Integer"),
    })
    public Result getDailyShareList(@RequestParam("page") Integer page,
                                    @RequestParam("pageSize") Integer pageSize) {
        try {
            return Result.success(dailyShareService.getDailyShareList(page, pageSize));
        } catch (MyException e) {
            return Result.result(e.getEnumExceptionType());
        }
    }

    /**
     * 根据专栏类型和时间区间获取每日分享列表
     * @param type
     * @param page
     * @param pageSize
     * @param startTime
     * @param endTime
     * @param orderByPopularity
     * @return
     */
    @Auth
    @GetMapping(value = "/getDailyShareTypeListByTime", produces = "application/json")
    @ApiOperation(value = "根据专栏类型和时间区间获取每日分享列表")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "type", value = "type", required = true, paramType = "query", dataType = "String"),
            @ApiImplicitParam(name = "page", value = "page",paramType = "query", dataType = "Integer"),
            @ApiImplicitParam(name = "pageSize", value = "pageSize",  paramType = "query", dataType = "Integer"),
            @ApiImplicitParam(name = "startTime", value = "startTime",  paramType = "query", dataType = "String"),
            @ApiImplicitParam(name = "endTime", value = "endTime",  paramType = "query", dataType = "String"),
            @ApiImplicitParam(name = "orderByPopularity", value = "orderByPopularity",  paramType = "query", dataType = "Boolean")
//            @ApiImplicitParam(name = "time", value = "time(0为三天之内，1为一周之内，2为一个月之内，3为三个月之内，4为三个月以上)",  paramType = "query", dataType = "Integer")
    })
    public Result getDailyShareListByTag(@RequestParam("type") String type,
                                         @RequestParam("page") Integer page,
                                         @RequestParam("pageSize") Integer pageSize,
                                         @RequestParam("startTime") String startTime,
                                         @RequestParam("endTime") String endTime,
                                         @RequestParam("orderByPopularity") Boolean orderByPopularity){
        try {
            return Result.success(dailyShareService.getDailyShareListByTag(type, page, pageSize, startTime, endTime, orderByPopularity));
        } catch (MyException e) {
            return Result.result(e.getEnumExceptionType());
        }
    }

    /**
     * 根据每日分享内容关键词搜索每日分享
     * @param type
     * @param page
     * @param pageSize
     * @param keyword
     * @return Result
     */
    @Auth
    @GetMapping(value = "/searchDailyShare", produces = "application/json")
    @ApiOperation(value = "根根据每日分享内容关键词搜索每日分享")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "type", value = "type", required = true, paramType = "query", dataType = "String"),
            @ApiImplicitParam(name = "page", value = "page",paramType = "query", dataType = "Integer"),
            @ApiImplicitParam(name = "pageSize", value = "pageSize",  paramType = "query", dataType = "Integer"),
            @ApiImplicitParam(name = "keyword", value = "keyword",  paramType = "query", dataType = "String")
    })
    public Result searchDailyShare(@RequestParam("type") String type,
                                   @RequestParam("page") Integer page,
                                   @RequestParam("pageSize") Integer pageSize,
                                   @RequestParam("keyword") String keyword) {
        try {
            return Result.success(dailyShareService.searchDailyShare(type, page, pageSize, keyword));
        } catch (MyException e) {
            return Result.result(e.getEnumExceptionType());
        }
    }

    /**
     * 获取每日分享详情
     * @param dailyShareId
     * @return Result
     */
    @Auth
    @GetMapping(value = "/getDailyShareById", produces = "application/json")
    @ApiOperation(value = "获取每日分享详情")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "dailyShareId", value = "dailyShareId", required = true, paramType = "query", dataType = "String")
    })
    public Result getDailyShareById(@RequestParam("dailyShareId") String dailyShareId) {
        try {
            return Result.success(dailyShareService.getDailyShareById(dailyShareId));
        } catch (MyException e) {
            return Result.result(e.getEnumExceptionType());
        }
    }
//
//    /**
//     * 获取用户的每日分享列表
//     * @param userId
//     * @param page
//     * @param pageSize
//     * @return Result
//     */
//    @Checked
//    @GetMapping(value = "/getDailyShareByUserId", produces = "application/json")
//    @ApiOperation(value = "获取用户的每日分享列表")
//    @ApiImplicitParams({
//            @ApiImplicitParam(name = "userId", value = "userId", required = true, paramType = "query", dataType = "String"),
//            @ApiImplicitParam(name = "page", value = "page", required = true, paramType = "query", dataType = "Integer"),
//            @ApiImplicitParam(name = "pageSize", value = "pageSize", required = true, paramType = "query", dataType = "Integer")
//    })
//    public Result getDailyShareByUserId(@RequestParam("userId") String userId,
//                                     @RequestParam("page") Integer page,
//                                     @RequestParam("pageSize") Integer pageSize) {
//        try {
//            return Result.success(dailyShareService.getDailyShareByUserId(userId, page, pageSize));
//        } catch (MyException e) {
//            return Result.result(e.getEnumExceptionType());
//        }
//    }
//
//    /**
//     * 删除每日分享
//     * @param dailyShareId
//     * @return Result
//     */
//    @Checked
//    @PostMapping(value = "/deleteDailyShare", produces = "application/json")
//    @ApiOperation(value = "删除每日分享")
//    public Result deleteDailyShare(@NotNull @RequestParam("dailyShareId") Integer dailyShareId) {
//        try {
//            return Result.success(dailyShareService.deleteDailyShare(dailyShareId));
//        } catch (MyException e) {
//            return Result.result(e.getEnumExceptionType());
//        }
//    }
//
//    /**
//     * 把每日分享置顶
//     * @param dailyShareId
//     * @return Result
//     */
//    @Admin
//    @PostMapping(value = "/topDailyShare", produces = "application/json")
//    @ApiOperation(value = "把每日分享置顶")
//    public Result topDailyShare(@NotNull @RequestParam("dailyShareId") Integer dailyShareId) {
//        try {
//            return Result.success(dailyShareService.topDailyShare(dailyShareId));
//        } catch (MyException e) {
//            return Result.result(e.getEnumExceptionType());
//        }
//    }
//
//    /**
//     * 把每日分享取消置顶
//     * @param dailyShareId
//     * @return Result
//     */
//    @Admin
//    @PostMapping(value = "/untopDailyShare", produces = "application/json")
//    @ApiOperation(value = "把每日分享取消置顶")
//    public Result untopDailyShare(@NotNull @RequestParam("dailyShareId") Integer dailyShareId) {
//        try {
//            return Result.success(dailyShareService.untopDailyShare(dailyShareId));
//        } catch (MyException e) {
//            return Result.result(e.getEnumExceptionType());
//        }
//    }
//
//    /**
//     * 把每日分享设为私密
//     * @param dailyShareId
//     * @return Result
//     */
//    @Auth
//    @PostMapping(value = "/privateDailyShare", produces = "application/json")
//    @ApiOperation(value = "把每日分享设为私密")
//    public Result privateDailyShare(@NotNull @RequestParam("dailyShareId") Integer dailyShareId) {
//        try {
//            return Result.success(dailyShareService.privateDailyShare(dailyShareId));
//        } catch (MyException e) {
//            return Result.result(e.getEnumExceptionType());
//        }
//    }
//
//    /**
//     * 把每日分享设为公开
//     * @param dailyShareId
//     * @return Result
//     */
//    @Auth
//    @PostMapping(value = "/publicDailyShare", produces = "application/json")
//    @ApiOperation(value = "把每日分享设为公开")
//    public Result publicDailyShare(@NotNull @RequestParam("dailyShareId") Integer dailyShareId) {
//        try {
//            return Result.success(dailyShareService.publicDailyShare(dailyShareId));
//        } catch (MyException e) {
//            return Result.result(e.getEnumExceptionType());
//        }
//    }
}







