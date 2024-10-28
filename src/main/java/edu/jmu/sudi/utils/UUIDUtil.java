package edu.jmu.sudi.utils;

import java.util.UUID;

/**
 * 唯一随机编码生成工具类
 * @author LiangJie
 */
public class UUIDUtil {

    /**
     * 生成具有唯一性表示的UUID，并且将字符串格式化
     * @return
     */
    public static String randomUUID(){
        return UUID.randomUUID().toString().replace("-", "");
    }

}
