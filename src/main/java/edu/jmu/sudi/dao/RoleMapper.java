package edu.jmu.sudi.dao;

import edu.jmu.sudi.entity.RoleEntity;
import edu.jmu.sudi.vo.RoleVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface RoleMapper {

    /**
     * 根据页面的条件查询角色列表
     * @param vo
     * @return
     */
    public List<RoleEntity> findRoleListByPage(RoleVo vo);

    /**
     * 添加角色
     * @param vo
     * @return
     */
    public Integer addRole(RoleVo vo);

    /**
     * 编辑角色信息
     * @param vo
     * @return
     */
    public Integer modifyRole(RoleVo vo);

    /**
     * 查询所有角色列表，返回map集合
     * @return
     */
    public List<Map<String, Object>> findRoleListMap();

    /**
     * 删除该角色的所有菜单权限
     * @param roleId
     * @return
     */
    public Integer deleteAllMenuByRoleId(Long roleId);

    /**
     * 对角色进行菜单授权
     * @param roleId
     * @param menuId
     * @return
     */
    public Integer grantMenu(@Param("roleId") Long roleId, @Param("menuId") Integer menuId);

    /**
     * 查找该角色的用户数
     * @param roleId
     * @return
     */
    public Integer countUserByRoleId(Long roleId);

    /**
     * 删除角色
     * @param roleId
     * @return
     */
    public Integer deleteRole(Long roleId);

    /**
     * 根据角色编号查找角色
     * @param roleId
     * @return
     */
    public RoleEntity findRoleByRoleId(Long roleId);

    /**
     * 根据角色名查找角色编号
     * @param roleName
     * @return
     */
    public Long findRoleIdByRoleName(String roleName);

    /**
     * 删除某个用户与某个角色的关系
     * @param userId
     * @param roleId
     * @return
     */
    public Integer deleteRoleAndUser(@Param("userId") Long userId, @Param("roleId") Long roleId);

}
