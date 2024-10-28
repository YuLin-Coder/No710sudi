package edu.jmu.sudi.dao;

import edu.jmu.sudi.entity.FoodEntity;
import edu.jmu.sudi.vo.FoodVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;

/**
 * 菜品SPU管理持久层
 * @author LiangJie
 */
@Repository
public interface FoodMapper {

    /**
     * 根据页面条件查询菜品SPU信息列表
     * @param vo
     * @return
     */
    public List<FoodEntity> findFoodListByPage(FoodVo vo);

    /**
     * 添加菜品SPU信息
     * @param vo
     * @return
     */
    public Integer addFood(FoodVo vo);

    /**
     * 修改菜品SPU信息
     * @param vo
     * @return
     */
    public Integer modifyFood(FoodVo vo);

    /**
     * 菜品上架
     * @param foodId
     * @param username
     * @return
     */
    public Integer foodOnShelf(@Param("foodId") Long foodId, @Param("username") String username);

    /**
     * 删除菜品SPU
     * @param foodId
     * @return
     */
    public Integer deleteFood(Long foodId);

    /**
     * 菜品下架
     * @param foodId
     * @param username
     * @return
     */
    public Integer foodOffShelf(@Param("foodId") Long foodId, @Param("username") String username);

    /**
     * 根据菜品类别编号查找对应的菜品
     * @param typeId
     * @return
     */
    public List<FoodEntity> findFoodByTypeId(Long typeId);

    /**
     * 根据菜品SPU编号查找
     * @param foodId
     * @return
     */
    public FoodEntity findFoodById(Long foodId);

    /**
     * 根据菜品类别查找所有上架的菜品
     * @param typeId
     * @return
     */
    public List<FoodEntity> findOnshelfFoodByType(Long typeId);

    /**
     * 查询所有上架的推荐菜品
     * @return
     */
    public List<FoodEntity> findRecommendFoodOnShelf();

    /**
     * 查询所有上架的热销菜品
     * @return
     */
    public List<FoodEntity> findHotSaleFoodOnShelf();

    /**
     * 增加某个菜品SPU的销量
     * @param foodId
     * @param amount
     * @return
     */
    public Integer addSaleCount(@Param("foodId") Long foodId, @Param("amount") Integer amount);

    /**
     * 修改菜品的分数
     * @param foodId
     * @param foodScore
     * @return
     */
    public Integer changeFoodScore(@Param("foodId") Long foodId, @Param("foodScore") BigDecimal foodScore);

    /**
     * 增加一条该菜品的评论数
     * @param foodId
     * @return
     */
    public Integer addCommentCountOne(Long foodId);

    /**
     * 该菜品浏览量+1
     * @param foodId
     * @return
     */
    public Integer addViewCountOne(Long foodId);

    /**
     * 该菜品的差评数量+1
     * @param foodId
     * @return
     */
    public Integer addFaultCountOne(Long foodId);
}
