package edu.jmu.sudi.controller.food;

import com.alibaba.fastjson.JSON;
import edu.jmu.sudi.service.FoodTypeService;
import edu.jmu.sudi.utils.LayuiTableDataResult;
import edu.jmu.sudi.vo.FoodTypeVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * 菜品类别管理控制器
 * @author LiangJie
 */
@RestController
@RequestMapping("/backstage/foodtype")
public class FoodTypeManageController {

    @Autowired
    private FoodTypeService foodTypeService;

    /**
     * 根据页面返回信息查找符合条件的菜品类别集合
     * @param vo
     * @return
     */
    @RequestMapping("/list")
    public String findFoodTypeListByPage(FoodTypeVo vo){
        LayuiTableDataResult foodTypeListByPage = foodTypeService.findFoodTypeListByPage(vo);
        return JSON.toJSONString(foodTypeListByPage);
    }

    /**
     * 菜品类别文件上传
     * @param foodtypeImage
     * @return
     */
    @RequestMapping("/uploadFile")
    public String uploadFile(MultipartFile foodtypeImage){
        Map<String, Object> map = foodTypeService.uploadFile(foodtypeImage);
        return JSON.toJSONString(map);
    }

    /**
     * 添加菜品类别
     * @param vo
     * @param session
     * @return
     */
    @RequestMapping("/add")
    public String addFoodtype(FoodTypeVo vo, HttpSession session){
        Map<String, Object> map = foodTypeService.addFoodtype(vo, session);
        return JSON.toJSONString(map);
    }

    /**
     * 编辑菜品类别
     * @param vo
     * @param session
     * @return
     */
    @RequestMapping("/modify")
    public String modifyFoodtype(FoodTypeVo vo, HttpSession session){
        Map<String, Object> map = foodTypeService.modifyFoodtype(vo, session);
        return JSON.toJSONString(map);
    }

    /**
     * 菜品类别下架
     * @param typeId
     * @param session
     * @return
     */
    @RequestMapping("/offShelf")
    public String offShelfFoodtype(Long typeId, HttpSession session){
        Map<String, Object> map = foodTypeService.offShelfFoodtype(typeId, session);
        return JSON.toJSONString(map);
    }

    /**
     * 菜品类别恢复上架
     * @param typeId
     * @param session
     * @return
     */
    @RequestMapping("/onShelf")
    public String onShelfFoodtype(Long typeId, HttpSession session){
        Map<String, Object> map = foodTypeService.onShelfFoodtype(typeId, session);
        return JSON.toJSONString(map);
    }



    /**
     * 查询所有的菜品类别
     * @return
     */
    @RequestMapping("/findAllFoodtype")
    public String findAllFoodtype(){
        Map<String, Object> map = foodTypeService.findAllFoodtype();
        return JSON.toJSONString(map);
    }



}
