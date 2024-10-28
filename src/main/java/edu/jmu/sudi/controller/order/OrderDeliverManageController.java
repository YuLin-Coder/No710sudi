package edu.jmu.sudi.controller.order;

import com.alibaba.fastjson.JSON;
import edu.jmu.sudi.service.OrderService;
import edu.jmu.sudi.utils.LayuiTableDataResult;
import edu.jmu.sudi.vo.OrderVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * 订单配送管理控制器
 * @author LiangJie
 */
@RestController
@RequestMapping("/backstage/order")
public class OrderDeliverManageController {

    @Autowired
    private OrderService orderService;

    /**
     * 查询该配送员的待配送订单
     * @param vo
     * @param session
     * @return
     */
    @RequestMapping("/orderDeliverList")
    public String orderDeliverList(OrderVo vo, HttpSession session){
        LayuiTableDataResult layuiTableDataResult = orderService.orderDeliverList(vo, session);
        return JSON.toJSONString(layuiTableDataResult);
    }

    /**
     * 订单送达
     * @param orderId
     * @param session
     * @return
     */
    @RequestMapping("/finishOrder")
    public String finishOrder(HttpSession session, String orderId){
        Map<String, Object> map = orderService.finishOrder(session, orderId);
        return JSON.toJSONString(map);
    }

    /**
     * 取消配送
     * @param orderId
     * @return
     */
    @RequestMapping("/cancelDeliver")
    public String cancelDeliver(String orderId) {
        Map<String, Object> map = orderService.cancelDeliver(orderId);
        return JSON.toJSONString(map);
    }

    /**
     * 查询某个配送员的所有配送记录
     * @param session
     * @return
     */
    @RequestMapping("/deliverRecord")
    public String findAllOrderByDeliverId(HttpSession session){
        LayuiTableDataResult allOrderByDeliverId = orderService.findAllOrderByDeliverId(session);
        return JSON.toJSONString(allOrderByDeliverId);
    }
}
