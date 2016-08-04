/**  
 * Project Name:platform_framework  
 * File Name:Token.java  
 * Package Name:com.zwsafety.platform.framework  
 * Date:2016年8月4日
 * Copyright (c) 2016,zwsafety All Rights Reserved.   
 */

package com.zwsafety.platform.framework;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * @ClassName:Token
 * @Description:TODO(用一句话描述该文件做什么)
 * @date:2016年8月4日
 * @author xufeng
 * @version 1.0
 * @since: JDK 1.7
 */

@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface Token {

    boolean save() default false;

    boolean remove() default false;
}
