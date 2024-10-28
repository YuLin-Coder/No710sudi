package edu.jmu.sudi.entity;

import java.io.Serializable;

/**
 * 菜品规格实体类
 * @author LiangJie
 */
public class FoodvalueEntity extends FoodattrEntity implements Serializable {

    private Long foodvalueId;
    private String foodvalueName;
    private Long foodId;

    public Long getFoodvalueId() {
        return foodvalueId;
    }

    public void setFoodvalueId(Long foodvalueId) {
        this.foodvalueId = foodvalueId;
    }

    public String getFoodvalueName() {
        return foodvalueName;
    }

    public void setFoodvalueName(String foodvalueName) {
        this.foodvalueName = foodvalueName;
    }

    public Long getFoodId() {
        return foodId;
    }

    public void setFoodId(Long foodId) {
        this.foodId = foodId;
    }
}
