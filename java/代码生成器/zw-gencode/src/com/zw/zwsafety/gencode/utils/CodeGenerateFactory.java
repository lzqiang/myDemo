package com.zw.zwsafety.gencode.utils;

import java.util.Date;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.velocity.VelocityContext;

import com.zw.zwsafety.gencode.page.CommonPageParser;
import com.zw.zwsafety.gencode.table.CreateBean;


public class CodeGenerateFactory {
	private static final Log log = LogFactory.getLog(CodeGenerateFactory.class);

	/**
	 * 
	 * @param createBean
	 * @param tableName
	 * @param codeName
	 * @param entityPackage
	 * @param keyType
	 * @return 0代码生成失败 1代码生成成功
	 */
	public static Integer codeGenerate(CreateBean createBean ,String tableName, String codeName,
			String entityPackage, String keyType) {

		String className = createBean.getTablesNameToClassName(tableName);
		String lowerName = className.substring(0, 1).toLowerCase()
				+ className.substring(1, className.length());
		String alllowerName = className.toLowerCase();


		String srcPath = getGencodePath()
				+ CodeResourceUtil.getSourceRootPackage() + "\\";

		String pckPath = srcPath + CodeResourceUtil.getBussiPackageURL() + "\\";
		
		String beanPath = entityPackage + "\\entity\\" + className+ ".java";
		
		String sqlMapperPath = entityPackage + "\\mapper\\" + className+"Mapper.xml";

		String mapperPath = entityPackage+"\\dao\\" + className+ "Mapper.java";
		
		String servicePath = entityPackage+"\\service\\"+ className+ "Service.java";
		
		String serviceImplPath = entityPackage+"\\service\\impl\\"+ className+ "ServiceImpl.java";
		
		String controllerPath = entityPackage+"\\controller\\"+ className + "Controller.java";
		
		String webPath = getGencodePath() + CodeResourceUtil.getWebRootPackage()
				+ "\\view\\" + CodeResourceUtil.getBussiPackageURL() + "\\";
		
		webPath = webPath + entityPackage + "\\";

		String jspPath = lowerName + ".jsp";
		String jsPath = "page-" + lowerName + ".js";

		VelocityContext context = new VelocityContext();
		context.put("className", className);
		context.put("lowerName", lowerName);
		context.put("alllowerName", alllowerName);
		context.put("codeName", codeName);
		context.put("tableName", tableName);
		context.put("bussPackage", CodeResourceUtil.getBussiPackage());
		context.put("entityPackage", entityPackage);
		context.put("keyType", keyType);
		context.put("createDate",DateUtil.formatDate(new Date(),DateUtil.ChinaFormat));
		context.put("createYear",DateUtil.getCurrentYear());
		context.put("createAuthor",CodeResourceUtil.getAuthor());
		
		try {
			context.put("feilds", createBean.getBeanFeilds(tableName));
		} catch (Exception e) {
			e.printStackTrace();
		}

		try {
			Map<String, Object> sqlMap = createBean.getAutoCreateSql(tableName);
			context.put("columnDatas", createBean.getColumnDatas(tableName));
			context.put("SQL", sqlMap);
		} catch (Exception e) {
			log.error("-----------------------" + codeName + "：" + tableName
					+ "生成失败,请检查表是否存在!-------------------------");
			return 0;
		}

		CommonPageParser.WriterPage(context, "EntityTemplate.ftl", pckPath,beanPath);
		CommonPageParser.WriterPage(context, "MapperTemplate.xml", pckPath,sqlMapperPath);
		CommonPageParser.WriterPage(context, "DaoTemplate.ftl", pckPath,mapperPath);
		CommonPageParser.WriterPage(context, "ServiceTemplate.ftl", pckPath,servicePath);
		CommonPageParser.WriterPage(context, "ServiceImplTemplate.ftl", pckPath,serviceImplPath);
		CommonPageParser.WriterPage(context, "ControllerTemplate.ftl", pckPath,controllerPath);
		
		

		CommonPageParser.WriterPage(context, "jspTemplate.ftl", webPath,
				jspPath);
		CommonPageParser.WriterPage(context, "jsTemplate.ftl", webPath, jsPath);

		return 1;
	}
	
	/**
	 * 获得代码生成输出路径
	 * @return
	 */
	public static String getGencodePath() {
		String path = CodeResourceUtil.getGencodePath() + "/";
		return path;
	}

	/**
	 * 获得工程路径
	 * @return
	 */
	public static String getProjectPath() {
		String path = System.getProperty("user.dir").replace("\\", "/") + "/";
		return path;
	}

}