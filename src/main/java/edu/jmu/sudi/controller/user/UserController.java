package edu.jmu.sudi.controller.user;

import com.alibaba.fastjson.JSON;
import edu.jmu.sudi.entity.UserEntity;
import edu.jmu.sudi.service.UserService;
import edu.jmu.sudi.utils.SystemConstant;
import edu.jmu.sudi.utils.TemplateUtil;
import edu.jmu.sudi.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    /**
     * 用户登录
     * @param username
     * @param password
     * @param session
     * @return
     */
    @ResponseBody
    @RequestMapping("/login")
    public String login(String username, String password, HttpSession session){
        Map<String, Object> map = userService.login(username, password, session);
        return JSON.toJSONString(map);
    }

    /**
     * 退出登录6
     * @param session
     * @return
     */
    @RequestMapping("/exit")
    public String exit(HttpSession session){
        userService.exit(session);
        return "redirect:/login.html";
    }

    /**
     * 校验用户注册输入的用户名是否存在
     * @param username
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkUsername")
    public String checkUsername(String username){
        Map<String, Object> map = userService.checkUsername(username);
        return JSON.toJSONString(map);
    }

    /**
     * 用户注册
     * @param vo
     * @param session
     * @return
     */
    @ResponseBody
    @RequestMapping("/register")
    public String register(UserVo vo, HttpSession session){
        Map<String, Object> register = userService.register(vo, session);
        return JSON.toJSONString(register);
    }

    /**
     * 查询登录用户的个人资料
     * @param session
     * @return
     */
    @ResponseBody
    @RequestMapping("/findUserByUserId")
    public String findUserByUserId(HttpSession session){
        Long userId = ((UserEntity) session.getAttribute(SystemConstant.USERLOGIN)).getUserId();
        Map<String, Object> userByUserId = userService.findUserByUserId(userId);
        return JSON.toJSONString(userByUserId);
    }

    /**
     * 查询某个用户的个人资料
     * @param vo
     * @return
     */
    @ResponseBody
    @RequestMapping("/modifyUserInfo")
    public String modifyUserInfo(UserVo vo, HttpSession session){
        Map<String, Object> map = userService.modifyUserReception(vo, session);
        return JSON.toJSONString(map);
    }

    /**
     * 用户修改密码
     * @param oldPassword
     * @param newPassword
     * @param session
     * @return
     */
    @ResponseBody
    @RequestMapping("/modifyPassword")
    public String modifyPassword(String oldPassword, String newPassword, HttpSession session){
        Map<String, Object> map = userService.modifyPassword(oldPassword, newPassword, session);
        return JSON.toJSONString(map);
    }
}
