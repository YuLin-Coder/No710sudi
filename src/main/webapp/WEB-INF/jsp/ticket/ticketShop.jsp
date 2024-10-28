<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
        <title>优惠券商城</title>
        <link href="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/css/style.css" type="text/css" rel="stylesheet">
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/js/-jquery-1.8.3.min.js"></script>
        <link href="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/css/nav2.css" type="text/css" rel="stylesheet"><!--藏品分类 -->
        <link href="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/css/amazeui.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/css/layui.css" media="all">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/css/public.css" media="all">
        <script src="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/js/amazeui.min.js"></script>
        <script type="text/javascript">
            <!--
            var timeout         = 500;
            var closetimer		= 0;
            var ddmenuitem      = 0;
            // open hidden layer
            function mopen(id)
            {
                // cancel close timer
                mcancelclosetime();
                // close old layer
                if(ddmenuitem) ddmenuitem.style.visibility = 'hidden';
                // get new layer and show it
                ddmenuitem = document.getElementById(id);
                ddmenuitem.style.visibility = 'visible';
            }
            // close showed layer
            function mclose()
            {
                if(ddmenuitem) ddmenuitem.style.visibility = 'hidden';
            }
            // go close timer
            function mclosetime()
            {
                closetimer = window.setTimeout(mclose, timeout);
            }
            // cancel close timer
            function mcancelclosetime()
            {
                if(closetimer)
                {
                    window.clearTimeout(closetimer);
                    closetimer = null;
                }
            }
            // close layer when click-out
            document.onclick = mclose;
            // -->
        </script>
        <style>
            .one_qcode{
                position:absolute;
                top:190px;
                width:200px;
                height:180px;
                background:#fff;
                text-align:center;
                color:#000;
                z-index:200;
            }
            .one_qcode img{
                margin:0 auto;
            }
            .yplb dd {
                display: block;
                float: left;
                width: 279px;
                border: 1px solid #f1f1f1;
                margin-top: -1px;
                margin-left: -1px;
                padding: 15px;
                margin: 10px;
            }
            [data-am-widget=tabs] {
                margin:0px;
            }
            .am-tabs-bd .am-tab-panel{ padding:0;}
            .am-tabs-default .am-tabs-nav a{ font-size:18px;}
            h1 {
                font-family:"微软雅黑";
                font-size:40px;
                margin:20px 0;
                border-bottom:solid 1px #ccc;
                padding-bottom:20px;
                letter-spacing:2px;
            }
            .time-item strong {
            }
            #day_show {
                float:left;
                line-height:49px;
                color:#c71c60;
                font-size:32px;
                margin:0 10px;
                font-family:Arial,Helvetica,sans-serif;
            }
            .item-title .unit {
                background:none;
                line-height:49px;
                font-size:24px;
                padding:0 10px;
                float:left;
            }
            .am-tabs-default .am-tabs-nav>.am-active a p{ border:1px solid #fff !important;}
        </style>
    </head>
    <body>
        <!--页面标题 -->
        <div style="width:100%; height:100px; background:url(${pageContext.request.contextPath}/static/plugins/Ruidan_Page/images/header_bgV2.png) no-repeat top center">
            <img src="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/images/yhq.png" style="width:1200px; margin:0 auto;">
        </div>

        <div class="biu_registered clear_after" style="width:100%; margin:0 auto;">

            <div style="background:#f8f8f8;padding: 0; width:1200px; margin:10px auto">
                <ul class="coupon-list" id="couponListUl">

                    <div id="view"></div>

                </ul>
            </div>



        </div>

        <div class="qing banq" style="margin-bottom:20px;">闽ICP备201721086021号 Copyright 宿递By <font color="#1aa094"><b>LiangJ</b></font>，All Rights Reserved</div>
    </body>
    <script id="demo" type="text/html">
        {{# layui.each(d.list, function(index,ticketType){ }}
            <li class="coupon-blue" style="position: relative;">
            {{# var clickId = "clickId_" + ticketType.ticketTypeId; }}
                <a class="coupon-a" id={{ clickId }} href="javascript:void(0)">
                    <div class="coupon-left">
                        <div class="pro-content">
                            <span class="pro-info" style="font-size: 16px;">{{ ticketType.ticketName }}</span>
                            <span class="ticket-info" style="color: #999999;position: absolute;top: 43px;left: 24px;font-size: 13px;">领取{{ ticketType.liveTime }}天后过期</span>
                            <div class="pro-price" style="position: absolute;top: 62px;left: 20px;">
                                <span class="big-price" style="font-size: 23px;">￥{{ ticketType.cheap }}</span>
                                <span class="price-info">满{{ ticketType.requirement }}可用</span>
                            </div>
                            <span style="position: absolute;top: 71px;left: 177px;font-size: 13px;color: orange">所需积分：{{ ticketType.needScore }}</span>
                        </div>
                    </div>
                    <div class="coupon-right">
                        <div class="triangle-border-right">
                            <em class="circular0"></em>
                            <em class="circular1"></em>
                        </div>
                        <div class="change-block">
                            <div class="progress-bar-block">
                                <div class="progress-bar">
                                {{# var receivePresent = "width:" + (1-parseInt(ticketType.receive)/parseInt(ticketType.ticketNum))*100 + "%";  }}
                                    <span style={{ receivePresent }}></span>
                                </div>
                            </div>
                            <span class="progress-text">已领取：{{ ticketType.receive }}</span>
                            <span class="coupon-btn">立即兑换</span>
                        </div>
                    </div>
                </a>
            </li>
        {{# }) }}

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
            $.post("${pageContext.request.contextPath}/reception/ticket/findAll", function (result) {
                console.log(result);
                /**
                 * 渲染模版
                 * @type {{title: string, list: *}}
                 */
                templetData = { //数据
                    "title":"Layui常用模块"
                    ,"list":result.ticketTypeList
                }
                var getTpl = demo.innerHTML;
                var view = document.getElementById('view');
                laytpl(getTpl).render(templetData, function(html){
                    view.innerHTML = html;
                });

                /**
                 * 监听每个优惠券类别的点击事件
                 */
                $(".coupon-a").click(function () {
                    var ticketTypeId = $(this).attr("id").split("_")[1];
                    var needScore = $(this).children().eq(0).children().eq(0).children().eq(3).text().split("：")[1];
                    layer.confirm('确定要花费<font color="#ff4500">【' + needScore + '积分】</font>去兑换该优惠券吗？', {icon: 3, title:'提示'}, function(index){
                        $.post("${pageContext.request.contextPath}/reception/ticket/receiveTicket",{ticketTypeId: ticketTypeId}, function (result1) {
                            layer.msg(result1.message);
                        }, "json");
                        layer.close(index);
                    });


                })



            }, "json");



        })
    </script>

</html>
