<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <meta charset="utf-8">
        <title>菜品SKU管理</title>
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/css/layui.css" media="all">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/css/public.css" media="all">
        <%-- 添加layui-dtree的css样式 --%>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui_ext/dtree/dtree.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui_ext/dtree/font/dtreefont.css">
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
                                    <label class="layui-form-label">SKU编号</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="skuId" autocomplete="off" class="layui-input" onkeyup="value=value.replace(/[^0-9]/g,'')">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">SKU名称</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="skuName" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">菜品类别</label>
                                    <div class="layui-input-inline">
                                        <select id="typeIdSearch" name="typeId" style="height: 32px;width: 150px;text-align: center;">
                                            <option value="" selected="">请选择</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="layui-inline my-inline my-full-input">
                                    <label class="layui-form-label">菜品名称</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="foodName" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">菜品价格</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="skuPrice" autocomplete="off" class="layui-input" onkeyup="clearNoNum(this)">
                                    </div>
                                </div>
                                <%--<div class="layui-inline">--%>
                                <%--    <label class="layui-form-label">菜品供量</label>--%>
                                <%--    <div class="layui-input-inline">--%>
                                <%--        <input type="text" name="skuStock" autocomplete="off" class="layui-input" onkeyup="value.replace(/[^0-9]/g,'')">--%>
                                <%--    </div>--%>
                                <%--</div>--%>
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
                    <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit" id="edit">
                        <i class="layui-icon layui-icon-edit"></i>编辑
                    </a>
                    <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete" id="delete">
                        <i class="layui-icon layui-icon-delete"></i>删除
                    </a>
                </script>

                <%-- 添加或修改弹出框 --%>
                <div class="layui-container" style="display: none;padding: 5px;width: 100%;" id="addOrUpdateForm">
                    <form class="layui-form" style="width: 90%" id="dataForm" lay-filter="dataForm">
                        <%--表单隐藏域--%>
                        <input type="hidden" name="skuId" id="skuId">
                        <div class="layui-form-item">
                            <div class="layui-inline layui-col-md6" style="margin-right: 0px;">
                                <label class="layui-form-label"><font color="red"> * </font>菜品类别</label>
                                <div class="layui-input-inline">
                                    <select id="typeId" name="typeId" style="height: 32px;width: 150px;text-align: center;" lay-verify="required" lay-filter="typeId">
                                        <option value="" selected="selected">请选择菜品类别</option>
                                    </select>
                                </div>
                            </div>
                            <div class="layui-inline layui-col-md6" style="margin-right: 0px;">
                                <label class="layui-form-label"><font color="red"> * </font>菜品名称</label>
                                <div class="layui-input-inline">
                                    <select id="foodIdSelect" name="foodId" style="height: 32px;width: 150px;text-align: center;" lay-verify="required">
                                        <option value="" selected="selected">请先选择菜品类别</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="layui-form-item layui-row" style="margin-right: 0px;">
                            <div class="layui-inline layui-col-md12" style="margin-right: 0px;">
                                <label class="layui-form-label"><font color="red"> * </font>规格名称</label>
                                <div class="layui-input-inline" style="margin-right: 0px;width: 77.5%;">
                                    <%--取名为skuName，实质是foodvalueName， 后端拼接--%>
                                    <input type="text" placeholder="请输入规格名称" autocomplete="off" class="layui-input" name="skuName" id="foodvalueName" lay-verify="required">
                                </div>
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <div class="layui-inline layui-col-md6 my-inline" style="margin-right: 0px;">
                                <label class="layui-form-label">SKU价格</label>
                                <div class="layui-input-inline">
                                    <input type="text" placeholder="请输入SKU价格" autocomplete="off" class="layui-input" name="skuPrice" id="skuPrice" onkeyup="clearNoNum(this)">
                                </div>
                            </div>
                            <%--<div class="layui-inline layui-col-md6 my-inline" style="margin-right: 0px;">--%>
                            <%--    <label class="layui-form-label">SKU库存</label>--%>
                            <%--    <div class="layui-input-inline">--%>
                            <%--        <input type="text" placeholder="请输入SKU库存" autocomplete="off" class="layui-input" name="skuStock" id="skuStock" onkeyup="value.replace(/[^0-9]/g,'')">--%>
                            <%--    </div>--%>
                            <%--</div>--%>
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
                url: '${pageContext.request.contextPath}/backstage/foodSku/list',
                toolbar: '#toolbarDemo',
                defaultToolbar: ['filter', 'exports', 'print', {
                    title: '提示',
                    layEvent: 'LAYTABLE_TIPS',
                    icon: 'layui-icon-tips'
                }],
                cols: [[
                    {type: "checkbox", width: 50, align: "center"},
                    {field: 'skuId', width: 160, title: 'SKU编号', align: "center", sort: true},
                    {field: 'skuName', minWidth: 140, title: '菜品SKU名称', align: "center"},
                    {field: 'foodName', minWidth: 140, title: '菜品SPU名称', align: "center"},
                    {field: 'typeName', minWidth: 140, title: '菜品类别', align: "center"},
                    {field: 'skuPrice', minWidth: 140, title: 'SKU单价', align: "center", templet: function (d) {
                        if (d.skuPrice == null)
                            return "<font color='#ff7f50'>未完善</font>";
                        else return d.skuPrice;
                    }},
                    // {field: 'skuStock', minWidth: 140, title: 'SKU供量', align: "center", templet: function (d){
                    //     if (d.skuStock == 0)
                    //         return "<font color='red'>已售罄</font>";
                    //     if (d.skuStock < 5)
                    //         return "<font color='#ff7f50'>库存紧张</font>"
                    //     else return d.skuStock;
                    // }},
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
             * 加载菜品类别下拉框向后台动态读取菜品类别数据
             */
            $.ajax({
                url: "${pageContext.request.contextPath}/backstage/foodtype/findAllFoodtype",
                dataType: "json",
                type: "post",
                success: function(result) {
                    if (result.code == 1){
                        $.each(result.foodtypeList, function (index, item) {
                            //向下拉框中追加元素
                            $("#typeId").append(new Option(item.typeName, item.typeId));
                            $("#typeIdSearch").append(new Option(item.typeName, item.typeId));
                        });
                        form.render("select");
                    }else {
                        $("#typeId").append(new Option("暂无数据", ""));
                        $("#typeIdSearch").append(new Option("暂无数据", ""));
                    }
                }
            });

            /**
             * toolbar监听头部工具栏事件
             */
            table.on('toolbar(currentTableFilter)', function (obj) {
                if (obj.event === 'add') {  // 监听添加操作
                    index = layer.open({
                        title: '添加菜品SKU',
                        type: 1,
                        shade: 0.2,
                        maxmin:true,
                        shadeClose: true,
                        area: ['60%', '50%'],
                        offset: ['100px', '220px'],
                        content: $("#addOrUpdateForm"),
                        success: function () {
                            //移除不可修改并添加校验
                            $("#foodIdSelect").empty();
                            $("#foodIdSelect").append(new Option("请先选择菜品类别", ""));
                            $("#foodIdSelect").removeAttr("disabled");
                            $("#typeId").removeAttr("disabled");
                            $("#foodvalueName").removeAttr("disabled");
                            $("#typeId").attr("lay-verify", "required");
                            $("#foodIdSelect").attr("lay-verify", "required");
                            $("#foodvalueName").attr("lay-verify", "required");
                            //清空表单数据
                            $("#dataForm")[0].reset();
                            //添加的提交请求路径赋值
                            url = "${pageContext.request.contextPath}/backstage/foodSku/add";
                        }
                    });
                }
            });

            /**
             * 监听新增表单菜品类别下拉框的选择事件
             */
            form.on('select(typeId)', function (data) {
                console.log(data);
                $.post("${pageContext.request.contextPath}/backstage/food/findFoodByTypeId", {typeId:data.value}, function (result) {
                    $("#foodIdSelect").empty();
                    if (result.code == 1) {
                        $("#foodIdSelect").append(new Option("请选择菜品SPU", ""));
                        $.each(result.foodList, function (index, item) {
                            //向下拉框中追加元素
                            $("#foodIdSelect").append(new Option(item.foodName, item.foodId));
                        });
                    }else {
                        $("#foodIdSelect").append(new Option("无数据", ""));
                    }
                    form.render();
                }, "json");
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
             * 监听表单行工具栏事件
             */
            table.on('tool(currentTableFilter)', function (obj) {
                var data = obj.data;
                console.log(data);
                if (obj.event === 'edit') {
                    index = layer.open({
                        title: '编辑菜品SKU',
                        type: 1,
                        shade: 0.2,
                        maxmin:true,
                        shadeClose: true,
                        area: ['60%', '50%'],
                        offset: ['100px', '220px'],
                        content: $("#addOrUpdateForm"),
                        success: function(){
                            //表单数据回显，参数1表示lay-filter的值，参数2表示回显的数据
                            form.val("dataForm", data);
                            //菜品下拉框回显
                            $("#foodIdSelect").empty();
                            $("#foodIdSelect").append(new Option(data.foodName, data.foodId));
                            //显示禁止修改并移除校验
                            $("#foodIdSelect").attr("disabled", "disabled");
                            $("#foodvalueName").attr("disabled", "disabled");
                            $("#typeId").attr("disabled", "disabled");
                            $("#typeId").removeAttr("lay-verify");
                            $("#foodIdSelect").removeAttr("lay-verify");
                            $("#foodvalueName").removeAttr("lay-verify");
                            //重新渲染表单
                            form.render();
                            //添加的提交请求
                            url = "${pageContext.request.contextPath}/backstage/foodSku/modify";
                        }
                    });
                }else if (obj.event === 'delete') {
                    var str = '确定要删除该条菜品SKU进行操作吗?\n删除后该SKU信息将不存在！';
                    console.log(data);
                    layer.confirm(str, {icon: 3, title:'提示'}, function(index){
                        $.post("${pageContext.request.contextPath}/backstage/foodSku/delete", data, function (result) {
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




        /**
        * 价格输入校验
        * @param obj
        */
        function clearNoNum(obj){
            //修复第一个字符是小数点 的情况.
            if(obj.value !=''&& obj.value.substr(0,1) == '.'){
                obj.value="";
            }
            obj.value = obj.value.replace(/^0*(0\.|[1-9])/, '$1');//解决 粘贴不生效
            obj.value = obj.value.replace(/[^\d.]/g,"");  //清除“数字”和“.”以外的字符
            obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的
            obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
            obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3');//只能输入两个小数
            if(obj.value.indexOf(".")< 0 && obj.value !=""){//以上已经过滤，此处控制的是如果没有小数点，首位不能为类似于 01、02的金额
                if(obj.value.substr(0,1) == '0' && obj.value.length == 2){
                    obj.value= obj.value.substr(1,obj.value.length);
                }
            }
        }



    </script>
</html>
