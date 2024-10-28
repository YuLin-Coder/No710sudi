package edu.jmu.sudi.entity;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 菜品SKU实体类
 * @author LiangJie
 */
public class FoodSkuEntity extends FoodEntity implements Serializable {

    private Long skuId;
    private String skuName;
    private BigDecimal skuPrice;
    private Integer skuSale;
    private Integer skuStock;

    public Long getSkuId() {
        return skuId;
    }

    public void setSkuId(Long skuId) {
        this.skuId = skuId;
    }

    public String getSkuName() {
        return skuName;
    }

    public void setSkuName(String skuName) {
        this.skuName = skuName;
    }

    public BigDecimal getSkuPrice() {
        return skuPrice;
    }

    public void setSkuPrice(BigDecimal skuPrice) {
        this.skuPrice = skuPrice;
    }

    public Integer getSkuSale() {
        return skuSale;
    }

    public void setSkuSale(Integer skuSale) {
        this.skuSale = skuSale;
    }

    public Integer getSkuStock() {
        return skuStock;
    }

    public void setSkuStock(Integer skuStock) {
        this.skuStock = skuStock;
    }
}
