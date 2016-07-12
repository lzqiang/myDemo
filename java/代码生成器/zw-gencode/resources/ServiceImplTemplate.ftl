/**  
 * Project Name:xx项目工程(英文名称)
 * File Name:${className}ServiceImpl.java  
 * Package Name:${bussPackage}.${entityPackage}.service.impl
 * Date:${createDate}
 * Copyright (c) ${createYear} ,zwsafety All Rights Reserved.   
 */
package ${bussPackage}.${entityPackage}.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import ${bussPackage}.${entityPackage}.dao.${className}Mapper;
import ${bussPackage}.${entityPackage}.entity.${className};
import ${bussPackage}.${entityPackage}.service.${className}Service;
import com.zwsafety.platform.base.BaseMapper;
import com.zwsafety.platform.base.BaseServiceImpl;

 /**
 * @ClassName:${className}ServiceImpl
 * @Description:TODO(用一句话描述该文件做什么)
 * @date:${createDate}
 * @author ${createAuthor}
 * @version 1.0
 * @since JDK 1.7
 */
@Service("$!{lowerName}Service")
public class ${className}ServiceImpl extends BaseServiceImpl<${className}, String> implements ${className}Service {
	
	/**  
	* @Fields $!{lowerName}Mapper:TODO(用一句话描述这个变量表示什么).  
	*/
	@Autowired
	private ${className}Mapper $!{lowerName}Mapper;

	/**  
	* @Fields redisTemplate:TODO(redis缓存模板).  
	*/
	@Autowired  
	private RedisTemplate<String,Object> redisTemplate;
	
	/**  
    * @Title  getMapper   
    * @Description  TODO(get方法)
 	* @date:${createDate}
 	* @author ${createAuthor}
    * @return BaseMapper<${className}, String>
    * @see com.zwsafety.platform.base.BaseServiceImpl#getMapper() 
    */
	@Override
	public BaseMapper<${className}, String> getMapper() {
		return $!{lowerName}Mapper;
	}


}
