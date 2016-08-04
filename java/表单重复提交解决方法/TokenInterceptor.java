/**  
 * Project Name:platform_framework  
 * File Name:TokenInterceptor.java  
 * Package Name:com.zwsafety.platform.framework  
 * Date:2016年8月4日
 * Copyright (c) 2016,zwsafety All Rights Reserved.   
 */

package com.zwsafety.platform.framework;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.zwsafety.platform.base.HtmlUtil;

/**
 * @ClassName:TokenInterceptor
 * @Description:TODO(用一句话描述该文件做什么)
 * @date:2016年8月4日
 * @author xufeng
 * @version 1.0
 * @since: JDK 1.7
 */
public class TokenInterceptor extends HandlerInterceptorAdapter {
    private static final Logger LOG = Logger.getLogger(Token.class);

    @Override
    public boolean preHandle(HttpServletRequest request,
            HttpServletResponse response, Object handler) throws Exception {
        if (handler instanceof HandlerMethod) {
            HandlerMethod handlerMethod = (HandlerMethod) handler;
            Method method = handlerMethod.getMethod();
            Token annotation = method.getAnnotation(Token.class);
            if (annotation != null) {
                boolean needSaveSession = annotation.save();
                if (needSaveSession) {
                    request.getSession(true).setAttribute("token",
                            UUID.randomUUID().toString());
                }
                boolean needRemoveSession = annotation.remove();
                if (needRemoveSession) {
                    if (isRepeatSubmit(request)) {
                        LOG.warn("请不要重复提交,url:" + request.getServletPath());
                        Map<String, Object> result = new HashMap<String, Object>();
                        result.put("success", false);
                        result.put("msg", "数据已提交，请不要重复提交!");
                        HtmlUtil.writerJson(response, result);
                        return false;
                    }
                    request.getSession(true).removeAttribute("token");
                }
            }
            return true;
        } else {
            return super.preHandle(request, response, handler);
        }
    }

    private boolean isRepeatSubmit(HttpServletRequest request) {
        String serverToken = (String) request.getSession(true).getAttribute(
                "token");
        if (serverToken == null) {
            return true;
        }
        String clinetToken = request.getParameter("token");
        if (clinetToken == null) {
            return true;
        }
        if (!serverToken.equals(clinetToken)) {
            return true;
        }
        return false;
    }
}
