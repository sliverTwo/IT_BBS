package com.sliver.common.utils;

public class NullUtils {
    public static  boolean isNull(Object ...objects){
        for (Object obj : objects){
            if(null == obj){
                return true;
            }
        }
        return false;
    }
}
