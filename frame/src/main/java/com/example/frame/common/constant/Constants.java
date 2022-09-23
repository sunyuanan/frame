package com.example.frame.common.constant;


import org.springframework.stereotype.Component;
/**
 * @author Galen
 * @Date 2021/12/18 21:47
 */
@Component
public class Constants {
    //当前登录账号id
    public static final String CURRENT_ACCOUNT_ID = "LOGIN_ID";
    //当前登录账号id
    public static final String CURRENT_ACCOUNT = "ACCOUNT";

    //当前登录角色id
    public static final String CURRENT_ACCOUNT_ROLE_ID = "ROLE_ID";
    //当前登录角色名称
    public static final String CURRENT_ACCOUNT_ROLE_NAME = "ROLE_NAME";
    //当前登录所属单位编码
    public static final String CURRENT_ACCOUNT_UNIT = "UNIT_CODE";
    //当前登录所属单位类型
    public static final String CURRENT_ACCOUNT_UNIT_TYPE = "UNIT_TYPE";
    //当前登录管辖编码
    public static final String CURRENT_ACCOUNT_UNIT_GUANXIA = "UNIT_GUANXIA_CODE";
    //登录用户姓名
    public static final String CURRENT_ACCOUNT_USER_NAME = "USER_NAME";

    public static final String TASK_CLASS_NAME = "TASK_CLASS_NAME";

    /**
     * 执行目标key
     */
    public static final String TASK_PROPERTIES = "TASK_PROPERTIES";

    /**
     * 默认
     */
    public static final String MISFIRE_DEFAULT = "0";

    /**
     * 立即触发执行
     */
    public static final String MISFIRE_IGNORE_MISFIRES = "1";

    /**
     * 触发一次执行
     */
    public static final String MISFIRE_FIRE_AND_PROCEED = "2";

    /**
     * 不触发立即执行
     */
    public static final String MISFIRE_DO_NOTHING = "3";

    public static enum Status {
        /**
         * 正常
         */
        NORMAL("0"),
        /**
         * 暂停
         */
        PAUSE("1");

        private String value;

        Status(String value) {
            this.value = value;
        }

        public String getValue() {
            return value;
        }
    }

}
