package edu.jmu.sudi.dao;

import edu.jmu.sudi.entity.OrderEntity;
import edu.jmu.sudi.vo.OrderVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;

/**
 * 订单DAO层
 * @author LiangJie
 */
@Repository
public interface OrderMapper {

    /**
     * 生成订单
     * @param order
     * @return
     */
    public Integer generateOrder(OrderEntity order);

    /**
     * 设置订单总计信息
     * @param orderId
     * @param totalCount
     * @param totalPrice
     * @return
     */
    public Integer setTotalInfo(@Param("orderId") String orderId,
                            @Param("totalCount")  Integer totalCount,
                            @Param("totalPrice")  BigDecimal totalPrice);

    /**
     * 查找当前登录用户的所有订单
     * @param userId
     * @return
     */
    public List<OrderEntity> findOrderListByUserId(Long userId);

    /**
     * 查询所有出餐中的订单，时间升序
     * @return
     */
    public List<OrderEntity> findAllCookingOrder();

    /**
     * 订单封装配送员信息并且修改订单状态
     * @param orderId
     * @param deliverId
     * @param deliverName
     * @param deliverPhone
     * @return
     */
    public Integer allocationOrder(@Param("orderId") String orderId,
                                   @Param("deliverId") String deliverId,
                                   @Param("deliverName") String deliverName,
                                   @Param("deliverPhone") String deliverPhone);

    /**
     * 查询当前配送员的待配送订单
     * @param deliverId
     * @return
     */
    public List<OrderEntity> findOrderDeliverList(String deliverId);

    /**
     * 订单结单
     * @param orderId
     * @return
     */
    public Integer finishOrder(String orderId);

    /**
     * 配送员取消订单配送，回退出餐中状态
     * @param orderId
     * @return
     */
    public Integer cancelDeliver(String orderId);

    /**
     * 取消订单
     * @param orderId
     * @return
     */
    public Integer cancelOrder(String orderId);

    /**
     * 查询某个配送员的所有配送记录
     * @param deliverId
     * @return
     */
    public List<OrderEntity> findAllOrderByDeliverId(String deliverId);

    /**
     * 根据订单编号查询订单
     * @param orderId
     * @return
     */
    public OrderEntity findOrderById(String orderId);

    /**
     * 修改订单为已投诉
     * @param orderId
     * @return
     */
    public Integer complainted(String orderId);

    /**
     * 查询当日某菜品的订货量
     * @param foodId
     * @return
     */
    public Integer findTodaySale(Long foodId);
}
