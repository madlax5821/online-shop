<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>backend</title>
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/css/bootstrap.css" />
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/css/index.css" />
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/js/userSetting.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js"></script>
    <script type="text/css" src="${pageContext.request.contextPath}/css/zshop.css"></script>
    <script>
        $(function () {
            /*设置分页*/
            $("#pagination").bootstrapPaginator({
                bootstrapMajorVersion: 3, /*bootstrap version*/
                currentPage:${pageInfo.pageNum}, //当前页
                totalPages:${pageInfo.pages},//总页数
                itemTexts:function (type, page, current) {//设置显示的样式，默认是arrow
                    switch (type){
                        case 'first':
                            return '首页';
                        case 'prev':
                            return '上一页';
                        case 'next':
                            return '下一页';
                        case 'last':
                            return '末页';
                        case 'page':
                            return page;
                    }
                },
                pageUrl:function (type, page, current) {//设置超链接的链接地址
                    return '${pageContext.request.contextPath}/backend/productType/getAllTypes?pageNum='+page;
                }
            });
        })
        /*add product type*/
        function addProductType() {
            console.log($("#productTypeName").val());
            $.post(("${pageContext.request.contextPath}/backend/productType/addType"),
                {
                    "name":$("#productTypeName").val()
                },function (result) {
                if (result.status==1){
                    layer.msg(result.message,{
                        time:2000,
                        skin:"successMsg"
                    },function () {
                        location.href="${pageContext.request.contextPath}/backend/productType/getAllTypes?pageNum="+${pageInfo.pageNum};
                    })
                }else {
                    layer.msg(result.message,{
                        time:2000,
                        skin:"errorMsg"
                    });
                }
            })
        }
        /*show product type by id*/
        function getProductTypeById(id) {
            $.getJSON(("${pageContext.request.contextPath}/backend/productType/getTypeById"),{
                "id":id
            },function (result) {
                console.log(result);
                if (result.status==1){
                    $("#proTypeNum").val(result.data.id);
                    $("#proTypeName").val(result.data.name);
                }
            })
        }
        /*modify product type name by id*/
        function modifyTypeName(){
            $.post(("${pageContext.request.contextPath}/backend/productType/modifyTypeName"),{
                "id":$("#proTypeNum").val(),
                "name":$("#proTypeName").val()
            },function (result) {
                if (result.status==1){
                    layer.msg(result.message,{
                        time:2000
                    },function () {
                        location.href="${pageContext.request.contextPath}/backend/productType/getAllTypes?pageNum="+${pageInfo.pageNum};
                    })
                }else {
                    layer.msg(result.message,{
                        time:2000
                    })
                }
            })
        }
        /*delete confirmation*/
        function showConfirm(id){
            $("#ProductTypeDelete").modal("show");
            $("#deleteProductTypeId").val(id);
        }
        /* delete type by id */
        function deleteTypeById() {
            $.post(("${pageContext.request.contextPath}/backend/productType/deleteTypeById"),{
                "id":$("#deleteProductTypeId").val()},
                function (result) {
                layer.msg(result.message,{time:2000},function () {
                    location.href="${pageContext.request.contextPath}/backend/productType/getAllTypes?pageNum="+${pageInfo.pageNum};
                })
            })
        }
        /*modify product type status by id*/
        function modifyTypeStatus(id,btn) {
            $.post(("${pageContext.request.contextPath}/backend/productType/modifyTypeStatus"),{'id':id},function (result) {
                console.log(result.data);
                if (result.status==1){
                    //$td=$(btn).parent().parent().children().eq(2);
                    $td=$(btn).parent().prev();
                    if ($td.text().trim()=="启用"){
                        $td.text("禁用")
                        $(btn).val("启用").removeClass("btn-danger").addClass("btn-success");
                    }else {
                        $td.text("启用")
                        $(btn).val("禁用").removeClass('btn-success').addClass('btn-danger');
                    }
                }
            })
        }
    </script>
</head>

