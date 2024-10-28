package edu.jmu.sudi.controller.food;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.TypeReference;
import edu.jmu.sudi.service.FoodService;
import edu.jmu.sudi.utils.LayuiTableDataResult;
import edu.jmu.sudi.vo.FoodVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * 菜品SPU管理控制器
 * @author LiangJie
 */
@RestController
@RequestMapping("/backstage/food")
public class FoodManageController {

    @Autowired
    private FoodService foodService;

    /**
     * 根据页面条件查询菜品SPU信息列表
     * @param vo
     * @return
     */
    @RequestMapping("/list")
    public String findFoodListByPage(FoodVo vo){
        LayuiTableDataResult foodListByPage = foodService.findFoodListByPage(vo);
        return JSON.toJSONString(foodListByPage);
    }

    /**
     * 菜品图片上传
     * @param foodImage
     * @return
     */
    @RequestMapping("/uploadFile")
    public String uploadFile(MultipartFile foodImage) {
        Map<String, Object> map = foodService.uploadFile(foodImage);
        return JSON.toJSONString(map);
    }

    /**
     * 添加菜品SPU信息并且生成菜品SKU信息
     * @param mapStr
     * @return
     */
    @RequestMapping("/add")
    public String addFood(@RequestParam String mapStr, FoodVo vo, HttpSession session) {
        /*
            数据拆分
         */
        //拆分菜品信息数据
        Integer limit = vo.getLimit();
        Integer page = vo.getPage();
        JSONObject jsonObject = JSONObject.parseObject(mapStr);
        vo = JSONObject.parseObject(jsonObject.get("foodData").toString(), FoodVo.class);
        vo.setPage(page);vo.setLimit(limit);
        //拆分菜品规格信息数据
        JSONArray foodParam = jsonObject.getJSONArray("foodParam");
        List<Map<String, Object>> foodParamList = JSON.parseObject(foodParam.toString(), new TypeReference<List<Map<String, Object>>>() {});

        Map<String, Object> map = foodService.addFood(vo, foodParamList, session, jsonObject);
        return JSON.toJSONString(map);
    }

    /**
     * 修改菜品SPU信息
     * @param mapStr
     * @param vo
     * @return
     */
    @RequestMapping("/modify")
    public String modifyFood(@RequestParam String mapStr, FoodVo vo, HttpSession session){
        //拆分菜品信息数据
        Integer limit = vo.getLimit();
        Integer page = vo.getPage();
        JSONObject jsonObject = JSONObject.parseObject(mapStr);
        vo = JSONObject.parseObject(jsonObject.get("foodData").toString(), FoodVo.class);
        vo.setPage(page);vo.setLimit(limit);
        Map<String, Object> map = foodService.modifyFood(vo, session);
        return JSON.toJSONString(map);
    }

    /**
     * 菜品上架
     * @param foodId
     * @param session
     * @return
     */
    @RequestMapping("/onShelf")
    public String onShelf(Long foodId, HttpSession session){
        Map<String, Object> map = foodService.onShelf(foodId, session);
        return JSON.toJSONString(map);
    }

    /**
     * 删除菜品SPU以及SKU信息
     * @param foodId
     * @return
     */
    @RequestMapping("/delete")
    public String delete(Long foodId){
        Map<String, Object> map = foodService.delete(foodId);
        return JSON.toJSONString(map);
    }

    /**
     * 菜品下架
     * @param foodId
     * @param session
     * @return
     */
    @RequestMapping("/offShelf")
    public String offShelf(Long foodId, HttpSession session) {
        Map<String, Object> map = foodService.offShelf(foodId, session);
        return JSON.toJSONString(map);
    }

    /**
     * 根据菜品类别编号查找对应的菜品
     * @param typeId
     * @return
     */
    @RequestMapping("/findFoodByTypeId")
    public String findFoodByTypeId(Long typeId) {
        Map<String, Object> foodByTypeId = foodService.findFoodByTypeId(typeId);
        return JSON.toJSONString(foodByTypeId);
    }

}
