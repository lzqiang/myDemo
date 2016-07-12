package com.zw.zwsafety.gencode.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * 时间操作定义类
 * @author xufeng
 * @date： 日期：2015.4.8
 */
public class DateUtil  {
	
	// 各种时间格式
	public static final String defaultFormat="yyyy-MM-dd HH:mm:ss";
	public static final String dayFormat="yyyy-MM-dd";
	
	public static final String ChinaFormat="yyyy年MM月dd日";
	/**
	 * 当前日历，这里用中国时间表示
	 * 
	 * @return 以当地时区表示的系统当前日历
	 */
	public static Calendar getCalendar() {
		return Calendar.getInstance();
	}

	
    /**  
    * @Title:getCurrentYear
    * @Description TODO(获得当前年份). 
    * @date  2015年7月6日 上午10:26:57 
    * @author peijun  
    * @return int
    */
    public static int getCurrentYear() {
        return getCalendar().get(Calendar.YEAR);
    }
    
	/**
	 * 指定毫秒数表示的日历
	 * 
	 * @param millis
	 *            毫秒数
	 * @return 指定毫秒数表示的日历
	 */
	public static Calendar getCalendar(long millis) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date(millis));
		return cal;
	}

	/**
	 * 当前日期
	 * 
	 * @return 系统当前时间
	 */
	public static Date getDate() {
		return new Date();
	}

	/**
	 * 指定毫秒数表示的日期
	 * 
	 * @param millis
	 *            毫秒数
	 * @return 指定毫秒数表示的日期
	 */
	public static Date getDate(long millis) {
		return new Date(millis);
	}

	
	/**
	 * 字符串转为date
	 * @param str
	 * @param sdf
	 * @return
	 */
	public static Date parseDate(String str, String format) {
		if (null == str || "".equals(str)) {
			return null;
		}
		Date date = null;
		try {
			SimpleDateFormat sdf = new SimpleDateFormat(format);
			date = sdf.parse(str);
			return date;
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 字符串转为date yyyy-MM-dd HH:mm:ss
	 * @param str
	 * @param sdf
	 * @return
	 */
	public static Date parseDate(String str)
			throws ParseException {
		return parseDate(str,defaultFormat);
	}

	/**
	 * 时间转为字符串
	 * @param date 
	 * @param sdf 时间格式
	 * @return
	 */
	public static String formatDate(Date date, String format) {
		if (null == date) {
			return null;
		}
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		return sdf.format(date);
	}
	
	/**
	 * 时间转为字符串 yyyy-MM-dd HH:mm:ss
	 * @param date
	 * @return
	 */
	public static String formatDate(Date date) {
		return formatDate(date,defaultFormat);
	}


}