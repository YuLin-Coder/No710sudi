package edu.jmu.sudi.service;

import edu.jmu.sudi.utils.LayuiTableDataResult;
import edu.jmu.sudi.vo.TicketVo;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * 优惠券商城服务层
 * @author LiangJie
 */
public interface TicketService {

    /**
     * 查询所有上架的优惠券类别
     * @return
     */
    public Map<String, Object> findAllTicketOnShelf();

    /**
     * 领取优惠券
     * @param ticketTypeId
     * @param session
     * @return
     */
    public Map<String, Object> receiveTicket(Long ticketTypeId, HttpSession session);

    /**
     * 根据页面信息查询优惠券领取记录
     * @param vo
     * @return
     */
    public LayuiTableDataResult findTicketListByPage(TicketVo vo);

    /**
     * 将某张优惠券作废
     * @param ticketId
     * @return
     */
    public Map<String, Object> invalid(Long ticketId);

    /**
     * 将某张优惠券复原
     * @param ticketId
     * @return
     */
    public Map<String, Object> restore(Long ticketId);

    /**
     * 将某张优惠券积分返还
     * @param ticketId
     * @param session
     * @return
     */
    public Map<String, Object> returnScore(Long ticketId, HttpSession session);

    /**
     * 查询某个用户的优惠券记录
     * @param session
     * @return
     */
    public Map<String, Object> findByUser(HttpSession session);

    /**
     * 查询该用户未使用的优惠券
     * @param session
     * @return
     */
    public Map<String, Object> findByUserUnuse(HttpSession session);

    /**
     * 根据优惠券编号查询优惠券
     * @param ticketId
     * @return
     */
    public Map<String, Object> findTicketById(Long ticketId);
}
