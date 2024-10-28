package edu.jmu.sudi.utils;

import java.util.ArrayList;
import java.util.List;

/**
 * layuimini为我们提供的工具类，帮助我们将菜单关系的List集合转换为Map映射
 */
public class TreeUtil {
    public static List<MenuNode> toTree(List<MenuNode> treeList, Integer pid) {
        List<MenuNode> retList = new ArrayList<MenuNode>();
        for (MenuNode parent : treeList) {
            if (pid.equals(parent.getPid())) {
                retList.add(findChildren(parent, treeList));
            }
        }
        return retList;
    }
    private static MenuNode findChildren(MenuNode parent, List<MenuNode> treeList) {
        for (MenuNode child : treeList) {
            if (parent.getId().equals(child.getPid())) {
                if (parent.getChild() == null) {
                    parent.setChild(new ArrayList<>());
                }
                parent.getChild().add(findChildren(child, treeList));
            }
        }
        return parent;
    }
}
