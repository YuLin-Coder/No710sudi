package edu.jmu.sudi.controller.menu;

import com.alibaba.fastjson.JSON;
import edu.jmu.sudi.service.MenuService;
import edu.jmu.sudi.utils.LayuiTableDataResult;
import edu.jmu.sudi.vo.MenuVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.io.Serializable;
import java.util.Map;

@RestController
@RequestMapping("/backstage/menu")
public class MenuManageController {

    @Autowired
    private MenuService menuService;

    /**
     * 查询左侧菜单栏导航列表
     * @return
     */
    @RequestMapping("/loadMenuList")
    public String loadMenuList(HttpServletRequest request){
        Map<String, Object> initJson = menuService.loadMenuList(request);
        return JSON.toJSONString(initJson);
    }

    /**
     * 加载菜单管理左侧菜单树
     * @return
     */
    @RequestMapping("/loadLeftMenuTree")
    public String loadLeftMenuTree(){
        LayuiTableDataResult layuiTableDataResult = menuService.loadMenuTree();
        return JSON.toJSONString(layuiTableDataResult);
    }

    /**
     * 加载菜单管理右侧表格
     * @return
     */
    @RequestMapping("/loadRightMenuTable")
    public String loadRightMenuTree(MenuVo vo){
        LayuiTableDataResult layuiTableDataResult = menuService.loadMenuTable(vo);
        return JSON.toJSONString(layuiTableDataResult);
    }

    /**
     * 新增菜单
     * @param vo
     * @return
     */
    @RequestMapping("/add")
    public String addMenu(MenuVo vo){
        Map<String, Object> map = menuService.addMenu(vo);
        return JSON.toJSONString(map);
    }

    /**
     * 修改菜单
     * @param vo
     * @return
     */
    @RequestMapping("/modify")
    public String modifyMenu(MenuVo vo){
        Map<String, Object> map = menuService.modifyMenu(vo);
        return JSON.toJSONString(map);
    }

    /**
     * 删除菜单
     * @param menuId
     * @return
     */
    @RequestMapping("/delete")
    public String deleteMenu(Integer menuId){
        Map<String, Object> map = menuService.deleteMenu(menuId);
        return JSON.toJSONString(map);
    }
}
