package fun.redamancyxun.eqmaster.backend.controller.emotionalintelligence;

import fun.redamancyxun.eqmaster.backend.annotation.Auth;
import fun.redamancyxun.eqmaster.backend.common.Result;
import fun.redamancyxun.eqmaster.backend.exception.MyException;
import fun.redamancyxun.eqmaster.backend.service.EmotionalIntelligenceService;
import fun.redamancyxun.eqmaster.backend.service.TestScoreService;
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
@Api("TestScoreController")
@RequestMapping("/emotionalIntelligence")
public class EmotionalIntelligenceController {

    @Autowired
    private EmotionalIntelligenceService emotionalIntelligenceService;

    /**
     * 获取用户历史EQ
     * @return Result
     */
    @Auth
    @PostMapping(value = "/getEQHistory", produces = "application/json")
    @ApiOperation(value = "获取用户历史EQ")
    public Result getEQHistory() {
        try {
            return Result.success(emotionalIntelligenceService.getEQHistory());
        } catch (MyException e) {
            return Result.result(e.getEnumExceptionType());
        }
    }

}
