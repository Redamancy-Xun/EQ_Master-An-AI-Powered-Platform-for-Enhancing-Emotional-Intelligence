package fun.redamancyxun.eqmaster.backend.controller.aichat;

import fun.redamancyxun.eqmaster.backend.annotation.Auth;
import fun.redamancyxun.eqmaster.backend.common.Result;
import fun.redamancyxun.eqmaster.backend.exception.MyException;
import fun.redamancyxun.eqmaster.backend.service.AIChatService;
import fun.redamancyxun.eqmaster.backend.service.EmotionalIntelligenceService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@RestController
@Slf4j
@Validated
@Api("AIChatController")
@RequestMapping("/aichat")
public class AIChatController {

    @Autowired
    private AIChatService aIChatService;

    /**
     * 获取用户历史EQ
     * @return Result
     */
    @Auth
    @GetMapping(value = "/aichat", produces = "application/json")
    @ApiOperation(value = "AI高情商回复")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "prompt", value = "prompt",  paramType = "query", dataType = "String"),
    })
    public Result AIChat(@RequestParam("prompt") String prompt) {
        try {
            return Result.success(aIChatService.chat(prompt));
        } catch (MyException e) {
            return Result.result(e.getEnumExceptionType());
        }
    }

}