<body>
    <div class="panel panel-default" id="userSet">
        <div class="panel-heading">
            <h3 class="panel-title">商品类型管理</h3>
        </div>
        <div class="panel-body">
            <input type="button" value="添加商品类型" class="btn btn-primary" id="doAddProTpye">
            <br>
            <br>
            <div class="show-list text-center">
                <table class="table table-bordered table-hover" style='text-align: center;'>
                    <thead>
                        <tr class="text-danger">
                            <th class="text-center">编号</th>
                            <th class="text-center">类型名称</th>
                            <th class="text-center">状态</th>
                            <th class="text-center">操作</th>
                        </tr>
                    </thead>
                    <tbody id="tb">
                    <c:forEach items="${requestScope.pageInfo.list}" var="productType">
                        <tr>
                            <td>${productType.id}</td>
                            <td>${productType.name}</td>
                            <td><c:if test="${productType.status==1}">启用</c:if>
                                <c:if test="${productType.status==0}">禁用</c:if>
                            </td>
                            <td class="text-center">
                                <input type="button" class="btn btn-warning btn-sm doProTypeModify" value="修改" onclick="getProductTypeById(${productType.id})">
                                <input type="button" class="btn btn-warning btn-sm doProTypeDelete" value="删除" onclick="showConfirm(${productType.id})">
                                <c:if test="${productType.status==1}">
                                    <input type="button" id="b1" class="btn btn-danger btn-sm doProTypeDisable" value="禁用" onclick="modifyTypeStatus(${productType.id},this)">
                                </c:if>
                                <c:if test="${productType.status==0}">
                                    <input type="button" id="b1" class="btn btn-success btn-sm doProTypeDisable" value="启用" onclick="modifyTypeStatus(${productType.id},this)">
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <%--使用bootstrap-paginator插件实现分页--%>
                <ul id="pagination"></ul>
            </div>
        </div>
    </div>
    
    <!-- 添加商品类型 start -->     
    <div class="modal fade" tabindex="-1" id="ProductType">
        <!-- 窗口声明 -->
        <div class="modal-dialog modal-lg">
            <!-- 内容声明 -->
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">添加商品类型</h4>
                </div>
                <div class="modal-body text-center">
                    <div class="row text-right">
                        <label for="productTypeName" class="col-sm-4 control-label">类型名称：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="productTypeName">
                        </div>
                    </div>
                    <br>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary addProductType" onclick="addProductType()">添加</button>
                    <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                </div>
            </div>
        </div>
    </div>
    <!-- 添加商品类型 end -->
    
    <!-- 修改商品类型 start -->
    <div class="modal fade" tabindex="-1" id="myProductType">
        <!-- 窗口声明 -->
        <div class="modal-dialog modal-lg">
            <!-- 内容声明 -->
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">修改商品类型</h4>
                </div>
                <div class="modal-body text-center">
                    <div class="row text-right">
                        <label for="proTypeNum" class="col-sm-4 control-label">编号：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="proTypeNum" readonly>
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="proTypeName" class="col-sm-4 control-label">类型名称</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="proTypeName">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-warning updateProType" onclick="modifyTypeName()">修改</button>
                    <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                </div>
            </div>
        </div>
    </div>
    <!-- 修改商品类型 end -->

    <!-- 删除商品类型 start -->
    <div class="modal fade" tabindex="-1" id="ProductTypeDelete">
        <!-- 窗口声明 -->
        <div class="modal-dialog modal-lg">
            <!-- 内容声明 -->
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">删除商品类型</h4>
                </div>
                <div class="modal-body text-center">
                    <h4>确定要删除该商品类型吗？</h4>
                </div>
                <div class="modal-footer">
                    <input type="hidden" id="deleteProductTypeId">
                    <button class="btn btn-primary addProductType" data-dismiss="modal" onclick="deleteTypeById()">删除</button>
                    <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                </div>
            </div>
        </div>
    </div>
    <!-- 删除商品类型 end -->
</body>

</html>