<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>我的订单</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/resources/css/myTicket.css" media="all">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/css/layui.css" media="all">
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

            function orderStatusText(orderStatus) {
                switch (orderStatus) {
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

            function orderStatusColor(orderStatus) {
                switch (orderStatus) {
                    case 1:
                        return "#f54a4a";
                    case 2:
                        return "#369eaf";
                    case 3:
                        return "#50d972";
                    case 4:
                        return "#ff0000";
                    case 5:
                        return "#b5b5b5";
                }
            }

            function deliverId(order) {
                if (order.deliverId != null) {
                    return order.deliverId;
                }else {
                    return "暂无配送员接单";
                }
            }

            function deliverName(order) {
                if (order.deliverName != null) {
                    return order.deliverName;
                }else {
                    return "暂无配送员接单";
                }
            }

            function deliverPhone(order) {
                if (order.deliverPhone != null) {
                    return order.deliverPhone;
                }else {
                    return "暂无配送员接单";
                }
            }

            function finishTime(time) {
                if (time != null ){
                    return formatDateTime(time);
                }else {
                    return "未结单";
                }
            }

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
                    <p class="navbar-text" style="position:absolute;top: 0px;left: 68px;width: 199px;">我的订单</p>
                </div>
            </div>
        </nav>

        <div id="orderList"></div>
        <div style="width: 100%;">
            <div class="qing banq" style="margin: 0 auto 20px;width: 457px;">闽ICP备201721086021号 Copyright 宿递By <font color="#1aa094"><b>LiangJ</b></font>，All Rights Reserved</div>
        </div>

        <%-- 评价订单弹出层 --%>
        <div class="layui-container" style="display: none;padding: 30px;width: 100%" id="commentForm">
            <form class="layui-form" style="width: 90%" id="dataForm" lay-filter="dataForm">
                <%--表单隐藏域--%>
                <input type="hidden" name="orderDetailId" id="orderDetailId">
                <div class="layui-inline layui-col-md2"><img id="foodImage" src="" style="width: 50px;height: 50px;"></div>
                <div class="layui-inline layui-col-md5" id="skuName" style="height: 50px;line-height: 50px;font-weight: 400"></div>
                <div class="layui-inline layui-col-md5">
                    <label style="font-weight: 200">评分</label>
                    <div id="foodScore"></div>
                </div>
                <div class="layui-form-item">
                    <textarea type="text" name="content" placeholder="请填写您对该菜品的看法" lay-verify="required" autocomplete="off" class="layui-textarea" id="content" style="width: 526px;"></textarea>
                </div>
                <div class="layui-form-item" style="margin-top: 20px;margin-bottom: 10px;"></div>
                <div class="layui-form-item layui-row layui-col-md12">
                    <div class="layui-input-block" style="text-align: center">
                        <button type="button" class="layui-btn layui-btn-checked" lay-submit lay-filter="doSubmit">
                            <span class="layui-icon layui-icon-add-1"></span>提交
                        </button>
                        <button type="reset" class="layui-btn layui-btn-primary" lay-reset lay-filter="doReset">
                            <span class="layui-icon layui-icon-refresh"></span>重置
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <%-- 投诉弹出框 --%>
        <div style="display: none;padding-top:15px;" id="complaintForm">
            <form class="layui-form" id="dataFrm" lay-filter="dataFrm">
                <%-- 表单隐藏域 --%>
                <input type="hidden" name="orderId" id="orderId">
                <div class="layui-form-item">
                    <div class="layui-inline layui-col-md6">
                        <label class="layui-form-label" style="width:120px;"><font color="red"> * </font>投诉类型</label>
                        <div class="layui-input-inline">
                            <select id="complaintType" name="complaintType" lay-filter="complaintType" style="width: 150px;text-align: center;" lay-verify="required">
                                <option value="" selected="selected">请选择投诉类型</option>
                                <option value="1">配送员投诉</option>
                                <option value="2">菜品投诉</option>
                                <option value="3">其他投诉</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline layui-col-md5">
                        <label class="layui-form-label" style="width:120px;">投诉对象</label>
                        <div class="layui-input-inline">
                            <select id="target" name="target" style="height: 32px;width: 150px;text-align: center;"></select>
                        </div>
                    </div>
                </div>

                <div class="layui-form-item">
                    <div class="layui-inline layui-col-md12 my-inline">
                        <label class="layui-form-label" style="width:120px;">投诉内容</label>
                        <div class="layui-input-inline" style="width: 77.5%;">
                            <textarea type="textarea" name="complaintContent" autocomplete="off" style="width:97.4%;" class="layui-input layui-textarea my-textarea" id="complaintContent" placeholder="请填写投诉内容"></textarea>
                        </div>
                    </div>
                </div>

                <div class="layui-form-item">
                    <br>
                </div>

                <div class="layui-form-item layui-row">
                    <div style="text-align: center">
                        <button type="button" class="layui-btn layui-btn-checked" lay-submit lay-filter="doSubmit">
                            <span class="layui-icon layui-icon-add-1"></span>提交
                        </button>
                    </div>
                </div>
            </form>
        </div>

    </body>
    <script type="text/html" id="demo">
    {{# layui.each(d.list, function(index, orderInfo){ }}
        <div class="orderBox">
            <div class="layui-form-item">
                <div class="layui-inline layui-col-md8" style="margin: 0;"><p class="myOrderBolder">订单编号：{{ orderInfo.order.orderId }}</p></div>
                <div class="layui-inline layui-col-md3">
                {{# var orderStatus = orderStatusText(orderInfo.order.orderStatus);
                    var color = orderStatusColor(orderInfo.order.orderStatus);}}
                    <p class="myOrderBolder">订单状态：<font color={{ color }}>{{ orderStatus }}</font></p>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-col-md4"><p>收货人姓名：<span>{{ orderInfo.order.realName }}</span></p></div>
                <div class="layui-col-md4"><p>联系方式：<span>{{ orderInfo.order.phone }}</span></p></div>
                <div class="layui-col-md4"><p>收货地址：<span>{{ orderInfo.order.address }}</span></p></div>
            </div>
            <div class="layui-form-item">
                <div class="layui-col-md4"><p>配送员编号：<span>{{ deliverId(orderInfo.order) }}</span></p></div>
                <div class="layui-col-md4"><p>配送员姓名：<span>{{ deliverName(orderInfo.order) }}</span></p></div>
                <div class="layui-col-md4"><p>配送员手机号：<span>{{ deliverPhone(orderInfo.order) }}</span></p></div>
            </div>
            <div class="layui-form-item">
                {{# var orderTime = formatDateTime(orderInfo.order.orderTime); }}
                <div class="layui-col-md4"><p>下单时间：<span>{{ orderTime }}</span></p></div>
                <div class="layui-col-md4"><p>结单时间：<span>{{ finishTime(orderInfo.order.finishTime) }}</span></p></div>
            </div>
            <hr style="margin-top: 0px;">
            {{# layui.each(orderInfo.orderDetailList, function(index, orderDetail){ }}
                <div class="layui-form-item" style="margin: 0 auto;">
                    {{# var foodImage = "${pageContext.request.contextPath}/upload/" + orderDetail.foodImage; }}
                    <input type="hidden" value="{{ orderDetail.orderDetailId }}"/>
                    <div class="layui-inline layui-col-md2" style="margin-left: 80px;"><img src={{ foodImage }} style="width: 50px;height: 50px"></div>
                    <div class="layui-inline layui-col-md3"><p style="line-height: 45px;">{{ orderDetail.skuName }}</p></div>
                    <div class="layui-inline layui-col-md2"><p style="line-height: 45px;">{{ (orderDetail.skuPrice).toFixed(2) }}元 × {{ orderDetail.amount }}份</p></div>
                    <div class="layui-inline layui-col-md2"><p style="line-height: 45px;">{{ (orderDetail.itemPrice).toFixed(2) }}元</p></div>
                    {{# if (orderInfo.order.orderStatus == 3){
                            if(orderDetail.comment == 2){ }}
                            <div class="layui-inline layui-col-md1">
                                <button type="button" class="layui-btn layui-btn-primary comment" id="comment">
                                    <i class="layui-icon layui-icon-reply-fill"></i> 评 价
                                </button>
                            </div>
                        {{# }else { }}
                            <div class="layui-inline layui-col-md1">
                                <button type="button" class="layui-btn layui-btn-disabled" id="commented">
                                    <i class="layui-icon layui-icon-ok-circle"></i> 已 评 价
                                </button>
                            </div>
                        {{# }
                    } }}
                </div>
            {{# }) }}
            <hr>
            <div class="clearfix layui-form-item">
                <div class="layui-col-md2" style="margin-left: 80px;"><p>总菜品数量：<span>{{ orderInfo.order.totalCount }}</span>份</p></div>
                <div class="layui-col-md2"><p>应付金额：<span>{{ (orderInfo.order.totalPrice).toFixed(2) }}</span>元</p></div>
                <div class="layui-col-md2"><p>优惠金额：<span>{{ (orderInfo.order.cheap).toFixed(2) }}</span>元</p></div>
                <div class="layui-col-md2"><p>实付金额：<span>{{ (orderInfo.order.actualPrice).toFixed(2) }}</span>元</p></div>
                {{# if (orderInfo.order.complaint == 2) { }}
                <div class="layui-col-md1"><button type="button" class="layui-btn layui-btn-primary complaint">
                    <i class="layui-icon layui-icon-service"></i> 我 要 投 诉
                </button></div>
                {{# } else { }}
                <div class="layui-col-md1"><button type="button" class="layui-btn layui-btn-primary" disabled>
                    <i class="layui-icon layui-icon-release"></i> 已 投 诉
                </button></div>
                {{# } }}
            </div>
        </div>
    {{# }) }}
    </script>

    <script src="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
    <script>
        layui.use(['jquery', 'layer', 'laytpl', 'rate', 'form'], function () {
            var $ = layui.jquery,
                rate = layui.rate,
                form = layui.form,
                laytpl = layui.laytpl,
                layer = layui.layer;

            var url;//提交的请求地址
            var index;//打开窗口的索引

            /**
             * 请求后端查询该用户的订单记录
             */
            $.post("${pageContext.request.contextPath}/reception/order/findOrderListByUserId", function (result) {
                if (result!=null){
                    /**
                     * 渲染模版
                     * @type {{title: string, list: *}}
                     */
                    var templetData = { //数据
                        "title":"Layui常用模块"
                        ,"list":result
                    }
                    var getTpl = demo.innerHTML;
                    var orderList = document.getElementById('orderList');
                    laytpl(getTpl).render(templetData, function(html){
                        orderList.innerHTML = html;
                    });

                    var orderDetailId;
                    var commentScore;

                    /**
                     * 监听评价按钮的点击事件
                     */
                    $(".comment").click(function () {
                        orderDetailId = $(this).parent().prev().prev().prev().prev().prev().val();
                        var foodImageSrc = $(this).parent().prev().prev().prev().prev().children().attr("src");
                        var skuName = $(this).parent().prev().prev().prev().text();
                        index = layer.open({
                            title: '菜品评价',
                            type: 1,
                            shade: 0.2,
                            maxmin:true,
                            shadeClose: true,
                            area: ['45%', '48%'],
                            offset: ['100px', '300px'],
                            content: $("#commentForm"),
                            success: function () {
                                //给隐藏域赋值
                                $("#orderDetailId").val(orderDetailId);
                                $("#foodImage").attr("src", foodImageSrc);
                                $("#skuName").text(skuName);
                                url = "${pageContext.request.contextPath}/reception/comment/add";

                                /**
                                 * 渲染评分星星
                                 */
                                rate.render({
                                    elem: '#foodScore'
                                    ,value: 2.5
                                    ,half: true
                                    ,text: true
                                    ,setText: function(value){
                                        this.span.text(value + "分");
                                    }
                                    ,choose: function(value){
                                        commentScore = value
                                    }
                                });

                                /**
                                 * 监听提交按钮的点击事件
                                 */
                                form.on("submit(doSubmit)", function(data){
                                    var commentData = {
                                        orderDetailId: orderDetailId,
                                        commentScore: commentScore,
                                        commentContent: $("#content").val()
                                    }
                                    //使用ajax的post请求去传递数据
                                    $.post(url, commentData, function(result){
                                        if (result.flag){
                                            //刷新页面
                                            location.reload();
                                            //关闭当前窗口
                                            layer.close(index);
                                        }
                                        //弹出提示信息
                                        layer.msg(result.message);
                                    }, "json");
                                    //禁止页面刷新
                                    return false;
                                });

                            }
                        });
                    })

                    /**
                     * 监听投诉按钮的点击事件
                     */
                    $(".complaint").click(function () {
                        var orderId = $(this).parent().parent().parent().children(0).children(0).children(0).text().split("：")[1].split("订单状态")[0];
                        $("#orderId").val(orderId);
                        index = layer.open({
                            title: '投诉',
                            type: 1,
                            shade: 0.2,
                            maxmin:true,
                            shadeClose: true,
                            area: ['60%', '45%'],
                            offset: ['100px', '240px'],
                            content: $("#complaintForm"),
                            success: function () {
                                //清空下拉框
                                $("#target").find("option").remove();
                                //清空表单数据
                                $("#dataFrm")[0].reset();
                                //添加的提交请求路径赋值
                                url = "${pageContext.request.contextPath}/reception/complaint/add";

                                /**
                                 * 监听投诉类型的选择事件
                                 */
                                form.on('select(complaintType)',function(data){
                                    //清空下拉框
                                    $("#target").find("option").remove();

                                    if (data.value==1){
                                        //向下拉框中追加元素
                                        $("#target").append(new Option("配送员", "配送员"));
                                    }else if (data.value == 2){
                                        //请求后端查询该订单下的所有菜品SKU
                                        $.post("${pageContext.request.contextPath}/backstage/order/findOrderDetailByOrderId", {orderId: orderId}, function (result1) {
                                            for (let x in result1) {
                                                $("#target").append(new Option(result1[x].skuName, result1[x].skuId));
                                            }
                                            form.render();
                                        }, "json");
                                    }else {
                                        $("#target").append(new Option("其他", "其他"));
                                    }
                                    form.render();
                                });

                                /**
                                 * 监听表单的提交事件
                                 */
                                form.on("submit(doSubmit)", function(data){
                                    //使用ajax的post请求去传递数据
                                    $.post(url, data.field, function(result2){
                                        alert(result2.message);
                                        layer.close(index);
                                        location.reload();
                                    }, "json");
                                    //禁止页面刷新
                                    return false;
                                });
                            }
                        });

                    })



                }else {
                    alert("暂无您的订单记录");
                }
            }, "json");





        });
    </script>


</html>
