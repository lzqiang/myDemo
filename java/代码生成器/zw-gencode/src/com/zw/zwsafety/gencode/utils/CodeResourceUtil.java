package com.zw.zwsafety.gencode.utils;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.PropertyResourceBundle;
import java.util.ResourceBundle;


/**
 * 加载配置文件
 * @date 2014-6-11
 * @author tony
 *
 */
public class CodeResourceUtil {
	private static ResourceBundle bundle = null;
	private static ResourceBundle bundlePath = null;
	static{
		/**
		 * 加载配置文件
		 */
		 try{
			InputStream bundleIn = new BufferedInputStream(new FileInputStream(
					CodeGenerateFactory.getProjectPath()
							+ "/config/database.properties"));
			bundle = new PropertyResourceBundle(bundleIn);
			InputStream bundlePathIn = new BufferedInputStream(
					new FileInputStream(CodeGenerateFactory.getProjectPath()
							+ "/config/config.properties"));
			bundlePath = new PropertyResourceBundle(bundlePathIn);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 获取数据库驱动
	 * @return
	 */
	public static final String getDIVER_NAME() {
		return bundle.getString("diver_name");
	}

	/**
	 * 获得数据库连接URL
	 * @return
	 */
	public static final String getURL() {
		return bundle.getString("url");
	}

	/**
	 * 获得数据库连接用户名
	 * @return
	 */
	public static final String getUSERNAME() {
		return bundle.getString("username");
	}


	/**
	 * 获得数据库连接密码
	 * @return
	 */
	public static final String getPASSWORD() {
		return bundle.getString("password");
	}


	/**
	 * 获得数据库名称
	 * @return
	 */
	public static final String getDATABASE_NAME() {
		return bundle.getString("database_name");
	}


	/**
	 * 获得数据库类型
	 * @return
	 */
	public static final String getDataBaseType() {
		return bundle.getString("database_type");
	}

	/**
	 * 获得业务包
	 * 如com.zw.zwsafety
	 * @return
	 */
	public static String getBussiPackage() {
		return bundlePath.getString("bussi_package");
	}
	
	/**
	 * 获得业务包路径
	 * 如com/zw/zwsafety
	 * @return
	 */
	public static String getBussiPackageURL() {
		return getBussiPackage().replace(".", "/");
	}


	/**
	 * 获得java代码根目录
	 * 如src
	 * @return
	 */
	public static final String getSourceRootPackage() {
		return bundlePath.getString("source_root_package").replace(".", "/");
	}

	/**
	 * 获得生成代码输出目录
	 * @return
	 */
	public static final String getGencodePath() {
		return bundlePath.getString("gencode_path");
	}

	/**
	 * 获得web目录
	 * @return
	 */
	public static final String getWebRootPackage() {
		return bundlePath.getString("webroot_package").replace(".", "/");
	}
	
	/**
	 * 获得代码编写作者
	 * @return
	 */
	public static final String getAuthor() {
		return bundlePath.getString("code_author");
	}
	
}