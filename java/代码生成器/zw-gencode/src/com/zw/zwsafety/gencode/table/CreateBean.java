package com.zw.zwsafety.gencode.table;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.lf5.util.ResourceUtils;

import com.zw.zwsafety.gencode.utils.CodeResourceUtil;


/**
 * 与数据库相关操作，连接数据库、生成bean、生成sql语句等
 * @author tony
 *
 */
public class CreateBean {
	private Connection connection = null;
	private String SQLTables = "show tables";
	private String method;
	private String argv;
	static String selectStr;
	static String from;

	static {
		try {
			Class.forName(CodeResourceUtil.getDIVER_NAME());
		} catch (Exception e) {
			e.printStackTrace();
		}

		selectStr = "select ";
		from = " from ";
	}

	public void setConnection(Connection connection) {
		this.connection = connection;
	}

	public Connection getConnection() throws SQLException {
		return connection;
	}
	
	/**
	 * 连接数据库
	 * @return
	 */
	public Connection connectDatabase(){
		if(connection==null){
			try {
				connection= DriverManager.getConnection(CodeResourceUtil.getURL(), CodeResourceUtil.getUSERNAME(), CodeResourceUtil.getPASSWORD());
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return connection;
	}
	
	
	/**
	 * 获得所有的表
	 * @return
	 * @throws SQLException
	 */
	public List<String> getTables() throws SQLException {
		PreparedStatement ps = connection.prepareStatement(this.SQLTables);
		ResultSet rs = ps.executeQuery();
		List<String> list = new ArrayList<String>();
		while (rs.next()) {
			String tableName = rs.getString(1);
			list.add(tableName);
		}
		rs.close();
		ps.close();
		return list;
	}

	/**
	 * 获得所有列
	 * @param tableName
	 * @return
	 * @throws SQLException
	 */
	public List<ColumnData> getColumnDatas(String tableName)
			throws SQLException {
		String databaseType=CodeResourceUtil.getDataBaseType();
		String SQLColumns=null;
		if("oracle".equals(databaseType)){
		   
			SQLColumns = "select USER_TAB_COLS.COLUMN_NAME as column_name ,"
					+ "USER_TAB_COLS.DATA_TYPE as data_type,"
					+ "user_col_comments.comments as column_comment,0,0,USER_TAB_COLS.CHAR_LENGTH as character_maximum_length,"
					+ "USER_TAB_COLS.NULLABLE as nullable from   SYS.USER_TAB_COLS  "
					+ "left join sys.user_col_comments on user_col_comments.TABLE_NAME = USER_TAB_COLS.TABLE_NAME  and user_col_comments.COLUMN_NAME = USER_TAB_COLS.COLUMN_NAME"
					+ " where USER_TAB_COLS.TABLE_NAME =  upper('"
					+ tableName
					+ "') ";
		}else if("mysql".equals(databaseType)){
			SQLColumns = "select column_name ,data_type,column_comment,0,0,character_maximum_length,is_nullable nullable from information_schema.columns where table_name =  '"
					+ tableName
					+ "' "
					+ "and table_schema =  '"
					+ CodeResourceUtil.getDATABASE_NAME() + "'";
		}
		

		PreparedStatement ps = connection.prepareStatement(SQLColumns);
		List<ColumnData> columnList = new ArrayList<ColumnData>();
		ResultSet rs = ps.executeQuery();
		StringBuffer str = new StringBuffer();
		StringBuffer getset = new StringBuffer();
		while (rs.next()) {
			String name = rs.getString(1).toLowerCase();
			String type = rs.getString(2);
			String comment = rs.getString(3);
			String precision = rs.getString(4);
			String scale = rs.getString(5);
			String charmaxLength = rs.getString(6) == null ? "" : rs
					.getString(6);
			String nullable = TableConvert.getNullAble(rs.getString(7));
			type = getType(type, precision, scale);

			ColumnData cd = new ColumnData();
			cd.setColumnName(name);
			cd.setDataType(type);
			//日期特殊处理
			if("datetime".equals(rs.getString(2))){
				cd.setColumnType("TIMESTAMP");
			}else{
				cd.setColumnType(rs.getString(2).toUpperCase());
			}
			cd.setColumnType(rs.getString(2).toUpperCase());
			cd.setColumnComment(comment);
			cd.setPrecision(precision);
			cd.setScale(scale);
			cd.setCharmaxLength(charmaxLength);
			cd.setNullable(nullable);
			formatFieldClassType(cd);
			columnList.add(cd);
		}
		this.argv = str.toString();
		this.method = getset.toString();
		rs.close();
		ps.close();
		return columnList;
	}

	/**
	 * 生成bean属性
	 * @param tableName
	 * @return
	 * @throws SQLException
	 */
	public String getBeanFeilds(String tableName) throws SQLException {
		List<ColumnData> dataList = getColumnDatas(tableName);
		StringBuffer str = new StringBuffer();
		StringBuffer getset = new StringBuffer();
		for (ColumnData d : dataList) {
			String name = d.getColumnName();
			String type = d.getDataType();
			String comment = d.getColumnComment();

			String maxChar = name.substring(0, 1).toUpperCase();
			str.append("/**").append("\r\t").append("* ").append("@Fields ")
			   .append(name).append(":TODO(").append(comment).append(").").append("\r\t").append("*/"); //注释
			str.append("\r\t").append("private ").append(type + " ").append(name).append(";").append("\r\t").append("\r\t"); //属性
			
			String method = maxChar + name.substring(1, name.length());
			
			getset.append("\r\t").append("/**").append("\r\t").append("* ").append("@return the ")
			      .append(name).append("\r\t").append("*/");//get方法注释
			getset.append("\r\t").append("public ").append(type + " ").append("get" + method + "() {\r\t");
			getset.append("    return this.").append(name).append(";\r\t}").append("\r\t");//get方法
			
			getset.append("\r\t").append("/**").append("\r\t").append("* ").append("@param ")
			      .append(name).append(" the ").append(name).append(" to set")
                  .append("\r\t").append("*/");//set方法注释
			getset.append("\r\t").append("public void ").append("set" + method + "(" + type + " " + name
							+ ") {\r\t");
			getset.append("    this." + name + " = ").append(name).append(";\r\t}").append("\r\t");
		}
		this.argv = str.toString();
		this.method = getset.toString();
		return this.argv + this.method;
	}

	private void formatFieldClassType(ColumnData columnt) {
		String fieldType = columnt.getColumnType();
		String scale = columnt.getScale();

		if ("N".equals(columnt.getNullable())) {
			columnt.setOptionType("required:true");
		}
		if (("datetime".equals(fieldType)) || ("time".equals(fieldType))) {
			columnt.setClassType("easyui-datetimebox");
		} else if ("date".equals(fieldType)) {
			columnt.setClassType("easyui-datebox");
		} else if ("int".equals(fieldType)) {
			columnt.setClassType("easyui-numberbox");
		} else if ("number".equals(fieldType)) {
			if ((StringUtils.isNotBlank(scale))
					&& (Integer.parseInt(scale) > 0)) {
				columnt.setClassType("easyui-numberbox");
				if (StringUtils.isNotBlank(columnt.getOptionType()))
					columnt.setOptionType(columnt.getOptionType() + ","
							+ "precision:2,groupSeparator:','");
				else
					columnt.setOptionType("precision:2,groupSeparator:','");
			} else {
				columnt.setClassType("easyui-numberbox");
			}
		} else if (("float".equals(fieldType)) || ("double".equals(fieldType))
				|| ("decimal".equals(fieldType))) {
			columnt.setClassType("easyui-numberbox");
			if (StringUtils.isNotBlank(columnt.getOptionType()))
				columnt.setOptionType(columnt.getOptionType() + ","
						+ "precision:2,groupSeparator:','");
			else
				columnt.setOptionType("precision:2,groupSeparator:','");
		} else {
			columnt.setClassType("easyui-validatebox");
		}
	}

	/**
	 * 获得类型
	 * @param dataType
	 * @param precision
	 * @param scale
	 * @return
	 */
	public String getType(String dataType, String precision, String scale) {
		dataType = dataType.toLowerCase();
		if (dataType.contains("char"))
			dataType = "String";
		else if (dataType.contains("int"))
			dataType = "Integer";
		else if (dataType.contains("float"))
			dataType = "Float";
		else if (dataType.contains("double"))
			dataType = "Double";
		else if (dataType.contains("number")) {
			if ((StringUtils.isNotBlank(scale))
					&& (Integer.parseInt(scale) > 0))
				dataType = "BigDecimal";
			else if ((StringUtils.isNotBlank(precision))
					&& (Integer.parseInt(precision) > 6))
				dataType = "Long";
			else
				dataType = "Integer";
		} else if (dataType.contains("decimal"))
			dataType = "BigDecimal";
		else if (dataType.contains("date"))
			dataType = "Date";
		else if (dataType.contains("time"))
			dataType = "Timestamp";
		else if (dataType.contains("clob"))
			dataType = "Clob";
		else {
			dataType = "Object";
		}
		return dataType;
	}

	public void getPackage(int type, String createPath, String content,
			String packageName, String className, String extendsClassName,
			String[] importName) throws Exception {
		if (packageName == null) {
			packageName = "";
		}
		StringBuffer sb = new StringBuffer();
		sb.append("package ").append(packageName).append(";\r");
		sb.append("\r");
		for (int i = 0; i < importName.length; i++) {
			sb.append("import ").append(importName[i]).append(";\r");
		}
		sb.append("\r");
		sb.append("/**\r *  entity. @author wolf Date:"
				+ new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
						.format(new Date()) + "\r */");
		sb.append("\r");
		sb.append("\rpublic class ").append(className);
		if (extendsClassName != null) {
			sb.append(" extends ").append(extendsClassName);
		}
		if (type == 1)
			sb.append(" ").append("implements java.io.Serializable {\r");
		else {
			sb.append(" {\r");
		}
		sb.append("\r\t");
		sb.append("private static final long serialVersionUID = 1L;\r\t");
		String temp = className.substring(0, 1).toLowerCase();
		temp = temp + className.substring(1, className.length());
		if (type == 1) {
			sb.append("private " + className + " " + temp + "; // entity ");
		}
		sb.append(content);
		sb.append("\r}");
		System.out.println(sb.toString());
		createFile(createPath, "", sb.toString());
	}

	public String getTablesNameToClassName(String tableName) {
		String[] split = tableName.split("_");
		if (split.length > 1) {
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < split.length; i++) {
				String tempTableName = split[i].substring(0, 1).toUpperCase()
						+ split[i].substring(1, split[i].length());
				sb.append(tempTableName);
			}

			return sb.toString();
		}
		String tempTables = split[0].substring(0, 1).toUpperCase()
				+ split[0].substring(1, split[0].length());
		return tempTables;
	}

	public void createFile(String path, String fileName, String str)
			throws IOException {
		FileWriter writer = new FileWriter(new File(path + fileName));
		writer.write(new String(str.getBytes("utf-8")));
		writer.flush();
		writer.close();
	}

	/**
	 * 生成sql语句-新增
	 * @param tableName
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getAutoCreateSql(String tableName)
			throws Exception {
		Map<String, Object> sqlMap = new HashMap<String, Object>();
		List<ColumnData> columnDatas = getColumnDatas(tableName);
		String columns = getColumnSplit(columnDatas);
		String[] columnList = getColumnList(columns);
		String columnFields = getColumnFields(columns);
		String insert = "insert into " + tableName + "("
				+ columns.replaceAll("\\|", ",") + ")\n values(#{"
				+ columns.replaceAll("\\|", "},#{") + "})";
		String update = getUpdateSql(tableName, columnList);
		String updateSelective = getUpdateSelectiveSql(tableName, columnDatas);
		String selectById = getSelectByIdSql(tableName, columnList);
		String delete = getDeleteSql(tableName, columnList);
		sqlMap.put("columnList", columnList);
		sqlMap.put("columnFields", columnFields);
		sqlMap.put(
				"insert",
				insert.replace("#{createTime}", "now()").replace(
						"#{updateTime}", "now()"));
		sqlMap.put(
				"update",
				update.replace("#{createTime}", "now()").replace(
						"#{updateTime}", "now()"));
		sqlMap.put("delete", delete);
		sqlMap.put("updateSelective", updateSelective);
		sqlMap.put("selectById", selectById);
		return sqlMap;
	}

	/**
	 * 生成sql语句-删除
	 * @param tableName
	 * @param columnsList
	 * @return
	 * @throws SQLException
	 */
	public String getDeleteSql(String tableName, String[] columnsList)
			throws SQLException {
		StringBuffer sb = new StringBuffer();
		sb.append("delete ");
		sb.append("\t from ").append(tableName).append(" where ");
		sb.append(columnsList[0]).append(" = #{").append(columnsList[0])
				.append("}");
		return sb.toString();
	}

	/**
	 * 生成sql语句-根据id查询
	 * @param tableName
	 * @param columnsList
	 * @return
	 * @throws SQLException
	 */
	public String getSelectByIdSql(String tableName, String[] columnsList)
			throws SQLException {
		StringBuffer sb = new StringBuffer();
		sb.append("select <include refid=\"Base_Column_List\" /> \n");
		sb.append("\t from ").append(tableName).append(" where ");
		sb.append(columnsList[0]).append(" = #{").append(columnsList[0])
				.append("}");
		return sb.toString();
	}

	public String getColumnFields(String columns) throws SQLException {
		String fields = columns;
		if ((fields != null) && (!"".equals(fields))) {
			fields = fields.replaceAll("[|]", ",");
		}
		return fields;
	}

	public String[] getColumnList(String columns) throws SQLException {
		String[] columnList = columns.split("[|]");
		return columnList;
	}

	public String getUpdateSql(String tableName, String[] columnsList)
			throws SQLException {
		StringBuffer sb = new StringBuffer();

		for (int i = 1; i < columnsList.length; i++) {
			String column = columnsList[i];
			if ("CREATETIME".equals(column.toUpperCase())) {
				continue;
			}
			if ("UPDATETIME".equals(column.toUpperCase()))
				sb.append(column + "=now()");
			else {
				sb.append(column + "=#{" + column + "}");
			}
			if (i + 1 < columnsList.length) {
				sb.append(",");
			}
		}
		String update = "update " + tableName + " set " + sb.toString()
				+ " where " + columnsList[0] + "=#{" + columnsList[0] + "}";
		return update;
	}

	public String getUpdateSelectiveSql(String tableName,
			List<ColumnData> columnList) throws SQLException {
		StringBuffer sb = new StringBuffer();
		ColumnData cd = (ColumnData) columnList.get(0);
		sb.append("\t<trim  suffixOverrides=\",\" >\n");
		for (int i = 1; i < columnList.size(); i++) {
			ColumnData data = (ColumnData) columnList.get(i);
			String columnName = data.getColumnName();
			sb.append("\t<if test=\"").append(columnName).append(" != null ");

			if ("String" == data.getDataType()) {
				sb.append(" and ").append(columnName).append(" != ''");
			}
			sb.append(" \">\n\t\t");
			sb.append(columnName + "=#{" + columnName + "},\n");
			sb.append("\t</if>\n");
		}
		sb.append("\t</trim>");
		String update = "update " + tableName + " set \n" + sb.toString()
				+ " where " + cd.getColumnName() + "=#{" + cd.getColumnName()
				+ "}";
		return update;
	}

	public String getColumnSplit(List<ColumnData> columnList)
			throws SQLException {
		StringBuffer commonColumns = new StringBuffer();
		for (ColumnData data : columnList) {
			commonColumns.append(data.getColumnName() + "|");
		}
		return commonColumns.delete(commonColumns.length() - 1,
				commonColumns.length()).toString();
	}
}
