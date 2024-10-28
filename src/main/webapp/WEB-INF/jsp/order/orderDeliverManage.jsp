<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <meta charset="utf-8">
        <title>订单配送</title>
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
                    <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="finishOrder">
                        <i class="layui-icon layui-icon-ok"></i>完成配送
                    </a>
                    <a class="layui-btn layui-btn-danger layui-btn-xs data-count-edit" lay-event="cancelOrder">
                        <i class="layui-icon layui-icon-close"></i>取消配送
                    </a>
                </script>

            </div>
        </div>
    </body>

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
             * 初始化表格区域,查询该配送员的待配送订单
             */
            var tableIns = table.render({
                elem: '#currentTableId',
                url: '${pageContext.request.contextPath}/backstage/order/orderDeliverList',
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
                    {field: 'phone', width: 140, title: '收货人手机号', sort: true, align: "center"},
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
                if (obj.event === 'finishOrder') {
                    layer.confirm('确定该订单已送达吗？', {icon: 3, title:'提示'}, function(index){
                        //请求后端完成订单
                        $.post("${pageContext.request.contextPath}/backstage/order/finishOrder", {orderId: data.orderId}, function (result) {
                            if (result.flag){
                                //刷新数据表格
                                tableIns.reload();
                            }
                            layer.msg(result.message);
                        }, "json");
                        layer.close(index);
                    });
                }else if (obj.event === 'cancelOrder') {
                    layer.confirm('确定取消该订单的配送吗？\n无故取消订单将有可能影响您的结单率！', {icon: 3, title:'提示'}, function(index){
                        //请求后端完成订单
                        $.post("${pageContext.request.contextPath}/backstage/order/cancelDeliver", {orderId: data.orderId}, function (result) {
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
