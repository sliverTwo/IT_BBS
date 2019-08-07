package com.sliver.common.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtils {
    /**
     * 计算两个日期之间相差的天数
     * @param maxDate 较小的时间
     * @param minDate  较大的时间
     * @return 相差天数
     * @throws ParseException
     */
    public static int daysBetween(Date maxDate, Date minDate) throws ParseException
    {
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
        maxDate=sdf.parse(sdf.format(maxDate));
        minDate=sdf.parse(sdf.format(minDate));
        Calendar cal = Calendar.getInstance();
        cal.setTime(maxDate);
        long time1 = cal.getTimeInMillis();
        cal.setTime(minDate);
        long time2 = cal.getTimeInMillis();
        long between_days=(time1-time2)/(1000*3600*24);

        return Integer.parseInt(String.valueOf(between_days));
    }

    /**
     *字符串的日期格式的计算
     */
    public static int daysBetween(String maxDate,String minDate) throws ParseException{
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
        Calendar cal = Calendar.getInstance();
        cal.setTime(sdf.parse(maxDate));
        long time1 = cal.getTimeInMillis();
        cal.setTime(sdf.parse(minDate));
        long time2 = cal.getTimeInMillis();
        long between_days=(time1-time2)/(1000*3600*24);

        return Integer.parseInt(String.valueOf(between_days));
    }

}
