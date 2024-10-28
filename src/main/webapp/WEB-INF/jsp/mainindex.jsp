<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <meta charset="utf-8">
        <title>宿递大学生食堂外卖平台后台面板</title>
        <meta name="keywords" content="layuimini,layui,layui模板,layui后台,后台模板,admin,admin模板,layui mini">
        <meta name="description" content="layuimini基于layui的轻量级前端后台管理框架，最简洁、易用的后台框架模板，面向所有层次的前后端程序,只需提供一个接口就直接初始化整个框架，无需复杂操作。">
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta http-equiv="Access-Control-Allow-Origin" content="*">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <meta name="apple-mobile-web-app-status-bar-style" content="black">
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="format-detection" content="telephone=no">
        <link rel="icon" href="${pageContext.request.contextPath}/static/plugins/layui/images/sudifavicon.ico">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/css/layui.css" media="all">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/css/layuimini.css?v=2.0.4.2" media="all">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/css/themes/default.css" media="all">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/lib/font-awesome-4.7.0/css/font-awesome.min.css" media="all">
        <%--<!--[if lt IE 9]>--%>
        <%--<script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>--%>
        <%--<script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>--%>
        <%--<![endif]-->--%>
        <style id="layuimini-bg-color">
        </style>
    </head>
    <body class="layui-layout-body layuimini-all">
        <div class="layui-layout layui-layout-admin">

            <div class="layui-header header">
                <div class="layui-logo layuimini-logo"></div>

                <div class="layuimini-header-content">
                    <a>
                        <div class="layuimini-tool"><i title="展开" class="fa fa-outdent" data-side-fold="1"></i></div>
                    </a>

                    <!--电脑端头部菜单-->
                    <ul class="layui-nav layui-layout-left layuimini-header-menu layuimini-menu-header-pc layuimini-pc-show"></ul>

                    <!--手机端头部菜单-->
                    <ul class="layui-nav layui-layout-left layuimini-header-menu layuimini-mobile-show">
                        <li class="layui-nav-item">
                            <a href="javascript:;"><i class="fa fa-list-ul"></i> 选择模块</a>
                            <dl class="layui-nav-child layuimini-menu-header-mobile">
                            </dl>
                        </li>
                    </ul>

                    <ul class="layui-nav layui-layout-right">
                        <li class="layui-nav-item" lay-unselect>
                            <a href="javascript:;" data-refresh="刷新"><i class="fa fa-refresh"></i></a>
                        </li>
                        <li class="layui-nav-item" lay-unselect>
                            <a href="javascript:;" data-clear="清理" class="layuimini-clear"><i class="fa fa-trash-o"></i></a>
                        </li>
                        <li class="layui-nav-item mobile layui-hide-xs" lay-unselect>
                            <a href="javascript:;" data-check-screen="full"><i class="fa fa-arrows-alt"></i></a>
                        </li>
                        <li class="layui-nav-item layuimini-setting">
                            <a href="javascript:;">${sessionScope.userLogin.username}</a>
                            <dl class="layui-nav-child">
                                <dd>
                                    <a href="javascript:;" layuimini-content-href="${pageContext.request.contextPath}/userInfo.html" data-title="基本资料" data-icon="fa fa-gears">个人中心</a>
                                </dd>
                                <dd>
                                    <a href="javascript:;" id="modifyPassword" data-title="修改密码" data-icon="fa fa-gears">修改密码</a>
                                </dd>
                                <dd>
                                    <hr>
                                </dd>
                                <dd>
                                    <a href="javascript:;" class="login-out">退出登录</a>
                                </dd>
                            </dl>
                        </li>
                        <li class="layui-nav-item layuimini-select-bgcolor" lay-unselect>
                            <a href="javascript:;" data-bgcolor="配色方案"><i class="fa fa-ellipsis-v"></i></a>
                        </li>
                    </ul>
                </div>
            </div>

            <!--无限极左侧菜单-->
            <div class="layui-side layui-bg-black layuimini-menu-left">
            </div>

            <!--初始化加载层-->
            <div class="layuimini-loader">
                <div class="layuimini-loader-inner"></div>
            </div>

            <!--手机端遮罩层-->
            <div class="layuimini-make"></div>

            <!-- 移动导航 -->
            <div class="layuimini-site-mobile"><i class="layui-icon"></i></div>

            <div class="layui-body">
                <div class="layuimini-tab layui-tab-rollTool layui-tab" lay-filter="layuiminiTab" lay-allowclose="true">
                    <ul class="layui-tab-title">
                        <li class="layui-this" id="layuiminiHomeTabId" lay-id=""></li>
                    </ul>
                    <div class="layui-tab-control">
                        <li class="layuimini-tab-roll-left layui-icon layui-icon-left"></li>
                        <li class="layuimini-tab-roll-right layui-icon layui-icon-right"></li>
                        <li class="layui-tab-tool layui-icon layui-icon-down">
                            <ul class="layui-nav close-box">
                                <li class="layui-nav-item">
                                    <a href="javascript:;"><span class="layui-nav-more"></span></a>
                                    <dl class="layui-nav-child">
                                        <dd><a href="javascript:;" layuimini-tab-close="current">关 闭 当 前</a></dd>
                                        <dd><a href="javascript:;" layuimini-tab-close="other">关 闭 其 他</a></dd>
                                        <dd><a href="javascript:;" layuimini-tab-close="all">关 闭 全 部</a></dd>
                                    </dl>
                                </li>
                            </ul>
                        </li>
                    </div>
                    <div class="layui-tab-content">
                        <div id="layuiminiHomeTabIframe" class="layui-tab-item layui-show"></div>
                    </div>
                </div>

            </div>
        </div>

        <%-- 修改密码弹出层 --%>
        <div class="layui-container" style="display: none;padding: 5px;width: 100%;" id="modifyPasswordForm">
            <form class="layui-form" style="width: 90%" id="dataForm" lay-filter="dataForm">
                <%--表单隐藏域--%>
                <input type="hidden" name="userId" id="userId">
                <div class="layui-form-item">
                    <label class="layui-form-label"><font color="red"> * </font>原始密码</label>
                    <div class="layui-input-block">
                        <input type="password" name="oldPassword" lay-verify="required" autocomplete="off" class="layui-input" id="oldPassword">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label"><font color="red"> * </font>新密码</label>
                    <div class="layui-input-block">
                        <input type="password" name="newPassword" lay-verify="required|password" autocomplete="off" class="layui-input" id="newPassword">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label"><font color="red"> * </font>确认密码</label>
                    <div class="layui-input-block">
                        <input type="password" name="reNewPassword" lay-verify="required|rePassword" autocomplete="off" class="layui-input" id="reNewPassword">
                    </div>
                </div>
                <div class="layui-form-item layui-row layui-col-md12">
                    <div class="layui-input-block" style="text-align: center">
                        <button type="button" class="layui-btn layui-btn-checked" lay-submit lay-filter="doSubmit">
                            <span class="layui-icon layui-icon-add-1"></span>确认修改
                        </button>
                        <button type="reset" class="layui-btn layui-btn-primary" lay-reset lay-filter="doReset">
                            <span class="layui-icon layui-icon-refresh"></span>重置
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <script src="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
        <script src="${pageContext.request.contextPath}/static/plugins/layui/js/lay-config.js?v=2.0.0" charset="utf-8"></script>
        <script>
            layui.use(['jquery', 'layer', 'miniAdmin','miniTongji', 'form'], function () {
                var $ = layui.jquery,
                    layer = layui.layer,
                    miniAdmin = layui.miniAdmin,
                    form = layui.form,
                    miniTongji = layui.miniTongji;

                var url;//提交的请求地址
                var index;//打开窗口的索引

                var options = {
                    iniUrl: "${pageContext.request.contextPath}/backstage/menu/loadMenuList",    // 初始化接口
                    clearUrl: "${pageContext.request.contextPath}/static/plugins/layui/api/clear.json", // 缓存清理接口
                    urlHashLocation: true,      // 是否打开hash定位
                    bgColorDefault: false,      // 主题默认配置
                    multiModule: true,          // 是否开启多模块
                    menuChildOpen: false,       // 是否默认展开菜单
                    loadingTime: 0,             // 初始化加载时间
                    pageAnim: true,             // iframe窗口动画
                    maxTabNum: 20,              // 最大的tab打开数量
                };
                miniAdmin.render(options);

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
                        if (!($("#newPassword").val() === value)){
                            return '两次密码输入不一致';
                        }
                    }
                });

                // 百度统计代码，只统计指定域名
                miniTongji.render({
                    specific: true,
                    domains: [
                        '99php.cn',
                        'layuimini.99php.cn',
                        'layuimini-onepage.99php.cn',
                    ],
                });

                /**
                 * 用户退出登录
                 */
                $('.login-out').on("click", function () {
                    layer.confirm('确定要退出登录吗？', {icon: 3, title:'提示', area: ['240px', '160px'], offset: 't'}, function(index){
                        location.href = "${pageContext.request.contextPath}/user/exit";
                        layer.close(index);
                    });
                });

                /**
                 * 用户修改密码
                 */
                $("#modifyPassword").click(function (){
                    index = layer.open({
                        title: '修改密码',
                        type: 1,
                        shade: 0.2,
                        maxmin:true,
                        shadeClose: true,
                        area: ['35%', '40%'],
                        offset: ['180px', '520px'],
                        content: $("#modifyPasswordForm"),
                        success: function () {
                            //重置表单值
                            $("#dataForm")[0].reset();
                            //添加的提交请求路径赋值
                            url = "${pageContext.request.contextPath}/user/modifyPassword";
                        }
                    });
                });

                /**
                 * 编写表单提交的监听事件,doSubmit是提交按钮的lay-filter的值
                 */
                form.on("submit(doSubmit)", function(data){
                    //使用ajax的post请求去传递数据
                    $.post(url, data.field, function(result){
                        if (result.flag){
                            //关闭当前窗口
                            layer.close(index);
                        }
                        //弹出提示信息
                        layer.msg(result.message);
                    }, "json");
                    //禁止页面刷新
                    return false;
                });
            });
        </script>
    </body>
</html>
