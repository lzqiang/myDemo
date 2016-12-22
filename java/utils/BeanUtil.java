package com.zwsafety.platform.utils;

import java.beans.BeanInfo;
import java.beans.IntrospectionException;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.alibaba.fastjson.JSONObject;

/**  
* @ClassName:BeanUtil 
* @Description:TODO(bean工具类) 
* @date:2015年9月22日 
* @author  peijun  
* @version   1.0
* @since  JDK 1.7  
*/
public final class BeanUtil {

    /**
     * 获取map中key值，并转为字符串
     * 
     * @param map
     *            Map对象
     * @param key
     * @return
     */
    public static <K, V> String getStringValue(Map<K, V> map, K key) {

        if (map == null) {
            return "";// 返回空字符串
        }
        if (key == null) {
            return "";// 返回空字符串
        }
        if (map.get(key) == null) {
            return "";// 返回空字符串
        }
        return map.get(key).toString();
    }

    /**
     * 获取map中key值，并转为字符串
     * 
     * @param map
     *            Map对象
     * @param key
     * @return
     */
    public static <K, V> Long getLongValue(Map<K, V> map, K key) {
        String s = getStringValue(map, key);
        if (StringUtils.isNotEmpty(s)) {
            return new Long(s);
        } else {
            return null;
        }
    }

    /**
     * 将一个 Map 对象转化为一个 JavaBean
     * 
     * @param type
     *            要转化的类型
     * @param map
     *            包含属性值的 map
     * @return 转化出来的 JavaBean 对象
     * @throws IntrospectionException
     *             如果分析类属性失败
     * @throws IllegalAccessException
     *             如果实例化 JavaBean 失败
     * @throws InstantiationException
     *             如果实例化 JavaBean 失败
     * @throws InvocationTargetException
     *             如果调用属性的 setter 方法失败
     */
    public static <K, V> Object toObject(Map<K, V> map, Class<?> type)
            throws IntrospectionException, IllegalAccessException,
            InstantiationException, InvocationTargetException {
        BeanInfo beanInfo = Introspector.getBeanInfo(type); // 获取类属性
        Object obj = type.newInstance(); // 创建 JavaBean 对象

        // 给 JavaBean 对象的属性赋值
        PropertyDescriptor[] propertyDescriptors = beanInfo
                .getPropertyDescriptors();
        for (int i = 0; i < propertyDescriptors.length; i++) {
            PropertyDescriptor descriptor = propertyDescriptors[i];
            String propertyName = descriptor.getName();

            if (map.containsKey(propertyName)) {
                // 下面一句可以 try 起来，这样当一个属性赋值失败的时候就不会影响其他属性赋值。
                Object value = map.get(propertyName);

                Object[] args = new Object[1];
                args[0] = value;
                descriptor.getWriteMethod().invoke(obj, args);
            }
        }
        return obj;
    }
    
    /**
    * @Title:copyProperty
    * @Description TODO(拷贝属性值 将resMap中的值拷贝到dest中). 
    * @date  2016年12月22日 
    * @author lzqiangPC  
    * @param resMap 要修改的属性值
    * @param dest 修改后的对象
    * @throws IntrospectionException 如果分析类属性失败
    * @throws IllegalAccessException 如果实例化 JavaBean 失败
    * @throws InstantiationException 如果实例化 JavaBean 失败
    * @throws InvocationTargetException 如果调用属性的 setter 方法失败
    */
    public static <K,V> void copyProperty(Map<K, V> resMap,Object dest)
            throws  IllegalAccessException, IntrospectionException, IllegalArgumentException, InvocationTargetException {
    	if(null == dest){
    		throw new IllegalArgumentException("No destination bean specified");
    	}
        BeanInfo beanInfo = Introspector.getBeanInfo(dest.getClass()); // 获取类属性
        // 给 JavaBean 对象的属性赋值
        PropertyDescriptor[] propertyDescriptors = beanInfo
                .getPropertyDescriptors();
        for (int i = 0; i < propertyDescriptors.length; i++) {
            PropertyDescriptor descriptor = propertyDescriptors[i];
            String propertyName = descriptor.getName();
            if (resMap.containsKey(propertyName)) {
                // 下面一句可以 try 起来，这样当一个属性赋值失败的时候就不会影响其他属性赋值。
                Object value = resMap.get(propertyName);
                Object[] args = new Object[1];
                args[0] = value;
                descriptor.getWriteMethod().invoke(dest, args);
            }
        }
    }

    /**
     * 将一个 JavaBean 对象转化为一个 Map
     * 
     * @param bean
     *            要转化的JavaBean 对象
     * @return 转化出来的 Map 对象
     * @throws IntrospectionException
     *             如果分析类属性失败
     * @throws IllegalAccessException
     *             如果实例化 JavaBean 失败
     * @throws InvocationTargetException
     *             如果调用属性的 setter 方法失败
     */
    public static Map<String, Object> toMap(Object bean)
            throws IntrospectionException, IllegalAccessException,
            InvocationTargetException {
        Class<? extends Object> type = bean.getClass();
        Map<String, Object> returnMap = new HashMap<String, Object>();
        BeanInfo beanInfo = Introspector.getBeanInfo(type);

        PropertyDescriptor[] propertyDescriptors = beanInfo
                .getPropertyDescriptors();
        for (int i = 0; i < propertyDescriptors.length; i++) {
            PropertyDescriptor descriptor = propertyDescriptors[i];
            String propertyName = descriptor.getName();
            if (!propertyName.equals("class")) {
                Method readMethod = descriptor.getReadMethod();
                Object result = readMethod.invoke(bean, new Object[0]);
                if (result != null) {
                    returnMap.put(propertyName, result);
                } else {
                    returnMap.put(propertyName, "");
                }
            }
        }
        return returnMap;
    }
}
