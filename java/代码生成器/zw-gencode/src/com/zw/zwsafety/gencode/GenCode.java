package com.zw.zwsafety.gencode;

import java.io.File;
import java.sql.Connection;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.zw.zwsafety.gencode.table.CreateBean;
import com.zw.zwsafety.gencode.utils.CodeGenerateFactory;


/**
 * 解析gentable.xml
 * @author tony
 *
 */
public class GenCode {
	private static final Log log = LogFactory.getLog(GenCode.class);
	/**
	 * 解析xml
	 * @param rootElt
	 * @return
	 */
	public void gencode(CreateBean createBean) {
		SAXReader sax = new SAXReader();  
		String filepath = CodeGenerateFactory.getProjectPath()+ "/config/gentable.xml";
	    Document xmlDoc;
		try {
			xmlDoc = sax.read(new File(filepath));
			Element rootElt = xmlDoc.getRootElement();
			@SuppressWarnings("unchecked")
			List<Element> tables = rootElt.elements();
			int count=0;
			for(Element el:tables){
				String tableName = el.attribute("tableName").getText();
				String codeName = el.attribute("codeName").getText();
				String entityPackage = el.attribute("entityPackage").getText();
				String keyType = el.attribute("keyType").getText();
				int i=CodeGenerateFactory.codeGenerate(createBean,tableName, codeName, entityPackage,keyType);
				if(i==1){
					count++;
				}
			}
			log.info("代码生成完成，共"+tables.size()+"张表,成功生成代码："+count+"张表,失败"+(tables.size()-count)+"表");
			createBean.getConnection().close();
			File file=new File(CodeGenerateFactory.getGencodePath());
			if(!file.exists()){
				file.mkdirs();
			}
			Runtime.getRuntime().exec("cmd.exe /c start "+CodeGenerateFactory.getGencodePath());
		} catch (Exception e) {
			e.printStackTrace();
		}  
		
	}
	
	public static void main(String[] args) {
		CreateBean createBean = new CreateBean();
		Connection connection=createBean.connectDatabase();
		if(connection!=null){
			new GenCode().gencode(createBean);
		}
	}
}
