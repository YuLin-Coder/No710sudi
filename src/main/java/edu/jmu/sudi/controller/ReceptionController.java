package edu.jmu.sudi.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 系统控制器，专门用于控制页面的跳转，负责跳转前台页面
 */
@Controller
@RequestMapping("/reception")
public class ReceptionController {

    /**
     * 跳转到点餐中心
     * @return
     */
    @RequestMapping("/foodCenter.html")
    public String foodCenter(){
        return "food/foodCenter";
    }

    /**
     * 跳转到菜品详情页
     * @return
     */
    @RequestMapping("/foodInfo.html")
    public String foodInfo(){
        return "food/foodInfo";
    }

    /**
     * 跳转到购物车界面
     * @return
     */
    @RequestMapping("/shopcart.html")
    public String shopcart(){
        return "shopcart/shopcart";
    }

    /**
     * 跳转到优惠券商城页面
     * @return
     */
    @RequestMapping("/ticketShop.html")
    public String ticketShop(){
        return "ticket/ticketShop";
    }

    /**
     * 跳转到我的优惠券页面
     * @return
     */
    @RequestMapping("/myTicket.html")
    public String myTicket(){
        return "ticket/myTicket";
    }

    /**
     * 跳转到生成订单页面
     * @return
     */
    @RequestMapping("/generateOrder.html")
    public String generateOrder(){
        return "order/generateOrder";
    }

    /**
     * 跳转到支付成功的页面
     * @return
     */
    @RequestMapping("/paySuccess.html")
    public String paySuccess(){
        return "shopcart/paySuccess";
    }

    /**
     * 跳转到我的订单界面
     * @return
     */
    @RequestMapping("/myOrder.html")
    public String myOrder(){
        return "order/myOrder";
    }

    /**
     * 跳转到我的评论界面
     * @return
     */
    @RequestMapping("/myComments.html")
    public String myComments(){
        return "comment/myComment";
    }

    /**
     * 跳转到我的投诉界面
     * @return
     */
    @RequestMapping("/myComplaint.html")
    public String myComplaint(){
        return "complaint/myComplaint";
    }
}
