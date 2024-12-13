package fun.redamancyxun.eqmaster.backend.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum EnumExceptionType {
    // 项目自定义错误 1（1 开头）
    UNKNOWN_ERROR(999,"未知错误"),
    SYSTEM_INTERNAL_ANOMALY(1000, "网络不给力，请稍后重试"),
    UPDATE_FAIL(1001,"上传失败"),
    APPRAISE_NOT_EXIST(1002,"评价不存在"),
    CREDIT_NOT_EXIST(1003,"评价明细不存在"),
    INSERT_FAILED(1004,"数据录入失败"),
    TELEPHONE_EXIST(1005,"手机号已存在"),
    PASSWORD_ERROR(1006,"密码错误"),
    OLD_PASSWORD_ERROR(1006,"旧密码错误！"),
    TEXT_NOT_EXIST(1007,"文本不存在"),
    DATA_IS_NULL(1008,"传入数据不存在"),
    IO_ERROR(1009,"IO异常"),
    INTERRUPTED_ERROR(1010, "线程中断异常"),
    PROCESS_ERROR(1011, "进程错误"),
    PROCESS_TIME_OUT(1012, "进程超时"),

    // 项目自定义错误 2（3 开头）
    ARTICLE_NOT_EXIST(3001,"帖子不存在"),
    PARAMETER_ERROR(3002,"参数错误"),
    REDIS_ERROR(3003, "Redis错误"),
    NOTICE_NOT_EXIST(3004, "通知不存在"),
    COMMENT_NOT_EXIST(3005, "评论不存在"),
    STAR_EXIST(3006, "收藏已存在"),
    STAR_FAILED(3007, "收藏失败"),
    UNSTAR_EXIT(3008, "未收藏"),
    VIEW_COUNT_ERROR(3009, "浏览量错误"),
    LIKE_EXIST(3010, "已点赞"),
    LIKE_UNEXIST(3011, "未点赞"),
    COMMENT_NOT_FOUND(3012, "评论不存在"),
    REPLY_NOT_FOUND(3013, "回复不存在"),
    CONSIGNEE_NOT_EXIST(3014, "收货地址不存在"),
    EXPRESSORDER_NOT_EXIST(3015, "代取订单不存在"),
    ACCEPTEDSSORDER_NOT_EXIST(3016, "接收的代取订单不存在"),
    CANCEL_FAIL(3017,"代取订单取消失败，原订单任务可能已完成或者已超时"),
    RECEIVE_FAIL(3018,"无法将代取订单设为已收到，原订单任务可能已取消或者已超时"),
    DAILYSHARE_NOT_EXIST(3019,"每日分享不存在"),
    TESTSCORE_NOT_EXIST(3020,"测评分数不存在"),

    // 微信小程序通用错误 1
    INVALID_SESSION(2006,"会话丢失, 登录已失效, 请重新登录"),
    USER_NOT_ADMIN(2002,"用户非管理员"),
    NEED_SESSION_ID(2003,"未传入sessionId, 请传入会话id"),
    LOGIN_HAS_OVERDUE(2004,"登录已过期"),
    SESSION_IS_INVALID(2005,"该session数据库里没有, 请在header里key为session处对应有效的sessionId"),
    SEND_EMAIL_FAILED(2024, "发送邮件失败, 请检查邮箱账号"),
    EMAIL_HAS_BEEN_SIGNED_UP(2025, "该邮箱已被使用, 请更换邮箱"),
    VERIFICATION_CODE_WRONG(2026, "邮箱验证码错误, 请输入正确的邮箱验证码"),
    EMAIL_NOT_SIGNED_UP(2027, "该邮箱尚未注册账号, 请输入正确的邮箱或先用此邮箱注册账号"),
    PASSWORD_NOT_QUANTIFIED(2028, "密码强度不够, 请输入符合要求的密码"),
    CAN_NOT_DELETE(2030, "超级管理员无法注销, 你这么牛逼, 注销自己干嘛"),
    DO_NOT_SEND_VERIFICATION_CODE_AGAIN(2031, "您上一次验证码尚未失效, 请勿重复发送验证码"),
    VERIFICATION_CODE_HAS_EXPIRED(2038, "验证码已过期, 请重新发送验证码"),
    READ_FILE_ERROR(2039, "读取文件失败, 请检查文件"),
    WX_LOGIN_BUSY(2040,"微信小程序繁忙，请稍候再试"),
    WX_LOGIN_INVALID_CODE(2041,"授权失败，请检查微信账号是否正常"),
    WX_LOGIN_FREQUENCY_REFUSED(2042,"请求太频繁，一分钟不能超过100次,请勿多次重复授权"),
    WX_LOGIN_UNKNOWN_ERROR(2043,"微信授权未知错误,微信异常，请稍后再试"),
    WX_APPSECRET_INVALID(2044,"AppSecret 错误或者 AppSecret 不属于这个小程序,系统异常，请稍后再试"),
    WX_GRANTTYPE_MUSTBE_CLIENTCREDENTIAL(2045,"请确保 grant_type 字段值为 client_credential,系统异常，请稍后再试"),
    WX_APPID_INVALID(2046,"不合法的 AppID,系统异常，请稍后再试"),
    WX_CONTENT_ILLEGAL(2047,"内容安全校验不通过,内容含有违法违规内容，请修改"),
    WX_CONTENT_SECURITY_FORMAT_ERROR(2048,"内容安全校验格式不合法,系统异常，请稍后再试"),


    // 微信小程序通用错误 2
    USER_NOT_EXIST(9001,"用户不存在, 请检查手机号码是否正确"),
    UPDATE_FAILED(9007,"更新失败, 没有信息被更改"),
    WRONG_CODE(9021,"传入的code有误"),
    AUTHEN_NOT_EXIST(9022,"认证不存在"),
    STILL_NOT_VERIFIED(9023,"用户未身份认证"),
    APPLY_EXIST(9024,"已经发送过同样的申请啦！"),
    USER_NOT_THIS_TEAM(9025,"用户不是这个团队的！"),
    SYSTEM_ERROR(9026,"系统错误, 手机号获取失败"),
    INPUT_NULL(9027,"输入为空！"),
    EMAIL_PATTERN_ERROR(9028,"邮箱地址有误"),
    PERMISSION_DENIED(9029, "您没有权限进行此操作"),
    WECHAT_ERROR(9030, "微信登录失败, 请检查微信登录"),
    USER_BANNED(9032, "用户被封禁, 用户被封禁"),
    SESSION_NOT_FOUND(9041, "session不存在, 请清空wxStorage或重新登录！");

    private final int errorCode;

    private final String codeMessage;
}
