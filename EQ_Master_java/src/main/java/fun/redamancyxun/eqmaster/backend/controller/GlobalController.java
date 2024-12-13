package fun.redamancyxun.eqmaster.backend.controller;

import fun.redamancyxun.eqmaster.backend.annotation.Auth;
import fun.redamancyxun.eqmaster.backend.common.Result;
//import fun.redamancyxun.eqmaster.backend.controller.forum.request.ContactRequest;
import fun.redamancyxun.eqmaster.backend.controller.dailyshare.request.ContactRequest;
import fun.redamancyxun.eqmaster.backend.exception.MyException;
import fun.redamancyxun.eqmaster.backend.service.GlobalService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;

@RestController
@Slf4j
@Validated
@Api("GlobalController")
public class GlobalController {

    @Autowired
    private GlobalService globalService;

    /**
     * 上传图片
     * @param file
     * @return
     */
    @PostMapping(value = "/uploadImage", produces = "application/json")
    @ApiOperation(value = "上传图片 file:图片文件")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "file", value = "图片文件", required = true, paramType = "query", dataType = "MultipartFile")})
    public Result uploadImage(@RequestBody MultipartFile file) {
        try {
            return Result.success(globalService.uploadImage(file));
        } catch (Exception e) {
            if (e instanceof MyException) {
                return Result.result(((MyException) e).getEnumExceptionType());
            }
            return Result.fail(e.getMessage());
        }
    }

    /**
     * 上传多个图片
     * @param files
     * @return
     */
    @PostMapping(value = "/uploadImages", produces = "application/json")
    @ApiOperation(value = "上传多个图片 files:图片文件数组")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "files", value = "图片文件数组", required = true, paramType = "query", dataType = "List<MultipartFile>")})
    public Result uploadImages(@RequestBody MultipartFile[] files) {
        List<String> imageList = new ArrayList<>();
        try {
            for (MultipartFile file : files){
                imageList.add(globalService.uploadImage(file));
            }
            return Result.success(imageList);
        } catch (Exception e) {
            if (e instanceof MyException) {
                return Result.result(((MyException) e).getEnumExceptionType());
            }
            return Result.fail(e.getMessage());
        }
    }

    /**
     * 联系我们（发送邮件给客服）
     * @param contactRequest
     * @return
     */
    @Auth
    @PostMapping(value = "/contact" , produces = "application/json")
    @ApiOperation(value = "联系我们（发送邮件给客服）")
    public Result contact(@RequestBody ContactRequest contactRequest){
        try{
            return Result.success(globalService.contact(contactRequest));
        }catch (Exception e){
            if(e instanceof MyException){
                return Result.result(((MyException) e).getEnumExceptionType());
            }
            return Result.fail(e.getMessage());
        }
    }

}
