package com.example.frame.common.utils;

import java.util.UUID;

/**
 * @ClassName: PasswordUtils 密码工具类 @Version: 0.0.1
 */
public class PasswordUtils {

    /**
     * 匹配密码
     *
     * @param salt    盐
     * @param rawPass 明文
     * @param encPass 密文
     */
    public static boolean matches(String salt, String rawPass, String encPass) {
        return new PasswordEncoder(salt).matches(encPass, rawPass);
    }

    /**
     * 明文密码加密
     *
     * @param rawPass 明文
     */
    public static String encode(String rawPass, String salt) {
        return new PasswordEncoder(salt).encode(rawPass);
    }

    /**
     * 获取加密盐
     */
    public static String getSalt() {
        return UUID.randomUUID().toString().replaceAll("-", "").substring(0, 20);
    }

    public static void main(String[] args) {
        System.out.println(encode("123456", "324ce32d86224b00a02b"));
    }
}
