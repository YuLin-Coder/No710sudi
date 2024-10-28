package edu.jmu.sudi.service;

import edu.jmu.sudi.entity.UserEntity;
import edu.jmu.sudi.utils.LayuiTableDataResult;
import edu.jmu.sudi.utils.TemplateUtil;
import edu.jmu.sudi.vo.UserVo;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

public interface UserService {

    /**
     * 用户登录方法，根据用户名和密码校验用户的信息是否正确
     * @return
     */
    public Map<String, Object> login(String usernane, String password, HttpSession session);

    /**
     * 用户退出登录时的业务逻辑
     * @param session
     */
    public void exit(HttpSession session);

    /**
     * 根据页面条件查询用户列表
     * @param vo
     * @return
     */
    public LayuiTableDataResult findUserListByPage(UserVo vo);

    /**
     * 后台添加用户
     * @param vo
     * @return
     */
    public Map<String, Object> addUser(UserVo vo);

    /**
     * 后台修改用户信息
     * @param vo
     * @return
     */
    public Map<String, Object> modifyUserBackstage(UserVo vo);

    /**
     * 重置用户密码
     * @param userId
     * @return
     */
    public Map<String, Object> resetPassword(Long userId);

    /**
     * 查询用户所拥有的角色列表
     * @param userId
     * @return
     */
    public LayuiTableDataResult findRoleListByUserId(Long userId);

    /**
     * 为用户授权角色
     * @param roleIds
     * @param userId
     * @return
     */
    public Map<String, Object> grantRole(String roleIds, Long userId);

    /**
     * 删除用户信息
     * @param userId
     * @return
     */
    public Map<String, Object> deleteUser(Long userId);

    /**
     * 校验用户注册输入的用户名是否存在
     * @param username
     * @return
     */
    public Map<String, Object> checkUsername(String username);

    /**
     * 用户注册
     * @param vo
     * @param session
     * @return
     */
    public Map<String, Object> register(UserVo vo, HttpSession session);

    /**
     * 查询某个用户的个人资料
     * @param userId
     * @return
     */
    public Map<String, Object> findUserByUserId(Long userId);

    /**
     * 修改用户个人信息
     * @param vo
     * @param session
     * @return
     */
    public Map<String, Object> modifyUserReception(UserVo vo, HttpSession session);

    /**
     * 用户修改密码
     * @param oldPassword
     * @param newPassword
     * @param session
     * @return
     */
    public Map<String, Object> modifyPassword(String oldPassword, String newPassword, HttpSession session);
}
