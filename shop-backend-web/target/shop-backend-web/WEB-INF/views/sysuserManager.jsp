<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

    <script>
        $(function () {
            $("#pagination").bootstrapPaginator({
                bootstrapMajorVersion:3,
                currentPage:${adminPageInfo.pageNum},
                totalPages:${adminPageInfo.pages},
                itemTexts:function (type, page, current) {
                    switch (type){
                        case "first":
                            return "首页"
                        case "prev":
                            return "上一页"
                        case "next":
                            return "下一页"
                        case "last":
                            return "末页"
                        case "page":
                            return page
                    }
                },
                pageUrl:function (type, page, current) {
                    return "${pageContext.request.contextPath}/backend/admin/getAllAdmins?pageNum="+page;
                }
            })
        })

        function getAdmin(id) {
            $.post("${pageContext.request.contextPath}/backend/admin/getAdminById",{
                "id":id
            },function (result) {
                console.log(result.data.password);
                if (result.status==1){
                    $("#adminId").val(result.data.id);
                    $("#adminName").val(result.data.name);
                    $("#adminLoginName").val(result.data.loginName);
                    $("#adminLoginPass").val(result.data.password);
                    $("#adminPhone").val(result.data.phone);
                    $("#adminEmail").val(result.data.email);
                }
            })
        }

        function modifyAdmin() {
            $.post("${pageContext.request.contextPath}/backend/admin/modifyAdmin",{
                "id":$("#adminId").val(),
                "name":$("#adminName").val(),
                "loginName":$("#adminLoginName").val(),
                "password":$("#adminLoginPass").val(),
                "phone":$("#adminPhone").val(),
                "email":$("#adminEmail").val(),
                "roleId":$("#adminRole").val()
            },function (result) {
                if (result.status==1){
                    layer.msg(result.message,{
                        time:2000
                    },function () {
                        location.href="${pageContext.request.contextPath}/backend/admin/getAllAdmins?pageNum="+${adminPageInfo.pageNum};
                    })
                }else {
                    console.log(result.message)
                }
            })
        }

        function modifyAdminStatus(id){
            $.post("${pageContext.request.contextPath}/backend/admin/changeStatus",{
                "id":id
            },function (result) {
                if (result.status==1){
                    if($("#statusButton").val().trim()=="有效"){
                        $("#statusButton").val("无效");
                    }else {
                        $("#statusButton").val("有效");
                    }
                    location.href="${pageContext.request.contextPath}/backend/admin/getAllAdmins?pageNum="+${adminPageInfo.pageNum};
                }
            })
        }

        function addAdmin(){
            $.post("${pageContext.request.contextPath}/backend/admin/addAdmin",{
                "name":$("#admin-username").val(),
                "loginName":$("#admin-loginName").val(),
                "password":$("#admin-password").val(),
                "phone":$("#admin-phone").val(),
                "email":$("#admin-email").val(),
                "roleId":$("#admin-role").val()
            },function (result) {
                if (result.status==1){
                    layer.msg(result.message,{
                        time: 2000,
                    },function () {
                        location.href="${pageContext.request.contextPath}/backend/admin/getAllAdmins?pageNum="+${adminPageInfo.pageNum};
                    })
                }else {
                    console.log(result.message);
                }
            })
        }
    </script>
</head>

