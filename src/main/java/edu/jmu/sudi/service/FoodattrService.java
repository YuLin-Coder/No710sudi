package edu.jmu.sudi.service;

import edu.jmu.sudi.utils.LayuiTableDataResult;
import edu.jmu.sudi.vo.FoodattrVo;

import java.util.Map;

/**
 * 菜品规格组服务层
 * @author LiangJie
 */
public interface FoodattrService {

    /**
     * 根据页面返回信息查找符合条件的菜品规格组集合
     * @param vo
     * @return
     */
    public LayuiTableDataResult findFoodattrListByPage(FoodattrVo vo);

    /**
     * 添加菜品规格组
     * @param vo
     * @return
     */
    public Map<String, Object> addFoodattr(FoodattrVo vo);

    /**
     * 修改菜品规格组
     * @param vo
     * @return
     */
    public Map<String, Object> modifyFoodattr(FoodattrVo vo);

    /**
     * 删除菜品规格组
     * @param vo
     * @return
     */
    public Map<String, Object> deleteFoodattr(FoodattrVo vo);

    /**
     * 查询所有的菜品类别
     * @return
     */
    public Map<String, Object> findAllFoodattr();
}
