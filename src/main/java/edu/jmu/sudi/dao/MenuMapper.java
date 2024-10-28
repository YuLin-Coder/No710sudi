package edu.jmu.sudi.dao;

import edu.jmu.sudi.entity.MenuEntity;
import edu.jmu.sudi.vo.MenuVo;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MenuMapper {

    /**
     * 查询所有菜单列表
     * @return
     */
    public List<MenuEntity> findMenuList();

    /**
     * 根据用户Id查询其菜单列表
     * @param userId
     * @return
     */
    public List<MenuEntity> findMenuListByUserId(Long userId);

    /**
     * 根绝页面条件查询菜单列表
     * @param vo
     * @return
     */
    public List<MenuEntity> findMenuListByPage(MenuVo vo);

    /**
     * 新增菜单
     * @param vo
     * @return
     */
    public Integer addMenu(MenuVo vo);

    /**
     * 修改菜单
     * @param vo
     * @return
     */
    public Integer modifyMenu(MenuVo vo);

    /**
     * 查询该角色拥有的菜单列表
     * @param roleId
     * @return
     */
    public List<MenuEntity> findMenuIdListByRoleId(Long roleId);

    /**
     * 查询该菜单有多少用户在用
     * @param menuId
     * @return
     */
    public Integer countRoleByMenuId(Integer menuId);

    /**
     * 删除菜单
     * @param menuId
     * @return
     */
    public Integer deleteMenu(Integer menuId);

}
