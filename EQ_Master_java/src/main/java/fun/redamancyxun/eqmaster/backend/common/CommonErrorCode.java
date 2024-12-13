package fun.redamancyxun.eqmaster.backend.common;


import lombok.Getter;

import java.util.HashMap;
import java.util.Map;

/**
 * @author xiaowen
 * @version 2022/1/19 19:21
 */
@Getter
public enum CommonErrorCode {

    //1打头是微信错误，其他是程序错误
    WX_LOGIN_BUSY(1002,"系统繁忙，此时请开发者稍候再试","微信小程序繁忙，请稍候再试"),
    WX_LOGIN_INVALID_CODE(1003,"无效的code","授权失败，请检查微信账号是否正常"),
    WX_LOGIN_FREQUENCY_REFUSED(1004,"请求太频繁，一分钟不能超过100次","请勿多次重复授权"),
    WX_LOGIN_UNKNOWN_ERROR(1005,"微信授权未知错误","微信异常，请稍后再试"),
    WX_APPSECRET_INVALID(1006,"AppSecret 错误或者 AppSecret 不属于这个小程序","系统异常，请稍后再试"),
    WX_GRANTTYPE_MUSTBE_CLIENTCREDENTIAL(1007,"请确保 grant_type 字段值为 client_credential","系统异常，请稍后再试"),
    WX_APPID_INVALID(1008,"不合法的 AppID","系统异常，请稍后再试"),
    WX_CONTENT_ILLEGAL(1009,"内容安全校验不通过","内容含有违法违规内容，请修改"),
    WX_CONTENT_SECURITY_FORMAT_ERROR(1010,"内容安全校验格式不合法","系统异常，请稍后再试"),

    //微信支付回调
    WX_NOTIFY_RESULT_NULL(1011,"回调结果为空","回调结果为空"),
    WX_NOTIFY_RESULT_UNEXPECTED(1011,"回调结果不是success","回调结果不是success"),

    //微信订阅消息
    WX_SUBSCRIBE_SEND_NULL(140000,"订阅消息返回体为空","系统异常，请稍后再试"),
    WX_SUBSCRIBE_SEND_40003(140003,"touser字段openid为空或者不正确","系统异常，请稍后再试"),
    WX_SUBSCRIBE_SEND_40037(140037,"订阅模板id为空或不正确","系统异常，请稍后再试"),
    WX_SUBSCRIBE_SEND_43101(143101,"用户拒绝接受消息，如果用户之前曾经订阅过，则表示用户取消了订阅关系","系统异常，请稍后再试"),
    WX_SUBSCRIBE_SEND_47003(147003,"模板参数不准确，可能为空或者不满足规则，errmsg会提示具体是哪个字段出错","系统异常，请稍后再试"),
    WX_SUBSCRIBE_SEND_41030(141030,"page路径不正确，需要保证在现网版本小程序中存在，与app.json保持一致","系统异常，请稍后再试"),
    //微信退款

    //微信二维码
    WX_QRCODE_UNAUTHORIZED(1012,"暂无生成权限","系统异常，请稍后再试"),
    WX_QRCODE_TOO_FREQUENT(1013,"调用分钟频率受限(目前5000次/分钟，会调整)，如需大量小程序码，建议预生成","系统繁忙，请稍后重试"),

