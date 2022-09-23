package com.example.frame.common.aop.annotation;

import java.lang.annotation.*;


/**
 * @author sya
 * @Date 2021/12/18 21:47
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface CheckLockAnnotation {

    /*
     * 唯一ID
     * */
    String id() default "";


    /*
     *时间 单位(秒)
     * */
    int time() default 3;

}
