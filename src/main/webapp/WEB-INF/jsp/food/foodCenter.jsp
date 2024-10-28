<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>点餐中心</title>
        <link href="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/css/style.css" type="text/css" rel="stylesheet">
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/js/-jquery-1.8.3.min.js"></script>
        <link href="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/css/nav2.css" type="text/css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/css/amazeui.min.css" rel="stylesheet"/>
        <script src="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/js/amazeui.min.js"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/css/layui.css" media="all"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/css/layuimini.css?v=2.0.4.2" media="all"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/css/themes/default.css" media="all"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/lib/font-awesome-4.7.0/css/font-awesome.css" media="all"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/css/public.css" media="all"/>
        <style>
            .one_qcode {
                position: absolute;
                top: 190px;
                width: 200px;
                height: 180px;
                background: #fff;
                text-align: center;
                color: #000;
                z-index: 200;
            }

            .one_qcode img {
                margin: 0 auto;
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
                margin: 0px;
            }

            .am-tabs-bd .am-tab-panel {
                padding: 0;
            }

            .am-tabs-default .am-tabs-nav a {
                font-size: 18px;
            }

            h1 {
                font-family: "微软雅黑";
                font-size: 40px;
                margin: 20px 0;
                border-bottom: solid 1px #ccc;
                padding-bottom: 20px;
                letter-spacing: 2px;
            }

            .time-item strong {
            }

            #day_show {
                float: left;
                line-height: 49px;
                color: #c71c60;
                font-size: 32px;
                margin: 0 10px;
                font-family: Arial, Helvetica, sans-serif;
            }

            .item-title .unit {
                background: none;
                line-height: 49px;
                font-size: 24px;
                padding: 0 10px;
                float: left;
            }

            .am-tabs-default .am-tabs-nav > .am-active a p {
                border: 1px solid #fff !important;
            }
        </style>
    </head>
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
    <body>
        <div class="qing juzhong">
            <%-- 建立视图。用于呈现渲染结果 --%>
            <div id="view"></div>
        </div>
        <!--会员内容 -->
        </div>
        <div class="qing banq" style="margin-bottom:20px;">闽ICP备201721086021号 Copyright 宿递By <font color="#1aa094"><b>LiangJ</b></font>，All Rights Reserved</div>
    </body>

    <%-- 编写模版 --%>
    <script id="demo1" type="text/html">
        <div data-am-widget="tabs" class="am-tabs am-tabs-default">
            <ul class="am-tabs-nav am-cf" id="foodtype-nav">
                <li class="">
                    <span style="color: #1e9fff;line-height: 42px;text-overflow: ellipsis;display: block;font-size: 18px;word-wrap: normal;overflow: hidden;white-space: nowrap;text-decoration: none;">菜品类别</span>
                </li>
                {{# layui.each(d.list, function(index, item) {
                        var liClass = "";
                        var id="my-li-"+item.typeId;
                        if(index == 0) {
                           liClass = liClass + " am-active";
                        } }}
                        <li class={{ liClass }}><a href="#" id={{ id }}>{{ item.typeName }}</a></li>
                {{# }); }}
            </ul>

            <div class="am-tabs-bd" id="foodListView"></div>
        </div>
    </script>

    <script id="demo2" type="text/html">
        <div class="am-tab-panel am-active" style="width: 100%">
            <div class="rf" style="width:1200px;" style="margin: 0 auto;">
                <dl class="yplb">
                    {{# layui.each(d.list, function(index, food){
                            if(food != null) {
                            var foodInfoPath = "${pageContext.request.contextPath}/reception/foodInfo.html?foodId=" + food.foodId; }}
                            <dd style="background-color:#1aa0940a;">
                                <a href={{ foodInfoPath }} class="yptu">
                                    {{# var src = '/sudi/upload/' + food.foodImage; }}
                                    <img src={{ src }} width="230" height="230">
                                </a>
                                <div class="ypmc">
                                    <a href={{ foodInfoPath }} style="letter-spacing:1px;font-size: 22px;color: #333333;padding-left: 8px;">{{ food.foodName }}</a>
                                    <div style="float: right;margin-right: 10px;padding: 0px;color: #ffb800;font-size: 16px;font-weight: bold">
                                        {{ (food.foodScore).toFixed(1) }}
                                        <span class="layui-icon layui-icon-star-fill" style="color: #ffb800"></span>
                                    </div>
                                </div>
                                <div style="border:1px solid #1e9fff;border-radius: 50px; height: 45px;color: #1e9fff;">
                                    <a href={{ foodInfoPath }} style="color: #1e9fff;">
                                        <div style="width: 100%;text-align: center;font-size: 16px;line-height: 45px;">查看详情</div>
                                    </a>
                                </div>
                            </dd>
                    {{#     }
                    }) }}
                </dl>
            </div>
        </div>
    </script>

    <script src="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
    <script>
        layui.use(['form', 'table', 'jquery', 'layer', 'laytpl'], function () {
            var $ = layui.jquery,
                layer = layui.layer,
                laytpl = layui.laytpl;

            var data;//用于存储传回的所有数据

            /**
             * 请求后端查询所有上架的菜品类别和菜品信息
             */
            $.post("${pageContext.request.contextPath}/reception/food/findFoodType", function (result) {
                data = result;
                /**
                 * 渲染模版
                 * @type {{title: string, list: *}}
                 */
                var templetData = { //数据
                    "title":"Layui常用模块"
                    ,"list":data
                }
                var getTpl = demo1.innerHTML;
                var view = document.getElementById('view');
                laytpl(getTpl).render(templetData, function(html){
                    view.innerHTML = html;
                });

                var path = "${pageContext.request.contextPath}/reception/food/findFood";
                $.post(path, {typeId: result[0].typeId}, function (result) {
                    /**
                     * 渲染模版
                     * @type {{title: string, list: *}}
                     */
                    templetData = { //数据
                        "title":"Layui常用模块"
                        ,"list":result
                    }
                    var getTpl = demo2.innerHTML;
                    var foodListView = document.getElementById('foodListView');
                    laytpl(getTpl).render(templetData, function(html){
                        foodListView.innerHTML = html;
                    });
                })

                /**
                 * 监听菜品类别点击事件
                 */
                $("#foodtype-nav li a").click(function () {
                    var str = this.id.split("-");
                    $(".am-active").removeClass("am-active");
                    $(this).parent().addClass("am-active");
                    $.post(path, {typeId: str[str.length-1]}, function (result) {
                        /**
                         * 渲染模版
                         * @type {{title: string, list: *}}
                         */
                        templetData = { //数据
                            "title":"Layui常用模块"
                            ,"list":result
                        }
                        var getTpl = demo2.innerHTML;
                        var foodListView = document.getElementById('foodListView');
                        laytpl(getTpl).render(templetData, function(html){
                            foodListView.innerHTML = html;
                        });
                    })
                });

            });


        });


    </script>


</html>
