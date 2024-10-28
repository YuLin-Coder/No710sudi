package edu.jmu.sudi.controller.role;

import com.alibaba.fastjson.JSON;
import edu.jmu.sudi.service.RoleService;
import edu.jmu.sudi.utils.LayuiTableDataResult;
import edu.jmu.sudi.vo.RoleVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.Map;

@RestController
@RequestMapping("/backstage/role")
public class RoleManageController {

    @Autowired
    private RoleService roleService;

    /**
     * 根据页面的条件查询角色列表
     * @param vo
     * @return
     */
    @RequestMapping("/list")
    public String findRoleListByPage(RoleVo vo){
        LayuiTableDataResult roleListByPage = roleService.findRoleListByPage(vo);
        return JSON.toJSONString(roleListByPage);
    }

    /**
     * 添加角色
     * @param vo
     * @param session
     * @return
     */
    @RequestMapping("/add")
    public String addRole(RoleVo vo, HttpSession session){
        Map<String, Object> map = roleService.addRole(vo, session);
        return JSON.toJSONString(map);
    }

    /**
     * 编辑角色信息
     * @param vo
     * @param session
     * @return
     */
    @RequestMapping("/modify")
    public String modifyRole(RoleVo vo, HttpSession session){
        Map<String, Object> map = roleService.modifyRole(vo, session);
        return JSON.toJSONString(map);
    }

    /**
     * 初始化该角色的菜单列表
     * @param roleId
     * @return
     */
    @RequestMapping("/initRoleMenu")
    public String initRoleMenu(Long roleId){
        LayuiTableDataResult layuiTableDataResult = roleService.initRoleMenu(roleId);
        return JSON.toJSONString(layuiTableDataResult);
    }

    /**
     * 对该角色的菜单权限进行授权
     * @param menuIds
     * @param roleId
     * @return
     */
    @RequestMapping("/grantMenu")
    public String grantMenu(String menuIds, Long roleId){
        Map<String, Object> map = roleService.grantMenu(menuIds, roleId);
        return JSON.toJSONString(map);
    }

    /**
     * 删除角色
     * @param roleId
     * @return
     */
    @RequestMapping("/delete")
    public String deleteRole(Long roleId){
        Map<String, Object> map = roleService.deleteRole(roleId);
        return JSON.toJSONString(map);
    }
}
