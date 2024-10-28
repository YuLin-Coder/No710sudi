<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <meta charset="utf-8">
        <title>layui</title>
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/css/layui.css" media="all">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/css/public.css" media="all">
        <%-- 添加layui-dtree的css样式 --%>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui_ext/dtree/dtree.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui_ext/dtree/font/dtreefont.css">

    </head>
    <body>
        <div class="layuimini-container">
            <div class="layuimini-main">

                <%-- 头部条件搜索区域 --%>
                <fieldset class="table-search-fieldset">
                    <legend>搜索信息</legend>
                    <div style="margin: 10px 10px 10px 10px">
                        <form class="layui-form layui-form-pane" action="" id="searchForm">
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">用户编号</label>
                                    <div class="layui-input-inline">
                                        <input type="number" name="userId" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">用户名</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="username" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">邮箱地址</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="email" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">手机号</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="phone" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">性别</label>
                                    <div class="layui-input-inline">
                                        <select id="gender" name="gender" style="height: 32px;width: 150px;" style="text-align: center;">
                                            <option value="" selected=""></option>
                                            <option value="0">未知</option>
                                            <option value="1">男</option>
                                            <option value="2">女</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <button type="submit" class="layui-btn layui-btn-primary"  lay-submit lay-filter="data-search-btn">
                                        <i class="layui-icon layui-icon-search"></i>搜索
                                    </button>
                                    <button type="reset" class="layui-btn layui-btn-primary" lay-submit lay-filter="data-reset-btn" id="data-reset-btn">
                                        <i class="layui-icon layui-icon-refresh"></i>重置
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </fieldset>

                <%-- 表格头部工具栏 --%>
                <script type="text/html" id="toolbarDemo">
                    <div class="layui-btn-container">
                        <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add">
                            <i class="layui-icon layui-icon-add-1"></i>添加
                        </button>
                    </div>
                </script>

                <%-- 表格区域 --%>
                <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

                <%-- 表格行工具栏 --%>
                <script type="text/html" id="currentTableBar">
                    <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit">
                        <i class="layui-icon layui-icon-edit"></i>编辑
                    </a>
                    <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">
                        <i class="layui-icon layui-icon-delete"></i>删除
                    </a>
                    <a class="layui-btn layui-btn-xs layui-btn-checked data-count-grant" lay-event="resetPassword">
                        <i class="layui-icon layui-icon-about"></i>密码重置
                    </a>
                    <a class="layui-btn layui-btn-xs layui-btn-checked data-count-grant" lay-event="grantRole">
                        <i class="layui-icon layui-icon-user"></i>分配角色
                    </a>
                </script>

                <%-- 添加或修改弹出框 --%>
                <div class="layui-container" style="display: none;padding: 5px;width: 100%" id="addOrUpdateForm">
                    <form class="layui-form" style="width: 90%" id="dataForm" lay-filter="dataForm">
                        <%--表单隐藏域--%>
                        <input type="hidden" name="userId">
                        <div class="layui-form-item">
                            <label class="layui-form-label"><font color="red"> * </font>用户名</label>
                            <div class="layui-input-block">
                                <input type="text" name="username" lay-verify="required" autocomplete="off" class="layui-input" id="username">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label"><font color="red"> * </font>手机号</label>
                            <div class="layui-input-block">
                                <input type="text" name="phone" lay-verify="phone" lay-verify="required" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">邮箱地址</label>
                            <div class="layui-input-block">
                                <input type="text" name="email" autocomplete="off" class="layui-input">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">生日</label>
                            <div class="layui-input-inline">
                                <input type="text" name="birthday" autocomplete="off" placeholder="请输入生日" class="layui-input" id="birthday-window">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">性别</label>
                            <div class="layui-input-block">
                                <input type="radio" name="gender" value="0" title="未知">
                                <input type="radio" name="gender" value="1" title="男">
                                <input type="radio" name="gender" value="2" title="女">
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

                <%-- 分配菜单弹出层 --%>
                <div style="display: none;" id="grantMenu">
                    <ul id="roleTree" class="dtree" data-id="0"></ul>
                </div>

                <%-- 角色授权弹出框 --%>
                <div style="display: none;" id="grantRoleTableWindow">
                    <table class="layui-hide" id="grantRoleTable" style="display: none;padding: 5px"></table>
                </div>
            </div>
        </div>
    </body>

    <script src="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
