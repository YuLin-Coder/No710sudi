package edu.jmu.sudi.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 配送员实体类
 * @author LiangJie
 */
public class DeliverEntity extends UserEntity implements Serializable {
    private String deliverId;
    private String realName;
    private String imageUrl;
    private Integer orderCount;
    private Integer faultCount;
    private Integer finishCount;
    private Date joinDate;
    private Date leaveDate;
    private String remark;

    public String getDeliverId() {
        return deliverId;
    }

    public void setDeliverId(String deliverId) {
        this.deliverId = deliverId;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public Integer getOrderCount() {
        return orderCount;
    }

    public void setOrderCount(Integer orderCount) {
        this.orderCount = orderCount;
    }

    public Integer getFaultCount() {
        return faultCount;
    }

    public void setFaultCount(Integer faultCount) {
        this.faultCount = faultCount;
    }

    public Integer getFinishCount() {
        return finishCount;
    }

    public void setFinishCount(Integer finishCount) {
        this.finishCount = finishCount;
    }

    public Date getJoinDate() {
        return joinDate;
    }

    public void setJoinDate(Date joinDate) {
        this.joinDate = joinDate;
    }

    public Date getLeaveDate() {
        return leaveDate;
    }

    public void setLeaveDate(Date leaveDate) {
        this.leaveDate = leaveDate;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    @Override
    public String toString() {
        return "DeliverEntity{" +
                "deliverId='" + deliverId + '\'' +
                ", realName='" + realName + '\'' +
                ", imageUrl='" + imageUrl + '\'' +
                ", orderCount=" + orderCount +
                ", faultCount=" + faultCount +
                ", finishCount=" + finishCount +
                ", joinDate=" + joinDate +
                ", leaveDate=" + leaveDate +
                ", remark='" + remark + '\'' +
                '}';
    }
}
