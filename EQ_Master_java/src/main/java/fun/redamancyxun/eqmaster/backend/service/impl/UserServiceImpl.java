package fun.redamancyxun.eqmaster.backend.service.impl;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.IdUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import fun.redamancyxun.eqmaster.backend.config.YmlConfig;
import fun.redamancyxun.eqmaster.backend.controller.user.request.UpdateUserInfoRequest;
import fun.redamancyxun.eqmaster.backend.controller.user.response.UserInfoResponse;
import fun.redamancyxun.eqmaster.backend.dto.SessionData;
import fun.redamancyxun.eqmaster.backend.entity.EmotionalIntelligence;
import fun.redamancyxun.eqmaster.backend.entity.TestScore;
import fun.redamancyxun.eqmaster.backend.entity.User;
import fun.redamancyxun.eqmaster.backend.exception.EnumExceptionType;
import fun.redamancyxun.eqmaster.backend.exception.MyException;
import fun.redamancyxun.eqmaster.backend.mapper.UserMapper;
//import fun.redamancyxun.eqmaster.backend.service.AdviceActionService;
import fun.redamancyxun.eqmaster.backend.service.EmotionalIntelligenceService;
//import fun.redamancyxun.eqmaster.backend.service.ScoreActionService;
import fun.redamancyxun.eqmaster.backend.service.TestScoreService;
import fun.redamancyxun.eqmaster.backend.service.UserService;
import fun.redamancyxun.eqmaster.backend.util.*;
import okhttp3.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

import static fun.redamancyxun.eqmaster.backend.common.CommonConstants.*;

