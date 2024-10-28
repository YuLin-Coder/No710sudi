package edu.jmu.sudi.controller.user;

import com.alibaba.fastjson.JSON;
import edu.jmu.sudi.entity.UserEntity;
import edu.jmu.sudi.service.AddressService;
import edu.jmu.sudi.utils.LayuiTableDataResult;
import edu.jmu.sudi.vo.AddressVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * 用户地址管理控制器
 * @author LiangJie
 */
@RestController
@RequestMapping("/address")
public class AddressController {

    @Autowired
    private AddressService addressService;

    /**
     * 查找该角色的所有地址信息，返回LayUI数据表格格式
     */
    @RequestMapping("/list")
    public String findAddressListByUserId(AddressVo vo, HttpSession session){
        vo.setUserId(((UserEntity) session.getAttribute("userLogin")).getUserId());
        LayuiTableDataResult addressListByUserId = addressService.findAddressListByUserId(vo);
        return JSON.toJSONString(addressListByUserId);
    }

    /**
     * 查找该角色的所有地址信息，返回Map格式
     * @param session
     * @return
     */
    @RequestMapping("/listByUser")
    public String findAddressListByUser(HttpSession session){
        Map<String, Object> map = addressService.findAddressListByUser(session);
        return JSON.toJSONString(map);
    }

    /**
     * 添加地址
     * @param vo
     * @return
     */
    @RequestMapping("/add")
    public String addAddress(AddressVo vo, HttpSession session){
        Map<String, Object> map = addressService.addAddress(vo, session);
        return JSON.toJSONString(map);
    }

    /**
     * 修改地址
     * @param vo
     * @return
     */
    @RequestMapping("/modify")
    public String modifyAddress(AddressVo vo, HttpSession session){
        Map<String, Object> map = addressService.modifyAddress(vo, session);
        return JSON.toJSONString(map);
    }

    /**
     * 删除地址
     * @param addressId
     * @return
     */
    @RequestMapping("/delete")
    public String deleteAddress(Long addressId){
        Map<String, Object> map = addressService.deleteAddress(addressId);
        return JSON.toJSONString(map);
    }
}
