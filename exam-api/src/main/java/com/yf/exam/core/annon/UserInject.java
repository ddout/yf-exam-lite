package com.yf.exam.core.annon;


import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 注入用户ID
 * @author bool
 * @date 2019-05-09 14:31
 */
@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.TYPE, ElementType.METHOD})
public @interface UserInject {

    /**
     * 要注入的参数索引，一般为第一个，极端情况下会使用多个
     * @return
     */
    int index() default 0;

    /**
     * 是否必须的
     * @return
     */
    boolean required() default true;

    /**
     * 需要注入的字段名称，可以是多个
     * @return
     */
    String [] ids() default {"userId"};

    /**
     * 需要注入的字段名称，可以是多个
     * @return
     */
    String [] names() default {"userName"};
}
