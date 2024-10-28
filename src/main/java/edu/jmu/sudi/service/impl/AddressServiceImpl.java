package edu.jmu.sudi.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import edu.jmu.sudi.dao.AddressMapper;
import edu.jmu.sudi.entity.AddressEntity;
import edu.jmu.sudi.entity.UserEntity;
import edu.jmu.sudi.service.AddressService;
import edu.jmu.sudi.utils.LayuiTableDataResult;
import edu.jmu.sudi.utils.SystemConstant;
import edu.jmu.sudi.vo.AddressVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 用户地址管理服务层实现类
 * @author LiangJie
 */
@Service
@Transactional
public class AddressServiceImpl implements AddressService {

    @Autowired
    private AddressMapper addressMapper;

    /**
     * 查找该角色的所有地址信息
     * @param vo
     * @return
     */
    @Override
    public LayuiTableDataResult findAddressListByUserId(AddressVo vo) {
        PageHelper.startPage(vo.getPage(), vo.getLimit());
        List<AddressEntity> addressList = addressMapper.findAddressListByUserId(vo);
        PageInfo<AddressEntity> pageInfo = new PageInfo<>(addressList);
        return new LayuiTableDataResult(pageInfo.getTotal(), pageInfo.getList());
    }

    /**
     * 添加地址
     * @param vo
     * @param session
     * @return
     */
    @Override
    public Map<String, Object> addAddress(AddressVo vo, HttpSession session) {
        vo.setUserId(((UserEntity) session.getAttribute(SystemConstant.USERLOGIN)).getUserId());
        Map<String, Object> map = new HashMap<>(16);
        //查找该用户下首选的地址
        AddressEntity address = addressMapper.selectDefaultedAddressByUserId(vo.getUserId());
        if (addressMapper.addAddress(vo) > 0){
            if (vo.getDefaulted()==1 && address!=null) {
                //修改该地址为非首选
                addressMapper.modifyAddressUndefaulted(address.getAddressId());
            }
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "地址新增成功");
        }else {
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "地址新增失败");
        }
        return map;
    }

    /**
     * 修改地址
     * @param vo
     * @param session
     * @return
     */
    @Override
    public Map<String, Object> modifyAddress(AddressVo vo, HttpSession session) {
        vo.setUserId(((UserEntity) session.getAttribute(SystemConstant.USERLOGIN)).getUserId());
        Map<String, Object> map = new HashMap<>(16);
        AddressEntity address = addressMapper.selectDefaultedAddressByUserId(vo.getUserId());
        if (addressMapper.modifyAddress(vo) > 0) {
            if (vo.getDefaulted()==1 && address!=null) {
                //修改该地址为非首选
                addressMapper.modifyAddressUndefaulted(address.getAddressId());
            }
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "地址修改成功");
        }else {
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "地址修改失败");
        }
        return map;
    }

    /**
     * 删除地址
     * @param addressId
     * @return
     */
    @Override
    public Map<String, Object> deleteAddress(Long addressId) {
        Map<String, Object> map = new HashMap<>(16);
        if (addressMapper.deleteAddress(addressId) > 0) {
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "地址删除成功");
        }else {
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "地址删除失败");
        }
        return map;
    }

    /**
     * 查找该角色的所有地址信息，返回Map集合形式
     * @param session
     * @return
     */
    @Override
    public Map<String, Object> findAddressListByUser(HttpSession session) {
        Map<String, Object> map = new HashMap<>(16);
        AddressVo vo = new AddressVo();
        vo.setUserId(((UserEntity) session.getAttribute(SystemConstant.USERLOGIN)).getUserId());
        List<AddressEntity> addressList = addressMapper.findAddressListByUserId(vo);
        if (addressList != null) {
           map.put(SystemConstant.FLAG, true);
           map.put("addressList", addressList);
        }else {
            map.put(SystemConstant.FLAG, false);
        }
        return map;
    }
}
