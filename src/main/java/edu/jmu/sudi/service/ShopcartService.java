package edu.jmu.sudi.service;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * 购物车业务层
 * @author LiangJie
 */
public interface ShopcartService {

    /**
     * 添加菜品SKU到购物车
     * @param numCount
     * @param session
     * @param skuId
     * @return
     */
    public Map<String, Object> addShopcart(Long skuId, Integer numCount, HttpSession session);

    /**
     * 查找该用户下的所有购物车信息
     * @param session
     * @return
     */
    public Map<String, Object> findAllShopcartByUserId(HttpSession session);

    /**
     * 新增该用户某个SKU菜品的数量
     * @param shopcartId
     * @return
     */
    public Map<String, Object> addNumCountOne(Long shopcartId);

    /**
     * 减少该用户某个SKU菜品的数量
     * @param shopcartId
     * @return
     */
    public Map<String, Object> reduceNumCountOne(Long shopcartId);

    /**
     * 删除购物车的某一个条目
     * @param shopcartId
     * @return
     */
    public Map<String, Object> deleteShopcart(Long shopcartId);
}
