package edu.jmu.sudi.entity;

import java.io.Serializable;

/**
 * 用户信息实体类
 * @author LiangJie
 */
public class AddressEntity extends UserEntity implements Serializable {

    private Long addressId;
    private Integer defaulted;
    private String address;

    public Long getAddressId() {
        return addressId;
    }

    public void setAddressId(Long addressId) {
        this.addressId = addressId;
    }

    public Integer getDefaulted() {
        return defaulted;
    }

    public void setDefaulted(Integer defaulted) {
        this.defaulted = defaulted;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
