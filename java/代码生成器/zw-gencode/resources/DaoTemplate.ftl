/**  
 * Project Name:xx项目工程(英文名称)
 * File Name:${className}Mapper.java  
 * Package Name:package ${bussPackage}.${entityPackage}.dao
 * Date:${createDate}
 * Copyright (c) ${createYear} ,zwsafety All Rights Reserved.   
 */
package ${bussPackage}.${entityPackage}.dao;

import org.springframework.stereotype.Repository;
import ${bussPackage}.${entityPackage}.entity.${className};
import com.zwsafety.platform.base.BaseMapper;

 /**
 * @ClassName:${className}Mapper
 * @Description:TODO(用一句话描述该文件做什么)
 * @date:${createDate}
 * @author ${createAuthor}
 * @version 1.0
 * @since JDK 1.7
 */
 @Repository
public interface ${className}Mapper extends BaseMapper<${className}, String> {
	
}
