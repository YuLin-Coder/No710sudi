package edu.jmu.sudi.service;

import edu.jmu.sudi.dao.MenuMapper;
import edu.jmu.sudi.utils.LayuiTableDataResult;
import edu.jmu.sudi.vo.MenuVo;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

public interface MenuService {

    /**
     * 加载左侧菜单栏的导航列表
     * @return
     */
    public Map<String, Object> loadMenuList(HttpServletRequest request);

    /**
     * 加载菜单树
     * @return
     */
    public LayuiTableDataResult loadMenuTree();

    /**
     * 加载菜单表格
     * @param vo
     * @return
     */
    public LayuiTableDataResult loadMenuTable(MenuVo vo);

    /**
     * 新增菜单
     * @param vo
     * @return
     */
    public Map<String, Object> addMenu(MenuVo vo);

    /**
     * 修改菜单
     * @param vo
     * @return
     */
    public Map<String, Object> modifyMenu(MenuVo vo);

    /**
     * 删除菜单
     * @param menuId
     * @return
     */
    public Map<String, Object> deleteMenu(Integer menuId);
}
