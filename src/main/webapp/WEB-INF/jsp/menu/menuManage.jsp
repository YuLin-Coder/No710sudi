<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <meta charset="utf-8"/>
        <title>菜单管理</title>
        <meta name="renderer" content="webkit"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximun-scale=1"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/css/layui.css" media="all"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/css/layuimini.css?v=2.0.4.2" media="all"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/css/themes/default.css" media="all"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/lib/font-awesome-4.7.0/css/font-awesome.css" media="all"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/css/public.css" media="all"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui_ext/dtree/dtree.css" media="all"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui_ext/dtree/font/dtreefont.css" media="all"/>
        <%-- 添加layui-dtree的css样式 --%>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui_ext/dtree/dtree.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui_ext/dtree/font/dtreefont.css"/>
    </head>
    <body>
        <div class="layuimini-container">
            <div class="layuimini-main">
                <div class="layui-row" style="margin-top: -10px;">
                    <%-- 左侧菜单树 --%>
                    <div class="layui-col-md2" style="margin-top: 10px;">
                        <%-- 树节点容器开始 --%>
                        <ul id="menuTree" class="dtree" data-id="0" style="width: 240px;"></ul>
                        <%-- 树节点容器结束 --%>
                    </div>

                    <%-- 右侧数据表格 --%>
                    <div class="layui-col-md10">

                        <%-- 表格工具栏 --%>
                        <script type="text/html" id="toolbarDemo">
                            <div class="layui-btn-container">
                                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add">
                                    <i class="layui-icon layui-icon-add-1"></i> 添加
                                </button>
                            </div>
                        </script>


                        <%-- 数据表格 --%>
                        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>


                        <%-- 表格行工具栏 --%>
                        <script type="text/html" id="currentTableBar">
                            <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit">
                                <i class="layui-icon layui-icon-edit"></i>编辑
                            </a>
                            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">
                                <i class="layui-icon layui-icon-delete"></i>删除
                            </a>
                        </script>


                        <%-- 弹出框 --%>
                        <div style="display: none;padding: 5px" id="addOrUpdateForm">
                            <form class="layui-form" id="dataForm" lay-filter="dataForm">
                                <%--表单隐藏域--%>
                                <input type="hidden" name="id">

                                <div class="layui-form-item">
                                    <label class="layui-form-label">父级菜单</label>
                                    <div class="layui-input-block">
                                        <%--表单隐藏域，保存选中的父级菜单ID--%>
                                        <input type="hidden" name="pid" id="pid">
                                        <div class="layui-inline layui-col-md10">
                                            <ul id="selectTree" class="dtree" data-id="0"></ul>
                                        </div>
                                        <div class="layui-inline">
                                            <a class="layui-btn layui-btn-primary" lay-filter="resetPid" id="resetPid">
                                                <span class="layui-icon layui-icon-refresh"></span>重置
                                            </a>
                                        </div>
                                    </div>
                                </div>

                                <div class="layui-form-item" style="width: 97%;">
                                    <label class="layui-form-label"><font color="red"> * </font>菜单名称</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="title" lay-verify="required" autocomplete="off" placeholder="请输入菜单名称" class="layui-input" id="title">
                                    </div>
                                </div>

                                <div class="layui-form-item" style="width: 97%;">
                                    <label class="layui-form-label">菜单地址</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="href" autocomplete="off" placeholder="请输入菜单地址" class="layui-input" id="href">
                                    </div>
                                </div>

                                <div class="layui-form-item">
                                    <label class="layui-form-label">菜单图标</label>
                                    <div class="layui-input-block" style="position: relative">
                                        <%--表单隐藏域，保存选中的icon值--%>
                                        <input type="hidden" name="icon" id="icon">
                                        <input type="text" name="iconFa" id="iconPicker" lay-filter="iconPicker" autocomplete="off">
                                        <div class="layui-inline" style="position: absolute;top: 0;left:100px;">
                                            <a class="layui-btn layui-btn-primary" lay-filter="resetIcon" id="resetIcon">
                                                <span class="layui-icon layui-icon-refresh"></span>重置
                                            </a>
                                        </div>
                                    </div>
                                </div>

                                <div class="layui-form-item">
                                    <label class="layui-form-label"><font color="red"> * </font>是否展开</label>
                                    <div class="layui-input-block">
                                        <input type="radio" name="spread" value="1" title="是">
                                        <input type="radio" name="spread" value="0" title="否" checked>
                                    </div>
                                </div>

                                <div class="layui-form-item layui-row">
                                    <div class="layui-input-block" style="margin-left: 38%;">
                                        <button type="button" class="layui-btn layui-btn-normal" lay-submit lay-filter="doSubmit">
                                            <span class="layui-icon layui-icon-add-1"></span>提交
                                        </button>
                                        <a class="layui-btn layui-btn-danger" lay-filter="doReset" id="doReset">
                                            <span class="layui-icon layui-icon-delete"></span>清空
                                        </a>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>

    <script src="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
    <script>

        layui.extend({
            //继承第三方插件
            // layui-dtree脚本js文件的路径，不需要我们自己加.js，加了反而报错
            dtree: "${pageContext.request.contextPath}/static/plugins/layui_ext/dtree/dtree",
            //添加图标解析器
            iconPickerFa: "${pageContext.request.contextPath}/static/plugins/layui/js/lay-module/iconPicker/iconPickerFa"
        }).use(['form', 'table', 'jquery', 'dtree', 'layer', 'iconPickerFa'], function () {
            var $ = layui.jquery,
                form = layui.form,
                layer = layui.layer,
                table = layui.table,
                iconPickerFa = layui.iconPickerFa,
                dtree = layui.dtree;

            var url;//提交的请求地址
            var index;//打开窗口的索引

            /**
             * 渲染左侧的菜单树
             */
            var menuTree = dtree.render({
                elem: "#menuTree",
                url: "${pageContext.request.contextPath}/backstage/menu/loadLeftMenuTree", // 使用url加载（可与data加载同时存在）
                dataStyle: "layuiStyle", //使用layui风格的数据格式
                dataFormat: "list", //配置data的风格为list
                line: true, // 无树线
                skin: "laySimple",
                ficon: ["0", "7"],
                response: {message: "msg", statusCode: 0}, //修改response中返回数据的定义
                checkbarType: "all" //默认就是all，其他的值为： no-all  p-casc   self  only，效果参考帮助文档-案例演示-开启复选框
            });

            /**
             * 渲染右侧表格区域
             */
            var tableIns = table.render({
                elem: '#currentTableId',
                url: '${pageContext.request.contextPath}/backstage/menu/loadRightMenuTable',
                toolbar: '#toolbarDemo',
                defaultToolbar: ['filter', 'exports', 'print', {
                    title: '提示',
                    layEvent: 'LAYTABLE_TIPS',
                    icon: 'layui-icon-tips'
                }],
                cols: [[
                    {type: "checkbox", width: 50, align: "center"},
                    {field: 'id', width: 112, title: '菜单编号', sort: true, align: "center"},
                    {field: 'title', width: 140, title: '菜单名称', align: "center"},
                    {field: 'href', minWidth: 200, title: '菜单地址', align: "center"},
                    {
                        field: 'spread', width: 100, title: '是否展开', align: "center",
                        templet: function (d) {
                            switch (d.spread) {
                                case 0:
                                    return "<font color='blue'>否</font>";
                                case 1:
                                    return "<font color='#ff4500'>是</font>";
                                default:
                                    return "未知";
                            }
                        },
                    },
                    {
                        field: 'icon', width: 100, title: '菜单图标', align: "center",
                        templet: function (d) {
                            return "<i class='" + d.icon + "'></i>";
                        }
                    },
                    {title: '操作', width: 180, toolbar: '#currentTableBar', align: "center"}
                ]],
                limits: [10, 15, 20, 25, 50, 100],
                limit: 25,
                page: true,
                skin: 'line',
                //当最后一页的数据被删完后，可以自动返回到上一页
                done: function (res, curr, count) {
                    //判断当前页码是否大于1并且当前页的数据量是否为0
                    if (curr > 1 && res.data.length == 0) {
                        var pageValue = curr - 1;
                        //刷新数据表格的数据
                        tableIns.reload({
                            page: {curr: pageValue}
                        })
                    }
                }
            });

            /**
             * 监听左侧菜单树的节点点击事件
             */
            dtree.on("node('menuTree')", function (obj) {
                //nodeId是当前节点的ID值
                tableIns.reload({
                    where: {id: obj.param.nodeId},
                    page: {
                        curr: 1
                    }
                });
            });

            /**
             * 渲染菜单树下拉列表
             */
            var selectTree = dtree.renderSelect({
                elem: "#selectTree",
                width: "100%", // 指定树的宽度
                dataStyle: "layuiStyle", //使用layui风格的数据格式
                dataFormat: "list", //配置data的风格为list
                line: false, // 无树线
                skin: "layui",
                ficon: ["0", "7"],
                selectTips: "请选择，不选则默认为顶级菜单", //下拉框默认提示语
                response: {message: "msg", statusCode: 0}, //修改response中返回数据的定义
                url: "${pageContext.request.contextPath}/backstage/menu/loadLeftMenuTree"
            });

            /**
             * 监听下拉菜单树的点击事件，并将值赋给隐藏域
             */
            dtree.on("node(selectTree)", function (obj) {
                //将值赋给父级菜单隐藏域
                $("#pid").val(obj.param.nodeId);
            })

            /**
             * 初始化图标选择器组件
             */
            iconPickerFa.render({
                elem: "#iconPicker",    //图标选择器组件的选择器，推荐用input类型
                url: "${pageContext.request.contextPath}/static/plugins/layui/lib/font-awesome-4.7.0/less/variables.less",  //fa 图标接口
                search: true,   //是否开启搜索功能
                page: true,    //是否开启分页
                limit: 12,    //每页显示数量
                click: function (data) {    //点击之后的回调函数
                    //给icon的隐藏域赋值
                    $("#icon").val("fa " + data.icon);
                },
                success: function () {  //成功的回调函数
                    /**
                     * 设置图表选择器的初始图标为空
                     */
                    iconPickerFa.checkIcon('iconPicker', '');
                }
            });

            /**
             * 监听表格头部工具栏的点击事件
             */
            table.on("toolbar(currentTableFilter)", function (obj) {
                if (obj.event === "add"){
                    index = layer.open({
                        title: "添加菜单",  //标题
                        type: 1,
                        content: $("#addOrUpdateForm"), //内容
                        area: ['65%', '65%'],   //宽高
                        offset: ['75px', '200px'],
                        anim: 2,    //动画效果
                        success: function(){
                            //清空表单数据
                            $("#dataForm")[0].reset();
                            selectTree.selectResetVal();
                            $("#pid").val(null);
                            iconPickerFa.checkIcon('iconPicker', '');
                            $("#icon").val(null);
                            //添加提交请求地址
                            url = "${pageContext.request.contextPath}/backstage/menu/add";
                        }
                    })
                }
            });

            /**
             * 监听表单提交事件
             */
            form.on("submit(doSubmit)", function (data) {
                $.post(url, data.field, function (result) {
                    if (result.flag){
                        //刷新数据表格
                        tableIns.reload();
                        //刷新左侧菜单树
                        menuTree.reload();
                        //刷新下拉树
                        selectTree.reload();
                        //关闭当前窗口
                        layer.close(index);
                    }
                    //弹出提示信息
                    layer.msg(result.message);
                }, "json");
            });

            /**
             * 重置下拉菜单的选择
             */
            $("#resetPid").click(function () {
                selectTree.selectResetVal();
                //父级菜单隐藏域置空
                $("#pid").val(null);
            });

            /**
             * 重置图标选择器的选择
             */
            $("#resetIcon").click(function () {
                //重置图表选择器的初始图标
                iconPickerFa.checkIcon('iconPicker', '');
                //icon隐藏域置空
                $("#icon").val(null);
            });

            /**
             * 监听表单清空按钮点击事件
             */
            $("#doReset").click(function () {
                selectTree.selectResetVal();
                //父级菜单隐藏域置空
                $("#pid").val(null);
                //重置图表选择器的初始图标
                iconPickerFa.checkIcon('iconPicker', '');
                $("#icon").val('');
                //重置其他输入框
                $("#href").val('');
                $("#title").val('');
            });

            /**
             * 监听表格行工具栏事件
             */
            table.on("tool(currentTableFilter)", function (obj) {
                if (obj.event === "edit"){
                    index = layer.open({
                        title: "修改菜单",  //标题
                        type: 1,
                        content: $("#addOrUpdateForm"), //内容
                        area: ['65%', '81%'],   //宽高
                        offset: '50px', //快速设置距离顶部的坐标
                        anim: 2,    //动画效果
                        success: function(){
                            //表单数据回显，参数1表示lay-filter的值，参数2表示回显的数据
                            form.val("dataForm", obj.data);
                            //添加提交请求地址
                            url = "${pageContext.request.contextPath}/backstage/menu/modify";
                            if (obj.data.pid == 0){
                                //父级菜单为顶层菜单需要刷新一下下拉菜单树
                                selectTree.reload();
                            }
                            //下拉菜单树回显（参数1：下拉菜单树根的ID；参数2：回显数值）
                            dtree.dataInit("selectTree", obj.data.pid);
                            //设置显示的值（参数1：下拉菜单树根的ID）
                            dtree.selectVal("selectTree");
                            //选中图标回显
                            iconPickerFa.checkIcon('iconPicker', obj.data.icon);
                        }
                    });
                }else if (obj.event === "delete"){
                    layer.confirm('确定要删除<font color="red">【'+ obj.data.title +'】</font>菜单吗?',{icon: 3, title:'提示', offset: ['150px', '450px']},function(index){
                        $.post("${pageContext.request.contextPath}/backstage/menu/delete", {menuId: obj.data.id}, function (result) {
                            if (result.flag){
                                tableIns.reload();
                                menuTree.reload();
                                selectTree.reload();
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

