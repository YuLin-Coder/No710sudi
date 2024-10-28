package edu.jmu.sudi.controller.order;

import com.alibaba.fastjson.JSON;
import edu.jmu.sudi.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * 订单(用户端)控制器
 * @author LiangJie
 */
@RestController
@RequestMapping("/reception/order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    /**
     * 生成订单
     * @param session
     * @param map
     * @return
     */
    @RequestMapping("/generateOrder")
    public String generateOrder(@RequestParam Map<String, Object> map, HttpSession session){
        Map<String, Object> map1 = orderService.generateOrder(map, session);
        return JSON.toJSONString(map1);
    }

    /**
     * 查找当前登录用户的所有订单
     * @param session
     * @return
     */
    @RequestMapping("/findOrderListByUserId")
    public String findOrderListByUserId(HttpSession session){
        List<Map<String, Object>> orderInfoList = orderService.findOrderListByUserId(session);
        return JSON.toJSONString(orderInfoList);
    }

}
