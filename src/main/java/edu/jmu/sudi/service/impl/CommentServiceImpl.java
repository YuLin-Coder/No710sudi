package edu.jmu.sudi.service.impl;

import edu.jmu.sudi.dao.CommentMapper;
import edu.jmu.sudi.dao.FoodMapper;
import edu.jmu.sudi.dao.OrderDetailMapper;
import edu.jmu.sudi.dao.UserMapper;
import edu.jmu.sudi.entity.CommentEntity;
import edu.jmu.sudi.entity.OrderDetailEntity;
import edu.jmu.sudi.entity.UserEntity;
import edu.jmu.sudi.service.CommentService;
import edu.jmu.sudi.utils.SystemConstant;
import edu.jmu.sudi.vo.CommentVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 评论服务层实现类
 * @author LiangJie
 */
@Service
@Transactional
public class CommentServiceImpl implements CommentService {

    @Autowired
    private CommentMapper commentMapper;
    @Autowired
    private OrderDetailMapper orderDetailMapper;
    @Autowired
    private FoodMapper foodMapper;
    @Autowired
    private UserMapper userMapper;

    /**
     * 用户发表评论
     * @param session
     * @param vo
     * @return
     */
    @Override
    public Map<String, Object> addComment(CommentVo vo, HttpSession session) {
        Map<String, Object> map = new HashMap<>(16);
        Long userId = ((UserEntity) session.getAttribute(SystemConstant.USERLOGIN)).getUserId();
        vo.setUserId(userId);
        try {
            //1. 增加评论
            if (commentMapper.addComment(vo) <= 0) {
                throw new RuntimeException();
            }
            //2.1 根据细则编号查询对应细则
            OrderDetailEntity orderDetail = orderDetailMapper.findOrderDetailById(vo.getOrderDetailId());
            //2.2 增加一条该菜品的评论数（一定要先加一条，否则如果是没人评价的菜品会报除零异常 直接GG）
            if (foodMapper.addCommentCountOne(orderDetail.getFoodId()) <= 0) {
                throw new RuntimeException();
            }
            //2.3 计算菜品评分（计算规则：(原分数+现分数)/2）
            BigDecimal foodScore = orderDetail.getFoodScore().add(vo.getCommentScore()).divide(new BigDecimal(2));
            System.out.println(foodScore);
            if (foodMapper.changeFoodScore(orderDetail.getFoodId(), foodScore) <= 0){
                throw new RuntimeException();
            }
            //2.4 修改订单细则为已评论
            if (orderDetailMapper.commented(orderDetail.getOrderDetailId()) <= 0) {
                throw new RuntimeException();
            }
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "发表评价成功");
        }catch (RuntimeException e){
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "发表评价失败");
        }
        return map;
    }

    /**
     * 查询该菜品下的所有评论
     * @param foodId
     * @return
     */
    @Override
    public Map<String, Object> findByFood(Long foodId) {
        Map<String, Object> map = new HashMap<>(16);
        List<CommentEntity> commentList = commentMapper.findByFood(foodId);
        if (commentList!=null && !commentList.isEmpty()) {
            for (CommentEntity comment : commentList) {
                comment.setUsername(userMapper.findUserByUserId(comment.getUserId()).getUsername());
            }
            map.put(SystemConstant.FLAG, true);
            map.put("commentList", commentList);
        }else {
            map.put(SystemConstant.FLAG, false);
        }
        return map;
    }

    /**
     * 查询该用户的所有评论
     * @param session
     * @return
     */
    @Override
    public Map<String, Object> findByUser(HttpSession session) {
        Map<String, Object> map = new HashMap<>(16);
        Long userId = ((UserEntity) session.getAttribute(SystemConstant.USERLOGIN)).getUserId();
        List<CommentEntity> commentList = commentMapper.findByUser(userId);
        if (commentList!=null && !commentList.isEmpty()){
            map.put(SystemConstant.FLAG, true);
            map.put("commentList", commentList);
        }else {
            map.put(SystemConstant.FLAG, false);
        }
        return map;
    }
}
