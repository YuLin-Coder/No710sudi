package edu.jmu.sudi.dao;

import edu.jmu.sudi.entity.FoodTypeEntity;
import edu.jmu.sudi.vo.FoodTypeVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 菜品类别dao层
 * @author LiangJie
 */
@Repository
public interface FoodTypeMapper {

    /**
     * 根据页面返回信息查找符合条件的菜品类别集合
     * @param vo
     * @return
     */
    public List<FoodTypeEntity> findFoodTypeListByPage(FoodTypeVo vo);

    /**
     * 添加菜品类别
     * @param vo
     * @return
     */
    public Integer addFoodtype(FoodTypeVo vo);

    /**
     * 编辑菜品类别
     * @param vo
     * @return
     */
    public Integer modifyFoodtype(FoodTypeVo vo);

    /**
     * 菜品类别下架
     * @param typeId
     * @param username
     * @return
     */
    public Integer offShelfFoodtype(@Param("typeId") Long typeId, @Param("username") String username);

    /**
     * 菜品类别恢复上架
     * @param typeId
     * @param username
     * @return
     */
    public Integer onShelfFoodtype(@Param("typeId") Long typeId, @Param("username") String username);

    /**
     * 查询所有的菜品类别
     * @return
     */
    public List<FoodTypeEntity> findAllFoodtype();

    /**
     * 查询所有上架的菜品类别
     * @return
     */
    public List<FoodTypeEntity> findAllFoodtypeOnShelf();
}
