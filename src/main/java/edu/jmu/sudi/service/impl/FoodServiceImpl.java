package edu.jmu.sudi.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import edu.jmu.sudi.dao.*;
import edu.jmu.sudi.entity.*;
import edu.jmu.sudi.service.FoodService;
import edu.jmu.sudi.utils.FileUploadUtil;
import edu.jmu.sudi.utils.FoodSkuUtil;
import edu.jmu.sudi.utils.LayuiTableDataResult;
import edu.jmu.sudi.utils.SystemConstant;
import edu.jmu.sudi.vo.FoodVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 菜品SPU管理服务层实现类
 * @author LiangJie
 */
@Service
@Transactional
public class FoodServiceImpl implements FoodService {

    @Autowired
    private FoodMapper foodMapper;
    @Autowired
    private FoodattrMapper foodattrMapper;
    @Autowired
    private FoodvalueMapper foodvalueMapper;
    @Autowired
    private FoodSkuMapper foodSkuMapper;
    @Autowired
    private FoodTypeMapper foodTypeMapper;

    /**
     * 根据页面条件查询菜品SPU信息列表
     * @param vo
     * @return
     */
    @Override
    public LayuiTableDataResult findFoodListByPage(FoodVo vo) {
        PageHelper.startPage(vo.getPage(), vo.getLimit());
        List<FoodEntity> foodListByPage = foodMapper.findFoodListByPage(vo);
        PageInfo<FoodEntity> pageInfo = new PageInfo<>(foodListByPage);
        return new LayuiTableDataResult(pageInfo.getTotal(), pageInfo.getList());
    }

    /**
     * 菜品图片上传
     * @param foodImage
     * @return
     */
    @Override
    public Map<String, Object> uploadFile(MultipartFile foodImage) {
        //用于存储LayUI文件上传所必须的键值
        Map<String, Object> map = new HashMap<>(16);
        //判断一下文件是否为空
        if (!foodImage.isEmpty()) {
            //将文件重命名
            String newFileName = FileUploadUtil.rename(foodImage);
            //全部文件都放在一个文件夹下不好管理，所以以日期作为文件夹进行管理
            //组装路径
            String finalPath = new SimpleDateFormat("yyyyMMdd").format(new Date()) + "/" + newFileName;
            //获得文件对象，参数1：文件上传的路径，参数2：文件名称（包括文件夹）
            File path = new File(SystemConstant.UPLOADPATH + SystemConstant.FOODPATH, finalPath);
            if (!path.getParentFile().exists()) {
                //如果文件夹不存在，就创建文件夹
                path.getParentFile().mkdirs();
            }
            try {
                //将文件保存到磁盘中
                foodImage.transferTo(path);
                /*
                 * 严格按照LayUI规定传递所必须的参数
                 */
                map.put("code", 0);
                map.put("msg", "文件上传成功");
                Map<String, Object> dataMap = new HashMap<>(16);
                //图片路径
                dataMap.put("src", "/sudi/upload/food/" + finalPath);
                //鼠标悬停时显示的文本
                dataMap.put("title", newFileName);
                //保存图片路径，不包括前面的文件夹，从模块文件夹起始
                dataMap.put("imagePath", SystemConstant.FOODPATH + finalPath);
                map.put("data", dataMap);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return map;
    }

    /**
     * 添加菜品SPU信息
     * @param vo
     * @param foodParamList
     * @param session
     * @return
     */
    @Override
    public Map<String, Object> addFood(FoodVo vo, List<Map<String, Object>> foodParamList, HttpSession session, JSONObject json) {
        Map<String, Object> map = new HashMap<>(16);
        vo.setLastModifyBy(((UserEntity) session.getAttribute(SystemConstant.USERLOGIN)).getUsername());
        if (foodMapper.addFood(vo) > 0) {
            Long foodId = vo.getFoodId();
            //调用生成菜品SKU的方法
            if (this.generateSku(foodParamList, foodId, vo.getFoodName())) {
                map.put(SystemConstant.FLAG, true);
                map.put(SystemConstant.MESSAGE, "新增菜品SPU信息成功，请尽快完善该菜品的SKU信息");
            }else {
                map.put(SystemConstant.FLAG, false);
                map.put(SystemConstant.MESSAGE, "新增菜品SPU信息失败!");
            }
        }else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "新增菜品SPU信息失败");
        }
        return map;
    }

    /**
     * 生成菜品规格信息和SKU信息
     * @param foodParamList
     * @param foodId
     * @return
     */
    @Override
    public boolean generateSku(List<Map<String, Object>> foodParamList, Long foodId, String foodName) {
        try{
            //生成一个二维数组
            String[][] foodattrArr = new String[foodParamList.size()][];
            for (int i = 0; i < foodParamList.size(); i++) {
                //将Map映射转换成json字符串
                String json = JSON.toJSONString(foodParamList.get(i), true);
                Long attrId = Long.parseLong(foodParamList.get(i).get("attrId").toString());
                //将json数组转换成List集合
                List<String> foodvalueList = JSON.parseArray(JSON.parseObject(json).getString("foodvalueArr"), String.class);
                foodattrArr[i] = new String[foodvalueList.size()];
                for (String foodvalueName : foodvalueList) {
                    //将菜品规格添加到规格表中
                    String name = ((String) JSONObject.parseObject(foodvalueName).get("foodvalueName"));
                    foodvalueMapper.addFoodvalue(foodId, attrId, name);
                    foodattrArr[i][foodvalueList.indexOf(foodvalueName)] = name;
                }
            }
            //遍历二维数组，拼接SKU名称，生成菜品SKU信息
            List<StringBuilder> skuName = new ArrayList<>();
            List<StringBuilder> skuNameList = FoodSkuUtil.buildSku(foodattrArr, foodName, skuName);
            for (StringBuilder sb : skuNameList) {
                foodSkuMapper.addFoodSku(sb.toString(), foodId);
            }
            return true;
        }catch (Exception e) {
            return false;
        }
    }

