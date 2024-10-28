package edu.jmu.sudi.service;

import edu.jmu.sudi.vo.CommentVo;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * 评论服务层
 * @author LiangJie
 */
public interface CommentService {

    /**
     * 用户发表评论
     * @param vo
     * @param session
     * @return
     */
    public Map<String, Object> addComment(CommentVo vo, HttpSession session);

    /**
     * 查询该菜品下的所有评论
     * @param foodId
     * @return
     */
    public Map<String, Object> findByFood(Long foodId);

    /**
     * 查询该用户的所有评论
     * @param session
     * @return
     */
    public Map<String, Object> findByUser(HttpSession session);
}
