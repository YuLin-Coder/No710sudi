package edu.jmu.sudi.dao;

import edu.jmu.sudi.entity.ShopcartEntity;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 购物车DAO层
 * @author LiangJie
 */
@Repository
public interface ShopcartMapper {

    /**
     * 添加菜品SKU到购物车
     * @param shopcartEntity
     * @return
     */
    public Integer addShopcart(ShopcartEntity shopcartEntity);

    /**
     * 查询用户的购物车中是否存在某个SKU菜品
     * @param userId
     * @param skuId
     * @return
     */
    public ShopcartEntity findShopcartRecord(@Param("userId") Long userId, @Param("skuId") Long skuId);

    /**
     * 添加购物车中某个物品的数量
     * @param shopcartId
     * @param numCount
     * @return
     */
    public Integer addNumCount(@Param("shopcartId") Long shopcartId, @Param("numCount") Integer numCount);

    /**
     * 查找该用户下的所有购物车信息
     * @param userId
     * @return
     */
    public List<ShopcartEntity> findAllShopcartByUserId(Long userId);

    /**
     * 该用户某个SKU菜品的数量+1
     * @param shopcartId
     * @return
     */
    public Integer addNumCountOne(Long shopcartId);

    /**
     * 该用户某个SKU菜品的数量-1
     * @param shopcartId
     * @return
     */
    public Integer reduceNumCountOne(Long shopcartId);

    /**
     * 删除购物车的某一个条目
     * @param shopcartId
     * @return
     */
    public Integer deleteShopcart(Long shopcartId);

    /**
     * 清空某个用户的购物车
     * @param userId
     * @return
     */
    public Integer clearShopcart(Long userId);
}
