package edu.jmu.sudi.controller.food;

import com.alibaba.fastjson.JSON;
import edu.jmu.sudi.service.FoodattrService;
import edu.jmu.sudi.utils.LayuiTableDataResult;
import edu.jmu.sudi.vo.FoodTypeVo;
import edu.jmu.sudi.vo.FoodattrVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * 菜品SKU属性集管理控制器
 * @author LiangJie
 */
@RestController
@RequestMapping("/backstage/foodattr")
public class FoodattrManageController {

    @Autowired
    private FoodattrService foodattrService;

    /**
     * 根据页面返回信息查找符合条件的菜品规格组集合
     * @param vo
     * @return
     */
    @RequestMapping("/list")
    public String findFoodattrListByPage(FoodattrVo vo){
        LayuiTableDataResult foodattrListByPage = foodattrService.findFoodattrListByPage(vo);
        return JSON.toJSONString(foodattrListByPage);
    }

    /**
     * 添加菜品规格组
     * @param vo
     * @return
     */
    @RequestMapping("/add")
    public String addFoodattr(FoodattrVo vo){
        Map<String, Object> map = foodattrService.addFoodattr(vo);
        return JSON.toJSONString(map);
    }

    /**
     * 修改菜品规格组
     * @param vo
     * @return
     */
    @RequestMapping("/modify")
    public String modifyFoodattr(FoodattrVo vo){
        Map<String, Object> map = foodattrService.modifyFoodattr(vo);
        return JSON.toJSONString(map);
    }

    /**
     * 删除菜品规格组
     * @param vo
     * @return
     */
    @RequestMapping("/delete")
    public String deleteFoodattr(FoodattrVo vo){
        Map<String, Object> map = foodattrService.deleteFoodattr(vo);
        return JSON.toJSONString(map);
    }

    /**
     * 查询所有的菜品类别
     * @return
     */
    @RequestMapping("/findAllFoodattr")
    public String findAllFoodattr(){
        Map<String, Object> allFoodattr = foodattrService.findAllFoodattr();
        return JSON.toJSONString(allFoodattr);
    }
}
