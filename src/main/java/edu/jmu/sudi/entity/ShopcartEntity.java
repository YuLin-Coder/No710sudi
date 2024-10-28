package edu.jmu.sudi.entity;

import java.io.Serializable;

/**
 * 购物车实体类
 * @author LiangJie
 */
public class ShopcartEntity extends FoodSkuEntity implements Serializable {
    private Long shopcartId;
    private Long userId;
    private Integer numCount;

    public Long getShopcartId() {
        return shopcartId;
    }

    public void setShopcartId(Long shopcartId) {
        this.shopcartId = shopcartId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Integer getNumCount() {
        return numCount;
    }

    public void setNumCount(Integer numCount) {
        this.numCount = numCount;
    }


}
