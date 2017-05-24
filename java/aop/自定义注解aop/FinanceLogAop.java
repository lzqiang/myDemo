package com.ttpai.boss.finance.aop;

import com.alibaba.fastjson.serializer.SerializerFeature;
import com.ttpai.boss.finance.annotations.JsonOfLog;
import com.ttpai.util.Constants;
import com.ttpai.util.CookieUtil;
import com.ttpai.util.JsonUtil;
import net.paoding.rose.web.InvocationUtils;
import org.apache.commons.lang.StringUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletRequest;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Map;

/**
 * 拦截标记有 @JsonOfLog 的方法，以Json形式打印 【方法名，参数，返回值，异常堆栈等信息】
 */
public class FinanceLogAop {

    /**
     * 是否打印日志
     */
    private Boolean valid = true;
    /**
     * Log4j级别，在 applicationContext_aop.xml 里面配置
     */
    private String logLevel = "INFO";


    private static final Logger LOGGER = LoggerFactory.getLogger(FinanceLogAop.class);


    /**
     * 环绕方法
     *
     * @param point     切入点
     * @param jsonOfLog 注解对象
     * @return 被拦截方法的返回值
     * @throws Throwable 被拦截方法抛出的异常
     */
    public Object around(ProceedingJoinPoint point, JsonOfLog jsonOfLog) throws Throwable {
        Object ret = null;
        if (valid) {
            Map map = new HashMap();
            this.buildCookieInfo(map);
            map.put("method", point.getSignature().getDeclaringTypeName() + "." + point.getSignature().getName()); // 被拦截的方法
            map.put("argus", point.getArgs()); // 被拦截的方法参数
            if (null != jsonOfLog) {
                map.put("logDesc", jsonOfLog.logDesc()); // 注解中的描述
                map.put("author", jsonOfLog.author()); // 注解中的作者
            }

            try {
                ret = point.proceed();
                map.put("return", ret);  // 返回值
            } catch (Throwable throwable) {
                map.put("exception", throwable); // 异常
                throw throwable;
            } finally {
                if ("ERROR".equalsIgnoreCase(logLevel)) {
                    LOGGER.error(JsonUtil.toJSONString(map, new SerializerFeature[]{}));
                } else if ("WARN".equalsIgnoreCase(logLevel)) {
                    LOGGER.warn(JsonUtil.toJSONString(map, new SerializerFeature[]{}));
                } else if ("INFO".equalsIgnoreCase(logLevel)) {
                    LOGGER.info(JsonUtil.toJSONString(map, new SerializerFeature[]{}));
                } else if ("DEBUG".equalsIgnoreCase(logLevel)) {
                    LOGGER.debug(JsonUtil.toJSONString(map, new SerializerFeature[]{}));
                }
            }
        }
        return ret;
    }

    /**
     * 纪录操作人 信息
     */
    private void buildCookieInfo(Map map) {
        try {
            HttpServletRequest request = InvocationUtils.getCurrentThreadRequest();
            if (null != request) {
                map.put("accountId", getId(request));
                map.put("accountName", CookieUtil.getCookieValue(request, Constants.BOSS_COOKIE_ACCOUNT_NAME));
            }
        } catch (Exception ex) {
            // noting
        }
    }

    public Integer getId(HttpServletRequest request) throws Exception {
        String cookieId = CookieUtil.getCookieValue(request, Constants.BOSS_COOKIE_ACCOUNT_TOKEN);
        if (null != cookieId) {
            cookieId = URLDecoder.decode(URLDecoder.decode(cookieId, Constants.UTF8), Constants.UTF8);
            String strId = cookieId.substring(cookieId.lastIndexOf(Constants.BOSS_COOKIE_SPT) + 1);
            return StringUtils.isNotBlank(strId) ? Integer.valueOf(strId) : 0;
        } else {
            return 0;
        }
    }

    public void setValid(Boolean valid) {
        this.valid = valid;
    }

    public void setLogLevel(String logLevel) {
        this.logLevel = logLevel;
    }
}