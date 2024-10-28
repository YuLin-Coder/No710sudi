<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <head>
            <meta charset="utf-8">
            <title>修改密码</title>
            <meta name="renderer" content="webkit">
            <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
            <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/css/layui.css" media="all">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/css/public.css" media="all">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/lib/font-awesome-4.7.0/css/font-awesome.min.css"
            <%-- 添加layui-dtree的css样式 --%>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui_ext/dtree/dtree.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui_ext/dtree/font/dtreefont.css">
            <%-- 导入我自己写的样式 --%>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/static/resources/css/userInfo.css">
        </head>
    </head>
    <body>
        <div class="layui-container" style="display: none;padding: 5px;width: 100%;" id="userInfoForm">
            <form class="layui-form" style="width: 90%" id="dataForm" lay-filter="dataForm">
                <%--表单隐藏域--%>
                <input type="hidden" name="userId" id="userId">
                <div class="layui-form-item">
                    <label class="layui-form-label"><font color="red"> * </font>原始密码</label>
                    <div class="layui-input-block">
                        <input type="text" name="oldPassword" lay-verify="required" autocomplete="off" class="layui-input" id="oldPassword">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label"><font color="red"> * </font>新密码</label>
                    <div class="layui-input-block">
                        <input type="text" name="newPassword" lay-verify="required|password" autocomplete="off" class="layui-input" id="newPassword">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label"><font color="red"> * </font>确认密码</label>
                    <div class="layui-input-block">
                        <input type="text" name="reNewPassword" lay-verify="required|rePassword" autocomplete="off" class="layui-input" id="reNewPassword">
                    </div>
                </div>
                <div class="layui-form-item layui-row layui-col-md12">
                    <div class="layui-input-block" style="text-align: center">
                        <button type="button" class="layui-btn layui-btn-checked" lay-submit lay-filter="doSubmit">
                            <span class="layui-icon layui-icon-add-1"></span>提交
                        </button>
                        <button type="reset" class="layui-btn layui-btn-primary" lay-reset lay-filter="doReset">
                            <span class="layui-icon layui-icon-refresh"></span>重置
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </body>

    <script src="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
    <script>
        layui.use(['form','jquery','layer'], function () {
            var $ = layui.jquery,
                form = layui.form,
                layer = layui.layer;

            /**
             * 自定义表单校验规则
             */
            form.verify({
                //密码长度校验
                password: [
                    /^[\S]{6,12}$/,
                    '密码必须6到12位，且不能出现空格'
                ],
                //再次输入密码校验
                rePassword: function (value, item) {
                    if (!($("#password").val() === value)){
                        return '两次密码输入不一致';
                    }
                }
            });
        });
    </script>
</html>
