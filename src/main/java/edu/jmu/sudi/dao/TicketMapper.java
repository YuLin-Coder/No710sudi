package edu.jmu.sudi.dao;

import edu.jmu.sudi.entity.TicketEntity;
import edu.jmu.sudi.vo.TicketVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 优惠券DAO层
 * @author LiangJie
 */
public interface TicketMapper {

    /**
     * 添加优惠券的领取记录
     * @param ticketTypeId
     * @param userId
     * @return
     */
    public Integer addTicket(@Param("ticketTypeId") Long ticketTypeId, @Param("liveTime") Integer liveTime, @Param("userId") Long userId);

    /**
     * 根据页面信息查询优惠券领取记录
     * @param vo
     * @return
     */
    public List<TicketEntity> findTicketListByPage(TicketVo vo);

    /**
     * 将某张优惠券作废
     * @param ticketId
     * @return
     */
    public Integer invalid(Long ticketId);

    /**
     * 将某张优惠券复原
     * @param ticketId
     * @return
     */
    public Integer restore(Long ticketId);

    /**
     * 将某张优惠券积分返还
     * @param ticketId
     * @return
     */
    public Integer returnScore(Long ticketId);

    /**
     * 根据优惠券编号查询优惠券
     * @param ticketId
     * @return
     */
    public TicketEntity findTicketById(Long ticketId);

    /**
     * 查找所有过期的优惠券
     * @return
     */
    public List<Long> findTicketIdListOutTime();

    /**
     * 将优惠券状态改为过期
     * @param ticketId
     * @return
     */
    public Integer setOutTime(Long ticketId);

    /**
     * 查询某个用户的优惠券记录
     * @param userId
     * @return
     */
    public List<TicketEntity> findByUser(Long userId);

    /**
     * 查询该用户未使用的优惠券
     * @param userId
     * @return
     */
    public List<TicketEntity> findByUserUnuse(Long userId);

    /**
     * 将某张优惠券的状态设置为已使用
     * @param ticketId
     * @return
     */
    public Integer ticketUsed(Long ticketId);
}
