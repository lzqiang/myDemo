package cn.itcast.bookstore.utils;

public class DaoFactory {
	//单利设计
	private DaoFactory(){};
	private static final DaoFactory instance=new DaoFactory();
	public static DaoFactory getInstance(){
		return instance;
	}
	
	public <T> T createDao(String className,Class<T> clazz){
		T t=null;
		try {
			t=(T) clazz.forName(className).newInstance();
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return t;
	}
}
