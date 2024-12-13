package fun.redamancyxun.eqmaster.backend.controller.dailyshare;

import fun.redamancyxun.eqmaster.backend.annotation.Auth;
import fun.redamancyxun.eqmaster.backend.common.Result;
import fun.redamancyxun.eqmaster.backend.exception.MyException;
import fun.redamancyxun.eqmaster.backend.service.ShareService;
import io.swagger.annotations.Api;
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
@Api("ShareController")
@RequestMapping("/share")
public class ShareController {

    @Autowired
    private ShareService shareService;

    /**
     * 转发每日分享
     * @param dailyShareId
     * @return Result
     */
    @Auth
    @PostMapping(value = "/shareDailyShare", produces = "application/json")
    @ApiOperation(value = "转发每日分享")
    public Result shareDailyShare(@NotNull @RequestParam("dailyShareId") String dailyShareId) {
        try {
            return Result.success(shareService.shareDailyShare(dailyShareId));
        } catch (MyException e) {
            return Result.result(e.getEnumExceptionType());
        }
    }
}
