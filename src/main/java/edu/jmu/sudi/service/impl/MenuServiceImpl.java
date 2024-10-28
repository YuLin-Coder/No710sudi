package edu.jmu.sudi.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import edu.jmu.sudi.dao.MenuMapper;
import edu.jmu.sudi.entity.MenuEntity;
import edu.jmu.sudi.entity.UserEntity;
import edu.jmu.sudi.service.MenuService;
import edu.jmu.sudi.utils.*;
import edu.jmu.sudi.vo.MenuVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.awt.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
@Transactional
public class MenuServiceImpl implements MenuService {

    @Autowired
    private MenuMapper menuMapper;

    /**
     * 加载左侧导航的菜单栏列表
     * @return
     */
    @Override
    public Map<String, Object> loadMenuList(HttpServletRequest request) {
        //创建两个个Map集合分别对应init.json模板中的logoInfo和homeInfo
        Map<String, Object> homeInfo = new HashMap<>(16);
        Map<String, Object> logoInfo = new HashMap<>(16);
        //创建一个总的map去存放三个map
        Map<String, Object> initJson = new HashMap<>(16);

        //得到userId
        Long userId = ((UserEntity) request.getSession().getAttribute(SystemConstant.USERLOGIN)).getUserId();
        //调用根据用户Id查询其菜单列表的方法，得到菜单的list集合
        List<MenuEntity> menuList = menuMapper.findMenuListByUserId(userId);

        //创建一个List集合去保存菜单的节点
        List<MenuNode> menuNodeList = new ArrayList<>();
        //遍历循环菜单列表，目的是创建菜单之间的层级关系（一级菜单、二级菜单...）
        for (MenuEntity menu : menuList) {
            //创建一个节点工具类对象
            MenuNode menuNode = new MenuNode();
            menuNode.setId(menu.getId());
            menuNode.setPid(menu.getPid());
            menuNode.setTitle(menu.getTitle());
            menuNode.setHref(menu.getHref());
            menuNode.setSpread(menu.getSpread());
            menuNode.setIcon(menu.getIcon());
            //将节点添加到List集合中去
            menuNodeList.add(menuNode);
        }
        //将homeInfo的数据填入对应Map中
        homeInfo.put("title", "首页");
        homeInfo.put("href", request.getContextPath() + "/desktop.html");
        //将logoInfo的数据填入对应Map中
        logoInfo.put("title", "宿递 · SUDI");
        logoInfo.put("image", request.getContextPath() + "/static/plugins/layui/images/sudilogo.png");
        logoInfo.put("href", request.getContextPath() + "/index.html");
        //将所有的数据全部添加到总的Map映射中去
        initJson.put("homeInfo", homeInfo);
        initJson.put("logoInfo", logoInfo);
        //将菜单节点层级关系的List集合转换为Map集合，第二个参数表示最高父级，写0就ok
        initJson.put("menuInfo", TreeUtil.toTree(menuNodeList, 0));
        return initJson;
    }

    /**
     * 加载菜单树
     * @return
     */
    @Override
    public LayuiTableDataResult loadMenuTree() {
        //调用查询所有菜单列表的方法，得到菜单的list集合
        List<MenuEntity> menuList = menuMapper.findMenuList();
        //创建集合保存节点信息
        List<TreeNode> treeNodes = new ArrayList<>();
        //循环遍历菜单列表集合
        for (MenuEntity menu : menuList) {
            Boolean spread = (menu.getSpread()==null || menu.getSpread()==1) ? true : false;
            treeNodes.add(new TreeNode(menu.getId(), menu.getPid(), menu.getTitle(), spread));
        }
        return new LayuiTableDataResult(treeNodes);
    }

    /**
     * 加载菜单表格
     * @return
     */
    @Override
    public LayuiTableDataResult loadMenuTable(MenuVo vo) {
        //设置分页信息
        PageHelper.startPage(vo.getPage(), vo.getLimit());
        //调用分页查询的方法
        List<MenuEntity> menuList = menuMapper.findMenuListByPage(vo);
        //创建分页对象，将查询到的数据放进去
        PageInfo<MenuEntity> pageInfo = new PageInfo<>(menuList);
        return new LayuiTableDataResult(pageInfo.getTotal(), pageInfo.getList());
    }

    /**
     * 新增菜单
     * @param vo
     * @return
     */
    @Override
    public Map<String, Object> addMenu(MenuVo vo) {
        Map<String, Object> map = new HashMap<>(16);
        if (menuMapper.addMenu(vo) >= 1){
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "【" + vo.getTitle() + "】菜单新增成功");
        } else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "【" + vo.getTitle() + "】菜单新增失败");
        }
        return map;
    }

    /**
     * 修改菜单
     * @param vo
     * @return
     */
    @Override
    public Map<String, Object> modifyMenu(MenuVo vo) {
        Map<String, Object> map = new HashMap<>(16);
        //不可以父级菜单就是本身，直接返回修改错误
        if (vo.getPid().equals(vo.getId())){
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "修改菜单失败，您不可以选择本身作为父级菜单");
            return map;
        }
        if (menuMapper.modifyMenu(vo) >= 1){
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "【" + vo.getTitle() + "】菜单信息修改成功");
        } else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "【" + vo.getTitle() + "】菜单信息修改失败");
        }
        return map;
    }

    /**
     * 删除菜单
     * @param menuId
     * @return
     */
    @Override
    public Map<String, Object> deleteMenu(Integer menuId) {
        Map<String, Object> map = new HashMap<>(16);
        //删除菜单前先查询是否还有角色仍有使用该菜单的权限
        if (menuMapper.countRoleByMenuId(menuId) == 0){
            //删除菜单
            menuMapper.deleteMenu(menuId);
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "菜单删除成功");
        }else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "仍有角色拥有该菜单的使用权限，删除失败");
        }
        return map;
    }

}
