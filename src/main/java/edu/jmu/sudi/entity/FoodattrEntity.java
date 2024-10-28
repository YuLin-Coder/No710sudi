package edu.jmu.sudi.entity;

import java.io.Serializable;

/**
 * 菜品规格组实体类
 * @author LiangJie
 */
public class FoodattrEntity implements Serializable {

    private Long foodattrId;
    private String foodattrName;

    public Long getFoodattrId() {
        return foodattrId;
    }

    public void setFoodattrId(Long foodattrId) {
        this.foodattrId = foodattrId;
    }

    public String getFoodattrName() {
        return foodattrName;
    }

    public void setFoodattrName(String foodattrName) {
        this.foodattrName = foodattrName;
    }
}
