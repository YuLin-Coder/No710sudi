<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <meta charset="utf-8">
        <title>个人中心</title>
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
    <script>
        function gender(gender){
            if (gender == 1){
                return "男";
            }else if (gender == 2){
                return "女";
            }else {
                return "未填写";
            }
        }

        function formatDateTime(inputTime) {
            var date = new Date(inputTime);
            var y = date.getFullYear();
            var m = date.getMonth() + 1;
            m = m < 10 ? ('0' + m) : m;
            var d = date.getDate();
            d = d < 10 ? ('0' + d) : d;
            var h = date.getHours();
            h = h < 10 ? ('0' + h) : h;
            var minute = date.getMinutes();
            var second = date.getSeconds();
            minute = minute < 10 ? ('0' + minute) : minute;
            second = second < 10 ? ('0' + second) : second;
            return y + '-' + m + '-' + d+'  '+h+':'+minute+':'+second;
        };

        function formatDate(inputTime) {
            var date = new Date(inputTime);
            var y = date.getFullYear();
            var m = date.getMonth() + 1;
            m = m < 10 ? ('0' + m) : m;
            var d = date.getDate();
            d = d < 10 ? ('0' + d) : d;
            return y + '-' + m + '-' + d;
        };

        var format = function(time, format) {
            var t = new Date(time);
            var tf = function(i) {
                return (i < 10 ? '0' : '') + i
            };
            return format.replace(/yyyy|MM|dd|HH|mm|ss/g, function(a) {
                switch (a) {
                    case 'yyyy':
                        return tf(t.getFullYear());
                        break;
                    case 'MM':
                        return tf(t.getMonth() + 1);
                        break;
                    case 'mm':
                        return tf(t.getMinutes());
                        break;
                    case 'dd':
                        return tf(t.getDate());
                        break;
                    case 'HH':
                        return tf(t.getHours());
                        break;
                    case 'ss':
                        return tf(t.getSeconds());
                        break;
                }
            });
        }
    </script>
    <body style="background: #ffffff">
        <%-- 个人资料卡片 --%>
        <div class="userInfoCard">
            <fieldset class="layui-elem-field layui-field-title" style="margin:10px 0;">
                <legend>
                    <i class="fa fa-id-card-o" style="color: #009688"></i>&nbsp;&nbsp;<font color="#009688">我的资料卡片</font>
                </legend>
                <button type="button" class="layui-btn layui-btn-primary" id="modifyUserInfo" style="color: #009688">
                    <i class="fa fa-edit" style="color: #009688;"></i>&nbsp;&nbsp;修改资料
                </button>
            </fieldset>
            <div class="layui-card" style="border: none;box-shadow: none;">
                <div class="layui-card-body layui-text" id="myCard">
                    <table class="layui-table">
                        <colgroup>
                            <col width="100"><col>
                        </colgroup>
                        <tbody class="layui-table-tbody">
                            <tr>
                                <th>用户名</th>
                                <td>${sessionScope.userLogin.username}</td>
                                <th>手机号</th>
                                <td>${sessionScope.userLogin.phone}</td>
                                <th>性别</th>
                                <td id="gender"></td>
                            </tr>
                            <tr>
                                <th>邮箱地址</th>
                                <td>${sessionScope.userLogin.email}</td>
                                <th>上次登录时间</th>
                                <td id="lastLoginTime"></td>
                                <th>积分</th>
                                <td>${sessionScope.userLogin.score}</td>
                            </tr>
                            <tr>
                                <th>注册日期</th>
                                <td id="registerDate"></td>
                                <th>上次登出时间</th>
                                <td id="lastLogoutTime"></td>
                                <th>登录次数</th>
                                <td>${sessionScope.userLogin.loginCount}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>


        <%-- 四大按钮区域 --%>
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
            <legend>
                <i class="fa fa-tags" style="color: #009688"></i>&nbsp;&nbsp;<font color="#009688">我的足迹</font>
            </legend>
            <div class="userinfo-area">
                <div class="layui-inline userinfo-img">
                    <a href="${pageContext.request.contextPath}/reception/myOrder.html">
                        <img src="${pageContext.request.contextPath}/static/resources/images/MyOrders.png">
                    </a>
                </div>
                <div class="layui-inline userinfo-img">
                    <a href="${pageContext.request.contextPath}/reception/myTicket.html">
                        <img src="${pageContext.request.contextPath}/static/resources/images/MyCoupons.png">
                    </a>
                </div>
                <div class="layui-inline userinfo-img">
                    <a href="${pageContext.request.contextPath}/reception/myComments.html">
                        <img src="${pageContext.request.contextPath}/static/resources/images/MyComments.png">
                    </a>
                </div>
                <div class="layui-inline userinfo-img">
                    <a href="${pageContext.request.contextPath}/reception/myComplaint.html">
                        <img src="${pageContext.request.contextPath}/static/resources/images/MyComplaint.png">
                    </a>
                </div>
            </div>
        </fieldset>

        <%-- 用户地址管理区域 --%>
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
            <legend>
                <i class="fa fa-building" style="color: #009688"></i>&nbsp;&nbsp;<font color="#009688">我的地址管理</font>
            </legend>
            <div>
                <%-- 表格头部工具栏 --%>
                <script type="text/html" id="toolbarDemo">
                    <div class="layui-btn-container">
                        <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add">
                            <i class="layui-icon layui-icon-add-1"></i>添加
                        </button>
                    </div>
                </script>

                <%-- 表格区域 --%>
                <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter" style="width:100%;"></table>

                <%-- 表格行工具栏 --%>
                <script type="text/html" id="currentTableBar">
                    <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit">
                        <i class="layui-icon layui-icon-edit"></i>编辑
                    </a>
                    <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">
                        <i class="layui-icon layui-icon-delete"></i>删除
                    </a>
                </script>
            </div>
        </fieldset>

        <%-- 修改用户信息弹出框 --%>
        <div class="layui-container" style="display: none;padding: 5px;width: 100%;" id="userInfoForm">
            <form class="layui-form" style="width: 90%" id="dataForm" lay-filter="dataForm">
                <%--表单隐藏域--%>
                <input type="hidden" name="userId" id="userId">
                <div class="layui-form-item">
                    <label class="layui-form-label"><font color="red"> * </font>用户名</label>
                    <div class="layui-input-block">
                        <input type="text" name="username" lay-verify="required" autocomplete="off" class="layui-input" id="username">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label"><font color="red"> * </font>手机号</label>
                    <div class="layui-input-block">
                        <input type="text" name="phone" lay-verify="phone" lay-verify="required" autocomplete="off" class="layui-input" id="phone">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">邮箱地址</label>
                    <div class="layui-input-block">
                        <input type="text" name="email" autocomplete="off" class="layui-input" id="email">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">生日</label>
                    <div class="layui-input-inline">
                        <input type="text" name="birthday" autocomplete="off" placeholder="请输入生日" class="layui-input" id="birthday">
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

        <%-- 添加或修改地址信息弹出框 --%>
        <div class="layui-container" style="display: none;padding: 5px;width: 100%" id="addOrUpdateForm">
            <form class="layui-form" style="width: 90%" id="addressDataForm" lay-filter="dataForm">
                <%--表单隐藏域--%>
                <input type="hidden" name="addressId" id="addressId">
                <input type="hidden" name="userId" id="userId">
                <div class="layui-form-item">
                    <label class="layui-form-label"><font color="red"> * </font>是否首选</label>
                    <div class="layui-input-block">
                        <input type="radio" name="defaulted" value="1" title="是" checked>
                        <input type="radio" name="defaulted" value="0" title="否">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label"><font color="red"> * </font>地址信息</label>
                    <div class="layui-input-block">
                        <input type="text" name="address" lay-verify="required" autocomplete="off" class="layui-input" id="address">
                    </div>
                </div>

                <div class="layui-form-item layui-row layui-col-md12">
                    <div class="layui-input-block" style="text-align: center">
                        <button type="button" class="layui-btn layui-btn-checked" lay-submit lay-filter="addressSubmit">
                            <span class="layui-icon layui-icon-add-1"></span>提交
                        </button>
                        <button type="reset" class="layui-btn layui-btn-primary" lay-reset lay-filter="addressReset">
                            <span class="layui-icon layui-icon-refresh"></span>重置
                        </button>
                    </div>
                </div>
            </form>
        </div>


    </body>
    <script src="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>

    <script type="text/html" id="demo2">

    </script>

    <%-- 编写模版。使用一个script标签存放模板 --%>
    <script id="demo" type="text/html">
        <fieldset class="layui-elem-field layui-field-title userinfo-field" style="margin-top: 20px;">
            <legend> <font color="#1e9fff">{{ d.title }}</font> </legend>
            <div class="layui-container userinfo-container">
                {{#  layui.each(d.list, function(index, item){ }}
                    <div class="layui-col-md4 userinfo-item">
                        <span>{{ item.modname }}：</span>
                        <span>{{ item.site || '未填写' }}</span>
                {{#  }); }}
                {{#  if(d.list.length === 0){ }}
                        <span>无数据</span>
                {{#  } }}
                    </div>
            </div>
        </fieldset>
    </script>

    <script>
        document.getElementById("gender").innerHTML = gender(${sessionScope.userLogin.gender});
        document.getElementById("lastLoginTime").innerHTML = formatDateTime(new Date("${sessionScope.userLogin.lastLoginTime}"));
        document.getElementById("lastLogoutTime").innerHTML = formatDateTime(new Date("${sessionScope.userLogin.lastLogoutTime}"));
        document.getElementById("registerDate").innerHTML = formatDate(new Date("${sessionScope.userLogin.registerDate}"));

        layui.use(['jquery', 'laytpl', 'layer', 'form', 'laydate', 'table'], function() {
            var $ = layui.jquery,
                form = layui.form,
                laydate = layui.laydate,
                table = layui.table,
                laytpl = layui.laytpl,
                layer = layui.layer;

            var url;//提交的请求地址
            var index;//打开窗口的索引

            //执行一个laydate实例
            laydate.render({
                elem: '#birthday' //指定元素
                ,type: 'date'   //指定选择的格式
            });

            /**
             * 数据表单初始化
             */
            var tableIns = table.render({
                elem: '#currentTableId',
                url: '${pageContext.request.contextPath}/address/list',
                data:{
                    userId: ${sessionScope.userLogin.userId}
                },
                toolbar: '#toolbarDemo',
                defaultToolbar: ['filter', 'exports', 'print', {
                    title: '提示',
                    layEvent: 'LAYTABLE_TIPS',
                    icon: 'layui-icon-tips'
                }],
                cols: [[
                    {type: "checkbox", width: 50, align: "center"},
                    {field: 'addressId', width: 120, title: '地址编号', sort: true, align: "center"},
                    {field: 'defaulted', width: 120, title: '是否首选', templet: function (d) {
                        switch (d.defaulted) {
                            case 1:
                                return "<font color='red'>是</font>";
                            case 0:
                                return "否";
                        }
                    }, align: "center"},
                    {field: 'address', minWidth: 450, title: '地址信息', align: "center", sort: true},
                    {title: '操作', width: 200, toolbar: '#currentTableBar', align: "center"}
                ]],
                limits: [5],
                limit: 5,
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
             * 监听修改用户信息按钮的点击事件
             */
            $("#modifyUserInfo").click(function () {
                index = layer.open({
                    title: '编辑用户',
                    type: 1,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['45%', '70%'],
                    offset: ['50px', '300px'],
                    content: $("#userInfoForm"),
                    success: function(){
                        $.post("${pageContext.request.contextPath}/user/findUserByUserId", function (result) {
                            console.log(result);
                            //表单数据回显，参数1表示lay-filter的值，参数2表示回显的数据
                            $("#userId").val(${sessionScope.userLogin.userId});
                            $("#username").val(result.userLogin.username);
                            $("#phone").val(result.userLogin.phone);
                            $("#email").val(result.userLogin.email);
                            $("#birthday").val(result.userLogin.birthday);
                            $('input[name=gender][value="0"]').attr("checked", (result.userLogin.gender=='0' ? true : false));
                            $('input[name=gender][value="1"]').attr("checked", (result.userLogin.gender=='1' ? true : false));
                            $('input[name=gender][value="2"]').attr("checked", (result.userLogin.gender=='2' ? true : false));
                            //重新渲染表单的单选框按钮
                            form.render('radio');
                        }, "json");
                        //添加的提交请求
                        url = "${pageContext.request.contextPath}/user/modifyUserInfo"
                    }
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
            });

            /**
             * 编写用户信息编辑表单提交的监听事件,doSubmit是提交按钮的lay-filter的值
             */
            form.on("submit(doSubmit)", function(data){
                //使用ajax的post请求去传递数据
                $.post(url, data.field, function(result){
                    if (result.flag){
                        //刷新页面
                        window.location.reload();
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
             * 编写地址信息表单提交的监听事件,doSubmit是提交按钮的lay-filter的值
             */
            form.on("submit(addressSubmit)", function(data){
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
                        title: '添加地址',
                        type: 1,
                        shade: 0.2,
                        maxmin:true,
                        shadeClose: true,
                        area: ['45%', '42%'],
                        offset: ['150px', '300px'],
                        content: $("#addOrUpdateForm"),
                        success: function () {
                            //清空表单数据
                            $("#dataForm")[0].reset();
                            $("#address").val("");
                            //添加的提交请求路径赋值
                            url = "${pageContext.request.contextPath}/address/add";
                        }
                    });
                    $(window).on("resize", function () {
                        layer.full(index);
                    });
                }
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
                        area: ['45%', '42%'],
                        offset: ['150px', '300px'],
                        content: $("#addOrUpdateForm"),
                        success: function(){
                            //表单数据回显，参数1表示lay-filter的值，参数2表示回显的数据
                            form.val("dataForm", data);
                            //添加的提交请求
                            url = "${pageContext.request.contextPath}/address/modify"
                        }
                    });
                    $(window).on("resize", function () {
                        layer.full(index);
                    });
                    return false;
                } else if (obj.event === 'delete') {
                    var addressId = data.addressId;
                    layer.confirm('确定要删除该地址吗？', {icon: 3, title:'提示'}, function(index){
                        url = "${pageContext.request.contextPath}/address/delete";
                        $.post(url, {addressId: addressId}, function (result) {
                            if (result.flag){
                                //刷新数据表格
                                tableIns.reload();
                            }
                            layer.msg(result.message);
                        }, "json");
                        layer.close(index);
                    });
                }
            });



        });


    </script>
</html>
