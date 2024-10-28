package edu.jmu.sudi.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 角色实体类
 * @author LiangJie
 */
public class RoleEntity implements Serializable {
    private Long roleId;
    private String roleName;
    private String roleDesc;
    private String lastModifyBy;
    private Date lastModifyTime;

    public Long getRoleId() {
        return roleId;
    }

    public void setRoleId(Long roleId) {
        this.roleId = roleId;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getRoleDesc() {
        return roleDesc;
    }

    public void setRoleDesc(String roleDesc) {
        this.roleDesc = roleDesc;
    }

    public String getLastModifyBy() {
        return lastModifyBy;
    }

    public void setLastModifyBy(String lastModifyBy) {
        this.lastModifyBy = lastModifyBy;
    }

    public Date getLastModifyTime() {
        return lastModifyTime;
    }

    public void setLastModifyTime(Date lastModifyTime) {
        this.lastModifyTime = lastModifyTime;
    }

    @Override
    public String toString() {
        return "RoleEntity{" +
                "roleId=" + roleId +
                ", roleName='" + roleName + '\'' +
                ", roleDesc='" + roleDesc + '\'' +
                ", lastModifyBy='" + lastModifyBy + '\'' +
                ", lastModifyTime=" + lastModifyTime +
                '}';
    }
}
