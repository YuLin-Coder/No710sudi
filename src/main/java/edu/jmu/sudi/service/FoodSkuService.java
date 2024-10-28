package edu.jmu.sudi.service;

import edu.jmu.sudi.dao.FoodSkuMapper;
import edu.jmu.sudi.utils.LayuiTableDataResult;
import edu.jmu.sudi.vo.FoodSkuVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

/**
 * 菜品SKU服务层
 * @author LiangJie
 */
public interface FoodSkuService {

    /**
     * 根据页面的信息查询菜品SKU集合
     * @param vo
     * @return
     */
    public LayuiTableDataResult findFoodSkuListByPage(FoodSkuVo vo);

    /**
     * 新增菜品SKU
     * @param vo
     * @return
     */
    public Map<String, Object> addFoodSku(FoodSkuVo vo);

    /**
     * 新增菜品SKU
     * @param vo
     * @return
     */
    public Map<String, Object> modifyFoodSku(FoodSkuVo vo);

    /**
     * 删除菜品SKU
     * @param skuId
     * @param skuName
     * @param foodId
     * @return
     */
    public Map<String, Object> deleteFoodSku(Long skuId, String skuName, Long foodId);
}
