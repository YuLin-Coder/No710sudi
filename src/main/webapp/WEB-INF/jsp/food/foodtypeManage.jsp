<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <meta charset="utf-8">
        <title>菜品类别管理</title>
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/css/layui.css" media="all">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/css/public.css" media="all">
        <%-- 添加layui-dtree的css样式 --%>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui_ext/dtree/dtree.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui_ext/dtree/font/dtreefont.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/resources/css/foodtypeManage.css">
    </head>
    <script>
        var flag;//控制行工具栏显示的标识符
    </script>
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
                                    <label class="layui-form-label">类别编号</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="typeId" autocomplete="off" class="layui-input" onkeyup="value=value.replace(/[^0-9]/g,'')">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">类别名称</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="typeName" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">类别状态</label>
                                    <div class="layui-input-inline">
                                        <select id="typeStatus" name="typeStatus" style="height: 32px;width: 150px;text-align: center;">
                                            <option value="0" selected=""></option>
                                            <option value="1">使用中</option>
                                            <option value="2">下架</option>
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
                    {{# if(!flag){ }}
                    <a class="layui-btn layui-btn-xs layui-btn data-count-delete" lay-event="onShelf" id="onShelf">
                        <i class="layui-icon layui-icon-play"></i>上架
                    </a>
                    {{# } else{}}
                    <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit" id="edit">
                        <i class="layui-icon layui-icon-edit"></i>编辑
                    </a>
                    <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="offShelf" id="offShelf">
                        <i class="layui-icon layui-icon-pause"></i>下架
                    </a>
                    {{# }}}
                </script>

                <%-- 添加或修改弹出框 --%>
                <div class="layui-container" style="display: none;padding: 5px;width: 100%;" id="addOrUpdateForm">
                    <form class="layui-form" style="width: 90%" id="dataForm" lay-filter="dataForm">
                        <%--表单隐藏域--%>
                        <input type="hidden" name="typeId" id="typeId">
                        <div class="layui-form-item">
                            <label class="layui-form-label"><font color="red"> * </font>类别名称</label>
                            <div class="layui-input-inline">
                                <input type="text" name="typeName" lay-verify="required" autocomplete="off" class="layui-input" id="typeName">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label"><font color="red"> * </font>类别描述</label>
                            <div class="layui-input-block">
                                <textarea name="typeDesc" placeholder="请输入内容" lay-verify="required" class="layui-textarea" id="typeDesc" style="height: 120px;"></textarea>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-inline" style="width: 100%">
                                <label class="layui-form-label"><font color="red"> * </font>类别图片</label>
                                <div class="layui-upload-list layui-inline" id="imageBox" style="width: 817px;">
                                    <input type="hidden" name="typeImage" id="typeImage" value="foodtype/defaultImage/defaultImage.png" lay-verify="required">
                                    <a href="javascript:void(0);" style="width: 100%">
                                        <img class="upload-img" id="photoShow" src="/sudi/upload/foodtype/defaultImage/defaultImage.png">
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item layui-row layui-col-md12">
                            <div class="layui-input-block" style="text-align: center">
                                <button type="button" class="layui-btn layui-btn-checked" lay-submit lay-filter="doSubmit">
                                    <span class="layui-icon layui-icon-add-1"></span>提交
                                </button>
                                <button type="reset" class="layui-btn layui-btn-primary" lay-reset lay-filter="doReset" id="doReset">
                                    <span class="layui-icon layui-icon-refresh"></span>重置
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </body>
    <script src="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
    <script>
        layui.use(['form', 'table', 'jquery', 'upload', 'layer'], function () {
            var $ = layui.jquery,
                form = layui.form,
                table = layui.table,
                upload = layui.upload,
                layer = layui.layer;

            var url;//提交的请求地址
            var index;//打开窗口的索引

            /**
             * 数据表单初始化
             */
            var tableIns = table.render({
                elem: '#currentTableId',
                url: '${pageContext.request.contextPath}/backstage/foodtype/list',
                toolbar: '#toolbarDemo',
                defaultToolbar: ['filter', 'exports', 'print', {
                    title: '提示',
                    layEvent: 'LAYTABLE_TIPS',
                    icon: 'layui-icon-tips'
                }],
                cols: [[
                    {type: "checkbox", width: 50, align: "center"},
                    {field: 'typeId', width: 160, title: '菜品类别编号', align: "center", sort: true},
                    {field: 'typeName', minWidth: 140, title: '菜品类别名', align: "center"},
                    {field: 'lastModifyBy', width: 140, title: '上次修改人', align: "center"},
                    {field: 'lastModifyTime', width: 200, title: '上次修改时间', align: "center", sort: true,
                        templet:"<div>{{layui.util.toDateString(d.lastModifyTime, 'yyyy-MM-dd HH:mm:ss')}}</div>"
                    },
                    {field: 'typeStatus', width: 140, title: '类别状态', sort: true, align: "center",
                        templet: function (d) {
                            if (d.typeStatus == 1){
                                flag = true;
                                return "<font color='blue'>使用中</font>";
                            }else {
                                flag = false;
                                return "<font color='red'>下架</font>";
                            }
                        }
                    },
                    {title: '操作', width: 240, toolbar: '#currentTableBar', align: "center"}
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
                data.field.typeStatus = null;
            });

            /**
             * 渲染文件上传区域
             */
            upload.render({
                elem: "#photoShow",  //绑定元素
                url: "${pageContext.request.contextPath}/backstage/foodtype/uploadFile",    //文件上传后台处理路径
                acceptMime: "image/*",  //规定打开文件选择框时筛选出的文件类型
                field: "foodtypeImage",  //文件上传的字段值，等同于input标签的name，必须和后台处理路径的方法参数名一致
                method: "post",     //提交方式
                //文件上传成功之后的回调函数
                done: function (res, index, upload) {
                    console.log(res);
                    console.log(index);
                    console.log(upload);
                    layer.msg(res.msg);
                    //上传的图片回显
                    $("#photoShow").attr("src", res.data.src);
                    //改变背景颜色
                    $("#imageBox").css("background", "#ffffff");
                    //给隐藏域赋值，只需要后半截，前边的是通用的路径，不需要保存到数据库中
                    $("#typeImage").val(res.data.imagePath);
                }
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
                        title: '添加菜品类别',
                        type: 1,
                        shade: 0.2,
                        maxmin:true,
                        shadeClose: true,
                        area: ['80%', '70%'],
                        offset: ['50px', '120px'],
                        content: $("#addOrUpdateForm"),
                        success: function () {
                            //清空表单数据
                            $("#dataForm")[0].reset();
                            //重置默认图片
                            $("#photoShow").attr("src", "/sudi/upload/foodtype/defaultImage/defaultImage.png");
                            //重置默认图片
                            $("#photoShow").attr("src", "/sudi/upload/foodtype/defaultImage/defaultImage.png");
                            //重置隐藏域
                            $("#typeImage").val("foodtype/defaultImage/defaultImage.png");
                            //添加的提交请求路径赋值
                            url = "${pageContext.request.contextPath}/backstage/foodtype/add";
                        }
                    });
                    $(window).on("resize", function () {
                        layer.full(index);
                    });
                }
            });

            /**
             * 编写表单重置按钮的监听事件,doReset是提交按钮的lay-filter的值
             */
            $("#doReset").click(function () {
                //重置图片回显为默认的图片
                $("#photoShow").attr("src", "/sudi/upload/foodtype/defaultImage/defaultImage.png");
                //重置隐藏域为默认值
                $("#imageUrl").val("foodtype/defaultImage/defaultImage.png");
                //普通输入框文本域置空
                $("#realName").val("");
                $("#remark").val("");
                //禁止页面刷新
                return false;
            });

            /**
             * 监听表单行工具栏事件
             */
            table.on('tool(currentTableFilter)', function (obj) {
                var data = obj.data;
                console.log(data);
                if (obj.event === 'edit') {
                    index = layer.open({
                        title: '编辑菜品列表',
                        type: 1,
                        shade: 0.2,
                        maxmin:true,
                        shadeClose: true,
                        area: ['80%', '70%'],
                        offset: ['50px', '120px'],
                        content: $("#addOrUpdateForm"),
                        success: function(){
                            //表单数据回显，参数1表示lay-filter的值，参数2表示回显的数据
                            form.val("dataForm", data);
                            //重新渲染表单
                            form.render();
                            //添加的提交请求
                            url = "${pageContext.request.contextPath}/backstage/foodtype/modify";
                            //设置图片回显
                            $("#photoShow").attr("src", "/sudi/upload/" + data.typeImage);
                        }
                    });
                }else if (obj.event === "offShelf") {
                    var str = '确定要对<font color="red">【' +data.typeName+ '】</font>类别进行下架操作吗?\n下架操作将使用户无法正常浏览该类别下的所有菜品';
                    layer.confirm(str, {icon: 3, title:'提示'}, function(index){
                        $.post("${pageContext.request.contextPath}/backstage/foodtype/offShelf", {typeId: data.typeId}, function (result) {
                            if (result.flag){
                                //重新加载
                                tableIns.reload();
                            }
                            layer.msg(result.message);
                        },"json");
                        layer.close(index);
                    });
                }else if (obj.event === 'onShelf') {
                    var str = '确定要对<font color="red">【' +data.typeName+ '】</font>类别进行恢复上架操作吗?';
                    layer.confirm(str, {icon: 3, title:'提示'}, function(index){
                        $.post("${pageContext.request.contextPath}/backstage/foodtype/onShelf", {typeId: data.typeId}, function (result) {
                            if (result.flag){
                                //重新加载
                                tableIns.reload();
                            }
                            layer.msg(result.message);
                        },"json");
                        layer.close(index);
                    });
                }else if (obj.event === 'delete') {
                    var str = '确定要对<font color="red">【' +data.typeName+ '】</font>类别进行删除操作吗?\n删除菜品类别必须确保没有菜品属于类别！';
                    layer.confirm(str, {icon: 3, title:'提示'}, function(index){
                        $.post("${pageContext.request.contextPath}/backstage/foodtype/delete", {typeId: data.typeId}, function (result) {
                            console.log(result);
                            if (result.flag){
                                //重新加载
                                tableIns.reload();
                            }
                            layer.msg(result.message);
                        },"json");
                        layer.close(index);
                    });
                }
            });
        });
    </script>
</html>
