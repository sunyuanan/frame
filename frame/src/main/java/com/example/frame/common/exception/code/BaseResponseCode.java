package com.example.frame.common.exception.code;

public enum BaseResponseCode implements ResponseCodeInterface {
    /**
     * 这个要和前段约定好 引导用户去登录界面的 code=401001 引导用户重新登录 code=401002 token 过期刷新token code=401008 无权限访问
     */
    SUCCESS(0, "操作成功"),
    SYSTEM_BUSY(500001, "系统繁忙，请稍候再试"),
    OPERATION_ERRO(500002, "操作失败"),
    BAD_REQUEST(400, "请求参数异常"),
    TOKEN_PARSE_ERROR(401001, "登录凭证已过期，请重新登录"),
    TOKEN_ERROR(401001, "登录凭证已过期，请重新登录"),
    TOKEN_EXCEPTION(401001, "登陆凭证异常"),
    ACCOUNT_ERROR(401001, "该账号异常，请联系运营人员"),
    ACCOUNT_LOCK_ERROR(401001, "该用户已被锁定，请联系运营人员"),
    TOKEN_PAST_DUE(401002, "授权信息已过期，请刷新token"),
    DATA_ERROR(401003, "传入数据异常"),
    ACCOUNT_HAS(401002, "账号已存在"),
    NOT_ACCOUNT(401004, "该用户不存在,请先注册"),
    USER_LOCK(401005, "该用户已被锁定，请联系运营人员"),
    PASSWORD_ERROR(401006, "用户名或密码错误"),
    METHODARGUMENTNOTVALIDEXCEPTION(401007, "方法参数校验异常"),
    UNAUTHORIZED_ERROR(401008, "权鉴校验不通过"),
    ROLE_PERMISSION_RELATION(401009, "该菜单权限存在子集关联，不允许删除"),
    OLD_PASSWORD_ERROR(401010, "旧密码不正确"),
    NOT_PERMISSION_DELETED_DEPT(401011, "该组织机构下还关联着用户，不允许删除"),
    OPERATION_MENU_PERMISSION_CATALOG_ERROR(401012, "操作后的菜单类型是目录，所属菜单必须为默认顶级菜单或者目录"),
    OPERATION_MENU_PERMISSION_MENU_ERROR(401013, "操作后的菜单类型是菜单，所属菜单必须为目录类型"),
    OPERATION_MENU_PERMISSION_BTN_ERROR(401013, "操作后的菜单类型是按钮，所属菜单必须为菜单类型"),
    OPERATION_MENU_PERMISSION_UPDATE(401014, "操作的菜单权限存在子集关联不允许变更"),
    OPERATION_MENU_PERMISSION_URL_NOT_NULL(401015, "菜单权限的url不能为空"),
    OPERATION_MENU_PERMISSION_URL_PERMS_NULL(401016, "菜单权限的标识符不能为空"),
    OPERATION_MENU_PERMISSION_URL_METHOD_NULL(401017, "菜单权限的请求方式不能为空"),
    DEFAULT_FILE_NAME_LENGTH(401018, "文件名过长"),
    DEFAULT_MAX_SIZE(401019, "文件过大"),
    MD_TOKEN_ERROR(401020, "token错误"),
    OPERATION_dob(401021, "请勿重复提交"),
    DEFAULT_FILE_ERROR(401022, "附件保存异常"),
    Medth_TOKEN_PARSE_ERROR(4010041, "rep_token异常"),
    ACCOUNT_SQUEEZE_ERROR(4010042, "您账号已被其他地方登录"),
    METHOD_NOT_ALLOWED(405, "请求方式错误"),
    INTERNAL_SERVER_ERROR(505, "空指针异常"),
    ACCOUNT_JH_ERROR(4010043, "警号或身份证号不能为空"),
    NO_POWER_ERROR(4010044, "您无权限访问"),
    ACCOUNT_LOCK_30(4010045, "账号已锁定30分钟"),
    SQL_ERROR(4444444, "SQL语句错误"),
    ;

    /**
     * 错误码
     */
    private final int code;
    /**
     * 错误消息
     */
    private final String msg;

    BaseResponseCode(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    @Override
    public int getCode() {
        return code;
    }

    @Override
    public String getMsg() {
        return msg;
    }
}
