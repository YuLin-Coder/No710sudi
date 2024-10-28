<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <meta charset="utf-8">
        <title>优惠券领取记录管理</title>
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/css/layui.css" media="all">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/css/public.css" media="all">
        <%-- 添加layui-dtree的css样式 --%>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui_ext/dtree/dtree.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui_ext/dtree/font/dtreefont.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/resources/css/foodManage.css">
    </head>
    <script>
        var flag;//控制行工具栏显示的标识符
    </script>
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
                                    <label class="layui-form-label">优惠券编号</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="ticketId" autocomplete="off" class="layui-input" onkeyup="value=value.replace(/[^0-9]/g,'')">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">优惠券名称</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="ticketName" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">领取人</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="username" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">使用状态</label>
                                    <div class="layui-input-inline">
                                        <select id="ticketStatus" name="ticketStatus" style="height: 32px;width: 150px;text-align: center;">
                                            <option value="0" selected=""></option>
                                            <option value="1">未使用</option>
                                            <option value="2">已使用</option>
                                            <option value="3">已过期</option>
                                            <option value="4">已作废</option>
                                            <option value="5">积分已返还</option>
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
                    {{# if(flag == 1){ }}
                    <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="invalid">
                        <i class="layui-icon layui-icon-close"></i>作废
                    </a>
                    {{# } else if(flag == 2){ }}
                    <a class="layui-btn layui-btn-xs layui-btn data-count-delete" lay-event="restore">
                        <i class="layui-icon layui-icon-refresh"></i>复原
                    </a>
                    <a class="layui-btn layui-btn-xs layui-btn-normal data-count-delete" lay-event="returnScore">
                        <i class="layui-icon layui-icon-form"></i>返还积分
                    </a>
                    {{# } else if(flag == 3){ }}
                    <a class="layui-btn layui-btn-xs layui-btn-normal data-count-delete" lay-event="returnScore">
                        <i class="layui-icon layui-icon-form"></i>返还积分
                    </a>
                    {{# } else if(flag == 4){ }}
                    <a class="layui-btn layui-btn-xs layui-btn-normal data-count-delete" lay-event="returnScore">
                        <i class="layui-icon layui-icon-form"></i>返还积分
                    </a>
                    {{# } }}
                </script>

            </div>
        </div>
    </body>
    <script src="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
    <script>
        layui.use(['form', 'table', 'jquery', 'layer', 'laydate'], function () {
            var $ = layui.jquery,
                form = layui.form,
                table = layui.table,
                laydate = layui.laydate,
                layer = layui.layer;

            var url;//提交的请求地址
            var index;//打开窗口的索引

            /**
             * 数据表单初始化
             */
            var tableIns = table.render({
                elem: '#currentTableId',
                url: '${pageContext.request.contextPath}/backstage/ticket/list',
                toolbar: '#toolbarDemo',
                defaultToolbar: ['filter', 'exports', 'print', {
                    title: '提示',
                    layEvent: 'LAYTABLE_TIPS',
                    icon: 'layui-icon-tips'
                }],
                cols: [[
                    {type: "checkbox", width: 50, align: "center"},
                    {field: 'ticketId', width: 140, title: '优惠券编号', align: "center", sort: true},
                    {field: 'ticketName', minWidth: 180, title: '优惠券名称', align: "center"},
                    {field: 'username', width: 140, title: '用户名', align: "center"},
                    {field: 'startTime', width: 180, title: '领取日期', align: "center",
                        templet:"<div>{{layui.util.toDateString(d.startTime, 'yyyy-MM-dd')}}</div>"
                    },
                    {field: 'endTime', width: 180, title: '结束日期', align: "center",
                        templet:"<div>{{layui.util.toDateString(d.endTime, 'yyyy-MM-dd')}}</div>"
                    },
                    {field: 'ticketStatus', width: 130, title: '使用状态', sort: true, align: "center",
                        templet: function (d) {
                            console.log(d);
                            if (d.ticketStatus == 1){
                                flag = 1;
                                return "<font color='green'>未使用</font>";
                            }else if (d.ticketStatus == 2) {
                                flag = 2;
                                return "<font color='#6a5acd'>已使用</font>";
                            }else if (d.ticketStatus == 3) {
                                flag = 3;
                                return "<font color='#1e90ff'>已过期</font>"
                            }else if (d.ticketStatus == 4) {
                                flag = 4
                                return "<font color='#999999'>已作废</font>"
                            }else if (d.ticketStatus == 5) {
                                flag = 5;
                                return "<font color='#ffd700'>积分已返还</font>"
                            }
                        }
                    },
                    {title: '操作', minWidth: 240, toolbar: '#currentTableBar', align: "center"}
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

            /**
             * 监听表单行工具栏事件
             */
            table.on('tool(currentTableFilter)', function (obj) {
                var data = obj.data;
                if (obj.event === 'invalid') {
                    var str = '确定要作废该优惠券吗?作废后用户将无法使用该优惠券!';
                    layer.confirm(str, {icon: 3, title:'提示'}, function(index){
                        $.post("${pageContext.request.contextPath}/backstage/ticket/invalid", {ticketId:data.ticketId}, function (result) {
                            if (result.flag){
                                //重新加载
                                tableIns.reload();
                            }
                            layer.msg(result.message);
                        }, "json");
                        layer.close(index);
                    });
                }else if (obj.event === 'restore') {
                    var str = '确定要复原该优惠券吗?复原后用户将可以重新使用该优惠券';
                    layer.confirm(str, {icon: 3, title:'提示'}, function(index){
                        $.post("${pageContext.request.contextPath}/backstage/ticket/restore", {ticketId:data.ticketId}, function (result) {
                            if (result.flag){
                                //重新加载
                                tableIns.reload();
                            }
                            layer.msg(result.message);
                        }, "json");
                        layer.close(index);
                    });
                }else if (obj.event === 'returnScore') {
                    var str = '确定要返回积分给领取的用户吗?';
                    layer.confirm(str, {icon: 3, title:'提示'}, function(index){
                        $.post("${pageContext.request.contextPath}/backstage/ticket/returnScore", {ticketId:data.ticketId}, function (result) {
                            if (result.flag){
                                //重新加载
                                tableIns.reload();
                            }
                            layer.msg(result.message);
                        }, "json");
                        layer.close(index);
                    });
                }
            });
        });
    </script>
</html>
