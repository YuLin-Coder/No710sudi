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
                        <form class="layui-form layui-form-pane" action="">
                            <div class="layui-form-item">

                                <div class="layui-inline">
                                    <label class="layui-form-label">角色ID</label>
                                    <div class="layui-input-inline">
                                        <input type="number" name="roleId" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">角色名称</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="roleName" autocomplete="off" class="layui-input">
                                    </div>
                                </div>

                                <div class="layui-inline">
                                    <button type="submit" class="layui-btn layui-btn-primary"  lay-submit lay-filter="data-search-btn">
                                        <i class="layui-icon layui-icon-search"></i>搜索
                                    </button>
                                    <button type="reset" class="layui-btn layui-btn-primary"  lay-submit lay-filter="data-reset-btn">
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
                            <i class="layui-icon layui-icon-add-1"></i>添加 </button>
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
                    <a class="layui-btn layui-btn-xs layui-btn-checked data-count-grant" lay-event="grant">
                        <i class="layui-icon layui-icon-about"></i>授权菜单
                    </a>
                </script>

                <%-- 弹出框 --%>
                <div style="display: none;padding: 5px" id="addOrUpdateForm">
                    <form class="layui-form" style="width: 90%" id="dataForm" lay-filter="dataForm">
                        <%--表单隐藏域--%>
                        <input type="hidden" name="roleId">
                        <div class="layui-form-item">
                            <label class="layui-form-label"><font color="red"> * </font>角色名称</label>
                            <div class="layui-input-block">
                                <input type="text" name="roleName" lay-verify="required" autocomplete="off" placeholder="请输入角色名称" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label"><font color="red"> * </font>角色描述</label>
                            <div class="layui-input-block">
                                <textarea name="roleDesc" lay-verify="required" autocomplete="off" placeholder="请输入角色描述信息" class="layui-textarea"></textarea>
                            </div>
                        </div>

                        <div class="layui-form-item layui-row layui-col-xs12">
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

            </div>
        </div>
        <script src="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
        <script>

            layui.extend({
                //继承第三方插件
                // layui-dtree脚本js文件的路径，不需要我们自己加.js，加了反而报错
                dtree: "${pageContext.request.contextPath}/static/plugins/layui_ext/dtree/dtree",
            }).use(['form', 'table', 'jquery', 'dtree'], function () {
                var $ = layui.jquery,
                    form = layui.form,
                    table = layui.table,
                    dtree = layui.dtree;

                var url;//提交的请求地址
                var index;//打开窗口的索引

                var tableIns = table.render({
                    elem: '#currentTableId',
                    url: '${pageContext.request.contextPath}/backstage/role/list',
                    toolbar: '#toolbarDemo',
                    defaultToolbar: ['filter', 'exports', 'print', {
                        title: '提示',
                        layEvent: 'LAYTABLE_TIPS',
                        icon: 'layui-icon-tips'
                    }],
                    cols: [[
                        {type: "checkbox", width: 50},
                        {field: 'roleId', width: 120, title: '角色编号', sort: true, align: "center"},
                        {field: 'roleName', width: 160, title: '角色名称', align: "center"},
                        {field: 'roleDesc', minWidth: 300, title: '角色描述', align: "center"},
                        {field: 'lastModifyBy', width: 160, title: '修改人', align: "center"},
                        {field: 'lastModifyTime', width: 200, title: '修改时间', align: "center", sort:true,
                            templet:"<div>{{layui.util.toDateString(d.lastModifyTime, 'yyyy-MM-dd HH:mm:ss')}}</div>"
                        },
                        {title: '操作', minWidth: 250, toolbar: '#currentTableBar', align: "center"}
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
                 * toolbar监听事件
                 */
                table.on('toolbar(currentTableFilter)', function (obj) {
                    if (obj.event === 'add') {  // 监听添加操作
                        index = layer.open({
                            title: '新增角色',
                            type: 1,
                            shade: 0.2,
                            maxmin:true,
                            shadeClose: true,
                            area: ['50%', '60%'],
                            offset:['100px', '300px'],
                            content: $("#addOrUpdateForm"),
                            success: function () {
                                //清空表单数据
                                $("#dataForm")[0].reset();
                                //添加的提交请求路径赋值
                                url = "${pageContext.request.contextPath}/backstage/role/add";
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
                 * 监听表格行工具栏的点击事件
                 */
                table.on('tool(currentTableFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'edit') {
                        index = layer.open({
                            title: '编辑角色',
                            type: 1,
                            shade: 0.2,
                            maxmin:true,
                            shadeClose: true,
                            area: ['50%', '60%'],
                            offset:['100px', '300px'],
                            content: $("#addOrUpdateForm"),
                            success: function(){
                                //表单数据回显，参数1表示lay-filter的值，参数2表示回显的数据
                                form.val("dataForm", data);
                                //添加的提交请求
                                url = "${pageContext.request.contextPath}/backstage/role/modify";
                            }
                        });
                        $(window).on("resize", function () {
                            layer.full(index);
                        });
                        return false;
                    } else if (obj.event === 'delete') {
                        var roleId = data.roleId;
                        layer.confirm('确定要删除名为<font color="#ff4500">【' + data.roleName + '】</font>的角色吗？', {icon: 3, title:'提示'}, function(index){
                            url = "${pageContext.request.contextPath}/backstage/role/delete";
                            $.post(url, {roleId: roleId}, function (result) {
                                if (result.flag){
                                    //刷新数据表格
                                    tableIns.reload();
                                }
                                layer.msg(result.message);
                            }, "json");
                            layer.close(index);
                        });
                    }else if (obj.event === 'grant') {
                        index = layer.open({
                            title: '角色[<font color="red">'+data.roleName+'</font>]的菜单授权',
                            type: 1,
                            shade: 0.2,
                            maxmin:true,
                            shadeClose: true,
                            area: ['400px', '480px'],
                            offset: ['75px', '450px'],
                            content: $("#grantMenu"),
                            btn: ['<span class="layui-icon layui-icon-ok"> </span>确定', '<span class="layui-icon layui-icon-close"> </span>取消'],
                            yes: function(index, layero){ //确定按钮的回调
                                var param = dtree.getCheckbarNodesParam("roleTree");//获取复选框的选中值
                                if (param.length > 0){//判断是否选中了复选框
                                    var menuIdArray = [];//定义一个数组，用于存放选中的菜单ID
                                    for (var i = 0; i < param.length; i++) {//循环遍历获取选中的节点
                                        menuIdArray.push(param[i].nodeId);//将选中的菜单ID加到数组中去，nodeId是dtree要求的固定写法
                                    }
                                    var menuIds = menuIdArray.join(",");//将数组转换为JSON格式的字符串
                                    //发送ajax的post请求
                                    $.post("${pageContext.request.contextPath}/backstage/role/grantMenu", {menuIds: menuIds, roleId: data.roleId}, function (result) {
                                        layer.msg(result.message);
                                    }, "json");
                                    layer.close(index);
                                }else{
                                    layer.msg("请您选择至少一个的复选框!");
                                }
                            },
                            btn2: function(index, layero){
                                //按钮【按钮二】的回调

                                //return false 开启该代码可禁止点击该按钮关闭
                            },
                            cancel: function(){
                                //右上角关闭回调

                                //return false 开启该代码可禁止点击该按钮关闭
                            },
                            success: function(){
                                // 渲染dtree组件，初始化树
                                var DemoTree = dtree.render({
                                    elem: "#roleTree", //dtree树的对应 <ul> id值
                                    url: "${pageContext.request.contextPath}/backstage/role/initRoleMenu?roleId=" + data.roleId, // 初始化树的远程请求路径
                                    dataStyle: "layuiStyle", //使用layui风格的数据格式
                                    dataFormat: "list", //配置data的风格为list
                                    response: {message: "msg", statusCode: 0}, //修改response中返回数据的定义
                                    checkbar: true, //开启复选框
                                    checkbarType: "all" //默认就是all，其他的值为： no-all  p-casc   self  only
                                });
                            }
                        });
                        $(window).on("resize", function () {
                            layer.full(index);
                        });
                        return false;
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

    </body>
</html>
