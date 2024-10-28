<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>我的优惠券</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/resources/css/myTicket.css" media="all">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/css/layui.css" media="all">
        <link href="${pageContext.request.contextPath}/static/plugins/productStore/css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
        <script>
            function formatDate(date) {
                var y = date.getFullYear();
                var m = date.getMonth() + 1;
                m = m < 10 ? '0' + m : m;
                var d = date.getDate();
                d = d < 10 ? ('0' + d) : d;
                return y + '-' + m + '-' + d;
            };

            function ticketStatusName(ticketStatus) {
                switch (ticketStatus) {
                    case 1:
                        return "未使用";
                    case 2:
                        return "已使用";
                    case 3:
                        return "已过期";
                    case 4:
                        return "已作废";
                    case 5:
                        return "已返还";
                }
            }

            function ticketStatusColor(ticketStatus) {
                switch (ticketStatus) {
                    case 1:
                        return "#ffffff";
                    case 2:
                        return "#999999";
                    case 3:
                        return "#777777";
                    case 4:
                        return "#555555";
                    case 5:
                        return "rgba(0,8,63,0.38)";
                }
            }
        </script>
    </head>
    <body>

        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <div class="navbar-header" style="position: relative;margin-left: 44px;">
                    <button type="button" class="btn btn-default navbar-btn" onclick="javascript:window.history.go(-1);"> < 返回</button>
                    <p class="navbar-text" style="position:absolute;top: 0px;left: 68px;width: 199px;">我的优惠券</p>
                </div>
            </div>
        </nav>
        <div id="view"></div>

        <div style="clear:both;width: 100%;">
            <div class="qing banq" style="margin: 0 auto 20px;width: 457px;">闽ICP备201721086021号 Copyright 宿递By <font color="#1aa094"><b>LiangJ</b></font>，All Rights Reserved</div>
        </div>
    </body>

    <script type="text/html" id="demo">
        <div style="margin-left: 40px;">
        {{# layui.each(d.list, function(index, ticket){ }}
            <div class="stamp stamp01" style="float: left;margin-left: 20px;">
                <div class="par">
                    <p>宿递</p>
                    <sub class="sign">￥</sub><span style="font-size: 45px;">{{ (ticket.cheap).toFixed(2) }}</span><sub>优惠券</sub>
                    <p>订单满{{ ticket.requirement }}元</p>
                </div>
                {{# var ticketStatus = ticketStatusName(ticket.ticketStatus);
                    var color = ticketStatusColor(ticket.ticketStatus); }}
                <div class="copy"><font color={{ color }} style="font-weight: bolder">{{ ticketStatus }}</font>
                {{# var startTime = formatDate(new Date(ticket.startTime));
                    var endTime = formatDate(new Date(ticket.endTime)); }}
                    <p>{{ startTime }}<br>{{ endTime }}</p>
                </div>
                <i></i>
            </div>
        {{# }) }}
        </div>
    </script>
    <script src="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
    <script>
        layui.use(['jquery', 'layer', 'laytpl'], function () {
            var $ = layui.jquery,
                laytpl = layui.laytpl,
                layer = layui.layer;

            var url;//提交的请求地址
            var index;//打开窗口的索引

            /**
             * 请求后端查询所有上架的优惠券类别
             */
            $.post("${pageContext.request.contextPath}/reception/ticket/findByUser", function (result) {
                if (result.flag){
                    /**
                     * 渲染模版
                     * @type {{title: string, list: *}}
                     */
                    templetData = { //数据
                        "title":"Layui常用模块"
                        ,"list":result.ticketList
                    }
                    var getTpl = demo.innerHTML;
                    var view = document.getElementById('view');
                    laytpl(getTpl).render(templetData, function(html){
                        view.innerHTML = html;
                    });
                }else {
                    alert("您还没有优惠券呢，快去优惠券商城看看吧");
                }
            }, "json");



        });
    </script>

</html>