    USER_NOT_EXIST(2001,"用户不存在","用户不存在"),
    SYSTEM_ERROR(2002,"系统错误","系统错误，请重试"),
    INVALID_SESSION(2006,"会话丢失","登录已失效，请重新登录"),
    SCHOOL_UNAUTHORIZED(2007,"未通过学校认证","尚未进行校园认证，请先认证"),
    INVALID_PICTURE_TYPE(2008,"无效的图片类型（必须是goods或advice）","图片上传出错，请重试"),
    TEL_USED_ERROR(2009,"手机号已注册","请前往登录"),
    VERIFY_FAILED(2010,"验证失败","请重试"),
    LOGIN_FAILED(2011,"登录失败","用户名或密码错误"),
    PARAMS_INVALID(2012,"存在有误的参数","请重试"),
    UNSIGNED_USER(2013,"未注册用户","请前往注册"),
    INVALID_PHONE(2014,"无效手机号","请输入正确的手机号"),
    UPDATE_FAIL(2015,"更新失败，出现竞态条件","请稍后重试"),
    USER_NOT_ADMIN(2016,"用户非管理员","用户非管理员"),
    NEED_SESSION_ID(2017,"未传入sessionId","请传入会话id"),
    LOGIN_HAS_OVERDUE(2018,"登录已过期","登录已过期"),
    SESSION_IS_INVALID(2019,"该session数据库里没有","请在header里key为session处对应有效的sessionId"),
    DUPLICATE_DATABASE_INFORMATION(2020,"重复的数据库信息","信息添加失败，请重试"),
    UPLOAD_FILE_FAIL(2021,"上传文件失败","请检查网络状况后稍后重试"),
    FILENAME_CAN_NOT_BE_NULL(2022,"文件名不能为空","请取一个有后缀的文件名"),
    EXECUTION_FAIL(2023,"方法执行错误","请稍后重试"),
    DATA_NOT_EXISTS(2024, "无效的数据库信息", "数据库查询失败"),
    INVALID_PARAM(2025, "非法参数", "参数非法，请检查输入"),
    OPERATION_TOO_FREQUENT(2026, "操作过于频繁", "操作过于频繁，请稍后再试"),
    USERNAME_HAS_BEEN_SIGNED_UP(2027,"用户名已被注册","请尝试新的用户名"),
    PASSWORD_NOT_RIGHT(2028,"密码错误","密码错误，请重新输入密码"),
    TWO_INPUTED_PASSWORDS_NOT_THE_SAME(2028,"两次输入的密码不一致","两次输入密码不一致，请重新输入"),
    READ_FILE_ERROR(2029,"读取文件失败","请检查文件格式后重新上传文件"),
    FILE_NOT_EXIST(2030,"文件不存在","文件不存在"),
    DOWNLOAD_FILE_FAILED(2031,"下载失败","请在浏览器地址栏中输入链接来测试，或者检查网络或系统状况"),
    CAN_NOT_MODIFY(2033, "不可修改", "无权修改"),
    ACCOUNT_STATUS_NORMAL(2034, "账号状态正常","账号状态正常，无需申诉"),
    HAVE_NO_PERMISSION(2035, "无权进行本次操作","无权进行本次操作"),
    TELEPHONE_HAS_BEEN_SIGNED_UP(2036,"手机号已被注册","手机号已被注册"),
    PASSWORD_NOT_QUANTIFIED(2037,"密码不符合要求","密码不符合要求"),
    ZIPPATH_ERROR(2039,"打包路径错误，必须以.zip结尾","打包路径错误，必须以.zip结尾"),
    MESSAGE_NOT_EXIST(2040,"消息不存在","消息不存在"),
    ARTICLE_NOT_FOUND(2041,"文章不存在","文章不存在"),
    ARTICLE_ALREADY_EXIST(2042,"文章已存在","文章已存在"),
    CARD_NOT_FOUND(2043,"卡片不存在","卡片不存在"),
    VIDEO_ALREADY_EXIST(2044,"视频已存在","视频已存在"),
    THEME_NOT_EXIST(2045,"主题不存在","主题不存在"),
    ROLE_ALREADY_SET(2046,"角色已设置","角色已设置"),
    SUBPROJECT_NOT_EXIST(2047,"子项目不存在","子项目不存在"),
    GUIDANCE_NOT_EXIST(2048,"指导不存在","指导不存在"),
    FEEDBACK_NOT_EXIST(2049,"反馈不存在","反馈不存在"),
    FEEDBACK_HAS_BEEN_DEALED(2050,"反馈已处理","反馈已处理"),
    OBSERVATION_NOT_EXIST(2051,"观察不存在","观察不存在"),
    QUESTION_NOT_EXIST(2052,"问题不存在","问题不存在"),
    QUESTION_ALREADY_DELETED(2053,"问题已删除","问题已删除"),
    QUESTIONNAIRE_NOT_EXIST(2054,"问卷不存在","问卷不存在"),
    QUESTION_RESULT_NOT_EXIST(2055,"问题结果不存在","问题结果不存在"),
    SUB_PROJECT_NOT_EXIST(2056,"子项目不存在","子项目不存在"),
    QUESTIONNAIRE_FINISHED(2057,"问卷已完成","问卷已完成"),
    USER_ROLE_NOT_SET(2058,"用户身份未设置","用户身份未设置"),
    DELETE_ERROR(2059,"删除失败","删除失败,检查参数是否正确"),
    QUESTION_SECTION_NOT_EXIST(2060,"问题板块不存在","问题板块不存在"),
    ;

    /**
     * 错误码
     */
    private final Integer errorCode;

    /**
     * 错误原因（给开发看的）
     */
    private final String errorReason;

    /**
     * 错误行动指示（给用户看的）
     */
    private final String errorSuggestion;

    CommonErrorCode(Integer errorCode, String errorReason, String errorSuggestion) {
        this.errorCode = errorCode;
        this.errorReason = errorReason;
        this.errorSuggestion = errorSuggestion;
    }

    @Override
    public String toString() {
        return "CommonErrorCode{" +
                "errorCode=" + errorCode +
                ", errorReason='" + errorReason + '\'' +
                ", errorSuggestion='" + errorSuggestion + '\'' +
                '}';
    }

    //use for json serialization
    public Map<String,Object> toMap(){
        Map<String,Object> map = new HashMap<>();
        map.put("errorCode",errorCode);
        map.put("errorReason",errorReason);
        map.put("errorSuggestion",errorSuggestion);
        return map;
    }


}