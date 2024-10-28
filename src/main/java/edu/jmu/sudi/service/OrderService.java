package edu.jmu.sudi.service;

import edu.jmu.sudi.entity.OrderDetailEntity;
import edu.jmu.sudi.entity.OrderEntity;
import edu.jmu.sudi.utils.LayuiTableDataResult;
import edu.jmu.sudi.vo.OrderVo;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * 订单服务岑
 * @author LiangJie
 */
public interface OrderService {

    /**
     * 生成订单
     * @param map
     * @param session
     * @return
     */
    public Map<String, Object> generateOrder(Map<String, Object> map, HttpSession session);

    /**
     * 查找当前登录用户的所有订单
     * @param session
     * @return
     */
    public List<Map<String, Object>> findOrderListByUserId(HttpSession session);

    /**
     * 查询所有出餐中的订单
     * @param vo
     * @return
     */
    public LayuiTableDataResult findAllCookingOrder(OrderVo vo);

    /**
     * 查询该订单的所有细则
     * @param orderId
     * @return
     */
    public List<OrderDetailEntity> findOrderDetailByOrderId(String orderId);

    /**
     * 将订单分配给配送员
     * @param deliverId
     * @param orderId
     * @return
     */
    public Map<String, Object> allocationOrder(String deliverId, String orderId);

    /**
     * 查询该配送员的待配送订单
     * @param vo
     * @param session
     * @return
     */
    public LayuiTableDataResult orderDeliverList(OrderVo vo, HttpSession session);

    /**
     * 订单送达
     * @param session
     * @param orderId
     * @return
     */
    public Map<String, Object> finishOrder(HttpSession session, String orderId);

    /**
     * 取消配送
     * @param orderId
     * @return
     */
    public Map<String, Object> cancelDeliver(String orderId);

    /**
     * 取消订单
     * @param orderId
     * @return
     */
    public Map<String, Object> cancelOrder(String orderId);

    /**
     * 查询某个配送员的所有配送记录
     * @param session
     * @return
     */
    public LayuiTableDataResult findAllOrderByDeliverId(HttpSession session);
}