</html>

<script>
    //继承第三方插件
    layui.extend({
        // layui-dtree脚本js文件的路径
        dtree: "${pageContext.request.contextPath}/static/plugins/layui_ext/dtree/dtree",
    }).use(['form', 'table', 'jquery', 'laydate'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table,
            laydate = layui.laydate;

        //执行一个laydate实例
        laydate.render({
            elem: '#birthday' //指定元素
            ,type: 'date'   //指定选择的格式
        });
        laydate.render({
            elem: '#birthday-window' //指定元素
            ,type: 'date'   //指定选择的格式
        });

        var url;//提交的请求地址
        var index;//打开窗口的索引

        /**
         * 数据表单初始化
         */
        var tableIns = table.render({
            elem: '#currentTableId',
            url: '${pageContext.request.contextPath}/backstage/user/list',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {type: "checkbox", width: 50, align: "center"},
                {field: 'userId', width: 112, title: '用户编号', sort: true, align: "center"},
                {field: 'username', width: 112, title: '用户名', align: "center"},
                {field: 'phone', width: 130, title: '手机号', align: "center"},
                {field: 'gender', width: 64, title: '性别', templet: function (d) {
                        switch (d.gender) {
                            case 1:
                                return "男";
                            case 2:
                                return "女";
                            default:
                                return "未知";
                        }
                    }, align: "center"},
                {field: 'lastLoginTime', width: 160, title: '上次登录时间', sort: true, align: "center",
                    templet:"<div>{{layui.util.toDateString(d.lastLoginTime, 'yyyy-MM-dd HH:mm:ss')}}</div>"
                },
                {field: 'lastLogoutTime', width: 160, title: '上次登出时间', sort: true, align: "center",
                    templet:"<div>{{layui.util.toDateString(d.lastLogoutTime, 'yyyy-MM-dd HH:mm:ss')}}</div>"
                },
                {field: 'loginCount', width: 112, title: '登录次数', align: "center", sort: true},
                {title: '操作', width: 365, toolbar: '#currentTableBar', align: "center"}
            ]],
            limits: [10, 15, 20, 25, 50, 100],
            limit: 10,
            page: true,
            skin: 'line',
            //当最后一页的数据被删完后，可以自动返回到上一页
            done: function(res, curr, count){
                //判断当前页码是否大于1并且当前页的数据量是否为0
                if (curr>1 && res.data.length==0){
                    var pageValue = curr - 1;
                    //刷新数据表格的数据
                    tableIns.reload({
                        page: {curr: pageValue}
                    })
                }
            }
        });

        /**
         * 监听搜索操作
         */
        form.on('submit(data-search-btn)', function (data) {
            var date = new Date($("#birthday"));
            $("#birthday").val(date);
            console.log(data);
            //执行搜索重载
            tableIns.reload({
                where: data.field,
                page: {
                    curr: 1
                }
            });
            return false;
        });

        /**
         * 监听重置按钮的事件
         */
        form.on('submit(data-reset-btn)', function (data) {
            data.field.gender = null;
        });

        /**
         * 编写表单提交的监听事件,doSubmit是提交按钮的lay-filter的值
         */
        form.on("submit(doSubmit)", function(data){
            //使用ajax的post请求去传递数据
            $.post(url, data.field, function(result){
                if (result.flag){
                    //刷新数据表格
                    tableIns.reload();
                    //关闭当前窗口
                    layer.close(index);
                }
                //弹出提示信息
                layer.msg(result.message);
            }, "json");
            //禁止页面刷新
            return false;
        });

        /**
         * toolbar监听头部工具栏事件
         */
        table.on('toolbar(currentTableFilter)', function (obj) {
            if (obj.event === 'add') {  // 监听添加操作
                index = layer.open({
                    title: '添加角色',
                    type: 1,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['45%', '70%'],
                    offset: ['50px', '300px'],
                    content: $("#addOrUpdateForm"),
                    success: function () {
                        //清空表单数据
                        $("#dataForm")[0].reset();
                        //添加的提交请求路径赋值
                        url = "${pageContext.request.contextPath}/backstage/user/add";
                    }
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
            } else if (obj.event === 'delete') {  // 监听删除操作
                var checkStatus = table.checkStatus('currentTableId')
                    , data = checkStatus.data;
                layer.alert(JSON.stringify(data));
            }
        });

        /**
         * 监听表格复选框选择
         */
        table.on('checkbox(currentTableFilter)', function (obj) {
            console.log(obj)
        });

        /**
         * 监听表单行工具栏事件
         */
        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            if (obj.event === 'edit') {
                index = layer.open({
                    title: '编辑用户',
                    type: 1,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['45%', '70%'],
                    offset: ['50px', '300px'],
                    content: $("#addOrUpdateForm"),
                    success: function(){
                        //表单数据回显，参数1表示lay-filter的值，参数2表示回显的数据
                        form.val("dataForm", data);
                        //添加的提交请求
                        url = "${pageContext.request.contextPath}/backstage/user/modify"
                    }
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            } else if (obj.event === 'delete') {
                var userId = data.userId;
                layer.confirm('确定要删除名为<font color="red"> '+ data.username +' </font>的用户吗？', {icon: 3, title:'提示'}, function(index){
                    url = "${pageContext.request.contextPath}/backstage/user/delete";
                    $.post(url, {userId: userId}, function (result) {
                        if (result.flag){
                            //刷新数据表格
                            tableIns.reload();
                        }
                        layer.msg(result.message);
                    }, "json");
                    layer.close(index);
                });
            }else if (obj.event === 'resetPassword') {
                layer.confirm('确定要重置名为 <font color="#ff4500">' + data.username + '</font> 的用户的密码吗？<br>重置后的密码将默认为123456!', {icon: 3, title: '提示'}, function(index){
                    $.post("${pageContext.request.contextPath}/backstage/user/resetPassword", {userId: data.userId}, function(result){
                        //不论成功与否，弹窗提示
                        layer.msg(result.message);
                    }, "json");
                });
            }else if (obj.event === 'grantRole') {
                layer.open({
                    title:  "用户<font color='#ff4500'>【" + data.username + '】</font>的角色授权',
                    type: 1,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['60%', '70%'],
                    offset: ['100px', '250px'],
                    content: $("#grantRoleTableWindow"),
                    btn: ['<span class="layui-icon layui-icon-ok"> </span>确定', '<span class="layui-icon layui-icon-close"> </span>取消'],
                    yes: function(index, layero){ //确定按钮的回调
                        var checkStatus = table.checkStatus('grantRoleTable'); //获取角色表格的选中数据
                        console.log(checkStatus.data); //获取选中行的数据

                        //判断是否有选中行，没有就提示
                        if (checkStatus.data.length > 0) {
                            var roleIdArray = [];//定义一个数组，用于保存选中行的ID数据
                            for (var i = 0; i < checkStatus.data.length; i++) {
                                roleIdArray.push(checkStatus.data[i].roleId);
                            }
                            var roleIds = roleIdArray.join(",");//将数组组成由英文逗号分隔的字符串
                            $.post("${pageContext.request.contextPath}/backstage/user/grantRole",
                                {roleIds: roleIds, userId: data.userId},
                                function(result){
                                    layer.msg(result.message);
                                }, "json");
                            layer.close(index);
                        }else {
                            layer.msg("请为该用户分配角色");
                        }

                    },
                    btn2: function(index, layero){
                        //按钮【按钮二】的回调
                        //return false 开启该代码可禁止点击该按钮关闭
                    },
                    success: function(){
                        table.render({
                            elem: '#grantRoleTable',
                            url: '${pageContext.request.contextPath}/backstage/user/findRole?userId=' + data.userId,
                            content: $("#grantRoleTable"),
                            cols: [[
                                {type: "checkbox", width: 50, align: "center"},
                                {field: 'roleId', width: 120, title: '角色编号', sort: true, align: "center"},
                                {field: 'roleName', width: 160, title: '角色名称', align: "center"},
                                {field: 'roleDesc', width: 460, title: '角色描述', align: "center"}
                            ]],
                            limits: [10, 15, 20, 25, 50, 100],
                            limit: 10,
                            page: true,
                            skin: 'line',
                        });
                    }
                });
            }
        });

        /**
         * 删除按钮的监听事件
         */
        form.on("submit(doDelete)", function(data){
            //使用ajax的post请求去传递数据
            $.post(url, data.roleId, function(result){
                if (result.flag){
                    //刷新数据表格
                    tableIns.reload();
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
