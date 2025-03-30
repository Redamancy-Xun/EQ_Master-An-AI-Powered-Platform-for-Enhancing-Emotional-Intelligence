package fun.redamancyxun.eqmaster.backend.controller.user;

import fun.redamancyxun.eqmaster.backend.common.Result;
import fun.redamancyxun.eqmaster.backend.controller.user.request.UpdateUserInfoRequest;
import fun.redamancyxun.eqmaster.backend.controller.user.response.UserInfoResponse;
import fun.redamancyxun.eqmaster.backend.exception.MyException;
import fun.redamancyxun.eqmaster.backend.service.UserService;
import fun.redamancyxun.eqmaster.backend.util.SessionUtils;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.NotNull;

@Api("UserController")
@RestController
@RequestMapping("/user")
@Slf4j
public class UserController {

    @Autowired
    private UserService userService;

    /**
     * 登录
     * @param email
     * @param password
     * @return UserInfoResponse
     */
    @PostMapping(value = "/login", produces = "application/json")
    @ApiOperation(value = "登录", response = UserInfoResponse.class)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "email", value = "邮箱", required = true, paramType = "query", dataType = "String"),
            @ApiImplicitParam(name = "password", value = "密码", required = true, paramType = "query", dataType = "String")
    })
    public Result login(@NotNull @RequestParam("email") String email,
                        @NotNull @RequestParam("password") String password) {
        try {
            return Result.success(userService.login(email, password));
        } catch (Exception e) {
            if (e instanceof MyException) {
                return Result.result(((MyException) e).getEnumExceptionType());
            }
            return Result.fail(e.getMessage());
        }
    }

    /**
     * 发送验证码
     * @param email 邮箱
     * @return User
     * @throws MyException 通用异常
     */
    @PostMapping(value = "/sendVerificationCode", produces = "application/json")
    @ApiOperation(value = "发送验证码", response = Boolean.class)
    @ApiImplicitParam(name = "email", value = "邮箱", required = true, paramType = "query", dataType = "String")
    public Result sendVerificationCode(@NotNull @RequestParam("email") String email) throws MyException {
        try {
            return Result.success(userService.sendVerificationCode(email));
        } catch (Exception e) {
            if (e instanceof MyException) {
                return Result.result(((MyException) e).getEnumExceptionType());
            }
            return Result.fail(e.getMessage());
        }
    }

    /**
     * 验证验证码
     * @param email 邮箱
     * @param code 验证码
     * @return  Boolean
     * @throws MyException 通用异常
     */
    @PostMapping(value = "/verifyVerificationCode", produces = "application/json")
    @ApiOperation(value = "验证验证码", response = Boolean.class)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "email", value = "邮箱", required = true, paramType = "query", dataType = "String"),
            @ApiImplicitParam(name = "code", value = "验证码", required = true, paramType = "query", dataType = "String")
    })
    public Result verifyVerificationCode(@NotNull @RequestParam("email") String email,
                                         @NotNull @RequestParam("code") String code) throws MyException {
        try {
            return Result.success(userService.verifyVerificationCode(email, code));
        } catch (Exception e) {
            if (e instanceof MyException) {
                return Result.result(((MyException) e).getEnumExceptionType());
            }
            return Result.fail(e.getMessage());
        }
    }

    /**
     * 检测登录状态
     * @return Integer
     */
    @GetMapping(value = "/checkLogin", produces = "application/json")
    public Result checkLogin() throws MyException {
        try {
            return Result.success(userService.checkLogin());
        } catch (Exception e) {
            if (e instanceof MyException) {
                return Result.result(((MyException) e).getEnumExceptionType());
            }
            return Result.fail(e.getMessage());
        }
    }

    /**
     * 登出
     * @return UserInfoResponse
     */
    @PostMapping(value = "/logout", produces = "application/json")
    @ApiOperation(value = "登出", response = UserInfoResponse.class)
    public Result logout() {
        try {
            return Result.success(userService.logout());
        } catch (Exception e) {
            if (e instanceof MyException) {
                return Result.result(((MyException) e).getEnumExceptionType());
            }
            return Result.fail(e.getMessage());
        }
    }

    /**
     * 注册
     * @param username
     * @param email
     * @param password
     * @param profession 职业
     * @param workCommunicationDifficulty 工作沟通困难对象身份
     * @param lifeCommunicationDifficulty 生活沟通困难对象身份
     * @return UserInfoResponse
     */
    @PostMapping(value = "/signup", produces = "application/json")
    @ApiOperation(value = "注册", response = UserInfoResponse.class)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "username", value = "用户名", required = true, paramType = "query", dataType = "String"),
            @ApiImplicitParam(name = "email", value = "邮箱", required = true, paramType = "query", dataType = "String"),
            @ApiImplicitParam(name = "password", value = "密码", required = true, paramType = "query", dataType = "String"),
            @ApiImplicitParam(name = "profession", value = "职业" +
                    "【" +
                    "0：未知 " +
                    "1：学生（中学生、本科生、研究生） " +
                    "2：上班族 " +
                    "3：企业家/创业者 " +
                    "4：自由职业者 " +
                    "5：公务员/事业单位工作人员" +
                    "】", required = true, paramType = "query", dataType = "Integer"),
            @ApiImplicitParam(name = "workCommunicationDifficulty", value = "工作沟通困难对象身份" +
                    "【" +
                    "0：未知 " +
                    "1：上级 " +
                    "2：同事 " +
                    "3：下级 " +
                    "4：客户 " +
                    "5：老师 " +
                    "6：同学" +
                    "】", required = true, paramType = "query", dataType = "Integer"),
            @ApiImplicitParam(name = "lifeCommunicationDifficulty", value = "生活沟通困难对象身份" +
                    "【" +
                    "0：未知 " +
                    "1：子女、其他后辈 " +
                    "2：父母、其他长辈 " +
                    "3：兄弟/姐妹 " +
                    "4：伴侣 " +
                    "5：朋友 " +
                    "6：陌生人" +
                    "】", required = true, paramType = "query", dataType = "Integer")
    })
    public Result signup(@NotNull @RequestParam("username") String username,
                         @NotNull @RequestParam("email") String email,
                         @NotNull @RequestParam("password") String password,
                         @NotNull @RequestParam("profession") Integer profession,
                         @NotNull @RequestParam("workCommunicationDifficulty") Integer workCommunicationDifficulty,
                         @NotNull @RequestParam("lifeCommunicationDifficulty") Integer lifeCommunicationDifficulty) {
        try {
            return Result.success(userService.signup(username, email, password, profession, workCommunicationDifficulty, lifeCommunicationDifficulty));
        } catch (Exception e) {
            if (e instanceof MyException) {
                return Result.result(((MyException) e).getEnumExceptionType());
            }
            return Result.fail(e.getMessage());
        }
    }

    /**
     * 获取用户信息
     * @return UserInfoResponse
     */
    @GetMapping(value = "/getUserInfo", produces = "application/json")
    @ApiOperation(value = "获取用户信息", response = UserInfoResponse.class)
    public Result getUserInfo() {
        try {
            return Result.success(userService.getUserInfo());
        } catch (Exception e) {
            if (e instanceof MyException) {
                return Result.result(((MyException) e).getEnumExceptionType());
            }
            e.printStackTrace();
            return Result.fail(e.getMessage());
        }
    }

    /**
     * 更新用户信息
     * @param updateUserInfoRequest
     * @return UserInfoResponse
     */
    @PostMapping(value = "/updateUserInfo", produces = "application/json")
    @ApiOperation(value = "更新用户信息", response = UserInfoResponse.class)
    public Result updateUserInfo(@NotNull @RequestBody UpdateUserInfoRequest updateUserInfoRequest) {
        try {
            return Result.success(userService.updateUserInfo(updateUserInfoRequest));
        } catch (Exception e) {
            if (e instanceof MyException) {
                return Result.result(((MyException) e).getEnumExceptionType());
            }
            return Result.fail(e.getMessage());
        }
    }

    /**
     * 修改用户密码
     * @param oldPassword
     * @param newPassword
     * @return UserInfoResponse
     */
    @PostMapping(value = "/changePassword", produces = "application/json")
    @ApiOperation(value = "修改用户密码", response = UserInfoResponse.class)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "oldPassword", value = "旧密码", required = true, paramType = "query", dataType = "String"),
            @ApiImplicitParam(name = "newPassword", value = "新密码", required = true, paramType = "query", dataType = "String")
    })
    public Result changePassword(@NotNull @RequestParam("oldPassword") String oldPassword,
                                 @NotNull @RequestParam("newPassword") String newPassword) {
        try {
            return Result.success(userService.changePassword(oldPassword, newPassword));
        } catch (Exception e) {
            if (e instanceof MyException) {
                return Result.result(((MyException) e).getEnumExceptionType());
            }
            return Result.fail(e.getMessage());
        }
    }

    /**
     * 上传用户头像
     * @param file
     * @return String
     */
    @PostMapping(value = "/uploadPortrait", produces = "application/json")
    @ApiOperation(value = "上传用户头像", response = String.class)
    @ApiImplicitParam(name = "file", value = "图片文件", required = true, paramType = "formData", dataType = "file")
    public Result uploadPortrait(@RequestParam("file") MultipartFile file) {
        try {
            return Result.success(userService.uploadPortrait(file));
        } catch (Exception e) {
            if (e instanceof MyException) {
                return Result.result(((MyException) e).getEnumExceptionType());
            }
            return Result.fail(e.toString());
        }
    }
}
