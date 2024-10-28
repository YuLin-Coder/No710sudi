package edu.jmu.sudi.dao;

import edu.jmu.sudi.entity.FoodattrEntity;
import edu.jmu.sudi.vo.FoodattrVo;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 菜品规格组持久层
 * @author LiangJie
 */
@Repository
public interface FoodattrMapper {

    /**
     * 根据页面返回信息查找符合条件的菜品规格组集合
     * @param vo
     * @return
     */
    public List<FoodattrEntity> findFoodattrListByPage(FoodattrVo vo);

    /**
     * 添加菜品规格组
     * @param vo
     * @return
     */
    public Integer addFoodattr(FoodattrVo vo);

    /**
     * 修改菜品规格组
     * @param vo
     * @return
     */
    public Integer modifyFoodattr(FoodattrVo vo);

    /**
     * 删除菜品规格组
     * @param vo
     * @return
     */
    public Integer deleteFoodattr(FoodattrVo vo);

    /**
     * 查询所有的菜品类别
     * @return
     */
    public List<FoodattrEntity> findAllFoodattr();
}
