package edu.jmu.sudi.controller.deliver;

import com.alibaba.fastjson.JSON;
import edu.jmu.sudi.entity.DeliverEntity;
import edu.jmu.sudi.service.DeliverService;
import edu.jmu.sudi.utils.LayuiTableDataResult;
import edu.jmu.sudi.vo.DeliverVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

/**
 * 配送员管理控制器
 * @author LiangJie
 */
@RestController
@RequestMapping("/backstage/deliver")
public class DeliverManageController {

    @Autowired
    private DeliverService deliverService;

    /**
     * 根据页面的条件查询配送员列表
     * @param vo
     * @return
     */
    @RequestMapping("/list")
    public String findDeliverListByPage(DeliverVo vo){
        LayuiTableDataResult deliverListByPage = deliverService.findDeliverListByPage(vo);
        return JSON.toJSONString(deliverListByPage);
    }

    /**
     * 配送员证件照文件上传
     * @return
     */
    @RequestMapping("/uploadFile")
    public String uploadFile(MultipartFile deliverImage){
        Map<String, Object> map = deliverService.uploadFile(deliverImage);
        return JSON.toJSONString(map);
    }

    /**
     * 查找不是配送员的用户
     * @return
     */
    @RequestMapping("/findUser")
    public String findUserListNotDeliver(){
        Map<String, Object> map = deliverService.findUserListNotDeliver();
        return JSON.toJSONString(map);
    }

    /**
     * 添加配送员
     * @param vo
     * @return
     */
    @RequestMapping("/add")
    public String addDeliver(DeliverVo vo){
        Map<String, Object> map = deliverService.addDeliver(vo);
        return JSON.toJSONString(map);
    }

    /**
     * 修改配送员
     * @param vo
     * @return
     */
    @RequestMapping("/modify")
    public String modifyDeliver(DeliverVo vo){
        Map<String, Object> map = deliverService.modifyDeliver(vo);
        return JSON.toJSONString(map);
    }

    /**
     * 配送员离职
     * @return
     */
    @RequestMapping("/leave")
    public String leaveDeliver(String deliverId, Long userId){
        Map<String, Object> map = deliverService.leaveDeliver(deliverId, userId);
        return JSON.toJSONString(map);
    }

    /**
     * 配送员复职
     * @return
     */
    @RequestMapping("/reJoin")
    public String reJoinDeliver(String deliverId, Long userId){
        Map<String, Object> map = deliverService.reJoinDeliver(deliverId, userId);
        return JSON.toJSONString(map);
    }

    /**
     * 查找接单数、差评数、结单数的最大值
     * @return
     */
    @RequestMapping("/findMax")
    public String findMax(){
        Map<String, Object> max = deliverService.findMax();
        return JSON.toJSONString(max);
    }

    /**
     * 查询正式的配送员信息(未离职且已实名)
     * @return
     */
    @RequestMapping("/findFormalDeliver")
    public String findFormalDeliver(){
        List<DeliverEntity> formalDeliver = deliverService.findFormalDeliver();
        return JSON.toJSONString(formalDeliver);
    }
}
