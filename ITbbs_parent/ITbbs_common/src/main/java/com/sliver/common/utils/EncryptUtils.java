package com.sliver.common.utils;

public class EncryptUtils
{
	private static final String AESKey = "sliverTwodowithabc";
	public static String encryptFiled(String filed)
	{
		return AESUtils.encrypt(filed, AESKey);
	}
	public static String decryptFiled(String encryptFiled){
		return AESUtils.decrypt(encryptFiled, AESKey);
	}
	public static String encryptPassword(String password,String key)
	{
		return MD5Utils.string2MD5(AESUtils.encrypt(password, key),2);
	}
}
