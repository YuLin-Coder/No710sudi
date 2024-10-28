package edu.jmu.sudi.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import edu.jmu.sudi.dao.DeliverMapper;
import edu.jmu.sudi.dao.RoleMapper;
import edu.jmu.sudi.dao.UserMapper;
import edu.jmu.sudi.entity.DeliverEntity;
import edu.jmu.sudi.entity.MenuEntity;
import edu.jmu.sudi.entity.UserEntity;
import edu.jmu.sudi.service.DeliverService;
import edu.jmu.sudi.utils.CreateCodeUtil;
import edu.jmu.sudi.utils.FileUploadUtil;
import edu.jmu.sudi.utils.LayuiTableDataResult;
import edu.jmu.sudi.utils.SystemConstant;
import edu.jmu.sudi.vo.DeliverVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 配送员服务层实现类
 * @author LiangJie
 */
@Service
@Transactional
public class DeliverServiceImpl implements DeliverService {

    @Autowired
    private DeliverMapper deliverMapper;

    @Autowired
    private RoleMapper roleMapper;

    @Autowired
    private UserMapper userMapper;

    /**
     * 根据页面的条件查询配送员列表
     * @param vo
     * @return
     */
    @Override
    public LayuiTableDataResult findDeliverListByPage(DeliverVo vo) {
        //设置分页信息
        PageHelper.startPage(vo.getPage(), vo.getLimit());
        //调用分页查询的方法
        List<DeliverEntity> deliverList = deliverMapper.findDeliverListByPage(vo);
        //创建分页对象，将查询到的数据放进去
        PageInfo<DeliverEntity> pageInfo = new PageInfo<>(deliverList);
        return new LayuiTableDataResult(pageInfo.getTotal(), pageInfo.getList());
    }

