package edu.jmu.sudi.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import edu.jmu.sudi.dao.*;
import edu.jmu.sudi.entity.ComplaintEntity;
import edu.jmu.sudi.entity.FoodSkuEntity;
import edu.jmu.sudi.entity.OrderEntity;
import edu.jmu.sudi.entity.UserEntity;
import edu.jmu.sudi.service.ComplaintService;
import edu.jmu.sudi.utils.LayuiTableDataResult;
import edu.jmu.sudi.utils.SystemConstant;
import edu.jmu.sudi.vo.ComplaintVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 投诉 服务层实现类
 * @author LiangJie
 */
@Service
@Transactional
public class ComplaintServiceImpl implements ComplaintService {

    @Autowired
    private ComplaintMapper complaintMapper;
    @Autowired
    private DeliverMapper deliverMapper;
    @Autowired
    private OrderMapper orderMapper;
    @Autowired
    private FoodMapper foodMapper;
    @Autowired
    private FoodSkuMapper skuMapper;

    /**
     * 用户发表投诉
     * @param vo
     * @param session
     * @return
     */
    @Override
    public Map<String, Object> addComplaint(ComplaintVo vo, HttpSession session) {
        Map<String, Object> map = new HashMap<>(16);
        Long userId = ((UserEntity) session.getAttribute(SystemConstant.USERLOGIN)).getUserId();
        vo.setUserId(userId);
        //1. 根据订单编号查询订单
        OrderEntity order = orderMapper.findOrderById(vo.getOrderId());
        //2. 判断投诉的类型
        try {
            switch (vo.getComplaintType()){
                //2.1 投诉类型为配送员投诉
                case 1:{
                    if (deliverMapper.addFaultCountOne(order.getDeliverId()) <= 0){
                        map.put(SystemConstant.FLAG, false);
                        map.put(SystemConstant.MESSAGE, "投诉失败，该订单还无配送员接单");
                        return map;
                    }else {
                        //3. 修改订单为已投诉
                        if (orderMapper.complainted(order.getOrderId()) <= 0){
                            throw new RuntimeException();
                        }
                        //4. 添加投诉记录
                        if (complaintMapper.addComplaint(vo) <= 0){
                            throw new RuntimeException();
                        }
                        map.put(SystemConstant.FLAG, true);
                        map.put(SystemConstant.MESSAGE, "您的投诉已收到，很抱歉为您造成困扰，我们将针对您的投诉尽快做出处理");
                        return map;
                    }
                }
                //2.2 投诉类型为菜品投诉
                case 2:{
                    //根据SKU编号查询菜品信息
                    FoodSkuEntity sku = skuMapper.findFoodSkuBySkuId(Long.parseLong(vo.getTarget()));
                    if (foodMapper.addFaultCountOne(sku.getFoodId()) <= 0){
                        throw new RuntimeException();
                    }else {
                        //3. 修改订单为已投诉
                        if (orderMapper.complainted(order.getOrderId()) <= 0){
                            throw new RuntimeException();
                        }
                        //4. 修改投诉对象为sku名称而不是sku编号
                        vo.setTarget(sku.getSkuName());
                        //5. 添加投诉记录
                        if (complaintMapper.addComplaint(vo) <= 0){
                            throw new RuntimeException();
                        }
                        map.put(SystemConstant.FLAG, true);
                        map.put(SystemConstant.MESSAGE, "您的投诉已收到，很抱歉为您造成困扰，我们将针对您的投诉尽快做出处理");
                        return map;
                    }
                }
                //2.3 投诉类型为其他
                default:
                    //1. 修改订单为已投诉
                    if (orderMapper.complainted(order.getOrderId()) <= 0){
                        throw new RuntimeException();
                    }
                    //2. 添加投诉记录
                    if (complaintMapper.addComplaint(vo) <= 0){
                        throw new RuntimeException();
                    }
                    map.put(SystemConstant.FLAG, true);
                    map.put(SystemConstant.MESSAGE, "您的投诉已收到，很抱歉为您造成困扰，我们将针对您的投诉尽快做出处理");
                    return map;
            }
        }catch (RuntimeException e){
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "投诉失败");
        }
        return map;
    }

    /**
     * 根据页面传递的条件查询对应的投诉信息
     * @param vo
     * @return
     */
    @Override
    public LayuiTableDataResult findComplaintListByPage(ComplaintVo vo) {
        PageHelper.startPage(vo.getPage(), vo.getLimit());
        List<ComplaintEntity> complaintListByPage = complaintMapper.findComplaintListByPage(vo);
        PageInfo<ComplaintEntity> pageInfo = new PageInfo<>(complaintListByPage);
        return new LayuiTableDataResult(pageInfo.getTotal(), pageInfo.getList());
    }

    /**
     * 查询该用户的所有投诉
     * @param session
     * @return
     */
    @Override
    public Map<String, Object> findByUser(HttpSession session) {
        Map<String, Object> map = new HashMap<>(16);
        Long userId = ((UserEntity) session.getAttribute(SystemConstant.USERLOGIN)).getUserId();
        List<ComplaintEntity> complaintList = complaintMapper.findByUser(userId);
        if (complaintList!=null && !complaintList.isEmpty()) {
            map.put(SystemConstant.FLAG, true);
            map.put("complaintList", complaintList);
        }else {
            map.put(SystemConstant.FLAG, false);
        }
        return map;
    }
}
