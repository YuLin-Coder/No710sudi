package edu.jmu.sudi.utils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

/**
 * 专门用于快速生成各种编号
 */
public class CreateCodeUtil {

    static Random random = new Random();

    /**
     * 生成配送员唯一Id
     * @return  入职的时间到毫秒+两个随机数
     */
    public static String createDeliverId(){
        //获取当前时间
        Date date = new Date();
        String timeStr = new SimpleDateFormat("yyyyMMddHHmmss").format(date);
        String endNum = random.nextInt(9) + "" + random.nextInt(9);
        return timeStr + "" + endNum;
    }

    /**
     * 生成唯一的订单编号 (D+时间戳+5位随机数)
     * @return
     */
    public static String createOrderId(){
        Date date = new Date();
        String timeStr = new SimpleDateFormat("yyyyMMddHHmmss").format(date);
        String endNum = (int)(random.nextDouble()*(99999-10000 + 1)) + 10000 + "";
        return "D" + timeStr + endNum;
    }

}
