package edu.jmu.sudi.service;

import edu.jmu.sudi.utils.LayuiTableDataResult;
import edu.jmu.sudi.vo.RoleVo;

import javax.servlet.http.HttpSession;
import java.util.Map;

public interface RoleService {

    /**
     * 根据页面的条件查询角色列表
     * @param vo
     * @return
     */
    public LayuiTableDataResult findRoleListByPage(RoleVo vo);

    /**
     * 添加角色
     * @param vo
     * @param session
     * @return
     */
    public Map<String, Object> addRole(RoleVo vo, HttpSession session);

    /**
     * 编辑角色信息
     * @param vo
     * @param session
     * @return
     */
    public Map<String, Object> modifyRole(RoleVo vo, HttpSession session);

    /**
     * 初始化该角色的菜单列表
     * @param roleId
     * @return
     */
    public LayuiTableDataResult initRoleMenu(Long roleId);

    /**
     * 对该角色的菜单权限进行授权
     * @param menuIds
     * @param roleId
     * @return
     */
    public Map<String, Object> grantMenu(String menuIds, Long roleId);

    /**
     * 删除角色
     * @param roleId
     * @return
     */
    public Map<String, Object> deleteRole(Long roleId);
}
