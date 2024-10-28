<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <meta charset="utf-8">
        <title>首页</title>
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/css/layui.css" media="all">
        <link href="${pageContext.request.contextPath}/static/plugins/productStore/css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
        <link href="${pageContext.request.contextPath}/static/plugins/productStore/css/style.css" rel="stylesheet" type="text/css" media="all" />
        <link href="${pageContext.request.contextPath}/static/plugins/productStore/css/fasthover.css" rel="stylesheet" type="text/css" media="all" />
        <link href="${pageContext.request.contextPath}/static/plugins/productStore/css/font-awesome.css" rel="stylesheet">
        <script src="${pageContext.request.contextPath}/static/plugins/productStore/js/jquery.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/plugins/productStore/js/bootstrap-3.1.1.min.js"></script>
        <script type="text/javascript">
            jQuery(document).ready(function($) {
                $(".scroll").click(function(event){
                    event.preventDefault();
                    $('html,body').animate({scrollTop:$(this.hash).offset().top},1000);
                });
            });
        </script>
        <script type="application/x-javascript">
            addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
                function hideURLbar(){ window.scrollTo(0,1); }
        </script>
    </head>
    <body>
        <%-- 轮播图区域 --%>
        <div class="layui-carousel" id="test1">
            <div carousel-item>
                <div><a><img src="${pageContext.request.contextPath}/static/resources/images/banner1.png"></a></div>
                <div><a><img src="${pageContext.request.contextPath}/static/resources/images/banner2.png"></a></div>
                <div><a><img src="${pageContext.request.contextPath}/static/resources/images/banner3.png"></a></div>
            </div>
        </div>

        <!-- Related Products -->
        <div id="view"></div>
        <!-- //Related Products -->

    </body>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/plugins/productStore/js/jquery.flexisel.js"></script>
    <!-- cart-js -->
    <script src="${pageContext.request.contextPath}/static/plugins/productStore/js/minicart.js"></script>
    <script src="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
    <script type="text/html" id="demo">
        <div class="w3l_related_products">
            <div class="container">
                <h3>推荐菜品</h3>
                <ul id="flexiselDemo2">
                {{# layui.each(d.list.recommendFoodList, function(index, recommend){ }}
                    <li>
                        <div class="w3l_related_products_grid">
                        {{# var foodInfoPath = "${pageContext.request.contextPath}/reception/foodInfo.html?foodId=" + recommend.foodId;}}
                            <div class="agile_ecommerce_tab_left mobiles_grid">
                                <div class="hs-wrapper hs-wrapper3">
                                {{# var foodImage = "${pageContext.request.contextPath}/upload/" + recommend.foodImage; }}
                                    <img src={{ foodImage }} alt=" " class="img-responsive" style="height: 255px;"/>
                                    <img src={{ foodImage }} alt=" " class="img-responsive" style="height: 255px;"/>
                                    <img src={{ foodImage }} alt=" " class="img-responsive" style="height: 255px;"/>
                                    <img src={{ foodImage }} alt=" " class="img-responsive" style="height: 255px;"/>
                                    <img src={{ foodImage }} alt=" " class="img-responsive" style="height: 255px;"/>
                                </div>
                                <div class="w3_hs_bottom" style="height: 255px;">
                                    <a href={{ foodInfoPath }}>
                                        <div class="flex_ecommerce" style="height: 255px;"></div>
                                    </a>
                                </div>
                                <h5><a href={{ foodInfoPath }}>{{ recommend.foodName }}</a></h5>
                            </div>
                        </div>
                    </li>
                {{# }) }}
                </ul>
            </div>
            <div class="container" style="margin-top: 85px;">
                <h3>热销菜品</h3>
                <ul id="flexiselDemo3">
                {{# layui.each(d.list.hotSaleFoodList, function(index, hotSale){ }}
                    <li>
                        <div class="w3l_related_products_grid">
                            <div class="agile_ecommerce_tab_left mobiles_grid">
                            {{# var foodInfoPath = "${pageContext.request.contextPath}/reception/foodInfo.html?foodId=" + hotSale.foodId;}}
                                <div class="hs-wrapper hs-wrapper3" style="height: 200px;">
                                    {{# var foodImage = "${pageContext.request.contextPath}/upload/" + hotSale.foodImage; }}
                                    <img src={{ foodImage }} alt=" " class="img-responsive" style="height: 255px;"/>
                                    <img src={{ foodImage }} alt=" " class="img-responsive" style="height: 255px;"/>
                                    <img src={{ foodImage }} alt=" " class="img-responsive" style="height: 255px;"/>
                                    <img src={{ foodImage }} alt=" " class="img-responsive" style="height: 255px;"/>
                                    <img src={{ foodImage }} alt=" " class="img-responsive" style="height: 255px;"/>
                                    <div class="w3_hs_bottom" style="height: 255px;">
                                        <a href={{ foodInfoPath }}>
                                            <div class="flex_ecommerce" style="height: 255px;"></div>
                                        </a>
                                    </div>
                                </div>
                                <h5><a href={{ foodInfoPath }}>{{ hotSale.foodName }}</a></h5>
                            </div>
                        </div>
                    </li>
                {{# }) }}
                </ul>
            </div>
        </div>
    </script>
    <script src="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
    <script>
        layui.use(['form', 'table', 'jquery', 'laytpl', 'layer', 'carousel'], function () {
            var $ = layui.jquery,
                carousel = layui.carousel,
                laytpl = layui.laytpl,
                layer = layui.layer;

            var url;//提交的请求地址
            var index;//打开窗口的索引

            $.post("${pageContext.request.contextPath}/reception/food/findRecommendAndHotSaleFood", function (result) {
                if (result.flag){
                    /**
                     * 渲染模版
                     * @type {{title: string, list: *}}
                     */
                    var templetData = { //数据
                        "title":"Layui常用模块"
                        ,"list":result
                    }
                    var getTpl = demo.innerHTML;
                    var view = document.getElementById('view');
                    laytpl(getTpl).render(templetData, function(html){
                        view.innerHTML = html;
                    });

                    /**
                     * 渲染推荐菜品轮播
                     */
                    $("#flexiselDemo2").flexisel({
                        visibleItems:4,
                        animationSpeed: 1000,
                        autoPlay: true,
                        autoPlaySpeed: 3000,
                        pauseOnHover: true,
                        enableResponsiveBreakpoints: true,
                        responsiveBreakpoints: {
                            portrait: {
                                changePoint:568,
                                visibleItems: 1
                            },
                            landscape: {
                                changePoint:667,
                                visibleItems:2
                            },
                            tablet: {
                                changePoint:768,
                                visibleItems: 3
                            }
                        }
                    });

                    /**
                     * 渲染热销菜品轮播
                     */
                    $("#flexiselDemo3").flexisel({
                        visibleItems:4,
                        animationSpeed: 1000,
                        autoPlay: true,
                        autoPlaySpeed: 3000,
                        pauseOnHover: true,
                        enableResponsiveBreakpoints: true,
                        responsiveBreakpoints: {
                            portrait: {
                                changePoint:568,
                                visibleItems: 1
                            },
                            landscape: {
                                changePoint:667,
                                visibleItems:2
                            },
                            tablet: {
                                changePoint:768,
                                visibleItems: 3
                            }
                        }
                    });
                }
            }, "json");

            /**
             * 建造banner区域实例
             */
            carousel.render({
                elem: '#test1'
                ,width: '100%' //设置容器宽度
                ,arrow: 'always' //始终显示箭头
                //,anim: 'updown' //切换动画方式
            });

        });
    </script>


</html>
