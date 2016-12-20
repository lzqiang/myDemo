package cn.itcast.bookstore.utils;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.BeanUtils;

public class FillBookFormBean {
	//把请求对象中的数据填充到FormBean中
	public static <T> T toFormBookBean(HttpServletRequest request,Class<T> clazz){
		try {
			T bean=clazz.newInstance();
			Map map=request.getParameterMap();
			//将map中的key对应的bena中的属性成功的原则是  map中的key必须与bean中的属性一致
			BeanUtils.populate(bean, map);
			return bean;
		} catch (Exception e) {
			throw new RuntimeException(e);
		} 

		
	}
	
}
