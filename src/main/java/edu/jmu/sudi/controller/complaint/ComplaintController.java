package edu.jmu.sudi.controller.complaint;

import com.alibaba.fastjson.JSON;
import edu.jmu.sudi.entity.ComplaintEntity;
import edu.jmu.sudi.service.ComplaintService;
import edu.jmu.sudi.utils.LayuiTableDataResult;
import edu.jmu.sudi.vo.ComplaintVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * 投诉 控制器
 * @author LiangJie
 */
@RestController
@RequestMapping("/reception/complaint")
public class ComplaintController {

    @Autowired
    private ComplaintService complaintService;

    /**
     * 用户发表投诉
     * @param session
     * @param vo
     * @return
     */
    @RequestMapping("/add")
    public String addComplaint(ComplaintVo vo, HttpSession session){
        Map<String, Object> map = complaintService.addComplaint(vo, session);
        return JSON.toJSONString(map);
    }

    /**
     * 根据页面传递的条件查询对应的投诉信息
     * @param vo
     * @return
     */
    @RequestMapping("/list")
    public String findComplaintListByPage(ComplaintVo vo){
        LayuiTableDataResult complaintListByPage = complaintService.findComplaintListByPage(vo);
        return JSON.toJSONString(complaintListByPage);
    }

    /**
     * 查询该用户的所有投诉
     * @param session
     * @return
     */
    @RequestMapping("/findByUser")
    public String findByUser(HttpSession session){
        Map<String, Object> map = complaintService.findByUser(session);
        return JSON.toJSONString(map);
    }
}
