package edu.jmu.sudi.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import edu.jmu.sudi.dao.FoodattrMapper;
import edu.jmu.sudi.dao.FoodvalueMapper;
import edu.jmu.sudi.entity.FoodattrEntity;
import edu.jmu.sudi.service.FoodattrService;
import edu.jmu.sudi.utils.LayuiTableDataResult;
import edu.jmu.sudi.utils.SystemConstant;
import edu.jmu.sudi.vo.FoodattrVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 菜品规格组服务层实现类
 * @author LiangJie
 */
@Service
@Transactional
public class FoodattrServiceImpl implements FoodattrService {

    @Autowired
    private FoodattrMapper foodattrMapper;

    @Autowired
    private FoodvalueMapper foodvalueMapper;

    /**
     * 根据页面返回信息查找符合条件的菜品规格组集合
     * @param vo
     * @return
     */
    @Override
    public LayuiTableDataResult findFoodattrListByPage(FoodattrVo vo) {
        PageHelper.startPage(vo.getPage(), vo.getLimit());
        List<FoodattrEntity> foodattrListByPage = foodattrMapper.findFoodattrListByPage(vo);
        PageInfo<FoodattrEntity> pageInfo = new PageInfo<>(foodattrListByPage);
        return new LayuiTableDataResult(pageInfo.getTotal(), pageInfo.getList());
    }

    /**
     * 添加菜品规格组
     * @param vo
     * @return
     */
    @Override
    public Map<String, Object> addFoodattr(FoodattrVo vo) {
        Map<String, Object> map = new HashMap<>(16);
        if (foodattrMapper.addFoodattr(vo) > 0) {
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "新增菜品规格组成功");
        }else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "新增菜品规格组失败");
        }
        return map;
    }

    /**
     * 修改菜品规格组
     * @param vo
     * @return
     */
    @Override
    public Map<String, Object> modifyFoodattr(FoodattrVo vo) {
        Map<String, Object> map = new HashMap<>(16);
        if (foodattrMapper.modifyFoodattr(vo) > 0) {
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "菜品规格组信息修改成功");
        }else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "菜品规格组信息修改失败");
        }
        return map;
    }

    /**
     * 删除菜品规格组
     * @param vo
     * @return
     */
    @Override
    public Map<String, Object> deleteFoodattr(FoodattrVo vo) {
        Map<String, Object> map = new HashMap<>(16);
        //判断是否有规格正在使用该规格组，有的话不允许删除
        if (foodvalueMapper.findCountByFoodattrId(vo.getFoodattrId()) > 0) {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "该规格组下还存在规格，删除失败");
        }else {
            if (foodattrMapper.deleteFoodattr(vo) > 0) {
                map.put(SystemConstant.FLAG, true);
                map.put(SystemConstant.MESSAGE, "删除规格组成功");
            }else {
                map.put(SystemConstant.FLAG, false);
                map.put(SystemConstant.MESSAGE, "删除规格组失败");
            }
        }
        return map;
    }

    /**
     * 查询所有的菜品类别
     * @return
     */
    @Override
    public Map<String, Object> findAllFoodattr() {
        Map<String, Object> map = new HashMap<>(16);
        List<FoodattrEntity> foodattrList = foodattrMapper.findAllFoodattr();
        if (foodattrList != null) {
            map.put("code", 1);
        }else {
            map.put("code", 2);
        }
        map.put("foodattrList", foodattrList);
        return map;
    }


}
