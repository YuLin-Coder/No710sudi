package edu.jmu.sudi.entity;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 订单细则实体类
 * @author LiangJie
 */
public class OrderDetailEntity extends FoodSkuEntity implements Serializable {

    private Long orderDetailId;
    private String orderId;
    private Integer amount;
    private BigDecimal itemPrice;
    private Integer comment;

    public Long getOrderDetailId() {
        return orderDetailId;
    }

    public void setOrderDetailId(Long orderDetailId) {
        this.orderDetailId = orderDetailId;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    public BigDecimal getItemPrice() {
        return itemPrice;
    }

    public void setItemPrice(BigDecimal itemPrice) {
        this.itemPrice = itemPrice;
    }

    public Integer getComment() {
        return comment;
    }

    public void setComment(Integer comment) {
        this.comment = comment;
    }
}
