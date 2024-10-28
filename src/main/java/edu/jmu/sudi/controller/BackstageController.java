package edu.jmu.sudi.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 系统控制器，专门用于控制页面的跳转，负责跳转后台管理页面
 */
@Controller
@RequestMapping("/backstage")
public class BackstageController {

    /**
     * 跳转到用户管理界面
     * @return
     */
    @RequestMapping("/userManage.html")
    public String userManage(){
        return "user/userManage";
    }

    /**
     * 跳转到角色管理界面
     * @return
     */
    @RequestMapping("/roleManage.html")
    public String roleManage(){
        return "role/roleManage";
    }

    /**
     * 跳转到菜单管理界面
     * @return
     */
    @RequestMapping("/menuManage.html")
    public String menuManage(){
        return "menu/menuManage";
    }

    /**
     * 跳转到配送员管理界面
     * @return
     */
    @RequestMapping("/deliverManage.html")
    public String deliverManage(){
        return "deliver/deliverManage";
    }

    /**
     * 跳转到菜品类别管理界面
     * @return
     */
    @RequestMapping("/foodtypeManage.html")
    public String foodtypeManage(){
        return "food/foodtypeManage";
    }

    /**
     * 跳转到菜品规格组管理界面
     * @return
     */
    @RequestMapping("/foodattrManage.html")
    public String foodattrManage(){
        return "food/foodattrManage";
    }

    /**
     * 跳转到菜品SPU管理界面
     * @return
     */
    @RequestMapping("/foodManage.html")
    public String foodManage(){
        return "food/foodManage";
    }

    /**
     * 跳转到菜品SKU管理界面
     * @return
     */
    @RequestMapping("/foodSkuManage.html")
    public String foodSkuManage(){
        return "food/foodSkuManage";
    }

    /**
     * 跳转到优惠券类别管理界面
     * @return
     */
    @RequestMapping("/ticketTypeManage.html")
    public String ticketTypeManage() {
        return "ticket/ticketTypeManage";
    }

    /**
     * 跳转到优惠券领取记录管理界面
     * @return
     */
    @RequestMapping("/ticketManage.html")
    public String ticketManage(){
        return "ticket/ticketManage";
    }

    /**
     * 跳转到订单分配管理界面
     * @return
     */
    @RequestMapping("/orderAllocationManage.html")
    public String orderAllocationManage(){
        return "order/orderAllocationManage";
    }

    /**
     * 跳转到订单配送界面
     * @return
     */
    @RequestMapping("/orderDeliverManage.html")
    public String orderDeliverManage(){
        return "order/orderDeliverManage";
    }

    /**
     * 跳转到配送员配送记录界面
     * @return
     */
    @RequestMapping("/deliverRecord.html")
    public String deliverRecord(){
        return "deliver/deliverRecord";
    }

    /**
     * 跳转到投诉中心页面
     * @return
     */
    @RequestMapping("/complaintManage.html")
    public String complaintManage(){
        return "complaint/complaintManage";
    }
}
