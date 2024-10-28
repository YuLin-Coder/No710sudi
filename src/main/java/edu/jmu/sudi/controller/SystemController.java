package edu.jmu.sudi.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 系统控制器，专门用于控制页面的跳转，负责通用页面的跳转
 */
@Controller
@RequestMapping("/")
public class SystemController {

    /**
     * 跳转到主框架页
     * @return
     */
    @RequestMapping("/index.html")
    public String index(){
        return "mainindex";
    }

    /**
     * 跳转到登录界面
     * @return
     */
    @RequestMapping("/login.html")
    public String login(){
        return "user/login";
    }

    /**
     * 跳转到注册界面
     * @return
     */
    @RequestMapping("/register.html")
    public String register(){
        return "user/register";
    }

    /**
     * 跳转到个人中心界面
     * @return
     */
    @RequestMapping("/userInfo.html")
    public String userInfo(){
        return "user/userInfo";
    }

    /**
     * 跳转到修改密码界面
     * @return
     */
    @RequestMapping("/modifyPassword.html")
    public String modifyPassword(){
        return "user/modifyPassword";
    }

    /**
     * 跳转到用户主界面
     * @return
     */
    @RequestMapping("/desktop.html")
    public String desktop(){
        return "desktop";
    }
}
