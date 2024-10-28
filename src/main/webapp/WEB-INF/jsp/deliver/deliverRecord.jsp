<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <meta charset="utf-8">
        <title>配送记录</title>
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/css/layui.css" media="all">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/css/public.css" media="all">
    </head>
    <body>
        <div class="layuimini-container">
            <div class="layuimini-main">
                <%-- 头部统计数据区域 --%>


                <%-- 表格区域 --%>
                <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>
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
             * 数据表单初始化，查询当前配送员的所有订单配送记录
             */
            var tableIns = table.render({
                elem: '#currentTableId',
                url: '${pageContext.request.contextPath}/backstage/order/deliverRecord',
                toolbar: '#toolbarDemo', 
                defaultToolbar: ['filter', 'exports', 'print', {
                    title: '提示',
                    layEvent: 'LAYTABLE_TIPS',
                    icon: 'layui-icon-tips'
                }],
                cols: [[
                    {type: "checkbox", width: 50, align: "center"},
                    {field: 'orderId', minWidth: 160, title: '订单编号', align: "center"},
                    {field: 'realName', width: 130, title: '收货人', align: "center"},
                    {field: 'orderTime', width: 200, title: '下单时间', align: "center", sort: true,
                        templet:"<div>{{layui.util.toDateString(d.orderTime, 'yyyy-MM-dd HH:mm:ss')}}</div>"
                    },
                    {field: 'finishTime', width: 200, title: '结单时间', align: "center", sort: true,
                        templet:"<div>{{layui.util.toDateString(d.finishTime, 'yyyy-MM-dd HH:mm:ss')}}</div>"
                    },
                    {field: 'orderStatus', width: 130, title: '订单状态', align: "center", sort: true,
                        templet: function (d) {
                            switch (d.orderStatus) {
                                case 1:
                                    return "出餐中";
                                case 2:
                                    return "配送中";
                                case 3:
                                    return "已完成";
                                case 4:
                                    return "未支付";
                                case 5:
                                    return "已取消";
                            }
                        }
                    },
                    {field: 'complaint', width: 130, title: '是否被投诉', align: "center", sort: true,
                        templet: function (d) {
                            switch (d.complaint) {
                                case 1:
                                    return "<font color='red'>是</font>";
                                case 2:
                                    return "否";
                            }
                        }
                    },
                ]],
                limits: [10, 15, 20, 25, 50, 100],
                limit: 20,
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

        });
    </script>
</html>
