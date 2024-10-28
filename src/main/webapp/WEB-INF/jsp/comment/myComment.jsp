<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>我的评论</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/resources/css/myTicket.css" media="all">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/css/layui.css" media="all">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/css/public.css" media="all">
        <link href="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/css/style.css" type="text/css" rel="stylesheet">
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/js/-jquery-1.8.3.min.js"></script>
        <link href="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/css/nav2.css" type="text/css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/css/amazeui.min.css" rel="stylesheet" />
        <script src="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/js/amazeui.min.js"></script>
        <link href="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/css/fanda.css" type="text/css" rel="stylesheet">
        <script src="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/js/MagicZoom.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/js/ShopShow.js"></script>
        <link href="${pageContext.request.contextPath}/static/plugins/productStore/css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
        <script>
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
        </script>
        <style>
            .orderBox {
                width: 90.5%;
                margin: 0 auto 24px;
                background-color: #ffffff;
                box-shadow: 0  2px  10px  0 rgba(0, 0, 0, 0.2);
                border-radius: 5px;
                overflow: hidden;
                padding: 30px;
            }
            .myOrderBolder{
                font-size: 20px;
                font-weight: 600;
                color: #333333;
            }
            .myOrderFont{
                font-size: 16px;
                font-weight: 300;
                color: #333333;
            }
            .layui-form-item{
                margin-bottom: 0;
            }
        </style>
    </head>
    <body style="width: 100%;">
        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <div class="navbar-header" style="position: relative;margin-left: 44px;">
                    <button type="button" class="btn btn-default navbar-btn" onclick="javascript:window.history.go(-1);"> < 返回</button>
                    <p class="navbar-text" style="position:absolute;top: 0px;left: 68px;width: 199px;">我的评论</p>
                </div>
            </div>
        </nav>

        <div id="commentList"></div>

        <div style="width: 100%;">
            <div class="qing banq" style="margin: 0 auto 20px;width: 457px;">闽ICP备201721086021号 Copyright 宿递By <font color="#1aa094"><b>LiangJ</b></font>，All Rights Reserved</div>
        </div>




    </body>
    <script id="demo" type="text/html">
        <div class="qing juzhong">
            <div class="lf tu-prk" style="width: 100%;">
                <div class="tu-pr">
                    <div class="qing cpxk shu12 layui-form-item" style="padding: 22px 30px 22px;line-height: 28px;position: relative">
                        {{# layui.each(d.list, function(index, comment){ }}
                        <div>
                            <div class="layui-form-item">购买【{{ comment.skuName }}】后发表评论：</div>
                            <textarea readonly style="width: 100%;height: 80px;border: 1px solid rgba(0,0,0,.1);padding: 5px 16px 5px 16px;font-size: 16px;color: #333333;">
                                {{ comment.commentContent }}
                            </textarea>
                            <div style="color: #ffb800;font-size: 17px;" class="layui-inline">评分：{{ comment.commentScore }} <i class="layui-icon layui-icon-star-fill"></i></div>
                            <div style="float: right">评论时间：{{ formatDateTime(comment.commentTime) }}</div>
                            <hr style="color: #333333">
                        </div>
                        {{# }) }}
                    </div>
                </div>
            </div>
        </div>
    </script>

    <script src="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
    <script>
        layui.use(['jquery', 'layer', 'laytpl', 'rate', 'form'], function () {
            var $ = layui.jquery,
                laytpl = layui.laytpl,
                rate = layui.rate,
                form = layui.form,
                layer = layui.layer;

            var url;//提交的请求地址
            var index;//打开窗口的索引

            /**
             * 请求后端查询该用户的所有评论
             */
            $.post("${pageContext.request.contextPath}/reception/comment/findByUser", function (result) {
                if (result.flag){
                    /**
                     * 渲染模版
                     * @type {{title: string, list: *}}
                     */
                    var templetData = { //数据
                        "title":"Layui常用模块"
                        ,"list":result.commentList
                    }
                    var getTpl = demo.innerHTML;
                    var commentList = document.getElementById('commentList');
                    laytpl(getTpl).render(templetData, function(html){
                        commentList.innerHTML = html;
                    });
                }
            }, "json");

        });
    </script>

</html>
