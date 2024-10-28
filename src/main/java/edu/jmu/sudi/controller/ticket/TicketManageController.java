package edu.jmu.sudi.controller.ticket;

import com.alibaba.fastjson.JSON;
import edu.jmu.sudi.service.TicketService;
import edu.jmu.sudi.utils.LayuiTableDataResult;
import edu.jmu.sudi.vo.TicketVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * 优惠券领取管理控制器
 * @author LiangJie
 */
@RestController
@RequestMapping("/backstage/ticket")
public class TicketManageController {

    @Autowired
    private TicketService ticketService;

    /**
     * 根据页面信息查询优惠券领取记录
     * @param vo
     * @return
     */
    @RequestMapping("/list")
    public String findTicketListByPage(TicketVo vo){
        LayuiTableDataResult ticketListByPage = ticketService.findTicketListByPage(vo);
        return JSON.toJSONString(ticketListByPage);
    }

    /**
     * 将某张优惠券作废
     * @param ticketId
     * @return
     */
    @RequestMapping("/invalid")
    public String invalid(Long ticketId){
        Map<String, Object> map = ticketService.invalid(ticketId);
        return JSON.toJSONString(map);
    }

    /**
     * 将某张优惠券复原
     * @param ticketId
     * @return
     */
    @RequestMapping("/restore")
    public String restore(Long ticketId){
        Map<String, Object> map = ticketService.restore(ticketId);
        return JSON.toJSONString(map);
    }

    /**
     * 将某张优惠券积分返还
     * @param ticketId
     * @param session
     * @return
     */
    @RequestMapping("/returnScore")
    public String returnScore(Long ticketId, HttpSession session){
        Map<String, Object> map = ticketService.returnScore(ticketId, session);
        return JSON.toJSONString(map);
    }

}
