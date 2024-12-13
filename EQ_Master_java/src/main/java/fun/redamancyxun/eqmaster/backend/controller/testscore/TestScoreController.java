package fun.redamancyxun.eqmaster.backend.controller.testscore;

import fun.redamancyxun.eqmaster.backend.annotation.Auth;
import fun.redamancyxun.eqmaster.backend.annotation.Checked;
import fun.redamancyxun.eqmaster.backend.common.Result;
import fun.redamancyxun.eqmaster.backend.exception.MyException;
import fun.redamancyxun.eqmaster.backend.service.LikeService;
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
@RequestMapping("/testScore")
public class TestScoreController {

    @Autowired
    private TestScoreService testScoreService;

    /**
     * 创建测验分数
     * @param testId
     * @param score
     * @return TestScore
     */
    @Auth
    @PostMapping(value = "/create", produces = "application/json")
    @ApiOperation(value = "创建测验分数")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "testId", value = "testId", required = true, paramType = "query", dataType = "String"),
            @ApiImplicitParam(name = "score", value = "score", required = true, paramType = "query", dataType = "Double")
    })
    public Result createTestScore(@NotNull @RequestParam("testId") String testId,
                                  @NotNull @RequestParam("score") Double score) {
        try {
            return Result.success(testScoreService.createTestScore(testId, score));
        } catch (MyException e) {
            return Result.result(e.getEnumExceptionType());
        }
    }

    /**
     * 获取用户的所有测验分数记录
     * @return List<TestScore>
     */
    @Auth
    @PostMapping(value = "/getTestScoreHistory", produces = "application/json")
    @ApiOperation(value = "取用户的所有测验分数记录")
    public Result getTestScoreHistory() {
        try {
            return Result.success(testScoreService.getTestScoreHistory());
        } catch (MyException e) {
            return Result.result(e.getEnumExceptionType());
        }
    }

    /**
     * 获取用户所有测验分数
     * @return Map<String, Double>
     */
    @Auth
    @PostMapping(value = "/getUserTotalScore", produces = "application/json")
    @ApiOperation(value = "获取用户所有测验分数")
    public Result getUserTotalScore() {
        try {
            return Result.success(testScoreService.getUserTotalScore());
        } catch (MyException e) {
            return Result.result(e.getEnumExceptionType());
        }
    }


}
