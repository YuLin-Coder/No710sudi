package edu.jmu.sudi.dao;

import edu.jmu.sudi.entity.ComplaintEntity;
import edu.jmu.sudi.vo.ComplaintVo;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 投诉 DAO层
 * @author LiangJie
 */
@Repository
public interface ComplaintMapper {

    /**
     * 用户发表投诉
     * @param vo
     * @return
     */
    public Integer addComplaint(ComplaintVo vo);

    /**
     * 根据页面传递的条件查询对应的投诉信息
     * @param vo
     * @return
     */
    public List<ComplaintEntity> findComplaintListByPage(ComplaintVo vo);

    /**
     * 查询该用户的所有投诉
     * @param userId
     * @return
     */
    public List<ComplaintEntity> findByUser(Long userId);
}
