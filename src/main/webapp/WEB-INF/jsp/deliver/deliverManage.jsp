<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <meta charset="utf-8">
        <title>配送员管理</title>
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/css/layui.css" media="all">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/css/public.css" media="all">
        <%-- 添加layui-dtree的css样式 --%>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui_ext/dtree/dtree.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui_ext/dtree/font/dtreefont.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/resources/css/deliverManage.css">
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
                                    <label class="layui-form-label">配送员编号</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="deliverId" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">用户名</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="username" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">配送员姓名</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="realName" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">手机号</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="phone" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <!--
                                <div class="layui-inline">
                                    <label class="layui-form-label">加入日期</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="joinDate" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                -->
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
                        <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="reJoin" id="reJoin">
                            <i class="layui-icon layui-icon-refresh-1"></i>复职
                        </a>
                    {{# } else{}}
                        <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit" id="edit">
                            <i class="layui-icon layui-icon-edit"></i>编辑
                        </a>
                        <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="leave" id="leave">
                            <i class="layui-icon layui-icon-pause"></i>离职
                        </a>
                        <a class="layui-btn layui-btn-xs layui-btn-checked data-count-grant" lay-event="workData">
                            <i class="layui-icon layui-icon-survey"></i>配送数据
                        </a>
                    {{# }}}
                </script>

                <%-- 添加或修改弹出框 --%>
                <div class="layui-container" style="display: none;padding: 5px;width: 100%;" id="addOrUpdateForm">
                    <form class="layui-form" style="width: 90%" id="dataForm" lay-filter="dataForm">
                        <%--表单隐藏域--%>
                        <input type="hidden" name="deliverId" id="deliverId">
                        <input type="hidden" name="userId" id="userId">
                        <div class="layui-form-item">
                            <label class="layui-form-label"><font color="red"> * </font>用户名</label>
                            <div class="layui-input-inline">
                                <select name="username" lay-verify="required" class="layui-select-group" id="username" lay-filter="username">
                                    <option value="">请选择用户</option>
                                </select>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label"><font color="red"> * </font>真实姓名</label>
                            <div class="layui-input-block">
                                <input type="text" name="realName" lay-verify="required" autocomplete="off" class="layui-input" id="realName">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-inline layui-col-md5">
                                <label class="layui-form-label"><font color="red"> * </font>证件照片</label>
                                <div class="layui-upload-list layui-col-md3 layui-col-xs5" id="imageBox">
                                    <input type="hidden" name="imageUrl" id="imageUrl" value="deliver/defaultImage/defaultImage.png" lay-verify="required">
                                    <a href="javascript:void(0);">
                                        <img class="upload-img" id="photoShow" src="/sudi/upload/deliver/defaultImage/defaultImage.png">
                                    </a>
                                </div>
                            </div>
                            <div class="layui-form-text layui-inline-input layui-col-md6">
                                <label class="layui-form-label">备注</label>
                                <div class="layui-input-block">
                                    <textarea name="remark" placeholder="请输入内容" class="layui-textarea" id="remark" style="width:295px;height: 200px;"></textarea>
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

                <%-- 配送员数据可视化弹出框 --%>
                <div class="layui-container layui-card" style="display:none;padding:30px 30px 0 30px;width: 100%;" id="chartsContainer">
                    <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
                    <div class="layui-inline" id="deliverChart" style="width: 500px;height:380px;"></div>
                </div>

            </div>
        </div>
    </body>
    <script src="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
    <script>
        layui.config({
            base: '${pageContext.request.contextPath}/static/plugins/echarts/dist/'
        }).extend({
            echarts: '/echarts'
        }).use(['form', 'table', 'jquery', 'upload', 'layer', 'echarts'], function () {
            var $ = layui.jquery,
                form = layui.form,
                table = layui.table,
                upload = layui.upload,
                echarts = layui.echarts,
                layer = layui.layer;

            // 基于准备好的dom，初始化echarts实例
            var deliverChart = echarts.init(document.getElementById("deliverChart"));

            var url;//提交的请求地址
            var index;//打开窗口的索引

            /**
             * 数据表单初始化
             */
            var tableIns = table.render({
                elem: '#currentTableId',
                url: '${pageContext.request.contextPath}/backstage/deliver/list',
                toolbar: '#toolbarDemo',
                defaultToolbar: ['filter', 'exports', 'print', {
                    title: '提示',
                    layEvent: 'LAYTABLE_TIPS',
                    icon: 'layui-icon-tips'
                }],
                cols: [[
                    {type: "checkbox", width: 50, align: "center"},
                    {field: 'deliverId', minWidth: 160, title: '配送员编号', align: "center"},
                    {field: 'realName', width: 112, title: '真实姓名', align: "center", templet: function (d) {
                        if (d.realName==null || d.realName=='')
                            return "<font color='red'>未实名</font>";
                        else return d.realName;
                    }},
                    {field: 'phone', width: 130, title: '手机号', align: "center"},
                    {field: 'orderCount', width: 100, title: '接单数', align: "center", sort: true},
                    {field: 'faultCount', width: 100, title: '差评数', align: "center", sort: true},
                    {field: 'finishCount', width: 100, title: '结单数', align: "center", sort: true},
                    {field: 'joinDate', width: 120, title: '入职日期', sort: true, align: "center",
                        templet:"<div>{{layui.util.toDateString(d.lastLoginTime, 'yyyy-MM-dd')}}</div>"
                    },
                    {field: 'leaveDate', width: 120, title: '是否离职', sort: true, align: "center",
                        templet: function (d) {
                            if (d.leaveDate == null){
                                flag = true;
                                return "<font color='blue'>在职中</font>";
                            }else {
                                flag = false;
                                return "<font color='red'>离职</font>";
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
             * 渲染文件上传区域
             */
            upload.render({
                elem: "#photoShow",  //绑定元素
                url: "${pageContext.request.contextPath}/backstage/deliver/uploadFile",    //文件上传后台处理路径
                acceptMime: "image/*",  //规定打开文件选择框时筛选出的文件类型
                field: "deliverImage",  //文件上传的字段值，等同于input标签的name，必须和后台处理路径的方法参数名一致
                method: "post",     //提交方式
                //文件上传成功之后的回调函数
                done: function (res, index, upload) {
                    console.log(res);
                    console.log(index);
                    console.log(upload);
                    //上传的图片回显
                    $("#photoShow").attr("src", res.data.src);
                    //改变背景颜色
                    $("#imageBox").css("background", "#ffffff");
                    //给隐藏域赋值，只需要后半截，前边的是通用的路径，不需要保存到数据库中
                    $("#imageUrl").val(res.data.imagePath);
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
             * 编写表单重置按钮的监听事件,doReset是提交按钮的lay-filter的值
             */
            $("#doReset").click(function () {
                //重置图片回显为默认的图片
                $("#photoShow").attr("src", "/sudi/upload/deliver/defaultImage/defaultImage.png");
                //重置隐藏域为默认值
                $("#imageUrl").val("deliver/defaultImage/defaultImage.png");
                //普通输入框文本域置空
                $("#realName").val("");
                $("#remark").val("");
                //禁止页面刷新
                return false;
            });

            /**
             * toolbar监听头部工具栏事件
             */
            table.on('toolbar(currentTableFilter)', function (obj) {
                if (obj.event === 'add') {  // 监听添加操作
                    index = layer.open({
                        title: '添加配送员',
                        type: 1,
                        shade: 0.2,
                        maxmin:true,
                        shadeClose: true,
                        area: ['60%', '75%'],
                        offset: ['50px', '250px'],
                        content: $("#addOrUpdateForm"),
                        success: function () {
                            //设置下拉框可修改
                            $("#username").removeAttr("disabled");
                            //重新渲染表单
                            form.render();
                            //清空表单数据
                            $("#dataForm")[0].reset();
                            //添加的提交请求路径赋值
                            url = "${pageContext.request.contextPath}/backstage/deliver/add";
                            //重置默认图片
                            $("#photoShow").attr("src", "/sudi/upload/deliver/defaultImage/defaultImage.png");
                            //重置隐藏域
                            $("#imageUrl").val("deliver/defaultImage/defaultImage.png");
                        }
                    });
                }
            });

            /**
             * 对表单的下拉框进行初始化
             */
            $.ajax({
                url: "${pageContext.request.contextPath}/backstage/deliver/findUser",
                dataType: "json",
                type: "post",
                success: function(result) {
                    if (result.code == 1){
                        $.each(result.userList, function (index, item) {
                            //向下拉框中追加元素
                            $("#username").append(new Option(item.username, item.userId));
                        });
                        form.render("select");
                    }else {
                        $("#username").append(new Option("暂无数据", ""));
                    }
                }
            });

            /**
             * 监听表单下拉框的选择，给隐藏域赋值
             */
            form.on("select(username)", function (data) {
                console.log(data);
                $("#userId").val(data.value);
            });

            /**
             * 监听表单行工具栏事件
             */
            table.on('tool(currentTableFilter)', function (obj) {
                var data = obj.data;
                if (obj.event === 'edit') {
                    index = layer.open({
                        title: '编辑配送员',
                        type: 1,
                        shade: 0.2,
                        maxmin:true,
                        shadeClose: true,
                        area: ['60%', '75%'],
                        offset: ['50px', '250px'],
                        content: $("#addOrUpdateForm"),
                        success: function(){
                            //表单数据回显，参数1表示lay-filter的值，参数2表示回显的数据
                            form.val("dataForm", data);
                            //设置下拉框不可修改
                            $("#username").attr("disabled", "disabled");
                            //重新渲染表单
                            form.render();
                            //添加的提交请求
                            url = "${pageContext.request.contextPath}/backstage/deliver/modify";
                            //设置图片回显
                            $("#photoShow").attr("src", "/sudi/upload/" + data.imageUrl);
                        }
                    });
                    $(window).on("resize", function () {
                        layer.full(index);
                    });
                    return false;
                } else if (obj.event === "leave") {
                    layer.confirm('确定要对<font color="red">【' +data.realName+ '】</font>进行离职操作吗?', {icon: 3, title:'提示'}, function(index){
                        $.post("${pageContext.request.contextPath}/backstage/deliver/leave", {deliverId: data.deliverId, userId: data.userId}, function (result) {
                            console.log(result);
                            if (result.flag){
                                //重新加载
                                tableIns.reload();
                            }
                            layer.msg(result.message);
                        },"json");
                        layer.close(index);
                    });
                } else if (obj.event === "reJoin") {
                    layer.confirm('确定要对<font color="red">【' +data.realName+ '】</font>进行复职操作吗?', {icon: 3, title:'提示'}, function(index){
                        $.post("${pageContext.request.contextPath}/backstage/deliver/reJoin", {deliverId: data.deliverId, userId: data.userId}, function (result) {
                            console.log(result);
                            if (result.flag){
                                //重新加载
                                tableIns.reload();
                            }
                            layer.msg(result.message);
                        },"json");
                        layer.close(index);
                    });
                } else if (obj.event === "workData") {
                    layer.open({
                        title: '配送员工作数据',
                        type: 1,
                        shade: 0.2,
                        maxmin:true,
                        shadeClose: true,
                        area: ['550px', '455px'],
                        offset: ['70px', '320px'],
                        content: $("#chartsContainer"),
                        success: function () {
                            //定义三个变量盛放配送员的最大数据
                            var maxOrderCount;
                            var maxFaultCount;
                            var maxFinishCount;
                            //查询三个数据每个的最大值并返回
                            $.post("${pageContext.request.contextPath}/backstage/deliver/findMax", function (result) {
                                console.log(result);
                                //完成对三个最大值变量的赋值
                                maxOrderCount = parseInt(result.maxOrderCount);
                                maxFaultCount = parseInt(result.maxFaultCount);
                                maxFinishCount = parseInt(result.maxFinishCount);
                                // 指定配送员工作数据雷达图的配置项和数据
                                var option = {
                                    title: {
                                        text: '配送员工作数据雷达图'
                                    },
                                    tooltip: {},
                                    legend: {
                                        data: '工作数据',
                                    },
                                    radar: {
                                        // shape: 'circle',
                                        name: {
                                            textStyle: {
                                                color: '#fff',
                                                backgroundColor: '#999',
                                                borderRadius: 3,
                                                padding: [3, 5]
                                            }
                                        },
                                        indicator: [
                                            { name: '接单数', max: maxOrderCount},
                                            { name: '差评数', max: maxFaultCount},
                                            { name: '结单数', max: maxFinishCount}
                                        ]
                                    },
                                    series: [{
                                        type: 'radar',
                                        data: [
                                            {
                                                value: [data.orderCount, data.faultCount, data.finishCount],
                                                name: '工作数据'
                                            }
                                        ]
                                    }]
                                };
                                // 使用刚指定的配置项和数据显示图表。
                                deliverChart.setOption(option);
                            }, "json");
                        }
                    });
                }
            });





        });

    </script>

</html>
