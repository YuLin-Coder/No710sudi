package edu.jmu.sudi.dao;

import edu.jmu.sudi.entity.CommentEntity;
import edu.jmu.sudi.vo.CommentVo;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 评论DAO层
 * @author LiangJie
 */
@Repository
public interface CommentMapper {

    /**
     * 用户发表评论
     * @param vo
     * @return
     */
    public Integer addComment(CommentVo vo);

    /**
     * 查询该菜品下的所有评论
     * @param foodId
     * @return
     */
    public List<CommentEntity> findByFood(Long foodId);

    /**
     * 查询该用户的所有评论
     * @param userId
     * @return
     */
    public List<CommentEntity> findByUser(Long userId);
}
