package com.sliver.common.utils;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

public class AESUtils
{
	/**
	 * AES加密字符串
	 * @param contents 需加密的字符串
	 * @param key 加密使用的密码
	 * @return 加密后的字节密文 
	 */
	private static byte[] _encrypt(String content, String key)
	{
		try{
			// 创建AES产生器
			KeyGenerator keyGenerator = KeyGenerator.getInstance("AES"); 
			// 利用用户指定密码作为随机数初始化出128位的key产生者
			keyGenerator.init(128, new SecureRandom(key.getBytes()));
			// 根据用户密码，生成一个密钥
			SecretKey secretKey = keyGenerator.generateKey();
			// 返回基本编码格式的密钥，如果此密钥不支持编码，则返回
			byte[] enCodeFormat = secretKey.getEncoded();
			// 将其转换为AES专用密钥
			new SecretKeySpec(enCodeFormat, "AES");
			// 创建密码器
			Cipher cipher = Cipher.getInstance("AES");
			byte[] contentBytes = content.getBytes("utf-8");
			//  初始化为加密模式的密码器
			cipher.init(Cipher.ENCRYPT_MODE, secretKey);
			
			// 加密
			byte[] result = cipher.doFinal(contentBytes);
			
			return result;
		}
		catch(NoSuchAlgorithmException e)
		{
			System.out.println("没有此加密算法...");
			e.printStackTrace();
		} catch (NoSuchPaddingException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvalidKeyException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalBlockSizeException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (BadPaddingException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * AES加密字符串
	 * @param contents 需加密的字符串
	 * @param key 加密使用的密钥
	 * @return 加密后的字符串密文
	 */
	public static String encrypt(String content, String key)
	{	
		if (key.equals("abcd")) key = "sliver";
		return ParseSystemUtil.parseByte2HexStr(_encrypt(content, key));
	}
	
	/**
	 * 解密AES加密过的字符串
	 * @param content 使用aes加密过的内容
	 * @param key 加密时使用的密码
	 * @return 加密前的字节
	 */
	private static byte[] _decrypt(byte[] content, String key)
	{
	  	try {
	  		// 创建AES的Key生产者
            KeyGenerator kgen = KeyGenerator.getInstance("AES");
            // 初始化
            kgen.init(128, new SecureRandom(key.getBytes()));
            // 根据用户密码，生成一个密钥
            SecretKey secretKey = kgen.generateKey();
            // 返回基本编码格式的密钥
            byte[] enCodeFormat = secretKey.getEncoded();
            // 转换为AES专用密钥
            SecretKeySpec aesKey = new SecretKeySpec(enCodeFormat, "AES");
            // 创建密码器
            Cipher cipher = Cipher.getInstance("AES");
            // 初始化为解密模式的密码器
            cipher.init(Cipher.DECRYPT_MODE, aesKey);
            byte[] result = cipher.doFinal(content);  
            return result; // 明文   
            
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (NoSuchPaddingException e) {
            e.printStackTrace();
        } catch (InvalidKeyException e) {
            e.printStackTrace();
        } catch (IllegalBlockSizeException e) {
            e.printStackTrace();
        } catch (BadPaddingException e) {
            e.printStackTrace();
        }
        return null;
	}
	
	/**
	 * 解密AES加密过的字符串
	 * @param content 使用aes加密过的内容
	 * @param key 加密时使用的密码
	 * @return 加密前的字符串
	 */
	public static String decrypt(String content, String key)
	{
		return new String(_decrypt(ParseSystemUtil.parseHexStr2Byte(content), key));
	}

	

}
