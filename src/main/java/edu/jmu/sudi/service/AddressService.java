package edu.jmu.sudi.service;

import edu.jmu.sudi.utils.LayuiTableDataResult;
import edu.jmu.sudi.vo.AddressVo;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * 用户地址管理业务层
 * @author LiangJie
 */
public interface AddressService {

    /**
     * 查找该角色的所有地址信息
     * @param vo
     * @return
     */
    public LayuiTableDataResult findAddressListByUserId(AddressVo vo);

    /**
     * 添加地址
     * @param vo
     * @return
     */
    public Map<String, Object> addAddress(AddressVo vo, HttpSession session);

    /**
     * 修改地址
     * @param vo
     * @param session
     * @return
     */
    public Map<String, Object> modifyAddress(AddressVo vo, HttpSession session);

    /**
     * 删除地址
     * @param addressId
     * @return
     */
    public Map<String, Object> deleteAddress(Long addressId);

    /**
     * 查找该角色的所有地址信息，返回Map集合形式
     * @param session
     * @return
     */
    public Map<String, Object> findAddressListByUser(HttpSession session);
}
