package com.xiaofei.shop.util;

import java.util.UUID;

/**
 * Author: madlax
 * Date: 9/9/2021, 7:17 PM
 * Description:
 */
public class StringUtils {
    public static String renameFileName(String fileName){
        int dotIndex = fileName.lastIndexOf(".");
        String suffix = fileName.substring(dotIndex);
        return UUID.randomUUID().toString()+suffix;
    }
}
