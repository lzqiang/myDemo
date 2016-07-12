/**  
 * Project Name:xx项目工程(英文名称)
 * File Name:${className}Controller.java  
 * Package Name:${bussPackage}.${entityPackage}.controller  
 * Date:${createDate}
 * Copyright (c) ${createYear} ,zwsafety All Rights Reserved.   
 */
package ${bussPackage}.${entityPackage}.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import ${bussPackage}.${entityPackage}.entity.${className};
import ${bussPackage}.${entityPackage}.service.${className}Service;
import com.zwsafety.platform.base.BaseController;
 
 /**
 * @ClassName:${className}Controller
 * @Description:TODO(用一句话描述该文件做什么)
 * @date:${createDate}
 * @author ${createAuthor}
 * @version 1.0
 * @since JDK 1.7
 */
@Controller
@RequestMapping("/${entityPackage}/${alllowerName}") 
public class ${className}Controller extends BaseController {
	
	/**  
    * @Fields LOG:TODO(日志).  
    */
	private static final  Logger LOG = Logger.getLogger(${className}Controller.class);	
	
	 /**  
    * @Fields ${lowerName}Service:TODO(用一句话描述这个变量表示什么).  
    */
	@Autowired
	private ${className}Service ${lowerName}Service; 
	
	  /**
     * @Title:intoMainPage
     * @Description TODO(进入首页).
     * TODO(这里描述这个方法适用条件 – 可选).
     * TODO(这里描述这个方法的执行流程 – 可选).
     * TODO(这里描述这个方法的使用方法 – 可选).
     * TODO(这里描述这个方法的注意事项 – 可选).
     * @date ${createDate}
     * @author ${createAuthor}
     * @return ModelAndView
     */
	@RequestMapping
	public ModelAndView  intoMainPage()  {
		return forword("module/${entityPackage}/${alllowerName}List");
	}
	
	
    /**  
    * @Title:loadByPage
    * @Description TODO(根据条件查询权限数据结果集). 
    * TODO(这里描述这个方法适用条件 – 可选).
    * TODO(这里描述这个方法的执行流程 – 可选).
    * TODO(这里描述这个方法的使用方法 – 可选).
    * TODO(这里描述这个方法的注意事项 – 可选).
    * @date ${createDate}
    * @author ${createAuthor}
    * @param request 请求对象
    * @return Map<String, Object> 返回数据结果集
    */
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> loadByPage(HttpServletRequest request) {
		try {
			//封装查询参数
			Map<String, Object> params = new HashMap<String, Object>();
			PageBounds pageBounds  = getPageBounds(request);
			List<Map<String, Object>> rows = ${lowerName}Service.loadByPage(params, pageBounds);
			//返回数据结果集
			Map<String,Object> results  = createBootGrid(rows, pageBounds);
			return results;
		} catch (Exception e) {
			LOG.error(e.getMessage());
			e.printStackTrace();
		}
		return null;
	}
	
	 /**  
    * @Title:display
    * @Description TODO(查看详细界面). 
    * TODO(这里描述这个方法适用条件 – 可选).
    * TODO(这里描述这个方法的执行流程 – 可选).
    * TODO(这里描述这个方法的使用方法 – 可选).
    * TODO(这里描述这个方法的注意事项 – 可选).
    * @date ${createDate}
    * @author ${createAuthor}
    * @param id
    * @param model model对象
    * @return ModelAndView
    */
	@RequestMapping(value="/display/{id}")
	public	ModelAndView display(@PathVariable String id,Model model) {
		try {
			${className} ${lowerName}=${lowerName}Service.loadById(id);
			model.addAttribute("${lowerName}", ${lowerName});
		} catch (Exception e) {
		 	LOG.error(e.getMessage());
			e.printStackTrace();
		}
		return forword("module/${entityPackage}/${alllowerName}Display");
	}
	
	/**  
    * @Title:add
    * @Description TODO(进入新增页面). 
    * TODO(这里描述这个方法适用条件 – 可选).
    * TODO(这里描述这个方法的执行流程 – 可选).
    * TODO(这里描述这个方法的使用方法 – 可选).
    * TODO(这里描述这个方法的注意事项 – 可选).
    * @date ${createDate}
    * @author ${createAuthor}
    * @return ModelAndView
    */
	@RequestMapping("/add")
	public	ModelAndView add() {
		return forword("module/${entityPackage}/${alllowerName}Add");
	}
	
	/**  
    * @Title:edit
    * @Description TODO(进入编辑界面). 
    * TODO(这里描述这个方法适用条件 – 可选).
    * TODO(这里描述这个方法的执行流程 – 可选).
    * TODO(这里描述这个方法的使用方法 – 可选).
    * TODO(这里描述这个方法的注意事项 – 可选).
    * @date ${createDate}
    * @author ${createAuthor}
    * @param id
    * @param model model对象
    * @return ModelAndView
    */
	@RequestMapping("/edit/{id}")
	public	ModelAndView edit(@PathVariable String id,Model model) {
		try {
			${className} ${lowerName}=${lowerName}Service.loadById(id);
			model.addAttribute("${lowerName}", ${lowerName});
		} catch (Exception e) {
		 	LOG.error(e.getMessage());
			e.printStackTrace();
		}
		return forword("module/${entityPackage}/${alllowerName}Add");
	}
	
	/**  
    * @Title:save
    * @Description TODO(新增或编辑). 
    * TODO(这里描述这个方法适用条件 – 可选).
    * TODO(这里描述这个方法的执行流程 – 可选).
    * TODO(这里描述这个方法的使用方法 – 可选).
    * TODO(这里描述这个方法的注意事项 – 可选).
    * @date ${createDate}
    * @author ${createAuthor}
    * @param ${lowerName}
    * @param response 响应对象
    */
	@RequestMapping(value="/save",method=RequestMethod.POST)
	public void save(@ModelAttribute ${className} ${lowerName},HttpServletResponse response) {
			if (StringUtils.isEmpty(${lowerName}.getUserid())) {
			    //新增
				try {
					${lowerName}Service.save(${lowerName});
					sendSuccessMessage(response, "保存成功");
				} catch (Exception e) {
					sendFailureMessage(response, "保存失败!");
					LOG.error(e.getMessage());
					e.printStackTrace();
				}
			} else {
				//更新
				try {
					${lowerName}Service.update(${lowerName});
					sendSuccessMessage(response, "编辑成功");
				} catch (Exception e) {
					sendFailureMessage(response, "编辑失败!");
					LOG.error(e.getMessage());
					e.printStackTrace();
				}
			}
	}
	
	/**  
    * @Title:delete
    * @Description TODO(批量删除). 
    * TODO(这里描述这个方法适用条件 – 可选).
    * TODO(这里描述这个方法的执行流程 – 可选).
    * TODO(这里描述这个方法的使用方法 – 可选).
    * TODO(这里描述这个方法的注意事项 – 可选).
    * @date ${createDate}
    * @author ${createAuthor} 
    * @param ids
    * @param response 响应对象
    */
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public void delete(String[] ids,HttpServletResponse response) {
		try {
			if(ids.length>0){
				for (String id:ids) {
					${lowerName}Service.delete(id);
				}
				sendSuccessMessage(response, "删除成功");
			}
		} catch (Exception e) {
			sendFailureMessage(response, "删除失败!");
			LOG.error(e.getMessage());
			e.printStackTrace();
		}
	}

}
