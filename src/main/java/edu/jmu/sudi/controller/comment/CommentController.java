package edu.jmu.sudi.controller.comment;

import com.alibaba.fastjson.JSON;
import edu.jmu.sudi.service.CommentService;
import edu.jmu.sudi.vo.CommentVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * 评论控制器
 * @author LiangJie
 */
@RestController
@RequestMapping("/reception/comment")
public class CommentController {

    @Autowired
    private CommentService commentService;

    /**
     * 用户发表评论
     * @param vo
     * @param session
     * @return
     */
    @RequestMapping("/add")
    public String addComment(CommentVo vo, HttpSession session){
        Map<String, Object> map = commentService.addComment(vo, session);
        return JSON.toJSONString(map);
    }

    /**
     * 查询该菜品下的所有评论
     * @param foodId
     * @return
     */
    @RequestMapping("/findByFood")
    public String findByFood(Long foodId){
        Map<String, Object> map = commentService.findByFood(foodId);
        return JSON.toJSONString(map);
    }

    /**
     * 查询该用户的所有评论
     * @param session
     * @return
     */
    @RequestMapping("/findByUser")
    public String findByUser(HttpSession session){
        Map<String, Object> map = commentService.findByUser(session);
        return JSON.toJSONString(map);
    }

}
