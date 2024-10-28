package edu.jmu.sudi.service;

import edu.jmu.sudi.utils.LayuiTableDataResult;
import edu.jmu.sudi.vo.TicketTypeVo;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * 优惠券类别服务层
 * @author LiangJie
 */
public interface TicketTypeService {

    /**
     * 根据页面条件查询优惠券类型集合
     * @param vo
     * @return
     */
    public LayuiTableDataResult findTicketTypeListByPage(TicketTypeVo vo);

    /**
     * 新增优惠券类型
     * @param vo
     * @param session
     * @return
     */
    public Map<String, Object> addTicketType(TicketTypeVo vo, HttpSession session);

    /**
     * 修改优惠券类型
     * @param vo
     * @param session
     * @return
     */
    public Map<String, Object> modifyTicketType(TicketTypeVo vo, HttpSession session);

    /**
     * 优惠券类型上架
     * @param ticketTypeId
     * @param session
     * @return
     */
    public Map<String, Object> onShelf(Long ticketTypeId, HttpSession session);

    /**
     * 优惠券类型下架
     * @param ticketTypeId
     * @param session
     * @return
     */
    public Map<String, Object> offShelf(Long ticketTypeId, HttpSession session);

    /**
     * 删除优惠券类型
     * @param ticketTypeId
     * @return
     */
    public Map<String, Object> deleteTicketType(Long ticketTypeId);
}
