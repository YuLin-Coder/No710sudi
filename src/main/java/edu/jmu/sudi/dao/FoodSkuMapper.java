package edu.jmu.sudi.dao;

import edu.jmu.sudi.entity.FoodSkuEntity;
import edu.jmu.sudi.vo.FoodSkuVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 菜品SKU持久层
 * @author LiangJie
 */
public interface FoodSkuMapper {

    /**
     * 新增菜品SKU
     * @param skuName
     * @return
     */
    public Integer addFoodSku(@Param("skuName") String skuName, @Param("foodId") Long foodId);

    /**
     * 查找某个菜品下的所有菜品SKU信息是否都已经完善
     * @param foodId
     * @return
     */
    public Integer findFoodSkuIsNull(Long foodId);

    /**
     * 删除某个菜品的所有SKU信息
     * @param foodId
     * @return
     */
    public Integer deleteFoodSkuByFoodId(Long foodId);

    /**
     * 根据页面的信息查询菜品SKU集合
     * @param vo
     * @return
     */
    public List<FoodSkuEntity> findFoodSkuListByPage(FoodSkuVo vo);

    /**
     * 新增菜品SKU信息
     * @param vo
     * @return
     */
    public Integer addFoodSkuBySkuManage(FoodSkuVo vo);

    /**
     * 修改菜品SKU信息
     * @param vo
     * @return
     */
    public Integer modifyFoodSku(FoodSkuVo vo);

    /**
     * 删除菜品SKU
     * @param skuId
     * @return
     */
    public Integer deleteFoodSku(Long skuId);

    /**
     * 根据菜品编号查询所有SKU信息
     * @param foodId
     * @return
     */
    public List<FoodSkuEntity> findFoodSkuListByFoodId(Long foodId);

    /**
     * 根据skuId查找菜品spu
     * @param skuId
     * @return
     */
    public FoodSkuEntity findFoodSkuBySkuId(Long skuId);

    /**
     * 增加某个菜品的SKU销量
     * @param skuId
     * @param skuSale
     * @return
     */
    public Integer addSkuSale(@Param("skuId") Long skuId, @Param("skuSale") Integer skuSale);
}
