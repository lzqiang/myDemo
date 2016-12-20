package cn.itcast.bookstore.utils;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

import javax.sql.DataSource;

import org.apache.commons.dbcp.BasicDataSourceFactory;


public class JdbcUtil_dbcp {
	private static DataSource ds;
	static{
		try{
			InputStream in=
					JdbcUtil_dbcp.class.getClassLoader().getResourceAsStream("dbcpconfig.properties");
			Properties prop=new Properties();
			prop.load(in);
			BasicDataSourceFactory factory=new BasicDataSourceFactory();
			ds=factory.createDataSource(prop);
		}catch(Exception e){
			throw new ExceptionInInitializerError(e);
		}
	}
	public static Connection getConnection(){
		try {
			return ds.getConnection();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	public static DataSource getDataSource(){
		return ds;
	}
}
