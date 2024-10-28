package edu.jmu.sudi.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import edu.jmu.sudi.dao.FoodTypeMapper;
import edu.jmu.sudi.entity.FoodTypeEntity;
import edu.jmu.sudi.entity.UserEntity;
import edu.jmu.sudi.service.FoodTypeService;
import edu.jmu.sudi.utils.FileUploadUtil;
import edu.jmu.sudi.utils.LayuiTableDataResult;
import edu.jmu.sudi.utils.SystemConstant;
import edu.jmu.sudi.vo.FoodTypeVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 菜品类别服务层实现类
 * @author LiangJie
 */
@Service
@Transactional
public class FoodTypeServiceImpl implements FoodTypeService {

    @Autowired
    private FoodTypeMapper foodTypeMapper;

    /**
     * 根据页面返回信息查找符合条件的菜品类别集合
     * @param vo
     * @return
     */
    @Override
    public LayuiTableDataResult findFoodTypeListByPage(FoodTypeVo vo) {
        PageHelper.startPage(vo.getPage(), vo.getLimit());
        List<FoodTypeEntity> foodTypeList = foodTypeMapper.findFoodTypeListByPage(vo);
        PageInfo<FoodTypeEntity> pageInfo = new PageInfo<>(foodTypeList);
        return new LayuiTableDataResult(pageInfo.getTotal(), pageInfo.getList());
    }

    /**
     * 菜品类别文件上传
     * @param foodtypeImage
     * @return
     */
    @Override
    public Map<String, Object> uploadFile(MultipartFile foodtypeImage) {
        //用于存储LayUI文件上传所必须的键值
        Map<String, Object> map = new HashMap<>();
        //判断一下文件是否为空
        if (!foodtypeImage.isEmpty()) {
            //将文件重命名
            String newFileName = FileUploadUtil.rename(foodtypeImage);
            //全部文件都放在一个文件夹下不好管理，所以以日期作为文件夹进行管理
            //组装路径
            String finalPath = new SimpleDateFormat("yyyyMMdd").format(new Date()) + "/" + newFileName;
            //获得文件对象，参数1：文件上传的路径，参数2：文件名称（包括文件夹）
            File path = new File(SystemConstant.UPLOADPATH + SystemConstant.FOODTYPEPATH, finalPath);
            if (!path.getParentFile().exists()) {
                //如果文件夹不存在，就创建文件夹
                path.getParentFile().mkdirs();
            }
            try {
                //将文件保存到磁盘中
                foodtypeImage.transferTo(path);
                /*
                 * 严格按照LayUI规定传递所必须的参数
                 */
                map.put("code", 0);
                map.put("msg", "文件上传成功");
                Map<String, Object> dataMap = new HashMap<>(16);
                //图片路径
                dataMap.put("src", "/sudi/upload/foodtype/" + finalPath);
                //鼠标悬停时显示的文本
                dataMap.put("title", newFileName);
                //保存图片路径，不包括前面的文件夹，从模块文件夹起始
                dataMap.put("imagePath", SystemConstant.FOODTYPEPATH + finalPath);
                map.put("data", dataMap);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return map;
    }

    /**
     * 添加菜品类别
     * @param vo
     * @param session
     * @return
     */
    @Override
    public Map<String, Object> addFoodtype(FoodTypeVo vo, HttpSession session) {
        Map<String, Object> map = new HashMap<>(16);
        String username = ((UserEntity) session.getAttribute(SystemConstant.USERLOGIN)).getUsername();
        vo.setLastModifyBy(username);
        if (foodTypeMapper.addFoodtype(vo) > 0){
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "新增菜品类别成功");
        }else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "新增菜品类别失败");
        }
        return map;
    }

    /**
     * 编辑菜品类别
     * @param vo
     * @param session
     * @return
     */
    @Override
    public Map<String, Object> modifyFoodtype(FoodTypeVo vo, HttpSession session) {
        Map<String, Object> map = new HashMap<>(16);
        String username = ((UserEntity) session.getAttribute(SystemConstant.USERLOGIN)).getUsername();
        vo.setLastModifyBy(username);
        if (foodTypeMapper.modifyFoodtype(vo) > 0){
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "编辑菜品类别成功");
        }else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "编辑菜品类别失败");
        }
        return map;
    }

    /**
     * 菜品类别下架
     * @param typeId
     * @param session
     * @return
     */
    @Override
    public Map<String, Object> offShelfFoodtype(Long typeId, HttpSession session) {
        Map<String, Object> map = new HashMap<>(16);
        String username = ((UserEntity) session.getAttribute(SystemConstant.USERLOGIN)).getUsername();
        if (foodTypeMapper.offShelfFoodtype(typeId, username) > 0){
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "菜品类别下架成功");
        }else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "菜品类别下架失败");
        }
        return map;
    }

    /**
     * 菜品类别恢复上架
     * @param typeId
     * @param session
     * @return
     */
    @Override
    public Map<String, Object> onShelfFoodtype(Long typeId, HttpSession session) {
        Map<String, Object> map = new HashMap<>(16);
        String username = ((UserEntity) session.getAttribute(SystemConstant.USERLOGIN)).getUsername();
        if (foodTypeMapper.onShelfFoodtype(typeId, username) > 0){
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "恢复菜品类别上架成功");
        }else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "恢复菜品类别上架失败");
        }
        return map;
    }

    /**
     * 查询所有的菜品类别
     * @return
     */
    @Override
    public Map<String, Object> findAllFoodtype() {
        Map<String, Object> map = new HashMap<>(16);
        List<FoodTypeEntity> foodtypeList = foodTypeMapper.findAllFoodtype();
        if (foodtypeList != null){
            map.put("code", 1);
        }else {
            map.put("code", 2);
        }
        map.put("foodtypeList", foodtypeList);
        return map;
    }
}
