package edu.jmu.sudi.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import edu.jmu.sudi.dao.TicketMapper;
import edu.jmu.sudi.dao.TicketTypeMapper;
import edu.jmu.sudi.dao.UserMapper;
import edu.jmu.sudi.entity.TicketEntity;
import edu.jmu.sudi.entity.TicketTypeEntity;
import edu.jmu.sudi.entity.UserEntity;
import edu.jmu.sudi.service.TicketService;
import edu.jmu.sudi.utils.LayuiTableDataResult;
import edu.jmu.sudi.utils.SystemConstant;
import edu.jmu.sudi.vo.TicketVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 优惠券商城服务层实现类
 * @author LiangJie
 */
@Service
@Transactional
public class TicketServiceImpl implements TicketService {

    @Autowired
    private TicketTypeMapper ticketTypeMapper;
    @Autowired
    private TicketMapper ticketMapper;
    @Autowired
    private UserMapper userMapper;

    /**
     * 查询所有上架的优惠券类别
     * @return
     */
    @Override
    public Map<String, Object> findAllTicketOnShelf() {
        Map<String, Object> map = new HashMap<>(16);
        List<TicketTypeEntity> ticektTypeList = ticketTypeMapper.findAllTicketOnShelf();
        map.put("ticketTypeList", ticektTypeList);
        return map;
    }

    /**
     * 领取优惠券
     * @param ticketTypeId
     * @param session
     * @return
     */
    @Override
    public Map<String, Object> receiveTicket(Long ticketTypeId, HttpSession session) {
        Map<String, Object> map = new HashMap<>(16);
        //根据编号查询优惠券类别
        TicketTypeEntity ticketType = ticketTypeMapper.findTicketTypeById(ticketTypeId);
        UserEntity user = (UserEntity) session.getAttribute(SystemConstant.USERLOGIN);
        //判断用户的积分够不够领取
        if (user.getScore() < ticketType.getNeedScore()){
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "很抱歉，您的积分不足以兑换该优惠券");
            return map;
        }
        //如果剩余不足返回失败
        if ((ticketType.getTicketNum()-ticketType.getReceive()) <= 0) {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "很抱歉，该优惠券被抢光啦");
            return map;
        }
        //领取成功添加优惠券领取记录，扣除用户积分,优惠券类别已领取数+1
        if (ticketMapper.addTicket(ticketTypeId, ticketType.getLiveTime(), user.getUserId())>0 &&
            userMapper.modifyUserScore(-ticketType.getNeedScore(), user.getUserId())>0 &&
            ticketTypeMapper.addReceiveOne(ticketTypeId)>0) {
            user.setScore(user.getScore()-ticketType.getNeedScore());
            session.setAttribute(SystemConstant.USERLOGIN, user);
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "优惠券领取成功");
        }else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "优惠券领取失败");
        }
        return map;
    }

    /**
     * 根据页面信息查询优惠券领取记录
     * @param vo
     * @return
     */
    @Override
    public LayuiTableDataResult findTicketListByPage(TicketVo vo) {
        //查询过期的优惠券，设置其状态为过期
        List<Long> ticketOutTime = ticketMapper.findTicketIdListOutTime();
        for (Long ticketId : ticketOutTime) {
            ticketMapper.setOutTime(ticketId);
        }
        PageHelper.startPage(vo.getPage(), vo.getLimit());
        List<TicketEntity> ticketListByPage = ticketMapper.findTicketListByPage(vo);
        PageInfo<TicketEntity> pageInfo = new PageInfo<>(ticketListByPage);
        return new LayuiTableDataResult(pageInfo.getTotal(), pageInfo.getList());
    }

    /**
     * 将某张优惠券作废
     * @param ticketId
     * @return
     */
    @Override
    public Map<String, Object> invalid(Long ticketId) {
        Map<String, Object> map = new HashMap<>(16);
        if (ticketMapper.invalid(ticketId) > 0) {
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "优惠券已作废");
        }else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "优惠券作废失败");
        }
        return map;
    }

    /**
     * 将某张优惠券复原
     * @param ticketId
     * @return
     */
    @Override
    public Map<String, Object> restore(Long ticketId) {
        Map<String, Object> map = new HashMap<>(16);
        if (ticketMapper.restore(ticketId) > 0) {
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "优惠券已复原");
        }else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "优惠券复原失败");
        }
        return map;
    }

    /**
     * 将某张优惠券积分返还
     * @param ticketId
     * @param session
     * @return
     */
    @Override
    public Map<String, Object> returnScore(Long ticketId, HttpSession session) {
        UserEntity user = (UserEntity) session.getAttribute(SystemConstant.USERLOGIN);
        TicketEntity ticket = ticketMapper.findTicketById(ticketId);
        Map<String, Object> map = new HashMap<>(16);
        //修改优惠券状态并且退还用户积分
        if (ticketMapper.returnScore(ticketId)>0 && userMapper.modifyUserScore(ticket.getNeedScore(), user.getUserId())>0) {
            user.setScore(user.getScore() + ticket.getNeedScore());
            session.setAttribute(SystemConstant.USERLOGIN, user);
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "优惠券积分已成功返还给用户");
        }else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "优惠券积分返还失败");
        }
        return map;
    }

    /**
     * 查询某个用户的优惠券记录
     * @param session
     * @return
     */
    @Override
    public Map<String, Object> findByUser(HttpSession session) {
        Map<String, Object> map = new HashMap<>(16);
        Long userId = ((UserEntity) session.getAttribute(SystemConstant.USERLOGIN)).getUserId();
        List<TicketEntity> ticketList = ticketMapper.findByUser(userId);
        if (ticketList != null) {
            map.put(SystemConstant.FLAG, true);
            map.put("ticketList", ticketList);
        }else {
            map.put(SystemConstant.FLAG, false);
        }
        return map;
    }

    /**
     * 查询该用户未使用的优惠券
     * @param session
     * @return
     */
    @Override
    public Map<String, Object> findByUserUnuse(HttpSession session) {
        Map<String, Object> map = new HashMap<>(16);
        Long userId = ((UserEntity) session.getAttribute(SystemConstant.USERLOGIN)).getUserId();
        List<TicketEntity> ticketList = ticketMapper.findByUserUnuse(userId);
        if (ticketList != null) {
            map.put(SystemConstant.FLAG, true);
            map.put("ticketList", ticketList);
        }else {
            map.put(SystemConstant.FLAG, false);
        }
        return map;
    }

    /**
     * 根据优惠券编号查询优惠券
     * @param ticketId
     * @return
     */
    @Override
    public Map<String, Object> findTicketById(Long ticketId) {
        Map<String, Object> map = new HashMap<>(16);
        TicketEntity ticket = ticketMapper.findTicketById(ticketId);
        map.put("ticket", ticket);
        return map;
    }
}
