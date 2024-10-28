<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <meta charset="utf-8">
        <title>订单分配管理</title>
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/css/layui.css" media="all">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/css/public.css" media="all">
    </head>
    <body>
        <div class="layuimini-container">
            <div class="layuimini-main">

                <%-- 表格区域 --%>
                <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

                <%-- 表格行工具栏 --%>
                <script type="text/html" id="currentTableBar">
                    <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="findOrderDetail">
                        <i class="layui-icon layui-icon-edit"></i>查看订单
                    </a>
                    <a class="layui-btn layui-btn layui-btn-xs data-count-edit" lay-event="deliver">
                        <i class="layui-icon layui-icon-cart"></i>分配配送员
                    </a>
                    <a class="layui-btn layui-btn-danger layui-btn-xs data-count-edit" lay-event="delete">
                        <i class="layui-icon layui-icon-delete"></i>作废订单
                    </a>
                </script>

                <%-- 订单细则弹出框 --%>
                <div style="display: none;padding: 20px" id="orderDetail"></div>

                <%-- 分配配送员弹出框 --%>
                <div style="display: none;padding: 20px" id="deliver">
                    <form class="layui-form">
                        <%-- 隐藏域，存放订单编号 --%>
                        <input type="hidden" name="orderId" id="orderId">
                        <div class="layui-form-item">
                            <div style="margin: 0 auto;width: 325px;">
                                <label class="layui-inline"><font color="red"> * </font>请选择配送员：</label>
                                <div class="layui-inline">
                                    <select class="layui-select" name="deliverId" lay-verify="required" id="formalDeliver">
                                        <option value="" selected>请选择配送员</option>
                                    </select>
                                </div>
                            </div>
                            <div class="layui-form-item" style="margin-top: 30px;">
                                <div class="layui-input-block" style="text-align: center;margin-left: 0px;">
                                    <button type="button" class="layui-btn layui-btn-checked" lay-submit lay-filter="doSubmit">
                                        <span class="layui-icon layui-icon-add-1"></span>分配订单
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>

            </div>
        </div>
    </body>

    <script type="text/html" id="demo">
        {{# layui.each(d.list, function(index, orderDetail){ }}
        <div class="layui-form-item">
            {{# var foodImage = "${pageContext.request.contextPath}/upload/" + orderDetail.foodImage; }}
            <div class="layui-inline layui-col-md2" style="margin-left: 68px;"><img src={{ foodImage }} style="width: 50px;height: 50px"></div>
            <div class="layui-inline layui-col-md3"><p style="line-height: 45px;">{{ orderDetail.skuName }}</p></div>
            <div class="layui-inline layui-col-md2"><p style="line-height: 45px;">{{ (orderDetail.skuPrice).toFixed(2) }}元 × {{ orderDetail.amount }}份</p></div>
            <div class="layui-inline layui-col-md2"><p style="line-height: 45px;">{{ (orderDetail.itemPrice).toFixed(2) }}元</p></div>
        </div>
        {{# }) }}
    </script>

    <script src="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
    <script>
        layui.use(['form', 'table', 'jquery', 'laytpl'], function () {
            var $ = layui.jquery,
                form = layui.form,
                laytpl = layui.laytpl,
                table = layui.table;

            var url;//提交的请求地址
            var index;//打开窗口的索引

            /**
             * 初始化表格区域
             */
            var tableIns = table.render({
                elem: '#currentTableId',
                url: '${pageContext.request.contextPath}/backstage/order/allocationList',
                toolbar: '#toolbarDemo',
                defaultToolbar: ['filter', 'exports', 'print', {
                    title: '提示',
                    layEvent: 'LAYTABLE_TIPS',
                    icon: 'layui-icon-tips'
                }],
                cols: [[
                    {type: "checkbox", width: 50},
                    {field: 'orderId', width: 240, title: '订单编号', sort: true, align: "center"},
                    {field: 'realName', width: 120, title: '收货人', sort: true, align: "center"},
                    {field: 'address', minWidth: 240, title: '收货地址', sort: true, align: "center"},
                    {field: 'orderTime', width: 200, title: '下单时间', align: "center", sort:true,
                        templet:"<div>{{layui.util.toDateString(d.orderTime, 'yyyy-MM-dd HH:mm:ss')}}</div>"
                    },
                    {title: '操作', minWidth: 250, toolbar: '#currentTableBar', align: "center"}
                ]],
                limits: [10, 15, 20, 25, 50, 100],
                limit: 15,
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
             * 监听表格行工具栏的点击事件
             */
            table.on('tool(currentTableFilter)', function (obj) {
                var data = obj.data;
                if (obj.event === 'findOrderDetail') {
                    //请求后端查询该订单的所有细则
                    $.post("${pageContext.request.contextPath}/backstage/order/findOrderDetailByOrderId", {orderId:data.orderId}, function (result) {
                        //打开弹窗
                        index = layer.open({
                            title: '查看订单',
                            type: 1,
                            shade: 0.2,
                            maxmin:true,
                            shadeClose: true,
                            area: ['45%', '50%'],
                            offset:['100px', '350px'],
                            content: $("#orderDetail"),
                            success: function () {
                                /**
                                 * 渲染模版
                                 * @type {{title: string, list: *}}
                                 */
                                var templetData = { //数据
                                    "title":"Layui常用模块"
                                    ,"list":result
                                }
                                var getTpl = demo.innerHTML;
                                var orderDetail = document.getElementById('orderDetail');
                                laytpl(getTpl).render(templetData, function(html){
                                    orderDetail.innerHTML = html;
                                });
                            }
                        });
                    }, "json");
                }else if (obj.event === 'deliver') {
                    //打开弹窗
                    index = layer.open({
                        title: '分配配送员',
                        type: 1,
                        shade: 0.2,
                        maxmin:true,
                        shadeClose: true,
                        area: ['30%', '40%'],
                        offset:['130px', '420px'],
                        content: $("#deliver"),
                        success: function () {
                            //将订单编号封装到隐藏域中
                            $("#orderId").val(obj.data.orderId);
                            //请求后端查询正式的配送员信息(未离职且已实名)
                            $.post("${pageContext.request.contextPath}/backstage/deliver/findFormalDeliver", function (deliverResult) {
                                $.each(deliverResult, function (key, value) {
                                    $("#formalDeliver").append("<option value='"+value.deliverId+"'>"+value.realName+"</option>");
                                });
                                form.render();
                            }, "json")
                        }
                    });
                }else if (obj.event === 'delete') {
                    layer.confirm('确定要作废该订单吗？该操作请务必<font color="red">经过用户</font>的确认！', {icon: 3, title:'提示'}, function(index){
                        //请求后端取消订单
                        $.post("${pageContext.request.contextPath}/backstage/order/cancelOrder", {orderId: data.orderId}, function (cancelResult) {
                            if (cancelResult.flag){
                                //刷新数据表格
                                tableIns.reload();
                            }
                            //弹出提示信息
                            layer.msg(cancelResult.message);
                        }, "json")
                        layer.close(index);
                    });
                }
            });

            /**
             * 编写表单提交的监听事件,doSubmit是提交按钮的lay-filter的值
             */
            form.on("submit(doSubmit)", function(data){
                $.post("${pageContext.request.contextPath}/backstage/order/allocationOrder", data.field, function(result2){
                    if (result2.flag){
                        //刷新数据表格
                        tableIns.reload();
                        //关闭当前窗口
                        layer.close(index);
                    }
                    //弹出提示信息
                    layer.msg(result2.message);
                }, "json");
                //禁止页面刷新
                return false;
            });

        });
    </script>
</html>
