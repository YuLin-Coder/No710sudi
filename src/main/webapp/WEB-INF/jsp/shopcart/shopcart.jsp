<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
        <title>我的购物车</title>
        <link href="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/css/style.css" type="text/css" rel="stylesheet">
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/js/-jquery-1.8.3.min.js"></script>
        <link href="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/css/nav2.css" type="text/css" rel="stylesheet"><!--藏品分类 -->
        <link href="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/css/amazeui.min.css" rel="stylesheet" />
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
        </style>
    </head>
    <body>
        <div class="qing tibg">
            <div class="juzhong gwc-tk">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tbody><tr>
                        <td><img src="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/images/pa1.png" width="273" height="19"></td>
                        <td><img src="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/images/pa20.png" width="362" height="19"></td>
                        <td><img src="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/images/pa30.png" width="615" height="19"></td>
                    </tr></tbody>
                </table>
                <div class="qing chm">
                    <div class="lf" style="width:295px; text-align:right;">购物车</div>
                    <div class="lf" style="width:386px; text-align:right;">核对订单信息</div>
                    <div class="lf" style="width:323px; text-align:right;">支付成功</div>
                </div>
            </div>
        </div>
        <!--页面标题 -->
        <div id="view"></div>
        <div class="qing banq" style="margin-bottom:20px;">闽ICP备201721086021号 Copyright 宿递By <font color="#1aa094"><b>LiangJ</b></font>，All Rights Reserved</div>
    </body>


    <script id="demo" type="text/html">
        <div class="qing juzhong" style="margin-bottom:40px;">
            <div class="gwl" style="background-color:#f8f8f8;">
                <div class="gw-m" style="background-color:#fff;">
                    <div class="gw-m1">菜品名称</div>
                    <div class="gw-m2">单价</div>
                    <div class="gw-m3">数量</div>
                    <div class="gw-m4">小计</div>
                    <div class="gw-m5">操作</div>
                </div>
                {{# if(d.list[0] != null){ }}
                    {{# var zongjiage = 0; }}
                    {{# layui.each(d.list, function(index, item){ }}
                        {{# var shopcartId = "shopcartId_" + item.shopcartId; }}
                            <div class="gwlb" id={{ shopcartId }}>
                            {{# var background = "background:url(${pageContext.request.contextPath}/upload/"+ item.foodImage + ") center center no-repeat;"; }}
                                <a href="javascript:void(0)" class="gw-tu" style={{ background }}></a>
                                <div class="gw-jk"><a href="javascript:void(0)" style="font-size: 14px;color: #333333;">{{ item.skuName }}</a></div>
                                <div class="gw-jg">{{ item.skuPrice }}元</div>
                                <div class="gw-sl">
                                    <a href="javascript:void(0);" class="gw-sl1 lf reduce-btn" id="reduce-btn">-</a>
                                    {{# var order_num = "order_num_" + item.shopcartId; }}
                                    <input type="text" name="order_num" id={{ order_num }} value={{ item.numCount }} disabled="disabled">
                                    <a href="javascript:void(0);" class="gw-sl2 rf add-btn" id="add-btn">+</a>
                                </div>
                                <div class="gw-jg" id="heji">{{ item.skuPrice*item.numCount }}元</div>
                                {{# zongjiage = zongjiage + parseFloat(item.skuPrice*item.numCount); }}
                                {{# var deleteBtn = "delete_btn_" + item.shopcartId; }}
                                <a href="javascript:void(0)" class="shanc" id={{ deleteBtn }} style="margin-right: 6px;margin-top: -6px;">×</a>
                            </div>
                    {{# }) }}
            </div>
            <div class="gwzj">
                <div class="lf chjx">
                    <a href="${pageContext.request.contextPath}/reception/foodCenter.html">继续点餐</a>　　| 　　共<span id="zongshuliang">{{ d.list.length }}</span>件菜品
                </div>
                <div class="rf">
                    <div class="lf chhj">合计：<span id="zongjiage">{{ zongjiage }}</span>元</div>
                    <a href="javascript:void(0)" class="jie"><span>去结算</span><span>去结算</span></a>
                </div>
            </div>
        </div>
                {{# }else { }}
                    <img src="${pageContext.request.contextPath}/static/resources/images/emptyShopcart.png" style="height: 265px;margin: 0 auto;">
                {{# } }}
    </script>

    <script src="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
    <script>
        layui.use(['form', 'table', 'jquery', 'layer', 'laytpl'], function () {
            var $ = layui.jquery,
                layer = layui.layer,
                laytpl = layui.laytpl;

            /**
             * 请求后端查询该用户的购物车列表
             */
            var url = "${pageContext.request.contextPath}/reception/shopcart/findByUserId";
            $.post(url, function (result) {
                /**
                 * 渲染模版
                 * @type {{title: string, list: *}}
                 */
                var templetData = { //数据
                    "title":"Layui常用模块"
                    ,"list":result.shopcart
                }
                console.log(templetData);

                var getTpl = demo.innerHTML;
                var view = document.getElementById('view');
                laytpl(getTpl).render(templetData, function(html){
                    view.innerHTML = html;
                });

                /**
                 * 监听增加和减少按钮的事件
                 */
                $(".add-btn").click(function () {
                    var shopcartId = $(this).prev().attr("id").split("_")[2];
                    var thisElem = $(this);
                    $.post("${pageContext.request.contextPath}/reception/shopcart/addNumCountOne", {shopcartId: shopcartId}, function (result1) {
                        if (result1.split(":")[1] == "true}"){
                            $("#zongjiage").text(parseFloat($("#zongjiage").text()) + parseFloat($(thisElem).parent().prev().text()));//修改总计
                            $(thisElem).prev().val(parseInt($(thisElem).prev().val())+1);//修改数目
                            $(thisElem).parent().next().text(parseInt($(thisElem).prev().val()) * parseFloat($(thisElem).parent().prev().text()) + "元");//修改小计
                        }
                    });
                });
                $(".reduce-btn").click(function () {
                    var shopcartId = $(this).next().attr("id").split("_")[2];
                    var thisElem = $(this);
                    if ($(thisElem).next().val() > 1) {
                        $.post("${pageContext.request.contextPath}/reception/shopcart/reduceNumCountOne", {shopcartId: shopcartId}, function (result1) {
                            if (result1.split(":")[1] == "true}"){
                                $("#zongjiage").text(parseFloat($("#zongjiage").text()) - parseFloat($(thisElem).parent().prev().text()));//修改总计
                                $(thisElem).next().val(parseInt($(thisElem).next().val())-1);//修改数目
                                $(thisElem).parent().next().text(parseInt($(thisElem).next().val()) * parseFloat($(thisElem).parent().prev().text()) + "元");//修改小计
                            }
                        });
                    }else {
                        layer.msg("份数不能再减少啦!");
                    }
                });

                /**
                 * 监听购物车的条目删除点击事件
                 */
                $(".shanc").click(function () {
                    var thisElement = $(this);
                    var str = "确定要从购物车中删除该菜品条目吗?";
                    layer.confirm(str, {icon: 3, title:'提示', offset: ['200px', '450px']}, function(index){
                        var shopcartId = $(thisElement).attr("id").split("_")[2];
                        $.post("${pageContext.request.contextPath}/reception/shopcart/delete", {shopcartId: shopcartId},function (result2) {
                            if (result2.flag){
                                setTimeout(function(){
                                    location.reload();
                                }, 700);
                            }
                            layer.msg(result2.message);
                        }, "json");
                        layer.close(index);
                    });
                });

                /**
                 * 监听结算按钮的点击事件
                 */
                $(".jie").click(function () {
                    location.href = "${pageContext.request.contextPath}/reception/generateOrder.html";
                });
            }, "json");
        });
    </script>


</html>