<body>
    ${error}
    <!-- 系统用户管理 -->
    <div class="panel panel-default" id="adminSet">
        <div class="panel-heading">
            <h3 class="panel-title">系统用户管理</h3>
        </div>
        <div class="panel-body">
            <div class="showmargersearch">
                <form class="form-inline" action="${pageContext.request.contextPath}/backend/admin/searchAdmin" method="post">
				  <div class="form-group">
				    <label for="name">姓名:</label>
				    <input type="text" class="form-control" id="name" name="name" placeholder="请输入姓名" value="${adminParam.name}">
				  </div>
				  <div class="form-group">
				    <label for="loginName">帐号:</label>
				    <input type="text" class="form-control" id="loginName" name="loginName" placeholder="请输入帐号" value="${adminParam.loginName}">
				  </div>
				  <div class="form-group">
				    <label for="phone">电话:</label>
				    <input type="text" class="form-control" id="phone" name="phone" placeholder="请输入电话" value="${adminParam.phone}">
				  </div>
				  <div class="form-group">
				    <label for="role">角色</label>
	                    <select class="form-control" name="roleId" id="role">
	                        <option value="-1">全部</option>
                            <option value="1" <c:if test="${adminParam.roleId==1}">selected</c:if>>超级管理员</option>
	                        <option value="2" <c:if test="${adminParam.roleId==2}">selected</c:if>>商品管理员</option>
	                    </select>
				  </div>
				  <div class="form-group">
				    <label for="status">状态</label>
	                    <select class="form-control" name="isValid" id="status">
	                        <option value="-1">全部</option>
	                        <option value="1" <c:if test="${adminParam.isValid==1}">selected</c:if>>---有效---</option>
	                        <option value="0" <c:if test="${adminParam.isValid==0}">selected</c:if>>---无效---</option>
	                    </select>
				  </div>
				  <input type="submit" value="查询" class="btn btn-primary" id="doSearch">
				</form>
            </div>
            <br>
            <input type="button" value="添加系统用户" class="btn btn-primary" id="doAddManger">
            <div class="show-list text-center" style="position: relative; top: 10px;">
                <table class="table table-bordered table-hover" style='text-align: center;'>
                    <thead>
                        <tr class="text-danger">
                            <th class="text-center">序号</th>
                            <th class="text-center">姓名</th>
                            <th class="text-center">帐号</th>
                            <th class="text-center">电话</th>
                            <th class="text-center">邮箱</th>
                            <th class="text-center">状态</th>
                            <th class="text-center">注册时间</th>
                            <th class="text-center">角色</th>
                            <th class="text-center">操作</th>
                        </tr>
                    </thead>
                    <tbody id="tb">
                        <c:forEach items="${requestScope.adminPageInfo.list}" var="admin">
                            <tr>
                                <td>${admin.id}</td>
                                <td>${admin.name}</td>
                                <td>${admin.loginName}</td>
                                <td>${admin.phone}</td>
                                <td>${admin.email}</td>
                                <td>
                                    <c:if test="${admin.isValid==1}">有效</c:if>
                                    <c:if test="${admin.isValid==0}">无效</c:if>
                                </td>
                                <td>
                                    <fmt:formatDate value="${admin.createDate}" type="both"/>
                                </td>
                                <td>
                                    <c:if test="${admin.role.id==1}">超级管理员</c:if>
                                    <c:if test="${admin.role.id==2}">商品管理员</c:if>
                                </td>
                                <td class="text-center">
                                    <input type="button" class="btn btn-warning btn-sm doMangerModify" value="修改" onclick="getAdmin(${admin.id})">
                                    <c:if test="${admin.isValid==1}">
                                        <input type="button" id="statusButton" class="btn btn-danger btn-sm doMangerDisable" value="禁用" onclick="modifyAdminStatus(${admin.id})">
                                    </c:if>
                                    <c:if test="${admin.isValid==0}">
                                        <input type="button" id="statusButton" class="btn btn-success btn-sm doMangerDisable" value="启用" onclick="modifyAdminStatus(${admin.id})">
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <ul id="pagination"></ul>
            </div>
        </div>
    </div>

    <!-- 添加系统用户 start -->
    <div class="modal fade" tabindex="-1" id="myMangerUser">
        <!-- 窗口声明 -->
        <div class="modal-dialog">
            <!-- 内容声明 -->
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">添加系统用户</h4>
                </div>
                <div class="modal-body text-center">
                    <div class="row text-right">
                        <label for="admin-username" class="col-sm-4 control-label">用户姓名：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="admin-username">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="admin-loginName" class="col-sm-4 control-label">登录帐号：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="admin-loginName">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="admin-password" class="col-sm-4 control-label">登录密码：</label>
                        <div class="col-sm-4">
                            <input type="password" class="form-control" id="admin-password">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="admin-phone" class="col-sm-4 control-label">联系电话：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="admin-phone">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="admin-email" class="col-sm-4 control-label">联系邮箱：</label>
                        <div class="col-sm-4">
                            <input type="email" class="form-control" id="admin-email">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="admin-role" class="col-sm-4 control-label">角&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;色：</label>
                        <div class=" col-sm-4">
                            <select class="form-control" id="admin-role">
                                <option value="0">请选择</option>
                                <option value="1">超级管理员</option>
                                <option value="2">商品管理员</option>
                            </select>
                        </div>
                    </div>
                    <br>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary add-Manger" type="button" id="addAdmin" onclick="addAdmin()">添加</button>
                    <button class="btn btn-primary cancel" data-dismiss="modal" type="button">取消</button>
                </div>
            </div>
        </div>
    </div>
    <!-- 添加系统用户 end -->

    <!-- 修改系统用户 start -->
    <div class="modal fade" tabindex="-1" id="myModal-Manger">
        <!-- 窗口声明 -->
        <div class="modal-dialog">
            <!-- 内容声明 -->
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">系统用户修改</h4>
                </div>
                <div class="modal-body text-center">
                    <div class="row text-right">
                        <label for="adminId" class="col-sm-4 control-label">用户编号：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="adminId" name="id" readonly="readonly">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="adminName" class="col-sm-4 control-label">用户姓名：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" name="name" id="adminName">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="adminLoginName" class="col-sm-4 control-label">登录帐号：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="adminLoginName" name="loginName" readonly="readonly">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="adminLoginPass" class="col-sm-4 control-label">登录密码：</label>
                        <div class="col-sm-4">
                            <input type="password" class="form-control" name="password" id="adminLoginPass">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="adminPhone" class="col-sm-4 control-label">联系电话：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" name="phone" id="adminPhone">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="adminEmail" class="col-sm-4 control-label">联系邮箱：</label>
                        <div class="col-sm-4">
                            <input type="email" class="form-control" name="email" id="adminEmail">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="adminRole" class="col-sm-4 control-label">角&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;色：</label>
                        <div class=" col-sm-4">
                            <select class="form-control" id="adminRole" name="roleId">
                                <option value="0">请选择</option>
                                <option value="1">超级管理员</option>
                                <option value="2">商品管理员</option>
                            </select>
                        </div>
                    </div>
                    <br>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary doMargerModal" onclick="modifyAdmin()">修改</button>
                    <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                </div>
            </div>
        </div>
    </div>
    <!-- 修改系统用户 end -->

</body>

</html>