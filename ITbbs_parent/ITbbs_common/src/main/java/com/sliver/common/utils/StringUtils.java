package com.sliver.common.utils;

import java.io.UnsupportedEncodingException;

public class StringUtils {
    public static String sqlEncode(String str){
        str.replaceAll("%",""                                                                                      );
        str.replaceAll("_","");
        return str;
    }
    public static String filterString(String str,String filter){
        String[] strings = filter.split("\\|");
        for (String s : strings){
            System.out.println(s);
            str = str.replaceAll(s, "***");
        }
        return str;
    }
    public static String convertISO2utf8(String str) throws UnsupportedEncodingException {
        return new String(str.getBytes("ISO-8859-1"),"UTF-8");
    }

    public static boolean isEmpty(String str) {
        return null == str || str.trim().length() <= 0;
    }

    public static boolean isEmpty(String... str1 ){
        for(String str : str1){
            if(isEmpty(str)){
                return true;
            }
        }
        return false;
    }

    public static void main(String[] args) {
        System.out.println(filterString("sb","流氓|擦|我日|sb"));
    }
}
