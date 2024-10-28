package edu.jmu.sudi.dao;

import edu.jmu.sudi.entity.OrderDetailEntity;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 订单细则DAO层
 * @author LiangJie
 */
@Repository
public interface OrderDetailMapper {

    /**
     * 生成订单细则
     * @param orderDetail
     * @return
     */
    public Integer generateOrderDetail(OrderDetailEntity orderDetail);

    /**
     * 根据订单编号查询订单细则列表
     * @param orderId
     * @return
     */
    public List<OrderDetailEntity> findOrderDetailByOrderId(String orderId);

    /**
     * 根据订单细则编号查找订单细则
     * @param orderDetailId
     * @return
     */
    public OrderDetailEntity findOrderDetailById(Long orderDetailId);

    /**
     * 修改订单细则为已评论
     * @param orderDetailId
     * @return
     */
    public Integer commented(Long orderDetailId);

}
