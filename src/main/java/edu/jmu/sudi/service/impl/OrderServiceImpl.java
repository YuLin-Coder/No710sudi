package edu.jmu.sudi.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import edu.jmu.sudi.dao.*;
import edu.jmu.sudi.entity.*;
import edu.jmu.sudi.service.OrderService;
import edu.jmu.sudi.utils.CreateCodeUtil;
import edu.jmu.sudi.utils.LayuiTableDataResult;
import edu.jmu.sudi.utils.SystemConstant;
import edu.jmu.sudi.vo.OrderVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 订单服务层实现类
 * @author LiangJie
 */
@Service
@Transactional
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderMapper orderMapper;
    @Autowired
    private AddressMapper addressMapper;
    @Autowired
    private TicketMapper ticketMapper;
    @Autowired
    private ShopcartMapper shopcartMapper;
    @Autowired
    private OrderDetailMapper orderDetailMapper;
    @Autowired
    private FoodMapper foodMapper;
    @Autowired
    private FoodSkuMapper foodSkuMapper;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private DeliverMapper deliverMapper;

    /**
     * 生成订单
     * @param map
     * @param session
     * @return
     */
    @Override
    public Map<String, Object> generateOrder(Map<String, Object> map, HttpSession session) {
        Map<String, Object> map1 = new HashMap<>(16);
        OrderEntity order = new OrderEntity();
        //1.生成订单
        //1.1 封装订单对象
        order.setOrderId(CreateCodeUtil.createOrderId());
        order.setUserId(((UserEntity) session.getAttribute(SystemConstant.USERLOGIN)).getUserId());
        order.setAddress(addressMapper.findAddressById(Long.parseLong(((String) map.get("addressId")))).getAddress());
        order.setRealName(((String) map.get("realName")));
        order.setPhone(((String) map.get("phone")));
        if (map.get("ticketId")!=null && ((String) map.get("ticketId"))!=""){
            order.setTicketId(Long.parseLong((String) map.get("ticketId")));
            order.setCheap(ticketMapper.findTicketById(Long.parseLong((String) map.get("ticketId"))).getCheap());
        }
        //1.3 获取当前用户的购物车，判断日供量
        List<ShopcartEntity> shopcart = shopcartMapper.findAllShopcartByUserId(order.getUserId());
        for (ShopcartEntity shopcartEntity : shopcart) {
            //1. 查找当日该菜品剩余供量
            Integer todaySale = orderMapper.findTodaySale(shopcartEntity.getFoodId());
            todaySale = todaySale == null ? 0 : todaySale;//如果查不到今天的销量就取0
            //2. 判断购买量是否大于剩余供量
            if (shopcartEntity.getNumCount() > shopcartEntity.getDayStock()-todaySale){
                //2.1 购买量大于剩余供量：提示供量不足
                String msg = "很抱歉，【" + shopcartEntity.getFoodName() + "】供量不足您的" + shopcartEntity.getNumCount() + "需求";
                map.put(SystemConstant.MESSAGE, msg);
                return map;
            }else if (shopcartEntity.getNumCount() == shopcartEntity.getDayStock()-todaySale){
                //2.2 购买量等于剩余供量：允许购买，并且下架菜品
                foodMapper.foodOffShelf(shopcartEntity.getFoodId(), "自动下架");
            }
        }

        try {
            //1.2 生成订单
            if (orderMapper.generateOrder(order) <= 0) {
                throw new RuntimeException();
            }
            Integer totalCount = 0;
            BigDecimal totalPrice = new BigDecimal(0);
            //根据当前用户的购物车，生成订单细则
            for (ShopcartEntity item : shopcart) {
                OrderDetailEntity orderDetail = new OrderDetailEntity();
                orderDetail.setSkuId(item.getSkuId());
                orderDetail.setOrderId(order.getOrderId());
                orderDetail.setAmount(item.getNumCount());
                orderDetail.setItemPrice(item.getSkuPrice().multiply(new BigDecimal(item.getNumCount())));
                totalCount += orderDetail.getAmount();
                totalPrice = totalPrice.add(orderDetail.getItemPrice());

                //3. 菜品销量增加
                //3.1 根据skuId查找菜品spu的Id
                FoodSkuEntity foodSku = foodSkuMapper.findFoodSkuBySkuId(item.getSkuId());
                //3.2 增加SPU销量 和 SKU销量  +  1.3 生成订单细则
                if (orderDetailMapper.generateOrderDetail(orderDetail) <= 0 ||
                    foodMapper.addSaleCount(foodSku.getFoodId(), item.getNumCount()) <= 0 ||
                    foodSkuMapper.addSkuSale(item.getSkuId(), item.getNumCount()) <= 0){
                    throw new RuntimeException();
                }
            }
            //1.4 设置订单总计信息
            if (orderMapper.setTotalInfo(order.getOrderId(), totalCount, totalPrice) <= 0) {
                throw new RuntimeException();
            }
            //2. 如果有使用优惠券的话改变优惠券状态
            if (order.getTicketId() != null) {
                if (ticketMapper.ticketUsed(order.getTicketId()) <= 0){
                    throw new RuntimeException();
                }
            }
            //4. 积分奖励
            Integer rewardScore = totalPrice.intValue()/5;
            UserEntity user = (UserEntity) session.getAttribute(SystemConstant.USERLOGIN);
            user.setScore(user.getScore() + rewardScore);
            if (userMapper.modifyUserScore(rewardScore, user.getUserId()) <= 0){
                throw new RuntimeException();
            }
            //5. 清空购物车
            if (shopcartMapper.clearShopcart(order.getUserId()) <= 0){
                throw new RuntimeException();
            }
            map1.put(SystemConstant.FLAG, true);
            map1.put(SystemConstant.MESSAGE, "订单已生成");
            map1.put("rewardScore", rewardScore);
        }catch (RuntimeException e){
            e.printStackTrace();
            map1.put(SystemConstant.FLAG, false);
            map1.put(SystemConstant.MESSAGE, "生成订单失败");
        }
        return map1;
    }

    /**
     * 查找当前登录用户的所有订单
     * @param session
     * @return
     */
    @Override
    public List<Map<String, Object>> findOrderListByUserId(HttpSession session) {
        List<Map<String, Object>> orderInfoList = new ArrayList<>();
        Long userId = ((UserEntity) session.getAttribute(SystemConstant.USERLOGIN)).getUserId();
        List<OrderEntity> orderList = orderMapper.findOrderListByUserId(userId);
        for (OrderEntity order : orderList) {
            Map<String, Object> orderInfoMap = new HashMap<>(16);
            orderInfoMap.put("order", order);
            List<OrderDetailEntity> orderDetailList = orderDetailMapper.findOrderDetailByOrderId(order.getOrderId());
            orderInfoMap.put("orderDetailList", orderDetailList);
            orderInfoList.add(orderInfoMap);
        }
        return orderInfoList;
    }

    /**
     * 查询所有出餐中的订单，时间升序
     * @param vo
     * @return
     */
    @Override
    public LayuiTableDataResult findAllCookingOrder(OrderVo vo) {
        PageHelper.startPage(vo.getPage(), vo.getLimit());
        List<OrderEntity> orderList = orderMapper.findAllCookingOrder();
        PageInfo<OrderEntity> pageInfo = new PageInfo<>(orderList);
        return new LayuiTableDataResult(pageInfo.getTotal(), pageInfo.getList());
    }

    /**
     * 查询该订单的所有细则
     * @param orderId
     * @return
     */
    @Override
    public List<OrderDetailEntity> findOrderDetailByOrderId(String orderId) {
        List<OrderDetailEntity> orderDetailList = orderDetailMapper.findOrderDetailByOrderId(orderId);
        return orderDetailList;
    }

    /**
     * 将订单分配给配送员
     * @param deliverId
     * @param orderId
     * @return
     */
    @Override
    public Map<String, Object> allocationOrder(String deliverId, String orderId) {
        Map<String, Object> map = new HashMap<>(16);
        //1. 根据配送员编号查询配送员信息
        DeliverEntity deliver = deliverMapper.findDeliverById(deliverId);
        try{
            //2. 订单封装配送员信息并且修改订单状态
            if (orderMapper.allocationOrder(orderId, deliver.getDeliverId(), deliver.getRealName(), deliver.getPhone()) <= 0) {
                throw new RuntimeException();
            }
            //3. 配送员接单数+1
            if (deliverMapper.addOneOrderCount(deliver.getDeliverId()) <= 0) {
                throw new RuntimeException();
            }
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "订单已成功分配给【"+deliver.getRealName()+"】配送员！");
        }catch (RuntimeException e) {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "订单分配失败");
        }
        return map;
    }

    /**
     * 查询该配送员的待配送订单
     * @param vo
     * @param session
     * @return
     */
    @Override
    public LayuiTableDataResult orderDeliverList(OrderVo vo, HttpSession session) {
        PageHelper.startPage(vo.getPage(), vo.getLimit());
        Long userId = ((UserEntity) session.getAttribute(SystemConstant.USERLOGIN)).getUserId();
        //1. 查询当前配送员信息
        DeliverEntity deliver = deliverMapper.findDeliverByUser(userId);
        //2. 查询当前配送员的待配送订单
        List<OrderEntity> orderList = orderMapper.findOrderDeliverList(deliver.getDeliverId());
        PageInfo<OrderEntity> pageInfo = new PageInfo<>(orderList);
        return new LayuiTableDataResult(pageInfo.getTotal(), pageInfo.getList());
    }

    /**
     * 订单送达
     * @param session
     * @param orderId
     * @return
     */
    @Override
    public Map<String, Object> finishOrder(HttpSession session, String orderId) {
        Map<String, Object> map = new HashMap<>(16);
        Long userId = ((UserEntity) session.getAttribute(SystemConstant.USERLOGIN)).getUserId();
        try {
            //1. 配送员结单数+1
            if (deliverMapper.addOneFinishCount(userId) <= 0){
                throw new RuntimeException();
            }
            //2. 修改订单状态和结单时间
            if (orderMapper.finishOrder(orderId) <= 0) {
                throw new RuntimeException();
            }
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "辛苦啦！订单已成功送达~");
        }catch (RuntimeException e) {
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "辛苦啦！订单已成功送达~");
        }
        return map;
    }

    /**
     * 取消配送
     * @param orderId
     * @return
     */
    @Override
    public Map<String, Object> cancelDeliver(String orderId) {
        Map<String, Object> map = new HashMap<>(16);
        try {
            if (orderMapper.cancelDeliver(orderId) <= 0) {
                throw new RuntimeException();
            }
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "订单已取消配送");
        } catch (RuntimeException e){
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "订单取消配送失败");
        }
        return map;
    }

    /**
     * 取消订单
     * @param orderId
     * @return
     */
    @Override
    public Map<String, Object> cancelOrder(String orderId) {
        Map<String, Object> map = new HashMap<>(16);
        try {
            if (orderMapper.cancelOrder(orderId) <= 0) {
                throw new RuntimeException();
            }
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "订单已取消");
        } catch (RuntimeException e){
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "订单取消失败");
        }
        return map;
    }

    /**
     * 查询某个配送员的所有配送记录
     * @param session
     * @return
     */
    @Override
    public LayuiTableDataResult findAllOrderByDeliverId(HttpSession session) {
        Long userId = ((UserEntity) session.getAttribute(SystemConstant.USERLOGIN)).getUserId();
        //1. 获得当前登录的配送员
        DeliverEntity deliver = deliverMapper.findDeliverByUser(userId);
        List<OrderEntity> orderList = orderMapper.findAllOrderByDeliverId(deliver.getDeliverId());
        PageInfo<OrderEntity> pageInfo = new PageInfo<>(orderList);
        return new LayuiTableDataResult(pageInfo.getTotal(), pageInfo.getList());
    }


}
