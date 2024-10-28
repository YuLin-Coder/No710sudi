package edu.jmu.sudi.utils;

public interface SystemConstant {

    /**
     * 用户存放登录成功后的user变量名
     */
    String USERLOGIN = "userLogin";

    /**
     * 判断登录的状态，true表示登录成功，false反之
     */
    String LOGINFLAG = "loginFlag";

    /**
     * 返回的消息变量名
     */
    String MESSAGE = "message";

    /**
     * 标志位，判断是否执行成功
     */
    String FLAG = "flag";

    /**
     * layui表格的复选框选中标识
     */
    String LAY_CHECK = "LAY_CHECKED";

    /**
     * 系统默认用户的初始密码
     */
    String DEFAULTPASSWORD = "123456";

    /**
     * 用户默认的角色编号
     */
    Long DEFAULTROLEID = (long)1;

    /**
     * 配送员的角色名称(DeliverRoleName)
     */
    String DELIVERROLENAME = "配送员";

    /**
     * 文件上传的路径
     */
    String UPLOADPATH = "D:/sudi_data/upload/";

    /**
     * 配送员的文件上传路径
     */
    String DELIVERPATH = "deliver/";

    /**
     * 菜品类别的文件上传路径
     */
    String FOODTYPEPATH = "foodtype/";

    /**
     * 菜品SPU的文件上传路径
     */
    String FOODPATH = "food/";

}
