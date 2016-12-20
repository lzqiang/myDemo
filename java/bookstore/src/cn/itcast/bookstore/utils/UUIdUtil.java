package cn.itcast.bookstore.utils;

import java.util.UUID;

public class UUIdUtil {
	public static String getIdgener(){
		return UUID.randomUUID().toString();
	}
}