    /**
     * 配送员证件照文件上传
     * @param deliverImage
     * @return
     */
    @Override
    public Map<String, Object> uploadFile(MultipartFile deliverImage) {
        //用于存储LayUI文件上传所必须的键值
        Map<String, Object> map = new HashMap<>();
        //判断一下文件是否为空
        if (!deliverImage.isEmpty()) {
            //将文件重命名
            String newFileName = FileUploadUtil.rename(deliverImage);
            //全部文件都放在一个文件夹下不好管理，所以以日期作为文件夹进行管理
            //组装路径
            String finalPath = new SimpleDateFormat("yyyyMMdd").format(new Date()) + "/" + newFileName;
            //获得文件对象，参数1：文件上传的路径，参数2：文件名称（包括文件夹）
            File path = new File(SystemConstant.UPLOADPATH + SystemConstant.DELIVERPATH, finalPath);
            if (!path.getParentFile().exists()) {
                //如果文件夹不存在，就创建文件夹
                path.getParentFile().mkdirs();
            }
            try {
                //将文件保存到磁盘中
                deliverImage.transferTo(path);
                /*
                 * 严格按照LayUI规定传递所必须的参数
                 */
                map.put("code", 0);
                map.put("msg", "文件上传成功");
                Map<String, Object> dataMap = new HashMap<>(16);
                //图片路径
                dataMap.put("src", "/sudi/upload/deliver/" + finalPath);
                //鼠标悬停时显示的文本
                dataMap.put("title", newFileName);
                //保存图片路径，不包括前面的文件夹，从模块文件夹起始
                dataMap.put("imagePath", SystemConstant.DELIVERPATH + finalPath);
                map.put("data", dataMap);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return map;
    }

    /**
     * 查找不是配送员的用户
     * @return
     */
    @Override
    public Map<String, Object> findUserListNotDeliver() {
        Map<String, Object> map = new HashMap<>(16);
        //查找不是配送员的用户列表
        List<UserEntity> userList = deliverMapper.findUserListNotDeliver();
        if (userList != null) {
            map.put("code", 1);
        }else {
            map.put("code", 2);
        }
        map.put("userList", userList);
        return map;
    }

    /**
     * 添加配送员
     * @param vo
     * @return
     */
    @Override
    public Map<String, Object> addDeliver(DeliverVo vo) {
        Map<String, Object> map = new HashMap<>(16);
        //设置入职日期并生成配送员编号
        vo.setJoinDate(new Date());
        vo.setDeliverId(CreateCodeUtil.createDeliverId());
        //查找到配送员的角色ID
        Long roleId = roleMapper.findRoleIdByRoleName(SystemConstant.DELIVERROLENAME);
        if (roleId != null){
            //添加该用户与配送员角色之间的关系
            Integer result1 = userMapper.addUserAndRole(vo.getUserId(), roleId);
            //向配送员表添加该角色
            Integer result2 = deliverMapper.addDeliverMoreInfo(vo);
            if (result1>=1 && result2>=1){
                map.put(SystemConstant.FLAG, true);
                map.put(SystemConstant.MESSAGE, "【"+vo.getRealName()+"】的配送员关系添加成功");
                return map;
            }
        }
        map.put(SystemConstant.FLAG, false);
        map.put(SystemConstant.MESSAGE, "【"+vo.getRealName()+"】的配送员关系添加失败");
        return map;
    }

    /**
     * 修改配送员
     * @param vo
     * @return
     */
    @Override
    public Map<String, Object> modifyDeliver(DeliverVo vo) {
        Map<String, Object> map = new HashMap<>(16);
        if (deliverMapper.modifyDeliver(vo) > 0) {
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "【"+vo.getRealName()+"】配送员信息修改成功");
        } else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "【"+vo.getRealName()+"】配送员信息修改失败");
        }
        return map;
    }

    /**
     * 配送员离职
     * @param deliverId
     * @param userId
     * @return
     */
    @Override
    public Map<String, Object> leaveDeliver(String deliverId, Long userId) {
        Map<String, Object> map = new HashMap<>(16);
        Long deliverRoleId = roleMapper.findRoleIdByRoleName(SystemConstant.DELIVERROLENAME);
        //离职的时候需要删除其与配送员角色的关系
        if (roleMapper.deleteRoleAndUser(userId, deliverRoleId)>0 && deliverMapper.leaveDeliver(deliverId)>0) {
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "配送员离职成功");
        } else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "配送员离职失败");
        }
        return map;
    }

    /**
     * 配送员复职
     * @param deliverId
     * @param userId
     * @return
     */
    @Override
    public Map<String, Object> reJoinDeliver(String deliverId, Long userId) {
        Map<String, Object> map = new HashMap<>(16);
        Long deliverRoleId = roleMapper.findRoleIdByRoleName(SystemConstant.DELIVERROLENAME);
        //复职的时候需要添加其与配送员角色的关系
        try {
            if (deliverMapper.reJoinDeliver(deliverId)>0 && userMapper.addUserAndRole(userId, deliverRoleId)>0) {
                map.put(SystemConstant.FLAG, true);
                map.put(SystemConstant.MESSAGE, "配送员复职成功");
            } else {
                throw new Exception();
            }
        } catch (Exception e){
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "配送员复职失败");
        } finally {
            return map;
        }
    }

    /**
     * 查找接单数、差评数、结单数的最大值
     * @return
     */
    @Override
    public Map<String, Object> findMax() {
        Map<String, Object> map = new HashMap<>(16);
        map.put("maxOrderCount", deliverMapper.findMaxOrderCount());
        map.put("maxFaultCount", deliverMapper.findMaxFaultCount());
        map.put("maxFinishCount", deliverMapper.findMaxFinishCount());
        return map;
    }

    /**
     * 查询正式的配送员信息(未离职且已实名)
     * @return
     */
    @Override
    public List<DeliverEntity> findFormalDeliver() {
        List<DeliverEntity> deliverList = deliverMapper.findFormalDeliver();
        return deliverList;
    }


}
