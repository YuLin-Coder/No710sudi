package edu.jmu.sudi.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import edu.jmu.sudi.dao.FoodMapper;
import edu.jmu.sudi.dao.FoodSkuMapper;
import edu.jmu.sudi.dao.FoodvalueMapper;
import edu.jmu.sudi.entity.FoodSkuEntity;
import edu.jmu.sudi.service.FoodSkuService;
import edu.jmu.sudi.utils.LayuiTableDataResult;
import edu.jmu.sudi.utils.SystemConstant;
import edu.jmu.sudi.vo.FoodSkuVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 菜品SKU服务岑实现类
 * @author LiangJie
 */
@Service
@Transactional
public class FoodSkuServiceImpl implements FoodSkuService {

    @Autowired
    private FoodSkuMapper foodSkuMapper;
    @Autowired
    private FoodMapper foodMapper;
    @Autowired
    private FoodvalueMapper foodvalueMapper;

    /**
     * 根据页面的信息查询菜品SKU集合
     * @param vo
     * @return
     */
    @Override
    public LayuiTableDataResult findFoodSkuListByPage(FoodSkuVo vo) {
        PageHelper.startPage(vo.getPage(), vo.getLimit());
        List<FoodSkuEntity> foodSkuListByPage = foodSkuMapper.findFoodSkuListByPage(vo);
        PageInfo<FoodSkuEntity> pageInfo = new PageInfo<>(foodSkuListByPage);
        return new LayuiTableDataResult(pageInfo.getTotal(), pageInfo.getList());
    }

    /**
     * 新增菜品SKU
     * @param vo
     * @return
     */
    @Override
    public Map<String, Object> addFoodSku(FoodSkuVo vo) {
        Map<String, Object> map = new HashMap<>(16);
        //先新增菜品规格
        Long foodattrId = foodvalueMapper.findFoodattrIdByFoodId(vo.getFoodId());
        Integer result1 = foodvalueMapper.addFoodvalue(vo.getFoodId(), foodattrId, vo.getSkuName());
        //对菜品规格名进行拼接形成sku名
        String foodName = foodMapper.findFoodById(vo.getFoodId()).getFoodName();
        StringBuilder sb = new StringBuilder(foodName).append("(").append(vo.getSkuName()).append(")");
        vo.setSkuName(sb.toString());
        //新增SKU
        Integer result2 = foodSkuMapper.addFoodSkuBySkuManage(vo);
        if (result1>0 && result2>0) {
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "新增菜品SKU信息成功");
        }else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "新增菜品SKU信息失败");
        }
        return map;
    }

    /**
     * 修改菜品SKU
     * @param vo
     * @return
     */
    @Override
    public Map<String, Object> modifyFoodSku(FoodSkuVo vo) {
        Map<String, Object> map = new HashMap<>(16);
        if (foodSkuMapper.modifyFoodSku(vo) > 0) {
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "修改菜品SKU信息成功");
        }else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "修改菜品SKU信息失败");
        }
        return map;
    }

    /**
     * 删除菜品SKU
     * @param skuId
     * @param skuName
     * @param foodId
     * @return
     */
    @Override
    public Map<String, Object> deleteFoodSku(Long skuId, String skuName, Long foodId) {
        Map<String, Object> map = new HashMap<>(16);
        //拆解skuName得到foodvalueName
        String foodvalueName = skuName.split("[(]")[1];
        foodvalueName = foodvalueName.substring(0,foodvalueName.length() - 1);
        //删除foodvalue和sku记录
        if (foodSkuMapper.deleteFoodSku(skuId)>0 && foodvalueMapper.deleteFoodvalue(foodId, foodvalueName)>0) {
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "菜品SKU信息删除成功");
        }else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "菜品SKU信息删除失败");
        }
        return map;
    }

}
