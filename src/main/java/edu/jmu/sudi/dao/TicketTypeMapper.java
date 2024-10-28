package edu.jmu.sudi.dao;

import edu.jmu.sudi.entity.TicketTypeEntity;
import edu.jmu.sudi.vo.TicketTypeVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 优惠券类别DAO层
 * @author LiangJie
 */
@Repository
public interface TicketTypeMapper {


    /**
     * 根据页面条件查询优惠券类型集合
     * @param vo
     * @return
     */
    public List<TicketTypeEntity> findTicketTypeListByPage(TicketTypeVo vo);

    /**
     * 新增优惠券类型
     * @param vo
     * @return
     */
    public Integer addTicketType(TicketTypeVo vo);

    /**
     * 修改优惠券类型
     * @param vo
     * @return
     */
    public Integer modifyTicketType(TicketTypeVo vo);

    /**
     * 优惠券类型上架
     * @param ticketTypeId
     * @param username
     * @return
     */
    public Integer onShelf(@Param("ticketTypeId") Long ticketTypeId, @Param("username") String username);

    /**
     * 优惠券类型下架
     * @param ticketTypeId
     * @param username
     * @return
     */
    public Integer offShelf(@Param("ticketTypeId") Long ticketTypeId, @Param("username") String username);

    /**
     * 删除优惠券类型
     * @param ticketTypeId
     * @return
     */
    public Integer deleteTicketType(Long ticketTypeId);

    /**
     * 查询所有上架的优惠券类别
     * @return
     */
    public List<TicketTypeEntity> findAllTicketOnShelf();

    /**
     * 根据编号查询优惠券类别
     * @param ticketTypeId
     * @return
     */
    public TicketTypeEntity findTicketTypeById(Long ticketTypeId);

    /**
     * 优惠券领取数+1
     * @param ticketTypeId
     * @return
     */
    public Integer addReceiveOne(Long ticketTypeId);
}
