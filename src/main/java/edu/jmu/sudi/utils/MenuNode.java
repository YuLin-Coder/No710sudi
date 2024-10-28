package edu.jmu.sudi.utils;

import java.util.List;

/**
 * 菜单节点的工具类，用于存储菜单之间的层级关系
 */
public class MenuNode {
    private Integer id;
    private Integer pid;
    private String title;
    private String href;
    private Integer spread;
    private String icon;
    private List<MenuNode> child;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
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

    public Integer getSpread() {
        return spread;
    }

    public void setSpread(Integer spread) {
        this.spread = spread;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public List<MenuNode> getChild() {
        return child;
    }

    public void setChild(List<MenuNode> child) {
        this.child = child;
    }

    @Override
    public String toString() {
        return "MenuNode{" +
                "id=" + id +
                ", pid=" + pid +
                ", title='" + title + '\'' +
                ", href='" + href + '\'' +
                ", spread=" + spread +
                ", icon='" + icon + '\'' +
                ", child=" + child +
                '}';
    }
}
