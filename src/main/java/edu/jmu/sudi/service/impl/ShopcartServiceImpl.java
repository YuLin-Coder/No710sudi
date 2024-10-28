package edu.jmu.sudi.service.impl;

import edu.jmu.sudi.dao.ShopcartMapper;
import edu.jmu.sudi.entity.ShopcartEntity;
import edu.jmu.sudi.entity.UserEntity;
import edu.jmu.sudi.service.ShopcartService;
import edu.jmu.sudi.utils.SystemConstant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 购物车业务层实现类
 * @author LiangJie
 */
@Service
@Transactional
public class ShopcartServiceImpl implements ShopcartService {

    @Autowired
    private ShopcartMapper shopcartMapper;

    /**
     * 添加菜品SKU到购物车
     * @param skuId
     * @param numCount
     * @param session
     * @return
     */
    @Override
    public Map<String, Object> addShopcart(Long skuId, Integer numCount, HttpSession session) {
        Map<String, Object> map = new HashMap<>(16);
        Long userId = ((UserEntity) session.getAttribute(SystemConstant.USERLOGIN)).getUserId();
        //先要查询一下该用户的购物车中是否有该菜品SKU信息，有的话合并，没有的话才加上去
        ShopcartEntity record = shopcartMapper.findShopcartRecord(userId, skuId);
        if (record==null) {
            //封装实体类
            ShopcartEntity shopcart = new ShopcartEntity();
            shopcart.setNumCount(numCount);shopcart.setUserId(userId);shopcart.setSkuId(skuId);
            if (shopcartMapper.addShopcart(shopcart) > 0) {
                map.put(SystemConstant.FLAG, true);
                map.put(SystemConstant.MESSAGE, "菜品已经添加到购物车中啦！");
            }else {
                map.put(SystemConstant.FLAG, false);
                map.put(SystemConstant.MESSAGE, "菜品添加到购物车失败");
            }
        }else {
            if (shopcartMapper.addNumCount(record.getShopcartId(), numCount) > 0) {
                map.put(SystemConstant.FLAG, true);
                map.put(SystemConstant.MESSAGE, "购物车中该菜品数量修改成功！");
            }else {
                map.put(SystemConstant.FLAG, false);
                map.put(SystemConstant.MESSAGE, "菜品添加到购物车失败");
            }
        }
        return map;
    }

    /**
     * 查找该用户下的所有购物车信息
     * @param session
     * @return
     */
    @Override
    public Map<String, Object> findAllShopcartByUserId(HttpSession session) {
        Map<String, Object> map = new HashMap<>(16);
        Long userId = ((UserEntity) session.getAttribute(SystemConstant.USERLOGIN)).getUserId();
        List<ShopcartEntity> shopcartByUserId = shopcartMapper.findAllShopcartByUserId(userId);
        map.put("shopcart", shopcartByUserId);
        return map;
    }

    /**
     * 新增该用户某个SKU菜品的数量
     * @param shopcartId
     * @return
     */
    @Override
    public Map<String, Object> addNumCountOne(Long shopcartId) {
        Map<String, Object> map = new HashMap<>(16);
        if (shopcartMapper.addNumCountOne(shopcartId) > 0) {
            map.put(SystemConstant.FLAG, true);
        }else {
            map.put(SystemConstant.FLAG, false);
        }
        return map;
    }

    /**
     * 减少该用户某个SKU菜品的数量
     * @param shopcartId
     * @return
     */
    @Override
    public Map<String, Object> reduceNumCountOne(Long shopcartId) {
        Map<String, Object> map = new HashMap<>(16);
        if (shopcartMapper.reduceNumCountOne(shopcartId) > 0) {
            map.put(SystemConstant.FLAG, true);
        }else {
            map.put(SystemConstant.FLAG, false);
        }
        return map;
    }

    /**
     * 删除购物车的某一个条目
     * @param shopcartId
     * @return
     */
    @Override
    public Map<String, Object> deleteShopcart(Long shopcartId) {
        Map<String, Object> map = new HashMap<>(16);
        if (shopcartMapper.deleteShopcart(shopcartId) > 0) {
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "该菜品条目已成功从您的购物车中删除");
        }else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "菜品条目从购物车中删除失败");
        }
        return map;
    }


}

