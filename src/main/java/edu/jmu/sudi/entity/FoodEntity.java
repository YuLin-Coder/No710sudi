package edu.jmu.sudi.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 菜品SPU实体类
 * @author LiangJie
 */
public class FoodEntity extends FoodTypeEntity implements Serializable {

    private Long foodId;
    private String foodName;
    private String foodIngredient;
    private String foodVegon;
    private String foodCookWay;
    private Integer foodFaultCount;
    private String foodDesc;
    private String foodImage;
    private Integer foodSaleCount;
    private Integer foodViewCount;
    private BigDecimal foodScore;
    private Integer commentCount;
    private Integer recommend;
    private Integer hotSale;
    private Integer foodStatus;
    private String lastModifyBy;
    private Date lastModifyTime;
    private Integer dayStock;

    public Long getFoodId() {
        return foodId;
    }

    public void setFoodId(Long foodId) {
        this.foodId = foodId;
    }

    public String getFoodName() {
        return foodName;
    }

    public void setFoodName(String foodName) {
        this.foodName = foodName;
    }

    public String getFoodIngredient() {
        return foodIngredient;
    }

    public void setFoodIngredient(String foodIngredient) {
        this.foodIngredient = foodIngredient;
    }

    public String getFoodVegon() {
        return foodVegon;
    }

    public void setFoodVegon(String foodVegon) {
        this.foodVegon = foodVegon;
    }

    public String getFoodCookWay() {
        return foodCookWay;
    }

    public void setFoodCookWay(String foodCookWay) {
        this.foodCookWay = foodCookWay;
    }

    public Integer getFoodFaultCount() {
        return foodFaultCount;
    }

    public void setFoodFaultCount(Integer foodFaultCount) {
        this.foodFaultCount = foodFaultCount;
    }

    public String getFoodDesc() {
        return foodDesc;
    }

    public void setFoodDesc(String foodDesc) {
        this.foodDesc = foodDesc;
    }

    public String getFoodImage() {
        return foodImage;
    }

    public void setFoodImage(String foodImage) {
        this.foodImage = foodImage;
    }

    public Integer getFoodSaleCount() {
        return foodSaleCount;
    }

    public void setFoodSaleCount(Integer foodSaleCount) {
        this.foodSaleCount = foodSaleCount;
    }

    public Integer getFoodViewCount() {
        return foodViewCount;
    }

    public void setFoodViewCount(Integer foodViewCount) {
        this.foodViewCount = foodViewCount;
    }

    public BigDecimal getFoodScore() {
        return foodScore;
    }

    public void setFoodScore(BigDecimal foodScore) {
        this.foodScore = foodScore;
    }

    public Integer getCommentCount() {
        return commentCount;
    }

    public void setCommentCount(Integer commentCount) {
        this.commentCount = commentCount;
    }

    public Integer getRecommend() {
        return recommend;
    }

    public void setRecommend(Integer recommend) {
        this.recommend = recommend;
    }

    public Integer getHotSale() {
        return hotSale;
    }

    public void setHotSale(Integer hotSale) {
        this.hotSale = hotSale;
    }

    public Integer getFoodStatus() {
        return foodStatus;
    }

    public void setFoodStatus(Integer foodStatus) {
        this.foodStatus = foodStatus;
    }

    @Override
    public String getLastModifyBy() {
        return lastModifyBy;
    }

    @Override
    public void setLastModifyBy(String lastModifyBy) {
        this.lastModifyBy = lastModifyBy;
    }

    @Override
    public Date getLastModifyTime() {
        return lastModifyTime;
    }

    @Override
    public void setLastModifyTime(Date lastModifyTime) {
        this.lastModifyTime = lastModifyTime;
    }

    public Integer getDayStock() {
        return dayStock;
    }

    public void setDayStock(Integer dayStock) {
        this.dayStock = dayStock;
    }
}