    /**
     * 修改菜品SPU信息
     * @param vo
     * @param session
     * @return
     */
    @Override
    public Map<String, Object> modifyFood(FoodVo vo, HttpSession session) {
        Map<String, Object> map = new HashMap<>(16);
        vo.setLastModifyBy(((UserEntity) session.getAttribute(SystemConstant.USERLOGIN)).getUsername());
        if (foodMapper.modifyFood(vo) > 0) {
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "菜品SPU信息修改成功");
        }else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "菜品SPU信息修改失败");
        }
        return map;
    }

    /**
     * 菜品上架
     * @param foodId
     * @param session
     * @return
     */
    @Override
    public Map<String, Object> onShelf(Long foodId, HttpSession session) {
        Map<String, Object> map = new HashMap<>(16);
        String username = ((UserEntity) session.getAttribute(SystemConstant.USERLOGIN)).getUsername();
        //判断查看该菜品的SKU信息是否均完成，未完成的不允许上架
        if (foodSkuMapper.findFoodSkuIsNull(foodId) == 0) {
            //菜品上架
            if (foodMapper.foodOnShelf(foodId, username) > 0) {
                map.put(SystemConstant.FLAG, true);
                map.put(SystemConstant.MESSAGE, "菜品上架成功");
            }else {
                map.put(SystemConstant.FLAG, false);
                map.put(SystemConstant.MESSAGE, "菜品上架失败");
            }
        }else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "菜品上架失败，该菜品下仍有SKU信息未完善");
        }
        return map;
    }

    /**
     * 删除菜品SPU以及SKU信息
     * @param foodId
     * @return
     */
    @Override
    public Map<String, Object> delete(Long foodId) {
        Map<String, Object> map = new HashMap<>(16);
        //先要删除菜品的规格值
        if (foodvalueMapper.deleteFoodvalueByFoodId(foodId)>0
                && foodSkuMapper.deleteFoodSkuByFoodId(foodId)>0
                && foodMapper.deleteFood(foodId)>0) {
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "菜品SPU信息以及所有SKU信息删除成功");
        }else {
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "菜品信息删除失败");
        }
        return map;
    }

    /**
     * 菜品下架
     * @param foodId
     * @param session
     * @return
     */
    @Override
    public Map<String, Object> offShelf(Long foodId, HttpSession session) {
        Map<String, Object> map = new HashMap<>(16);
        String username = ((UserEntity) session.getAttribute(SystemConstant.USERLOGIN)).getUsername();
        if (foodMapper.foodOffShelf(foodId, username) > 0) {
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "菜品下架成功");
        }else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "菜品下架失败");
        }
        return map;
    }

    /**
     * 根据菜品类别编号查找对应的菜品
     * @param typeId
     * @return
     */
    @Override
    public Map<String, Object> findFoodByTypeId(Long typeId) {
        Map<String, Object> map = new HashMap<>(16);
        List<FoodEntity> foodByTypeId = foodMapper.findFoodByTypeId(typeId);
        if (foodByTypeId!=null && !foodByTypeId.isEmpty()) {
            map.put("code", 1);
            map.put("foodList", foodByTypeId);
        }else {
            map.put("code", 2);
        }
        return map;
    }

    /**
     * 查找所有上架类别
     * @return
     */
    @Override
    public List<FoodTypeEntity> findFoodType() {
        List<FoodTypeEntity> foodtypeList = foodTypeMapper.findAllFoodtypeOnShelf();
        return foodtypeList;
    }

    /**
     * 根据类别ID查询上架菜品
     * @param typeId
     * @return
     */
    @Override
    public List<FoodEntity> findOnshelfFoodByType(Long typeId) {
        List<FoodEntity> foodByType = foodMapper.findOnshelfFoodByType(typeId);
        return foodByType;
    }

    /**
     * 根据菜品编号查询该菜品的所有信息
     * @param foodId
     * @return
     */
    @Override
    public Map<String, Object> findFoodInfoById(Long foodId) {
        Map<String, Object> map = new HashMap<>(16);
        //该菜品浏览量+1
        foodMapper.addViewCountOne(foodId);
        List<FoodvalueEntity> foodvalueList = foodvalueMapper.findFoodvalueListByFoodId(foodId);
        map.put("foodvalueList", foodvalueList);
        List<FoodSkuEntity> foodSkuList = foodSkuMapper.findFoodSkuListByFoodId(foodId);
        map.put("foodSkuList", foodSkuList);
        FoodEntity foodSpu = foodMapper.findFoodById(foodId);
        map.put("foodSpu", foodSpu);
        return map;
    }

    /**
     * 查询所有上架的推荐和热销菜品
     * @return
     */
    @Override
    public Map<String, Object> findRecommendAndHotSaleFood() {
        Map<String, Object> map = new HashMap<>(16);
        List<FoodEntity> recommendFoodOnShelf = foodMapper.findRecommendFoodOnShelf();
        List<FoodEntity> hotSaleFoodOnShelf = foodMapper.findHotSaleFoodOnShelf();
        if (hotSaleFoodOnShelf!=null && recommendFoodOnShelf!=null){
            map.put(SystemConstant.FLAG, true);
            map.put("recommendFoodList", recommendFoodOnShelf);
            map.put("hotSaleFoodList", hotSaleFoodOnShelf);
        }else {
            map.put(SystemConstant.FLAG, false);
        }
        return map;
    }
}
