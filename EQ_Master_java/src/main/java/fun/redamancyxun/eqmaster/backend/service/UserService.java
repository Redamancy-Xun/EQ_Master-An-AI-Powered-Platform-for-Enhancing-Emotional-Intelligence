package fun.redamancyxun.eqmaster.backend.service;

import com.baomidou.mybatisplus.extension.service.IService;
import fun.redamancyxun.eqmaster.backend.controller.user.request.UpdateUserInfoRequest;
import fun.redamancyxun.eqmaster.backend.controller.user.response.UserInfoResponse;
import fun.redamancyxun.eqmaster.backend.entity.User;
import fun.redamancyxun.eqmaster.backend.exception.MyException;
import org.springframework.web.multipart.MultipartFile;

/**
*  针对表【user(用户信息)】的数据库操作Service
*/
public interface UserService extends IService<User> {

    // 登录
    UserInfoResponse login(String email, String password) throws Exception;

    // 发送验证码
    Boolean sendVerificationCode(String email) throws MyException;

    // 验证验证码
    Boolean verifyVerificationCode(String email, String code) throws MyException;

    // 检测登录状态
    Integer checkLogin() throws MyException;

    // 注销
    UserInfoResponse logout();

    // 注册
    UserInfoResponse signup(String username, String email, String password, Integer profession, Integer workCommunicationDifficulty, Integer lifeCommunicationDifficulty) throws MyException;

    // 获取用户信息
    UserInfoResponse getUserInfo();

    // 更新用户信息
    UserInfoResponse updateUserInfo(UpdateUserInfoRequest updateUserInfoRequest);

    // 修改密码
    UserInfoResponse changePassword(String oldPassword, String newPassword);

    // 上传用户头像
    String uploadPortrait(MultipartFile file);

//    void deleteUser();

    User getUserById(String userId);
}
