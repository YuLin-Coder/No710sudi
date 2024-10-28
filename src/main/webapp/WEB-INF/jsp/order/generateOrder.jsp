<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
        <title>生成订单</title>
        <link href="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/css/style.css" type="text/css" rel="stylesheet">
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/js/-jquery-1.8.3.min.js"></script>
        <link href="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/css/nav2.css" type="text/css" rel="stylesheet"><!--藏品分类 -->
        <link href="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/css/amazeui.min.css" rel="stylesheet" />
        <script src="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/js/amazeui.min.js"></script>
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
        <form id="myform" action="" method="post">
            <div class="qing tibg">
                <div class="juzhong gwc-tk">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tbody><tr>
                            <td><img src="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/images/pa1.png" width="273" height="19"></td>
                            <td><img src="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/images/pa2.png" width="362" height="19"></td>
                            <td><img src="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/images/pa30.png" width="615" height="19"></td>
                        </tr>
                        </tbody></table>
                    <div class="qing chm">
                        <div class="lf" style="width:295px; text-align:right;">购物车</div>
                        <div class="lf" style="width:386px; text-align:right;">核对订单信息</div>
                        <div class="lf" style="width:323px; text-align:right;">支付成功</div>
                    </div>
                </div>
            </div>
            <!--核对信息 -->
            <div class="qing juzhong">

                <div class="cenbg">
                    <div class="qing" style="position: relative;border-bottom: 1px solid #e3e3e3;padding-bottom: 8px;">
                        <div class="xxti layui-inline" style="position: relative;"><font color="red"> * </font><span>收货人：</span>
                            <input type="text" class="layui-input-inline" name="realName" id="realName" lay-verify="required" style="position: absolute;top:6px;left: 124px;font-size: 16px;" placeholder="请输入收货人姓名">
                        </div>
                        <div class="xxti layui-inline" style="position: relative;position:absolute;left: 600px;top: 0px;"><font color="red"> * </font><span>手机号：</span>
                            <input type="text" class="layui-input-inline" name="phone" id="phone" lay-verify="required|phone" style="position: absolute;top:6px;left: 124px;font-size: 16px;" placeholder="请输入联系手机号" value="${sessionScope.userLogin.phone}">
                        </div>
                        <div class="layui-form-item">
                            <div class="xxti layui-inline" style="position: relative;"><span>收货地址：</span>
                                <select class="layui-input-inline" name="address" id="address" lay-verify="required" style="position: absolute;top:6px;left: 124px;font-size: 16px;"></select>
                            </div>
                        </div>
                    </div>
                    <!--支付方式 -->
                    <div class="qing fuk">
                        <div class="fu-ti"><div class="xxti">支付方式</div></div>
                        <div class="lf"><!--选中状态 class为paynn -->
                            <input type="hidden" name="pay_method" value="1" id="pay_method">
                            <a href="javascript:void(0)" id="pay_method_1" class="pay paynn">
                                <img src="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/images/pay1.png" width="160" height="60">
                            </a>
                            <a href="javascript:void(0)" id="pay_method_2" class="pay">
                                <img src="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/images/pay2.png" width="160" height="60">
                            </a>
                            <a href="javascript:void(0)" id="pay_method_3" class="pay">
                                <img src="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/images/pay3.png" width="160" height="60">
                            </a>
                        </div>
                    </div>
                    <!--配送方式 -->
                    <div class="qing dizk" style="position:relative;">
                        <div class="xxti lf"><span>优惠券</span>
                            <select class="layui-input-inline" name="ticketId" id="ticketId" style="position: absolute;top: 26px;left: 124px;font-size: 16px;" lay-filter="ticketId">
                                <option value="" selected>不使用</option>
                            </select>
                        </div>
                    </div>
                    <!--商品及优惠 -->
                    <div class="qing" id="view"></div>
                </div>
            </div>
        </form>



        <div class="qing banq" style="margin-bottom:20px;">闽ICP备201721086021号 Copyright 宿递By <font color="#1aa094"><b>LiangJ</b></font>，All Rights Reserved</div>
    </body>

    <script id="demo" type="text/html">
        <div class="qing">
            <div class="xxti lf">菜品条目</div>
            <a href="${pageContext.request.contextPath}/reception/shopcart.html" class="rf hui">返回购物车<span> &gt;</span></a>
        </div>
        <div class="qing xcp">
            {{# var totalCount = 0;
                var totalPrice = 0;}}
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tbody>
                {{# layui.each(d.list, function(index, item){ }}
                    {{# var foodImage = "${pageContext.request.contextPath}/upload/" + item.foodImage; }}
                    <tr>
                        <td width="75"><img src={{ foodImage }} width="59" height="45"></td>
                        <td width=""><a href="javascript:void(0)" class="dj-m1" style="font-size: 14px;color: #333333;margin-left: 16px;">{{ item.skuName }}</a></td>
                        <td width="150" align="center"><div class="xsl">{{ item.skuPrice }}元&nbsp;&nbsp;×&nbsp;&nbsp;{{ item.numCount }}份</div></td>
                        <td width="150" align="center"><div class="xslj">{{ item.skuPrice*item.numCount }}元</div></td>
                    </tr>
                    {{# totalCount += item.numCount;
                        totalPrice += item.skuPrice*item.numCount; }}
                {{# }) }}
                </tbody>
            </table>
        </div>
        <div class="qing fuyk0">
            <div class="rf fuyk">
                <div class="fu-you2 rf">{{ totalCount }}件</div>
                <div class="fu-yu2 rf">菜品件数：</div>
            </div>
            <div class="rf fuyk">
                <div class="fu-you2 rf" id="totalPrice">{{ totalPrice.toFixed(2) }}元</div>
                <div class="fu-yu2 rf">应付总金额：</div>
            </div>
            <div class="rf fuyk">
                <div class="fu-you2 rf" id="cheap">0.00元</div>
                <div class="fu-yu2 rf">优惠金额：</div>
            </div>
            <div class="rf fuyk">
                <div class="fu-you3 rf"><sapn id="actualPrice">{{ totalPrice.toFixed(2) }}元</sapn></div>
                <div class="fu-yu2 fu-yu3 rf">实付总金额：</div>
            </div>
        </div>
        <div class="qing rf"><a href="javascript:void(0)" id="commit"><input type="button" value="确认并支付" class="jie2"></a></div>
    </script>

    <script src="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
    <script>
        layui.use(['form', 'jquery', 'layer', 'laytpl'], function () {
            var $ = layui.jquery,
                layer = layui.layer,
                form = layui.form,
                laytpl = layui.laytpl;

            /**
             * 请求后端访问当前用户购物车中的菜品条目
             */
            $.post("${pageContext.request.contextPath}/reception/shopcart/findByUserId", function (result) {
                /**
                 * 渲染模版
                 * @type {{title: string, list: *}}
                 */
                var templetData = { //数据
                    "title":"Layui常用模块"
                    ,"list":result.shopcart
                }
                var getTpl = demo.innerHTML;
                var view = document.getElementById('view');
                laytpl(getTpl).render(templetData, function(html){
                    view.innerHTML = html;
                });

                /**
                 * 监听订单提交按钮的点击事件
                 */
                $("#commit").click(function () {
                    if ($("#realName").val() == ''){
                        alert("请填写收货人姓名");
                    }else {
                        //发送post请求生成订单
                        var realName = $("#realName").val();
                        var phone = $("#phone").val();
                        var addressId = $("#address").val();
                        var ticketId = $("#ticketId").val();
                        var orderData = {
                            realName: realName,
                            phone: phone,
                            addressId: addressId,
                            ticketId: ticketId,
                        }
                        $.get("${pageContext.request.contextPath}/reception/order/generateOrder", orderData, function (orderResult) {
                            console.log(orderResult);
                            if(orderResult.flag){
                                //跳转到支付成功页面
                                location.href = "${pageContext.request.contextPath}/reception/paySuccess.html?rewardScore=" + orderResult.rewardScore;
                                layer.msg(orderResult.message + "，恭喜您获得奖励积分：" + orderResult.rewardScore);
                            }else {
                                layer.msg(orderResult.message);
                            }

                        }, "json");
                    }
                });
            }, "json");

            /**
             * 请求后端获取用户的地址信息
             */
            $.post("${pageContext.request.contextPath}/address/listByUser", function (addressResult) {
                if (addressResult.flag){
                    $.each(addressResult.addressList, function (index, address) {
                        //向下拉框中追加元素
                        if (address.defaulted == 1){
                            $("#address").append(new Option(address.address, address.addressId, true, true));
                        }else {
                            $("#address").append(new Option(address.address, address.addressId));
                        }
                    });
                    form.render("select");
                }
            }, "json");

            /**
             * 请求后端获取用户未使用的优惠券列表
             */
            $.post("${pageContext.request.contextPath}/reception/ticket/findByUserUnuse", function (ticketResult) {
                if (ticketResult.flag){
                    var totalPrice = $("#totalPrice").text().split("元")[0];
                    $.each(ticketResult.ticketList, function (index, ticket) {
                        //向下拉框中追加元素
                        var str = ticket.ticketName+"————满"+ticket.requirement+"减"+ticket.cheap+"元";
                        if (ticket.requirement <= totalPrice){
                            $("#ticketId").append(new Option(str, ticket.ticketId, true, false));
                        }
                    });
                    form.render("select");
                }
            }, "json");

            /**
             * 点着玩的支付方式
             */
            $(".pay").click(function () {
                $(".pay").removeClass("paynn");
                $(this).attr("class", "pay paynn");
            });

            /**
             * 监听优惠券选择的改变事件
             */
            $("#ticketId").change(function () {
                var ticketId = $(this).val();
                $.post("${pageContext.request.contextPath}/reception/ticket/findTicketById", {ticketId: ticketId}, function (result3) {
                    result3 = JSON.parse(result3);
                    var cheap = (parseFloat(result3.ticket.cheap)).toFixed(2);
                    $("#cheap").text(cheap + "元");
                    $("#actualPrice").text((parseFloat($("#totalPrice").text().split("元")[0]) - parseFloat($("#cheap").text().split("元")[0])).toFixed(2));
                });
            });
        });
    </script>
</html>