package edu.jmu.sudi.controller.user;

import com.alibaba.fastjson.JSON;
import edu.jmu.sudi.service.UserService;
import edu.jmu.sudi.utils.LayuiTableDataResult;
import edu.jmu.sudi.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/backstage/user")
public class UserManageController {

    @Autowired
    private UserService userService;

    /**
     * 根据页面的条件查找用户列表
     * @param vo
     * @return
     */
    @RequestMapping("/list")
    public String findUserListByPage(UserVo vo){
        LayuiTableDataResult userListByPage = userService.findUserListByPage(vo);
        return JSON.toJSONString(userListByPage);
    }

    /**
     * 后台添加用户
     * @param vo
     * @return
     */
    @RequestMapping("/add")
    public String addUser(UserVo vo){
        Map<String, Object> map = userService.addUser(vo);
        return JSON.toJSONString(map);
    }

    /**
     * 后台修改用户信息
     * @param vo
     * @return
     */
    @RequestMapping("/modify")
    public String modifyUserBackstage(UserVo vo){
        Map<String, Object> map = userService.modifyUserBackstage(vo);
        return JSON.toJSONString(map);
    }

    /**
     * 重置用户密码
     * @param userId
     * @return
     */
    @RequestMapping("/resetPassword")
    public String resetPassword(Long userId){
        Map<String, Object> map = userService.resetPassword(userId);
        return JSON.toJSONString(map);
    }

    /**
     * 查找该用户所拥有的角色
     * @param userId
     * @return
     */
    @RequestMapping("/findRole")
    public String findRoleListByUserId(Long userId){
        LayuiTableDataResult roleListByUserId = userService.findRoleListByUserId(userId);
        return JSON.toJSONString(roleListByUserId);
    }

    /**
     * 为用户授权角色
     * @param roleIds
     * @param userId
     * @return
     */
    @RequestMapping("/grantRole")
    public String grantRole(String roleIds, Long userId){
        Map<String, Object> map = userService.grantRole(roleIds, userId);
        return JSON.toJSONString(map);
    }

    /**
     * 删除用户信息
     * @param userId
     * @return
     */
    @RequestMapping("/delete")
    public String deleteUser(Long userId){
        Map<String, Object> map = userService.deleteUser(userId);
        return JSON.toJSONString(map);
    }
}
