<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <meta charset="utf-8">
        <title>菜品类别管理</title>
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/css/layui.css" media="all">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/css/public.css" media="all">
        <%-- 添加layui-dtree的css样式 --%>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui_ext/dtree/dtree.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui_ext/dtree/font/dtreefont.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/resources/css/foodManage.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui_inputTag/inputTags.css">
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
                                    <label class="layui-form-label">菜品编号</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="foodId" autocomplete="off" class="layui-input" onkeyup="value=value.replace(/[^0-9]/g,'')">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">菜品名称</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="foodName" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">菜品类别</label>
                                    <div class="layui-input-inline">
                                        <select id="typeIdSearch" name="typeId" style="height: 32px;width: 150px;text-align: center;">
                                            <option value="" selected="selected"></option>
                                        </select>
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">是否推荐</label>
                                    <div class="layui-input-inline">
                                        <select id="recommendSearch" name="recommend" style="height: 32px;width: 150px;text-align: center;">
                                            <option value="0" selected=""></option>
                                            <option value="1">是</option>
                                            <option value="2">否</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">是否热销</label>
                                    <div class="layui-input-inline">
                                        <select id="hotSaleSearch" name="hotSale" style="height: 32px;width: 150px;text-align: center;">
                                            <option value="0" selected=""></option>
                                            <option value="1">是</option>
                                            <option value="2">否</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">菜品状态</label>
                                    <div class="layui-input-inline">
                                        <select id="foodStatus" name="foodStatus" style="height: 32px;width: 150px;text-align: center;">
                                            <option value="0" selected=""></option>
                                            <option value="1">上架</option>
                                            <option value="2">下架</option>
                                            <option value="3">未完善</option>
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

                <%-- 表格头部工具栏 --%>
                <script type="text/html" id="toolbarDemo">
                    <div class="layui-btn-container">
                        <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add">
                            <i class="layui-icon layui-icon-add-1"></i>添加
                        </button>
                    </div>
                </script>

                <%-- 表格区域 --%>
                <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

                <%-- 表格行工具栏 --%>
                <script type="text/html" id="currentTableBar">
                    {{# if(!flag){ }}
                    <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit" id="edit">
                        <i class="layui-icon layui-icon-edit"></i>编辑
                    </a>
                    <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete" id="delete">
                        <i class="layui-icon layui-icon-delete"></i>删除
                    </a>
                    <a class="layui-btn layui-btn-xs layui-btn data-count-delete" lay-event="onShelf" id="onShelf">
                        <i class="layui-icon layui-icon-play"></i>上架
                    </a>
                    {{# } else{}}
                    <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="offShelf" id="offShelf">
                        <i class="layui-icon layui-icon-pause"></i>下架
                    </a>
                    {{# } }}
                </script>

                <%-- 添加或修改弹出框 --%>
                <div class="layui-container" style="display: none;padding-top:15px;" id="addOrUpdateForm">
                    <form class="layui-form" style="width: 90%;" id="dataForm" lay-filter="dataForm">
                        <%--表单隐藏域--%>
                        <input type="hidden" name="foodId" id="foodId">
                        <div class="layui-form-item">
                            <div class="layui-inline layui-col-md4 my-inline">
                                <label class="layui-form-label"><font color="red"> * </font>菜品名称</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="foodName" lay-verify="required" autocomplete="off" class="layui-input" id="foodName" placeholder="请输入菜品名称">
                                </div>
                            </div>
                            <div class="layui-inline layui-col-md4 my-inline">
                                <label class="layui-form-label"><font color="red"> * </font>菜品类别</label>
                                <div class="layui-input-inline">
                                    <select id="typeId" name="typeId" style="height: 32px;width: 150px;text-align: center;" lay-verify="required">
                                        <option value="" selected="selected"></option>
                                    </select>
                                </div>
                            </div>
                            <div class="layui-inline layui-col-md4 my-inline">
                                <label class="layui-form-label">菜品荤素</label>
                                <div class="layui-input-inline">
                                    <select id="foodVegon" name="foodVegon" style="height: 32px;width: 150px;text-align: center;">
                                        <option value="" selected="selected">请选择菜品荤素</option>
                                        <option value="荤菜">荤菜</option>
                                        <option value="素菜">素菜</option>
                                        <option value="半荤半素">半荤半素</option>
                                        <option value="其他">其他</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <div class="layui-inline layui-col-md4 my-inline">
                                <label class="layui-form-label">烹饪方式</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="foodCookWay" autocomplete="off" class="layui-input" id="foodCookWay" placeholder="请输入烹饪方式">
                                </div>
                            </div>
                            <div class="layui-inline layui-col-md4 my-inline">
                                <label class="layui-form-label"><font color="red"> * </font>是否推荐</label>
                                <div class="layui-input-inline">
                                    <input type="radio" name="recommend" value="1" title="是">
                                    <input type="radio" name="recommend" value="2" title="否" checked>
                                </div>
                            </div>
                            <div class="layui-inline layui-col-md4 my-inline">
                                <label class="layui-form-label"><font color="red"> * </font>是否热销</label>
                                <div class="layui-input-inline">
                                    <input type="radio" name="hotSale" value="1" title="是">
                                    <input type="radio" name="hotSale" value="2" title="否" checked>
                                </div>
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <div class="layui-inline my-inline layui-col-md8">
                                <label class="layui-form-label">菜品配料</label>
                                <div class="layui-input-inline" style="width: 77.5%">
                                    <input type="text" name="foodIngredient" placeholder="请输入菜品配料" autocomplete="off" class="layui-input" id="foodIngredient">
                                </div>
                            </div>
                            <div class="layui-inline layui-col-md4 my-inline">
                                <label class="layui-form-label"><font color="red"> * </font>每日供量</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="dayStock" lay-verify="required" autocomplete="off" class="layui-input" id="dayStock" placeholder="请输入每日供量"  onkeyup="value=value.replace(/[^0-9]/g,'')">
                                </div>
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <div class="layui-inline layui-col-md4 my-inline">
                                <label class="layui-form-label"><font color="red"> * </font>菜品图片</label>
                                <div class="my-imageBox layui-inline" id="imageBox">
                                    <input type="hidden" name="foodImage" id="foodImage" value="food/defaultImage/defaultImage.png" lay-verify="required">
                                    <a href="javascript:void(0);" style="width: 100%">
                                        <img class="upload-img" id="photoShow" src="/sudi/upload/food/defaultImage/defaultImage.png">
                                    </a>
                                </div>
                            </div>
                            <div class="layui-inline layui-col-md8 my-inline">
                                <label class="layui-form-label">菜品描述</label>
                                <div class="layui-input-inline" style="width: 77.5%;">
                                    <textarea type="textarea" name="foodDesc" autocomplete="off" class="layui-input layui-textarea my-textarea" id="foodDesc" placeholder="请输入菜品描述"></textarea>
                                </div>
                            </div>
                        </div>

                        <div id="standardGroup">
                            <div class="layui-form-item">
                                <div class="layui-inline layui-col-md4 my-inline">
                                    <label class="layui-form-label"><font color="red"> * </font>规格组选择</label>
                                    <div class="layui-input-inline">
                                        <select class="foodattrId" name="foodattrId" style="height: 32px;width: 150px;text-align: center;" lay-verify="required" id="foodattrId" lay-filter="foodattrId">
                                            <option value="" selected="selected">请选择规格组</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="layui-inline layui-col-md8 my-inline" style="position: relative">
                                    <label class="layui-form-label"><font color="red"> * </font>设置规格</label>
                                    <div class="tags" id="tags" style="position: absolute;top:-42px;left: 110px;width: 517px;padding: 0 5px;">
                                        <input type="text" name="foodvalueName" class="layui-input inputTags" id="inputTags" placeholder="回车生成标签"/>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <br>
                        </div>

                        <div class="layui-form-item" style="display: none">
                            <div class="layui-input-inline" style="margin-left: 320px">
                                <button id="add" type="button" class="layui-btn layui-btn-warm layui-btn-sm">
                                    <i class="layui-icon">&#xe654; 新增一个规格组</i>
                                </button>
                            </div>
                            <div class="layui-input-inline" style="margin-left: 20px">
                                <button type="button"
                                        class="layui-btn layui-btn-danger layui-btn-sm removeclass"><i
                                        class="layui-icon">&#xe67e; 删除上一个规格组</i></button>
                            </div>
                        </div>

                        <div class="layui-form-item layui-row layui-col-md10">
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
        //用于存储菜品规格组信息和规格信息
        var attrValueJsonArr = [];

        layui.config({
            base: '${pageContext.request.contextPath}/static/plugins/'
        }).extend({ //设定模块别名
            inputTags:'layui_inputTag/inputTags'   //相对于上述 base 目录的子目录(js文件路径，引用文件时不需要加.js后缀)
        }).use(['form', 'table', 'jquery', 'upload', 'layer', 'inputTags'], function () {
            var $ = layui.jquery,
                form = layui.form,
                table = layui.table,
                upload = layui.upload,
                inputTags = layui.inputTags,
                layer = layui.layer;

            var url;//提交的请求地址
            var index;//打开窗口的索引

            /**
             * 数据表单初始化
             */
            var tableIns = table.render({
                elem: '#currentTableId',
                url: '${pageContext.request.contextPath}/backstage/food/list',
                toolbar: '#toolbarDemo',
                defaultToolbar: ['filter', 'exports', 'print', {
                    title: '提示',
                    layEvent: 'LAYTABLE_TIPS',
                    icon: 'layui-icon-tips'
                }],
                cols: [[
                    {type: "checkbox", width: 50, align: "center"},
                    {field: 'foodId', width: 112, title: '菜品编号', align: "center", sort: true},
                    {field: 'foodName', minWidth: 160, title: '菜品名称', align: "center"},
                    {field: 'typeName', width: 110, title: '所属类别', align: "center"},
                    {field: 'recommend', width: 112, title: '是否推荐', sort: true, align: "center",
                        templet: function (d) {
                            if (d.recommend == 1){
                                return "<font color='red'>是</font>";
                            }else {
                                return "<font color='#333333'>否</font>";
                            }
                        }
                    },
                    {field: 'hotSale', width: 112, title: '是否热销', sort: true, align: "center",
                        templet: function (d) {
                            if (d.hotSale == 1){
                                return "<font color='blue'>是</font>";
                            }else {
                                return "<font color='#333333'>否</font>";
                            }
                        }
                    },
                    {field: 'lastModifyBy', width: 120, title: '上次修改人', align: "center"},
                    {field: 'lastModifyTime', width: 166, title: '上次修改时间', align: "center", sort: true,
                        templet:"<div>{{layui.util.toDateString(d.lastModifyTime, 'yyyy-MM-dd HH:mm:ss')}}</div>"
                    },
                    {field: 'foodStatus', width: 114, title: '菜品状态', sort: true, align: "center",
                        templet: function (d) {
                            if (d.foodStatus == 1){
                                flag = true;
                                return "<font color='blue'>使用中</font>";
                            }else if (d.foodStatus == 2) {
                                flag = false;
                                return "<font color='red'>下架</font>";
                            }else {
                                flag = false;
                                return "<font color='orange'>未完善</font>";
                            }
                        }
                    },
                    {title: '操作', minWidth: 212, toolbar: '#currentTableBar', align: "center"}
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
             * 加载菜品类别下拉框向后台动态读取菜品类别数据
             */
            $.ajax({
                url: "${pageContext.request.contextPath}/backstage/foodtype/findAllFoodtype",
                dataType: "json",
                type: "post",
                success: function(result) {
                    if (result.code == 1){
                        $.each(result.foodtypeList, function (index, item) {
                            //向下拉框中追加元素
                            $("#typeId").append(new Option(item.typeName, item.typeId));
                            $("#typeIdSearch").append(new Option(item.typeName, item.typeId));
                        });
                        form.render("select");
                    }else {
                        $("#typeId").append(new Option("暂无数据", ""));
                        $("#typeIdSearch").append(new Option("暂无数据", ""));
                    }
                }
            });

            /**
             * 加载规格组下拉框向后台动态读取规格组数据
             */
            $.ajax({
                url: "${pageContext.request.contextPath}/backstage/foodattr/findAllFoodattr",
                dataType: "json",
                type: "post",
                success: function(result) {
                    if (result.code == 1){
                        $.each(result.foodattrList, function (index, item) {
                            //向下拉框中追加元素
                            $(".foodattrId").append(new Option(item.foodattrName, item.foodattrId));
                        });
                        form.render("select");
                    }else {
                        $(".foodattrId").append(new Option("暂无数据", ""));
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
             * toolbar监听头部工具栏事件
             */
            table.on('toolbar(currentTableFilter)', function (obj) {
                if (obj.event === 'add') {  // 监听添加操作
                    index = layer.open({
                        title: '添加菜品SPU',
                        type: 1,
                        shade: 0.2,
                        maxmin:true,
                        shadeClose: true,
                        area: ['80%', '80%'],
                        offset: ['50px', '120px'],
                        content: $("#addOrUpdateForm"),
                        success: function () {
                            //清空表单数据
                            $("#dataForm")[0].reset();
                            //重置默认图片
                            $("#photoShow").attr("src", "/sudi/upload/food/defaultImage/defaultImage.png");
                            //重置默认图片
                            $("#photoShow").attr("src", "/sudi/upload/food/defaultImage/defaultImage.png");
                            //重置隐藏域
                            $("#foodImage").val("food/defaultImage/defaultImage.png");
                            //添加的提交请求路径赋值
                            url = "${pageContext.request.contextPath}/backstage/food/add";
                        }
                    });
                }
            });

            /**
             * 渲染文件上传区域
             */
            upload.render({
                elem: "#photoShow",  //绑定元素
                url: "${pageContext.request.contextPath}/backstage/food/uploadFile",    //文件上传后台处理路径
                acceptMime: "image/*",  //规定打开文件选择框时筛选出的文件类型
                field: "foodImage",  //文件上传的字段值，等同于input标签的name，必须和后台处理路径的方法参数名一致
                method: "post",     //提交方式
                //文件上传成功之后的回调函数
                done: function (res, index, upload) {
                    console.log(res);
                    console.log(index);
                    console.log(upload);
                    //上传的图片回显
                    $("#photoShow").attr("src", res.data.src);
                    //改变背景颜色
                    $("#imageBox").css("background", "#ffffff");
                    //给隐藏域赋值，只需要后半截，前边的是通用的路径，不需要保存到数据库中
                    $("#foodImage").val(res.data.imagePath);
                }
            });

            /**
             * 添加规格组下拉框的选择事件
             */
            var foodattrId = null;//记录规格组的编号
            form.on('select(foodattrId)',function(data){
                foodattrId = data.value;
            });

            /**
             * 渲染tag输入框
             */
            var foodvalueArr = new Array();//定义一个value数组
            inputTags.render({
                elem: '#inputTags', //定义输入框input对象,elem为输入框元素
                //content: [''], //默认标签
                aldaBtn: false, //是否开启获取所有数据的按钮
                done: function(value) { //回车后的回调
                    foodvalueArr.push(value);//追加到数组中
                }
            });

            /**
             * 动态添加input输入框
             */
            var foodvalueArrStr = [];
            var x = 1;//规格组的数目
            $("#add").click(function () {
               <%-- if (foodvalueArr.length == 0) {--%>
               <%--     layer.msg("请先完成上一个规格集的规格设置");--%>
               <%-- }else {--%>
               <%--     // 将上方的数据加入到json对象中去--%>
               <%--     for (var i=0; i<foodvalueArr.length; i++){--%>
               <%--         var item = {--%>
               <%--             "foodvalueName": foodvalueArr[i]--%>
               <%--         };--%>
               <%--         foodvalueArrStr.push(item);--%>
               <%--     }--%>
               <%--     var attrItem = {--%>
               <%--         "attrId": foodattrId,--%>
               <%--         "foodvalueArr": foodvalueArrStr--%>
               <%--     };--%>
               <%--     attrValueJsonArr.push(attrItem);--%>
               <%--     console.log(attrValueJsonArr);--%>
               <%--     foodvalueArrStr = [];--%>
               <%--     foodvalueArr = new Array();--%>
               <%--     foodattrId = null;--%>
               <%--     //清除上方的ID值防止下方的ID值重复--%>
               <%--     $("#inputTags").attr("disabled", "disabled");--%>
               <%--     $("#inputTags").removeAttr("id");--%>
               <%--     $("#foodattrId").attr("disabled", "disabled");--%>
               <%--     $("#foodattrId").removeAttr("id");--%>
               <%--     $("#foodattrId").removeAttr("lay-filter");--%>

               <%--     var str =  '<div class="layui-form-item">'+--%>
               <%--         '<div class="layui-inline layui-col-md4 my-inline">'+--%>
               <%--         '<label class="layui-form-label"><font color="red"> * </font>规格组选择</label>'+--%>
               <%--         '<div class="layui-input-inline">'+--%>
               <%--         '<select class="foodattrId" name="foodattrId" id="foodattrId" style="height: 32px;width: 150px;text-align: center;" lay-verify="required" lay-filter="foodattrId">'+--%>
               <%--         '<option value="" selected="selected">请选择规格组</option>'+--%>
               <%--         '</select>'+--%>
               <%--         '</div>'+--%>
               <%--         '</div>'+--%>
               <%--         '<div class="layui-inline layui-col-md8 my-inline" style="position: relative">'+--%>
               <%--         '<label class="layui-form-label"><font color="red"> * </font>设置规格</label>'+--%>
               <%--         '<div class="tags" id="tags" style="position: absolute;top:-42px;left: 110px;width: 508px;padding: 0 5px;">'+--%>
               <%--         '<input type="text" name="foodvalueName" class="layui-input inputTags" id="inputTags" placeholder="回车生成标签"/>'+--%>
               <%--         '</div>'+--%>
               <%--         '</div>'+--%>
               <%--         '</div>';--%>

               <%--     $("#standardGroup").append(str);--%>
               <%--     /**--%>
               <%--      * 加载规格组下拉框向后台动态读取规格组数据--%>
               <%--      */--%>
               <%--     $.ajax({--%>
               <%--         url: "${pageContext.request.contextPath}/backstage/foodattr/findAllFoodattr",--%>
               <%--         dataType: "json",--%>
               <%--         type: "post",--%>
               <%--         success: function(result) {--%>
               <%--             if (result.code == 1){--%>
               <%--                 $.each(result.foodattrList, function (index, item) {--%>
               <%--                     //向下拉框中追加元素--%>
               <%--                     $(".foodattrId").append(new Option(item.foodattrName, item.foodattrId));--%>
               <%--                 });--%>
               <%--                 form.render("select");--%>
               <%--             }else {--%>
               <%--                 $(".foodattrId").append(new Option("暂无数据", ""));--%>
               <%--             }--%>
               <%--         }--%>
               <%--     });--%>
               <%--     /**--%>
               <%--      * 渲染tag输入框--%>
               <%--      */--%>
               <%--     inputTags.render({--%>
               <%--         elem: "#inputTags", //定义输入框input对象,elem为输入框元素--%>
               <%--         content: [], //默认标签--%>
               <%--         aldaBtn: false, //是否开启获取所有数据的按钮--%>
               <%--         done: function(value) { //回车后的回调--%>
               <%--             foodvalueArr.push(value);//追加到数组中--%>
               <%--         }--%>
               <%--     });--%>
               <%--     /**--%>
               <%--      * 添加规格组下拉框的选择事件--%>
               <%--      */--%>
               <%--     form.on('select(foodattrId)',function(data){--%>
               <%--         foodattrId = data.value;--%>
               <%--     });--%>
               <%--     form.render();--%>
               <%--     x++;--%>
               <%--}--%>
            });

            /**
             * 删除动态添加的input输入框
             */
            $("body").on('click', ".removeclass", function () {
                // if (x == 1){
                //     layer.msg("商品必须至少拥有一个规格组信息");
                // }else {
                //     //元素移除前校验是否被引用
                //     var approvalName = $(this).parent().prev('div.layui-input-inline').children().val();
                //     var parentEle = $(this).parent().parent().prev('#standardGroup').children("div:last-child");
                //     parentEle.remove();
                //     x--;
                //     if (attrValueJsonArr.length < x) {
                //         attrValueJsonArr.pop();//删去最后一条规格
                //     }
                //     console.log(attrValueJsonArr);
                // }
            });

            /**
             * 编写表单提交的监听事件,doSubmit是提交按钮的lay-filter的值
             */
            form.on("submit(doSubmit)", function(data){
                //点击提交的时候如果几个存储数据的还有东西就需要先保存
                if (foodvalueArrStr != [] || foodattrId != null){
                    for (var i=0; i<foodvalueArr.length; i++){
                        var item = {
                            "foodvalueName": foodvalueArr[i]
                        };
                        foodvalueArrStr.push(item);
                    }
                    var attrItem = {
                        "attrId": foodattrId,
                        "foodvalueArr": foodvalueArrStr
                    };
                    attrValueJsonArr.push(attrItem);
                }
                //这里有几个字段LayUI没有自动赋值，再此手动赋值
                data.field.foodImage = $("#foodImage").val();

                var foodData = {
                    "foodData": data.field
                }

                var foodParam = {
                    "foodParam": attrValueJsonArr
                };
                var final = $.extend({}, foodData, foodParam);

                //使用ajax的post请求去传递数据
                $.post(url, {mapStr: JSON.stringify(final)}, function(result){
                    if (result.flag){
                        //刷新数据表格
                        tableIns.reload();
                        //关闭当前窗口
                        layer.close(index);
                    }
                    //弹出提示信息
                    layer.msg(result.message);
                }, "json");
                //禁止页面刷新
                return false;
            });

            /**
             * 监听表单行工具栏事件
             */
            table.on('tool(currentTableFilter)', function (obj) {
                var data = obj.data;
                console.log(data);
                if (obj.event === 'edit') {
                    index = layer.open({
                        title: '编辑菜品SPU',
                        type: 1,
                        shade: 0.2,
                        maxmin:true,
                        shadeClose: true,
                        area: ['80%', '80%'],
                        offset: ['50px', '120px'],
                        content: $("#addOrUpdateForm"),
                        success: function(){
                            //表单数据回显，参数1表示lay-filter的值，参数2表示回显的数据
                            //form.val("dataForm", data);
                            //自动回显失效，手动设置回显
                            $("#foodId").val(data.foodId);
                            $("#foodName").val(data.foodName);
                            $("#foodVegon").val(data.foodVegon);
                            $("#typeId").val(data.typeId);
                            $("#foodCookWay").val(data.foodCookWay);
                            $("#foodIngredient").val(data.foodIngredient);
                            $("#foodImage").val(data.foodImage);
                            $("input[type=radio][name=recommend][value="+data.recommend+"]").attr("checked", true);
                            $("input[type=radio][name=hotSale][value="+data.hotSale+"]").attr("checked", true);
                            $("#foodDesc").val(data.foodDesc);
                            //重新渲染表单
                            form.render();
                            //添加的提交请求
                            url = "${pageContext.request.contextPath}/backstage/food/modify";
                            //隐藏标签输入框
                            $("#standardGroup").css("display", "none");
                            $(".foodattrId").removeAttr("lay-verify");
                            //设置图片回显
                            $("#photoShow").attr("src", "/sudi/upload/" + data.foodImage);
                        }
                    });
                }else if (obj.event === "offShelf") {
                    var str = '确定要对<font color="red">【' +data.foodName+ '】</font>类别进行下架操作吗?\n下架操作将使用户无法浏览该菜品';
                    layer.confirm(str, {icon: 3, title:'提示'}, function(index){
                        $.post("${pageContext.request.contextPath}/backstage/food/offShelf", {foodId: data.foodId}, function (result) {
                            if (result.flag){
                                //重新加载
                                tableIns.reload();
                            }
                            layer.msg(result.message);
                        },"json");
                        layer.close(index);
                    });
                }else if (obj.event === 'onShelf') {
                    var str = '确定要对<font color="red">【' +data.foodName+ '】</font>类别进行上架操作吗?';
                    layer.confirm(str, {icon: 3, title:'提示'}, function(index){
                        $.post("${pageContext.request.contextPath}/backstage/food/onShelf", {foodId: data.foodId}, function (result) {
                            if (result.flag){
                                //重新加载
                                tableIns.reload();
                            }
                            layer.msg(result.message);
                        },"json");
                        layer.close(index);
                    });
                }else if (obj.event === 'delete') {
                    var str = '确定要对<font color="red">【' +data.foodName+ '】</font>菜品进行删除操作吗?\n此操作不可逆！删除菜品后该菜品的所有SKU信息将一并删除！';
                    layer.confirm(str, {icon: 3, title:'提示'}, function(index){
                        $.post("${pageContext.request.contextPath}/backstage/food/delete", {foodId: data.foodId}, function (result) {
                            console.log(result);
                            if (result.flag){
                                //重新加载
                                tableIns.reload();
                            }
                            layer.msg(result.message);
                        },"json");
                        layer.close(index);
                    });
                }
            });



        });

    </script>
</html>
