package edu.jmu.sudi.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import edu.jmu.sudi.dao.MenuMapper;
import edu.jmu.sudi.dao.RoleMapper;
import edu.jmu.sudi.entity.MenuEntity;
import edu.jmu.sudi.entity.RoleEntity;
import edu.jmu.sudi.entity.UserEntity;
import edu.jmu.sudi.service.RoleService;
import edu.jmu.sudi.utils.LayuiTableDataResult;
import edu.jmu.sudi.utils.SystemConstant;
import edu.jmu.sudi.utils.TreeNode;
import edu.jmu.sudi.vo.RoleVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleMapper roleMapper;

    @Autowired
    private MenuMapper menuMapper;

    /**
     * 根据页面的条件查询角色列表
     * @param vo
     * @return
     */
    @Override
    public LayuiTableDataResult findRoleListByPage(RoleVo vo) {
        //设置分页信息
        PageHelper.startPage(vo.getPage(), vo.getLimit());
        //调用分页查询的方法
        List<RoleEntity> roleListByPage = roleMapper.findRoleListByPage(vo);
        //创建分页对象，将查询到的数据放进去
        PageInfo<RoleEntity> pageInfo = new PageInfo<>(roleListByPage);
        //返回数据
        return new LayuiTableDataResult(pageInfo.getTotal(), pageInfo.getList());
    }

    /**
     * 添加角色
     * @param vo
     * @param session
     * @return
     */
    @Override
    public Map<String, Object> addRole(RoleVo vo, HttpSession session) {
        Map<String, Object> map = new HashMap<>(16);
        //获取当前登录用户信息
        UserEntity userLogin = (UserEntity) session.getAttribute(SystemConstant.USERLOGIN);
        vo.setLastModifyBy(userLogin.getUsername());
        if (roleMapper.addRole(vo) >= 1) {
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "新增角色【" + vo.getRoleName() + "】成功");
        }else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "【" + vo.getRoleName() + "】角色新增失败");
        }
        return map;
    }

    /**
     * 编辑角色信息
     * @param vo
     * @param session
     * @return
     */
    @Override
    public Map<String, Object> modifyRole(RoleVo vo, HttpSession session) {
        Map<String, Object> map = new HashMap<>(16);
        String username = ((UserEntity) session.getAttribute(SystemConstant.USERLOGIN)).getUsername();
        vo.setLastModifyBy(username);
        if (roleMapper.modifyRole(vo) >= 1) {
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "角色【" + vo.getRoleName() + "】信息修改成功");
        }else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "角色【" + vo.getRoleName() + "】信息修改失败");
        }
        return map;
    }

    /**
     * 初始化该角色的菜单列表
     * @param roleId
     * @return
     */
    @Override
    public LayuiTableDataResult initRoleMenu(Long roleId) {
        //调用查询所有菜单列表的方法，得到菜单的list集合
        List<MenuEntity> menuList = menuMapper.findMenuList();
        //查找该角色具有的菜单
        List<MenuEntity> menuIdListByRoleId = menuMapper.findMenuIdListByRoleId(roleId);
        //创建一个初始化的树节点集合
        List<TreeNode> treeNodes = new ArrayList<>();
        //遍历所有的菜单列表
        for (MenuEntity menu : menuList) {
            //判断一下是否需要展开
            Boolean spread = (menu.getSpread() == null || menu.getSpread()==1) ? true : false;
            TreeNode treeNode = new TreeNode(menu.getId(), menu.getPid(), menu.getTitle(), spread);
            //遍历角色拥有的菜单列表
            for (MenuEntity menu1 : menuIdListByRoleId) {
                //判断当角色的菜单中
                if (menu.getId().equals(menu1.getId())){
                    //如果拥有的菜单中存在，就修改状态为选中，状态码为1
                    treeNode.setCheckArr("1");
                }
            }
            //将menu对象添加到集合中去
            treeNodes.add(treeNode);
        }
        return new LayuiTableDataResult(treeNodes);
    }

    /**
     * 对该角色的菜单权限进行授权
     * @param menuIds
     * @param roleId
     * @return
     */
    @Override
    public Map<String, Object> grantMenu(String menuIds, Long roleId) {
        Map<String, Object> map = new HashMap<>(16);
        try {
            //将菜单ID拆分出来
            String[] menuIdArr = menuIds.split(",");
            //删除该角色的所有已有菜单权限
            roleMapper.deleteAllMenuByRoleId(roleId);
            for (String menuId : menuIdArr) {
                //对角色进行菜单授权
                roleMapper.grantMenu(roleId, Integer.parseInt(menuId));
            }
            map.put(SystemConstant.MESSAGE, "角色菜单关系授权成功");
        } catch (Exception e) {
            map.put(SystemConstant.MESSAGE, "角色菜单关系授权失败");
        }
        return map;
    }

    /**
     * 删除角色
     * @param roleId
     * @return
     */
    @Override
    public Map<String, Object> deleteRole(Long roleId) {
        Map<String, Object> map = new HashMap<>(16);
        //判断角色下是否还有用户，有的话不准删除
        if (roleMapper.countUserByRoleId(roleId) == 0){
            //删除该角色的所有菜单授权
            roleMapper.deleteAllMenuByRoleId(roleId);
            //删除该角色
            if (roleMapper.deleteRole(roleId) >= 1){
                map.put(SystemConstant.FLAG, true);
                map.put(SystemConstant.MESSAGE, "角色删除成功");
                return map;
            }
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "角色删除失败");
        }else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "仍有用户使用该角色，角色删除失败");
        }
        return map;
    }


}
