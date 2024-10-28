package edu.jmu.sudi.utils;

import java.util.ArrayList;
import java.util.List;

/**
 * @author LiangJie
 */
public class FoodSkuUtil {

    /**
     * 遍历二维数组，拼接SKU名称
     * @param foodattrArr
     * @return
     */
    public static List<StringBuilder> buildSku(String[][] foodattrArr, String foodName, List<StringBuilder> skuNameList) {
        for (String[] strings : foodattrArr) {
            for (String str : strings) {
                StringBuilder sb = new StringBuilder();
                sb.append(foodName + "(" + str + ")");
                skuNameList.add(sb);
            }
        }
        return skuNameList;
    }

//        if (rowIndex < foodattrArr.length-1){
//            for (int j = colIndex; j < foodattrArr[rowIndex].length; j++) {
//                StringBuilder sb = new StringBuilder();
//                sb.append(foodName + "(");
//                for (int i = rowIndex; i < foodattrArr.length; i++) {
//                    if (j == foodattrArr.length - 1) {
//                        sb.append(foodattrArr[i][j]);
//                    } else {
//                        sb.append(foodattrArr[i][j] + "+");
//                    }
//                }
//                sb.append(")");
//                skuNameList.add(sb);
//            }
//            //递归,并且合递归回来的List
//            skuNameList.addAll(buildSku(foodattrArr, rowIndex + 1, colIndex + 1, foodName, skuNameList));
//        }else {
//
//        }








}
