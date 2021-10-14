<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>backend</title>
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/css/bootstrap.css" />
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/css/index.css" />
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/css/file.css" />
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/css/bootstrap-validator.min.css" />
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
    <script src="${pageContext.request.contextPath}/js/userSetting.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-validator.min.js"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js"></script>
    <script>
        $(function(){
            $("#pagination").bootstrapPaginator({
                bootstrapMajorVersion:3,
                currentPage:${pageInfo.pageNum},
                totalPages:${pageInfo.pages},
                alignment:"center",
                itemTexts:function (type, page, current) {
                    switch (type){
                        case 'first':
                            return "首页";
                        case 'prev':
                            return "上一页";
                        case 'next':
                            return "下一页";
                        case 'last':
                            return "末页";
                        case 'page':
                            return page;
                    }
                },
                pageUrl:function (type,page,current) {
                    return "${pageContext.request.contextPath}/backend/product/getAllProducts?pageNum="+page;
                }
            })

            //上传图像预览
            $('#product-image').on('change',function() {
                $('#img').attr('src', window.URL.createObjectURL(this.files[0]));
            });        
            $('#pro-image').on('change',function() {
                $('#img2').attr('src', window.URL.createObjectURL(this.files[0]));
            });    
        });

        function showConfirm(id){
            $("#ProductDelete").modal("show");
            $("#deleteProductId").val(id);
        }

        function deleteProductById(){
            $.post(("${pageContext.request.contextPath}/backend/product/removeProduct"),
                {
                    'id':$("#deleteProductId").val()
                },function (result) {
                console.log(result.status)
                    if (result.status==1){
                        layer.msg(result.message,{
                            time:2000
                        },function (){
                            location.href="${pageContext.request.contextPath}/backend/product/getAllProducts?pageNum="+${pageInfo.pageNum};
                        })
                    }
                })

        }

        function getProductById(id){
            $.post("${pageContext.request.contextPath}/backend/product/getProduct",{
                "id":id
            },function (result) {
                console.log(result.data.image);
                if (result.status==1){
                    $("#pro-num").val(result.data.id);
                    $("#pro-name").val(result.data.name);
                    $("#pro-price").val(result.data.price);
                    $("#img2").attr("src","${pageContext.request.contextPath}/backend/product/getImage?path="+result.data.image);
                    $("#pro-typeId").val(result.data.productType.id);
                }
            })
        }

        $(function () {
            $("#formAddProduct").bootstrapValidator({
                feedbackIcons:{
                    valid:'glyphicon glyphicon-ok',
                    invalid:'glyphicon glyphicon-remove',
                    validating:'glyphicon glyphicon-refresh'
                },
                fields:{
                    name:{
                        validators:{
                            notEmpty:{
                                message:"test"
                            }
                        }
                    },
                    price:{
                        validators: {
                            notEmpty: {
                                message: "price cannot be empty"
                            }
                        }
                    },
                    file:{
                        validators:{
                            notEmpty:{
                                message:"please select a picture"
                            }
                        }
                    }
                }
            })

        })
    </script>

</head>

