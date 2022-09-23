package com.example.frame.common.aop.annotation;

import java.lang.annotation.*;

/**
 * @author Galen
 * @Date 2021/12/18 21:47
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface LogAnnotation {
    /**
     * 模块
     */
    String title() default "";

    /**
     * 功能
     */
    String action() default "";

    /**
     * 类型
     */
    int type() default 0;
}
