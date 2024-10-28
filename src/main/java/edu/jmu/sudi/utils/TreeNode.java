package edu.jmu.sudi.utils;

import java.util.ArrayList;
import java.util.List;

/**
 * 树节点属性类
 */
public class TreeNode {

    private Integer id;//菜单节点编号
    private Integer parentId;//父节点编号
    private String title;//菜单节点名称
    private String icon;//菜单节点图标
    private String href;//菜单路径
    private Boolean spread;//是否展开
    private List<TreeNode> children = new ArrayList<>();//子节点菜单
    private String checkArr = "0";//复选框是否被默认选中,0为默认不选中

    public TreeNode() {}

    public TreeNode(Integer id, Integer parentId, String title, Boolean spread) {
        this.id = id;
        this.parentId = parentId;
        this.title = title;
        this.spread = spread;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getHref() {
        return href;
    }

    public void setHref(String href) {
        this.href = href;
    }

    public Boolean getSpread() {
        return spread;
    }

    public void setSpread(Boolean spread) {
        this.spread = spread;
    }

    public List<TreeNode> getChildren() {
        return children;
    }

    public void setChildren(List<TreeNode> children) {
        this.children = children;
    }

    public String getCheckArr() {
        return checkArr;
    }

    public void setCheckArr(String checkArr) {
        this.checkArr = checkArr;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public TreeNode(Integer id, Integer parentId, String title, String icon, String href, Boolean spread, List<TreeNode> children, String checkArr) {
        this.id = id;
        this.parentId = parentId;
        this.title = title;
        this.icon = icon;
        this.href = href;
        this.spread = spread;
        this.children = children;
        this.checkArr = checkArr;
    }
}
