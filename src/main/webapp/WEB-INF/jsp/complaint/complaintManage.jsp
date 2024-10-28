<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <meta charset="utf-8">
        <title>投诉中心</title>
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/css/layui.css" media="all">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/css/public.css" media="all">
        <%-- 添加layui-dtree的css样式 --%>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui_ext/dtree/dtree.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui_ext/dtree/font/dtreefont.css">
    </head>
    <body>
        <div class="layuimini-container">
            <div class="layuimini-main">

                <%-- 头部条件搜索区域 --%>
                <fieldset class="table-search-fieldset">
                    <legend>搜索信息</legend>
                    <div style="margin: 10px 10px 10px 10px">
                        <form class="layui-form layui-form-pane" action="" id="searchForm">
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">投诉编号</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="ticketTypeId" autocomplete="off" class="layui-input" onkeyup="value=value.replace(/[^0-9]/g,'')">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">投诉类型</label>
                                    <div class="layui-input-inline">
                                        <select type="text" name="complaintType">
                                            <option value="0">请选择</option>
                                            <option value="1">配送员投诉</option>
                                            <option value="2">菜品投诉</option>
                                            <option value="3">其他</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <button type="submit" class="layui-btn layui-btn-primary"  lay-submit lay-filter="data-search-btn">
                                        <i class="layui-icon layui-icon-search"></i>搜索
                                    </button>
                                    <button type="reset" class="layui-btn layui-btn-primary" lay-submit lay-filter="data-reset-btn" id="data-reset-btn">
                                        <i class="layui-icon layui-icon-refresh"></i>重置
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </fieldset>

                <%-- 表格区域 --%>
                <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

                <%-- 表格行工具栏 --%>
                <script type="text/html" id="currentTableBar">
                    <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit" id="edit">
                        <i class="layui-icon layui-icon-edit"></i>编辑
                    </a>
                </script>

                <%-- 添加或修改弹出框 --%>
                <div class="layui-container" style="display: none;padding: 5px;width: 100%;" id="addOrUpdateForm">
                    <form class="layui-form" style="width: 90%" id="dataForm" lay-filter="dataForm">
                        <%--表单隐藏域--%>
                        <input type="hidden" name="ticketTypeId" id="ticketTypeId">
                        <div class="layui-form-item">
                            <div class="layui-inline layui-col-md6 my-inline">
                                <label class="layui-form-label"><font color="red"> * </font>优惠券名称</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="ticketName" placeholder="请输入优惠券名称" lay-verify="required" autocomplete="off" class="layui-input" id="ticketName">
                                </div>
                            </div>
                            <div class="layui-inline layui-col-md6 my-inline">
                                <label class="layui-form-label"><font color="red"> * </font>使用门槛</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="requirement" placeholder="请输入使用门槛" lay-verify="required" autocomplete="off" class="layui-input" id="requirement">
                                </div>
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <div class="layui-inline layui-col-md6 my-inline">
                                <label class="layui-form-label"><font color="red"> * </font>优惠金额</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="cheap" placeholder="请输入优惠金额" lay-verify="required" autocomplete="off" class="layui-input" id="cheap">
                                </div>
                            </div>
                            <div class="layui-inline layui-col-md6 my-inline">
                                <label class="layui-form-label"><font color="red"> * </font>提供数量</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="ticketNum" placeholder="请输入提供数量" lay-verify="required" autocomplete="off" class="layui-input" id="ticketNum">
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-inline layui-col-md6 my-inline">
                                <label class="layui-form-label"><font color="red"> * </font>生效天数</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="liveTime" placeholder="请输入生效天数" lay-verify="required" autocomplete="off" class="layui-input" id="liveTime">
                                </div>
                            </div>
                            <div class="layui-inline layui-col-md6 my-inline">
                                <label class="layui-form-label"><font color="red"> * </font>所需积分</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="needScore" placeholder="请输入所需积分" lay-verify="required" autocomplete="off" class="layui-input" id="needScore">
                                </div>
                            </div>
                        </div>

                        <div class="layui-form-item layui-row layui-col-md12">
                            <div class="layui-input-block" style="text-align: center">
                                <button type="button" class="layui-btn layui-btn-checked" lay-submit lay-filter="doSubmit">
                                    <span class="layui-icon layui-icon-add-1"></span>提交
                                </button>
                                <button type="reset" class="layui-btn layui-btn-primary" lay-reset lay-filter="doReset" id="doReset">
                                    <span class="layui-icon layui-icon-refresh"></span>重置
                                </button>
                            </div>
                        </div>
                    </form>
                </div>

            </div>
        </div>
    </body>
    <script src="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
    <script>
        layui.use(['form', 'table', 'jquery', 'layer'], function () {
            var $ = layui.jquery,
                form = layui.form,
                table = layui.table,
                layer = layui.layer;

            var url;//提交的请求地址
            var index;//打开窗口的索引

            /**
             * 数据表单初始化
             */
            var tableIns = table.render({
                elem: '#currentTableId',
                url: '${pageContext.request.contextPath}/reception/complaint/list',
                toolbar: '#toolbarDemo',
                defaultToolbar: ['filter', 'exports', 'print', {
                    title: '提示',
                    layEvent: 'LAYTABLE_TIPS',
                    icon: 'layui-icon-tips'
                }],
                cols: [[
                    {type: "checkbox", width: 50, align: "center"},
                    {field: 'complaintId', width: 114, title: '投诉编号', align: "center", sort: true},
                    {field: 'orderId', width: 190, title: '订单编号', align: "center"},
                    {field: 'username', width: 90, title: '投诉人', align: "center"},
                    {field: 'complaintType', width: 114, title: '投诉类型', align: "center", sort: true,
                        templet: function (d) {
                            if (d.complaintType == 1){
                                return "<font color='#4662d9'>配送员投诉</font>";
                            }else if (d.complaintType == 2){
                                return "<font color='#ff4500'>菜品投诉</font>";
                            }else if (d.complaintType == 3){
                                return "<font color='#999999'>其他</font>";
                            }
                        }
                    },
                    {field: 'target', width: 120, title: '投诉对象', align: "center"},
                    {field: 'complaintContent', minWidth: 200, title: '投诉内容', align: "center"},
                    {field: 'complaintTime', minWidth: 160, title: '投诉时间', align: "center", sort: true,
                        templet:"<div>{{layui.util.toDateString(d.complaintTime, 'yyyy-MM-dd HH:mm:ss')}}</div>"
                    }
                ]],
                limits: [10, 15, 20, 25, 50, 100],
                limit: 10,
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
             * 监听搜索操作
             */
            form.on('submit(data-search-btn)', function (data) {
                console.log(data);
                //执行搜索重载
                tableIns.reload({
                    where: data.field,
                    page: {
                        curr: 1
                    }
                });
                return false;
            });
        });
    </script>

</html>