/**
* @description 针对表【user(用户信息)】的数据库操作Service实现
*/
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService{

    @Autowired
    SessionUtils sessionUtils;

    @Autowired
    UserMapper userMapper;

    @Autowired
    EmotionalIntelligenceService emotionalIntelligenceService;

    @Autowired
    TestScoreService testScoreService;

    @Autowired
    YmlConfig ymlConfig;

    @Autowired
    private RedisUtils redisUtils;

    @Autowired
    private HttpServletRequest request;

    /**
     * 注册
     * @param username 用户名
     * @param telephone 手机号
     * @param password 密码
     * @return UserInfoResponse
     * @throws MyException 通用异常
     */
    @Override
    //@Transactional 注解标记该方法需要进行事务管理，在出现 MyException 异常时进行回滚操作
    @Transactional(rollbackFor = MyException.class)
    public UserInfoResponse signup(String username, String telephone, String password) throws MyException {

        // 如果手机号已经被使用，则报错提醒
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("telephone", telephone);
        if (userMapper.selectCount(queryWrapper) != 0){
            throw new MyException(EnumExceptionType.TELEPHONE_EXIST);
        }

        User user = User.builder()
                .id(UUID.randomUUID().toString().substring(0, 8))
                .portrait(IMAGE_PATH + "defaultAvatar.svg")
                .password(password)
                .telephone(telephone)
                .username(username)
                .commentCount(0)
                .likeCount(0)
                .gender(2)
                .age(-1)
                .role(3)
                .nation("")
                .province("")
                .city("")
                .signature("那些看似不起波澜的日复一日，会突然在某一天，让人看到坚持的意义。")
                .build();

        //调用 userMapper 的 insert 方法将用户信息插入到数据库中
        if (userMapper.insert(user) == 0){
            throw new MyException(EnumExceptionType.INSERT_FAILED);
        }

        //生成 sessionId 和 sessionData，分别存入 sessionUtils 和 redisUtils 中，设置过期时间为 86400 秒
        String sessionId = sessionUtils.generateSessionId();
        SessionData sessionData = new SessionData(user);
        sessionUtils.setSessionId(sessionId);
        redisUtils.set(user.getId(), sessionId, 604800);
        redisUtils.set(sessionId, sessionData, 604800);

        return new UserInfoResponse(user, sessionId);
    }

    /**
     * 登录
     * @param telephone 手机号
     * @param password 密码
     * @return UserInfoResponse
     * @throws Exception 异常
     */
    @Override
    public UserInfoResponse login(String telephone, String password) throws Exception {;

        // 构造一个 QueryWrapper 用于查询用户信息，根据 telephone 从数据库中查询对应的用户信息
        QueryWrapper<User> userQueryWrapper = new QueryWrapper<>();
        userQueryWrapper.eq("telephone", telephone);
        User user = userMapper.selectOne(userQueryWrapper);

        // 如果用户不存在，则报错提醒
        if (user == null){
            throw new MyException(EnumExceptionType.USER_NOT_EXIST);
        }

        // 如果密码不正确，则报错提醒
        if (!user.getPassword().equals(password)){
            throw new MyException(EnumExceptionType.PASSWORD_ERROR);
        }

        //生成 sessionId 和 sessionData，分别存入 sessionUtils 和 redisUtils 中，设置过期时间为 86400 秒
        String sessionId = sessionUtils.generateSessionId();
        SessionData sessionData = new SessionData(user);
        sessionUtils.setSessionId(sessionId);
        redisUtils.set(user.getId(), sessionId, 604800);
        redisUtils.set(sessionId, sessionData, 604800);

        //最后构造一个 LoginInfo 对象
        return new UserInfoResponse(user, sessionId);
    }

    /**
     * 根据cookie检测登录状况
     * @return -1 会话过期，0 表示未登录，1 成功登录
     * @throws MyException 通用异常
     */
    @Override
    public Integer checkLogin() throws MyException {

        //从请求头中获得 sessionId
        String key = request.getHeader("session");

        // 如果请求头中没有 sessionId，则返回未登录
        if (key == null || !redisUtils.hasKey(key)) {
            return 0;
        }
        // 如果 sessionId 过期，则删除 sessionId，并返回会话过期
        if (redisUtils.isExpire(key)) {
            redisUtils.del(key);
            return -1;
        }

        // 刷新 sessionData
        sessionUtils.refreshData(null);

        return 1;
    }

    /**
     * 注销
     *
     * @return UserInfoResponse
     */
    @Override
    public UserInfoResponse logout() {

//        // 获取当前用户的 userId
//        String userId = sessionUtils.getUserId();
//
//        // 删除 redis 中的 sessionId 和 sessionData
//        redisUtils.del(userId);
//        redisUtils.del(sessionUtils.getSessionId());

        User user = getUserById(sessionUtils.getUserId());
        sessionUtils.invalidate();
        return new UserInfoResponse(user);
    }


    /**
     * 获取用户信息
     * @return UserInfoResponse
     * @throws MyException 通用异常
     */
    @Override
    public UserInfoResponse getUserInfo() {

        // 获取当前用户的 userId
        User user = getUserById(sessionUtils.getUserId());
        sessionUtils.refreshData(null);

        // 获取用户的情商记录和测评分数记录
        List<EmotionalIntelligence> EQHistory = emotionalIntelligenceService.getEQHistory();
        List<TestScore> testScoreHistory = testScoreService.getTestScoreHistory();

        //最后构造一个 LoginInfo 对象
        return new UserInfoResponse(user, EQHistory, testScoreHistory);
    }

    /**
     * 更新用户信息
     * @param updateUserInfoRequest 用户信息
     * @return UserInfoResponse
     * @throws MyException 通用异常
     */
    @Override
    public UserInfoResponse updateUserInfo(UpdateUserInfoRequest updateUserInfoRequest) {

        // 获取当前用户的 userId
        User user = getUserById(sessionUtils.getUserId());
        sessionUtils.refreshData(null);

        if (updateUserInfoRequest.getUsername() != null) {
            user.setUsername(updateUserInfoRequest.getUsername());
        }
        if (updateUserInfoRequest.getSignature() != null) {
            user.setSignature(updateUserInfoRequest.getSignature());
        }
        if (updateUserInfoRequest.getGender() != null) {
            user.setGender(updateUserInfoRequest.getGender());
        }
        if (updateUserInfoRequest.getAge() != null) {
            user.setAge(updateUserInfoRequest.getAge());
        }
        if (updateUserInfoRequest.getNation() != null) {
            user.setNation(updateUserInfoRequest.getNation());
        }
        if (updateUserInfoRequest.getProvince() != null) {
            user.setProvince(updateUserInfoRequest.getProvince());
        }
        if (updateUserInfoRequest.getCity() != null) {
            user.setCity(updateUserInfoRequest.getCity());
        }

        if (userMapper.updateById(user) == 0){
            throw new MyException(EnumExceptionType.UPDATE_FAILED);
        }

        return new UserInfoResponse(user);
    }

    /**
     * 修改密码
     * @param oldPassword 旧密码
     * @param newPassword 新密码
     * @return UserInfoResponse
     * @throws MyException 通用异常
     */
    @Override
    public UserInfoResponse changePassword(String oldPassword, String newPassword) throws MyException {

        // 获取当前用户的 userId
        User user = getUserById(sessionUtils.getUserId());
        sessionUtils.refreshData(null);

        if (!user.getPassword().equals(oldPassword)){
            throw new MyException(EnumExceptionType.OLD_PASSWORD_ERROR);
        }

        user.setPassword(newPassword);

        if (userMapper.updateById(user) == 0){
            throw new MyException(EnumExceptionType.UPDATE_FAILED);
        }

        return new UserInfoResponse(user);
    }

    /**
     * 上传头像
     * @param file 头像文件
     * @return String
     * @throws MyException 通用异常
     */
    @Override
    public String uploadPortrait(MultipartFile file) throws MyException {

        // 获取当前用户的 userId
        User user = getUserById(sessionUtils.getUserId());
        sessionUtils.refreshData(null);

        if (user == null) {
            throw new MyException(EnumExceptionType.USER_NOT_EXIST);
        }
        String originalFilename = file.getOriginalFilename();
        String flag = IdUtil.fastSimpleUUID();
        String rootFilePath = USER_FILE_PATH + flag + "-" + originalFilename;
        try {
            FileUtil.writeBytes(file.getBytes(), rootFilePath);
        } catch (IOException e) {
            throw new MyException(EnumExceptionType.READ_FILE_ERROR);
        }
        String link = IMAGE_PATH + flag + "-" + originalFilename;
        user.setPortrait(link);

        if (userMapper.updateById(user) == 0) {
            throw new MyException(EnumExceptionType.UPDATE_FAIL);
        }

        return link;
    }

    /**
     * 根据userId获取用户信息
     * @param userId 用户id
     * @return  User
     * @throws MyException 通用异常
     */
    @Override
    public User getUserById(String userId) throws MyException{
        User user = userMapper.selectById(userId);
        sessionUtils.refreshData(null);
        if (user == null){
            throw new MyException(EnumExceptionType.USER_NOT_EXIST);
        }
        return user;
    }
}