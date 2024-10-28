package edu.jmu.sudi.dao;

import edu.jmu.sudi.entity.AddressEntity;
import edu.jmu.sudi.vo.AddressVo;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author LiangJie
 */
@Repository
public interface AddressMapper {

    /**
     * 查找该角色的所有地址信息
     * @param vo
     * @return
     */
    public List<AddressEntity> findAddressListByUserId(AddressVo vo);

    /**
     * 添加地址
     * @param vo
     * @return
     */
    public Integer addAddress(AddressVo vo);

    /**
     * 查找该用户为首选的地址
     * @param userId
     * @return
     */
    public AddressEntity selectDefaultedAddressByUserId(Long userId);

    /**
     * 修改地址为非首选
     * @return
     */
    public Integer modifyAddressUndefaulted(Long addressId);

    /**
     * 修改地址
     * @param vo
     * @return
     */
    public Integer modifyAddress(AddressVo vo);

    /**
     * 删除地址
     * @param addressId
     * @return
     */
    public Integer deleteAddress(Long addressId);

    /**
     * 根据地址编号查询地址
     * @param addressId
     * @return
     */
    public AddressEntity findAddressById(Long addressId);
}
