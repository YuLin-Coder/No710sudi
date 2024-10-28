package edu.jmu.sudi.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import edu.jmu.sudi.dao.TicketTypeMapper;
import edu.jmu.sudi.entity.TicketTypeEntity;
import edu.jmu.sudi.entity.UserEntity;
import edu.jmu.sudi.service.TicketTypeService;
import edu.jmu.sudi.utils.LayuiTableDataResult;
import edu.jmu.sudi.utils.SystemConstant;
import edu.jmu.sudi.vo.TicketTypeVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 优惠券类别服务层实现类
 * @author LiangJie
 */
@Service
@Transactional
public class TicketTypeServiceImpl implements TicketTypeService {

    @Autowired
    private TicketTypeMapper ticketTypeMapper;

    /**
     * 根据页面条件查询优惠券类型集合
     * @param vo
     * @return
     */
    @Override
    public LayuiTableDataResult findTicketTypeListByPage(TicketTypeVo vo) {
        PageHelper.startPage(vo.getPage(), vo.getLimit());
        List<TicketTypeEntity> ticketTypeListByPage = ticketTypeMapper.findTicketTypeListByPage(vo);
        PageInfo<TicketTypeEntity> pageInfo = new PageInfo<>(ticketTypeListByPage);
        return new LayuiTableDataResult(pageInfo.getTotal(), pageInfo.getList());
    }

    /**
     * 新增优惠券类型
     * @param vo
     * @param session
     * @return
     */
    @Override
    public Map<String, Object> addTicketType(TicketTypeVo vo, HttpSession session) {
        Map<String, Object> map = new HashMap<>(16);
        String username = ((UserEntity) session.getAttribute(SystemConstant.USERLOGIN)).getUsername();
        vo.setLastModifyBy(username);
        if (ticketTypeMapper.addTicketType(vo) > 0) {
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "新增优惠券类型成功");
        }else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "新增优惠券类型失败");
        }
        return map;
    }

    /**
     * 修改优惠券类型
     * @param vo
     * @param session
     * @return
     */
    @Override
    public Map<String, Object> modifyTicketType(TicketTypeVo vo, HttpSession session) {
        Map<String, Object> map = new HashMap<>(16);
        String username = ((UserEntity) session.getAttribute(SystemConstant.USERLOGIN)).getUsername();
        vo.setLastModifyBy(username);
        if (ticketTypeMapper.modifyTicketType(vo) > 0) {
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "优惠券类型信息修改成功");
        }else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "优惠券类型信息修改失败");
        }
        return map;
    }

    /**
     * 优惠券类型上架
     * @param ticketTypeId
     * @param session
     * @return
     */
    @Override
    public Map<String, Object> onShelf(Long ticketTypeId, HttpSession session) {
        Map<String, Object> map = new HashMap<>(16);
        String username = ((UserEntity) session.getAttribute(SystemConstant.USERLOGIN)).getUsername();
        if (ticketTypeMapper.onShelf(ticketTypeId, username) > 0) {
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "优惠券类型上架成功");
        }else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "优惠券类型上架失败");
        }
        return map;
    }

    /**
     * 优惠券类型下架
     * @param ticketTypeId
     * @param session
     * @return
     */
    @Override
    public Map<String, Object> offShelf(Long ticketTypeId, HttpSession session) {
        Map<String, Object> map = new HashMap<>(16);
        String username = ((UserEntity) session.getAttribute(SystemConstant.USERLOGIN)).getUsername();
        if (ticketTypeMapper.offShelf(ticketTypeId, username) > 0) {
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "优惠券类型下架成功");
        }else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "优惠券类型下架失败");
        }
        return map;
    }

    /**
     * 删除优惠券类型
     * @param ticketTypeId
     * @return
     */
    @Override
    public Map<String, Object> deleteTicketType(Long ticketTypeId) {
        Map<String, Object> map = new HashMap<>(16);
        if (ticketTypeMapper.deleteTicketType(ticketTypeId) > 0) {
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "优惠券类型删除成功");
        }else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "优惠券类型删除失败，仍有用户已领取该券未使用");
        }
        return map;
    }


}
