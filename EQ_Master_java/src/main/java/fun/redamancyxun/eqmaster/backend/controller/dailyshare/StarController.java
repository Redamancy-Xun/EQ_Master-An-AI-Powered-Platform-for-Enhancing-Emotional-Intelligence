package fun.redamancyxun.eqmaster.backend.controller.dailyshare;

import fun.redamancyxun.eqmaster.backend.annotation.Checked;
import fun.redamancyxun.eqmaster.backend.common.Result;
import fun.redamancyxun.eqmaster.backend.exception.MyException;
import fun.redamancyxun.eqmaster.backend.service.StarService;
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

@RestController
@Slf4j
@Validated
@Api("StarController")
@RequestMapping("/star")
public class StarController {

    @Autowired
    private StarService starService;

    @Autowired
    private SessionUtils sessionUtils;

    /**
     * 收藏每日分享
     * @param dailyShareId
     * @return Result
     */
    @Checked
    @PostMapping(value = "/starDailyShare", produces = "application/json")
    @ApiOperation(value = "收藏每日分享")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "dailyShareId", value = "dailyShareId", required = true, paramType = "query", dataType = "String"),
    })
    public Result starDailyShare(@NotNull @RequestParam("dailyShareId") String dailyShareId) {
        try {
            return Result.success(starService.starDailyShare(dailyShareId));
        } catch (MyException e) {
            return Result.result(e.getEnumExceptionType());
        }
    }

    /**
     * 取消收藏每日分享
     * @param dailyShareId
     * @return Result
     */
    @Checked
    @PostMapping(value = "/unstarDailyShare", produces = "application/json")
    @ApiOperation(value = "取消收藏每日分享")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "dailyShareId", value = "dailyShareId", required = true, paramType = "query", dataType = "String"),
    })
    public Result unstarDailyShare(@NotNull @RequestParam("dailyShareId") String dailyShareId) {
        try {
            return Result.success(starService.unstarDailyShare(dailyShareId));
        } catch (MyException e) {
            return Result.result(e.getEnumExceptionType());
        }
    }

    /**
     * 获取自己的收藏列表
     * @param page
     * @param pageSize
     * @return Result
     */
    @Checked
    @GetMapping(value = "/getStarList", produces = "application/json")
    @ApiOperation(value = "获取自己的收藏列表")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "page", value = "page", required = true, paramType = "query", dataType = "Integer"),
            @ApiImplicitParam(name = "pageSize", value = "pageSize", required = true, paramType = "query", dataType = "Integer"),
    })
    public Result getStarListByUserId(@RequestParam("page") Integer page,
                                      @RequestParam("pageSize") Integer pageSize) {
        try {
            return Result.success(starService.getStarList(page, pageSize));
        } catch (MyException e) {
            return Result.result(e.getEnumExceptionType());
        }
    }
}






