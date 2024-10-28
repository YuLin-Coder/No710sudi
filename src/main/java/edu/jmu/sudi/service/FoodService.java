package edu.jmu.sudi.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import edu.jmu.sudi.entity.FoodEntity;
import edu.jmu.sudi.entity.FoodTypeEntity;
import edu.jmu.sudi.utils.LayuiTableDataResult;
import edu.jmu.sudi.vo.FoodVo;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * 菜品SPU管理服务层
 * @author LiangJie
 */
public interface FoodService {

    /**
     * 根据页面条件查询菜品SPU信息列表
     * @param vo
     * @return
     */
    public LayuiTableDataResult findFoodListByPage(FoodVo vo);

    /**
     * 菜品图片上传
     * @param foodImage
     * @return
     */
    public Map<String, Object> uploadFile(MultipartFile foodImage);

    /**
     * 添加菜品SPU信息并且生成菜品SKU信息
     * @param vo
     * @param foodParamList
     * @param session
     * @param json
     * @return
     */
    public Map<String, Object> addFood(FoodVo vo, List<Map<String, Object>> foodParamList, HttpSession session, JSONObject json);

    /**
     * 生成菜品规格信息和SKU信息
     * @param foodId
     * @param foodParamList
     * @param foodName
     * @return
     */
    public boolean generateSku(List<Map<String, Object>> foodParamList, Long foodId, String foodName);

    /**
     * 修改菜品SPU信息
     * @param vo
     * @param session
     * @return
     */
    public Map<String, Object> modifyFood(FoodVo vo, HttpSession session);

    /**
     * 菜品上架
     * @param foodId
     * @param session
     * @return
     */
    public Map<String, Object> onShelf(Long foodId, HttpSession session);

    /**
     * 删除菜品SPU以及SKU信息
     * @param foodId
     * @return
     */
    public Map<String, Object> delete(Long foodId);

    /**
     * 菜品下架
     * @param foodId
     * @param session
     * @return
     */
    public Map<String, Object> offShelf(Long foodId, HttpSession session);

    /**
     * 根据菜品类别编号查找对应的菜品
     * @param typeId
     * @return
     */
    public Map<String, Object> findFoodByTypeId(Long typeId);

    /**
     * 查找所有上架类别的所有上架菜品
     * @return
     */
    public List<FoodTypeEntity> findFoodType();

    /**
     * 根据类别ID查询上架菜品
     * @param typeId
     * @return
     */
    public List<FoodEntity> findOnshelfFoodByType(Long typeId);

    /**
     * 根据菜品编号查询所有菜品信息
     * @param foodId
     * @return
     */
    public Map<String, Object> findFoodInfoById(Long foodId);

    /**
     * 查询所有上架的推荐和热销菜品
     * @return
     */
    public Map<String, Object> findRecommendAndHotSaleFood();

}
