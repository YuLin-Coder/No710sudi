package edu.jmu.sudi.service;

import edu.jmu.sudi.entity.DeliverEntity;
import edu.jmu.sudi.utils.LayuiTableDataResult;
import edu.jmu.sudi.vo.DeliverVo;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

/**
 * 配送员服务层
 * @author LiangJie
 */
public interface DeliverService {

    /**
     * 根据页面的条件查询配送员列表
     * @param vo
     * @return
     */
    public LayuiTableDataResult findDeliverListByPage(DeliverVo vo);

    /**
     * 配送员证件照文件上传
     * @param deliverImage
     * @return
     */
    public Map<String, Object> uploadFile(MultipartFile deliverImage);

    /**
     * 查找不是配送员的用户
     * @return
     */
    public Map<String, Object> findUserListNotDeliver();

    /**
     * 添加配送员
     * @param vo
     * @return
     */
    public Map<String, Object> addDeliver(DeliverVo vo);

    /**
     * 修改配送员
     * @param vo
     * @return
     */
    public Map<String, Object> modifyDeliver(DeliverVo vo);

    /**
     * 配送员离职
     * @param deliverId
     * @param userId
     * @return
     */
    public Map<String, Object> leaveDeliver(String deliverId, Long userId);

    /**
     * 配送员复职
     * @param deliverId
     * @param userId
     * @return
     */
    public Map<String, Object> reJoinDeliver(String deliverId, Long userId);

    /**
     * 查找接单数、差评数、结单数的最大值
     * @return
     */
    public Map<String, Object> findMax();

    /**
     * 查询正式的配送员信息(未离职且已实名)
     * @return
     */
    public List<DeliverEntity> findFormalDeliver();
}
