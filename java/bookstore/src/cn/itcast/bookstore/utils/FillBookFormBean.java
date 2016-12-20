package cn.itcast.bookstore.utils;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.BeanUtils;

public class FillBookFormBean {
	//����������е�������䵽FormBean��
	public static <T> T toFormBookBean(HttpServletRequest request,Class<T> clazz){
		try {
			T bean=clazz.newInstance();
			Map map=request.getParameterMap();
			//��map�е�key��Ӧ��bena�е����Գɹ���ԭ����  map�е�key������bean�е�����һ��
			BeanUtils.populate(bean, map);
			return bean;
		} catch (Exception e) {
			throw new RuntimeException(e);
		} 

		
	}
	
}