<body>
    ${errorMsg}
    <div class="panel panel-default" id="userPic">
        <div class="panel-heading">
            <h3 class="panel-title">商品管理</h3>
        </div>
        <div class="panel-body">
            <input type="button" value="添加商品" class="btn btn-primary" id="doAddPro">
            <br>
            <br>
            <div class="show-list text-center" >
                <table class="table table-bordered table-hover" style='text-align: center;'>
                    <thead>
                        <tr class="text-danger">
                            <th class="text-center">编号</th>
                            <th class="text-center">商品</th>
                            <th class="text-center">价格</th>
                            <th class="text-center">产品类型</th>
                            <th class="text-center">状态</th>
                            <th class="text-center">操作</th>
                        </tr>
                    </thead>

                    <tbody id="tb">
                    <c:forEach items="${requestScope.pageInfo.list}" var="product">
                        <tr>
                            <td>${product.id}</td>
                            <td>${product.name}</td>
                            <td>${product.price}</td>
                            <td>${product.productType.name}</td>
                            <td>
                                <c:if test="${product.productType.status==1}">有效商品</c:if>
                                <c:if test="${product.productType.status==0}">无效商品</c:if>
                            </td>
                            <td class="text-center">
                                <input type="button" class="btn btn-warning btn-sm doProModify" value="修改" onclick="getProductById(${product.id})">
                                <input type="button" class="btn btn-warning btn-sm doProDelete" value="删除" onclick="showConfirm(${product.id})">
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <%--user bootstrap paginator to manage pages--%>
                <ul id="pagination"></ul>
            </div>
        </div>
    </div>

   <%--======================================================================================================================--%>

    <!-- 添加商品 start -->     
    <div class="modal fade" tabindex="-1" id="Product">
        <!-- 窗口声明 -->
        <div class="modal-dialog modal-lg">
            <!-- 内容声明 -->
            <form id="formAddProduct" action="${pageContext.request.contextPath}/backend/product/addProduct" method="post" class="form-horizontal" enctype="multipart/form-data">
                <div class="modal-content">
                    <!-- 头部、主体、脚注 -->
                    <div class="modal-header">
                        <button class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">添加商品</h4>
                    </div>
                    <div class="modal-body text-center row">
                        <div class="col-sm-8">
                            <div class="form-group">
                                <label for="product-name" class="col-sm-4 control-label">商品名称：</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" id="product-name" name="name">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="product-price" class="col-sm-4 control-label">商品价格：</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" id="product-price" name="price">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="product-image" class="col-sm-4 control-label">商品图片：</label>
                                <div class="col-sm-8">
                                    <a href="javascript:" class="file">选择文件
                                        <input type="file" name="file" id="product-image">
                                    </a>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="product-type" class="col-sm-4 control-label">商品类型：</label>
                                <div class="col-sm-8">
                                    <select class="form-control" id="product-type" name="productTypeId">
                                        <option value="0">--请选择--</option>
                                        <c:forEach items="${productTypes}" var="productType">
                                            <option value="${productType.id}">${productType.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <!-- 显示图像预览 -->
                            <img style="width: 160px;height: 180px;" id="img">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-primary addProduct" type="submit">添加</button>
                        <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!-- 添加商品 end -->  
    
    <!-- 修改商品 start -->  
    <div class="modal fade" tabindex="-1" id="myProduct">
        <!-- 窗口声明 -->
        <div class="modal-dialog modal-lg">
            <!-- 内容声明 -->
            <form action="${pageContext.request.contextPath}/backend/product/modifyProduct" method="post" class="form-horizontal" enctype="multipart/form-data">
                <div class="modal-content">
                    <!-- 头部、主体、脚注 -->
                    <div class="modal-header">
                        <button class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">修改商品</h4>
                    </div>
                    <div class="modal-body text-center row">
                        <div class="col-sm-8">
                            <input type="hidden" name="pageNum" value="${pageInfo.pageNum}">
                            <div class="form-group">
                                <label for="pro-num" class="col-sm-4 control-label">商品编号：</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" name="id" id="pro-num" readonly>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="pro-name" class="col-sm-4 control-label">商品名称：</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" name="name" id="pro-name">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="pro-price" class="col-sm-4 control-label">商品价格：</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" name="price" id="pro-price">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="pro-image" class="col-sm-4 control-label">商品图片：</label>
                                <div class="col-sm-8">
                                    <a class="file">
                                        选择文件 <input type="file" name="file" id="pro-image">
                                    </a>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="product-type" class="col-sm-4 control-label">商品类型：</label>
                                <div class="col-sm-8">
                                    <select class="form-control" name="productTypeId" id="pro-typeId">
                                        <option value="0" >--请选择--</option>
                                        <c:forEach items="${requestScope.productTypes}" var="productType">
                                            <option value="${productType.id}">${productType.name}</option>
                                        </c:forEach>

                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <!-- 显示图像预览 -->
                            <img style="width: 160px;height: 180px;" id="img2">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-primary updatePro" type="submit">修改</button>
                        <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!-- 修改商品 end -->

    <!-- 删除商品类型 start -->
    <div class="modal fade" tabindex="-1" id="ProductDelete">
        <!-- 窗口声明 -->
        <div class="modal-dialog modal-lg">
            <!-- 内容声明 -->
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">删除商品</h4>
                </div>
                <div class="modal-body text-center">
                    <h4>确定要删除该商品吗？</h4>
                </div>
                <div class="modal-footer">
                    <input type="hidden" id="deleteProductId">
                    <button class="btn btn-primary addProductType" data-dismiss="modal" onclick="deleteProductById()">删除</button>
                    <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                </div>
            </div>
        </div>
    </div>
    <!-- 删除商品类型 end -->
</body>

</html>