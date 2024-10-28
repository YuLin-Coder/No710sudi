package edu.jmu.sudi.controller.shopcart;

import com.alibaba.fastjson.JSON;
import edu.jmu.sudi.service.ShopcartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * 购物车控制器
 * @author LiangJie
 */
@RestController
@RequestMapping("/reception/shopcart")
public class ShopcartController {

    @Autowired
    private ShopcartService shopcartService;

    /**
     * 添加菜品SKU到购物车
     * @param session
     * @param numCount
     * @param skuId
     * @return
     */
    @RequestMapping("/add")
    public String addShopcart(Long skuId, Integer numCount, HttpSession session){
        Map<String, Object> map = shopcartService.addShopcart(skuId, numCount, session);
        return JSON.toJSONString(map);
    }

    /**
     * 查找该用户下的所有购物车信息
     * @param session
     * @return
     */
    @RequestMapping("/findByUserId")
    public String findAllShopcartByUserId(HttpSession session){
        Map<String, Object> map = shopcartService.findAllShopcartByUserId(session);
        return JSON.toJSONString(map);
    }

    /**
     * 新增该用户某个SKU菜品的数量
     * @param shopcartId
     * @return
     */
    @RequestMapping("/addNumCountOne")
    public String addNumCountOne(Long shopcartId){
        Map<String, Object> map = shopcartService.addNumCountOne(shopcartId);
        return JSON.toJSONString(map);
    }

    /**
     * 减少该用户某个SKU菜品的数量
     * @param shopcartId
     * @return
     */
    @RequestMapping("/reduceNumCountOne")
    public String reduceNumCountOne(Long shopcartId){
        Map<String, Object> map = shopcartService.reduceNumCountOne(shopcartId);
        return JSON.toJSONString(map);
    }

    /**
     * 删除购物车的某一个条目
     * @param shopcartId
     * @return
     */
    @RequestMapping("/delete")
    public String deleteShopcart(Long shopcartId){
        Map<String, Object> map = shopcartService.deleteShopcart(shopcartId);
        return JSON.toJSONString(map);
    }

}
