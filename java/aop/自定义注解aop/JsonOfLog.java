package com.ttpai.boss.finance.annotations;

import java.lang.annotation.*;

/**
 * 拦截方法，以Json方式打印方法和返回值
 *
 * @see com.ttpai.boss.finance.aop.FinanceLogAop
 * <p/>
 * Created by Kail on 2016/3/9.
 */
@Documented
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface JsonOfLog {

    /**
     * 需要打印的日志描述
     */
    public String logDesc() default "";

    /**
     * 谁对这个日志比较熟悉
     */
    public String author() default "";

}
