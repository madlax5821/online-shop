<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="${pageContext.request.contextPath}/js/template.js"></script>
<script src="${pageContext.request.contextPath}/layer/layer.js"></script>
<%--
  Created by IntelliJ IDEA.
  User: madlax
  Date: 9/29/2021
  Time: 1:59 PM
  To change this template use File | Settings | File Templates.
--%>
<script id="welcomeInfo" type="text/html">
    <li class="userName">
        您好：{{name}}！ <%--数据来源于js里的let content=template("welcomeInfo",result.data);--%>
    </li>
    <li class="dropdown">
        <a href="#" class="dropdown-toggle user-active" data-toggle="dropdown" role="button">
            <img class="img-circle" src="${pageContext.request.contextPath}/images/user.jpeg" height="30" />
            <span class="caret"></span>
        </a>
        <ul class="dropdown-menu">
            <li>
                <a href="#" data-toggle="modal" data-target="#modifyPasswordModal">
                    <i class="glyphicon glyphicon-cog"></i>修改密码
                </a>
            </li>
            <li>
                <a href="#" onclick="logout()">
                    <i class="glyphicon glyphicon-off"></i> 退出
                </a>
            </li>
        </ul>
    </li>

</script>

<script>
    function loginByAccount() {
        $.post('${pageContext.request.contextPath}/frontend/customer/loginByAccount', {
            "loginName":$("#userName").val(),
            "password":$("#userPassword").val()
        },function (result) {
            console.log(result.message)
            if (result.status==1){
                //原始办法 刷新页面
                //location.href='${pageContext.request.contextPath}/frontend/product/searchProduct';
                //局部刷新
                $("#loginModal").modal('hide');
                let content=template("welcomeInfo",result.data);
                $("#navBar").html(content);
            }else {
                $("#loginInfo").html(result.message)
            }
        })
    }

    function loginBySMS() {
        $.post("${pageContext.request.contextPath}/frontend/customer/loginBySMS",{
            "verificationCode":$("#verificationCode").val(),
            "phone":$("#phone").val()
        },function (result) {
            if (result.status==1){
                $("#loginModal").modal("hide");
                let content = template("welcomeInfo",result.data);
                $("#navBar").html(content);
            }else {
                $("#loginInfo1").html(result.message);
            }
        })
    }

    function logout() {
        $.post("${pageContext.request.contextPath}/frontend/customer/logout",function (result) {
            if (result.status==1){
                location.href="${pageContext.request.contextPath}/frontend/product/searchProduct";
            }
        })
    }

    function sendSMS(btn) {
        $.post("${pageContext.request.contextPath}/frontend/SMS/sendCode",
        {
            "phone":$("#phone").val()
        },function (result) {
            if (result.status!=1){
                $("#loginInfo1").html(result.message);
            }else {
                console.log(result.message)
                let time =60;
                timer=setInterval(function () {
                    if (time>0){
                        $(btn).attr("disabled",true);
                        $(btn).html("resend("+time+")");
                        time--;
                    }else {
                        $(btn).attr("disabled",false);
                        $(btn).html("resend");
                        clearInterval(timer);  //stop timer
                    }
                },1000)
            }
        });
    }

    function register(){
        $.post("${pageContext.request.contextPath}/frontend/customer/register",{
            "name":$("#name").val(),
            "loginName":$("#loginName").val(),
            "password":$("#password").val(),
            "phone":$("#registerPhone").val(),
            "address":$("#address").val()
        },function (result) {
            if (result.status==1){
                layer.msg(result.message,{
                    time:2000
                },function (){
                    location.href='${pageContext.request.contextPath}/frontend/product/searchProduct';
                })
            }else {
                $("#registerInfo").html(result.message);
            }
        })
    }

</script>

<!-- navbar start -->
<div class="navbar navbar-default clear-bottom">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand logo-style" href="http://edu.51cto.com/center/lec/info/index?user_id=12392007">
                <img class="brand-img" src="${pageContext.request.contextPath}/images/com-logo1.png" alt="logo" height="70">
            </a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li class="active">
                    <a href="#">商城主页</a>
                </li>
                <li>
                    <a href="myOrders.jsp">我的订单</a>
                </li>
                <li>
                    <a href="cart.html">购物车</a>
                </li>
                <li class="dropdown">
                    <a href="'${pageContext.request.contextPath}/customer/personalCenter?id='+${customer.id}">会员中心</a>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right" id="navBar">
                <c:choose >
                    <c:when test="${empty customer}">
                        <li>
                            <a href="#" data-toggle="modal" data-target="#loginModal">登陆</a>
                        </li>
                        <li>
                            <a href="#" data-toggle="modal" data-target="#registModal">注册</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="userName">
                            您好：${customer.name}！
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle user-active" data-toggle="dropdown" role="button">
                                <img class="img-circle" src="${pageContext.request.contextPath}/images/user.jpeg" height="30" />
                                <span class="caret"></span>
                            </a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a href="#" data-toggle="modal" data-target="#modifyPasswordModal">
                                        <i class="glyphicon glyphicon-cog"></i>修改密码
                                    </a>
                                </li>
                                <li>
                                    <a href="#" onclick="logout()">
                                        <i class="glyphicon glyphicon-off"></i> 退出
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</div>
<!-- navbar end -->

<!-- 修改密码模态框 start -->
<div class="modal fade" id="modifyPasswordModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">修改密码</h4>
            </div>
            <form action="" class="form-horizontal" method="post">
                <div class="modal-body">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">原密码：</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="password">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">新密码：</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="password">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">重复密码：</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="password">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal" aria-label="Close">关&nbsp;&nbsp;闭</button>
                    <button type="reset" class="btn btn-warning">重&nbsp;&nbsp;置</button>
                    <button type="submit" class="btn btn-warning">修&nbsp;&nbsp;改</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- 修改密码模态框 end -->

<!-- 登录模态框 start  -->
<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <!-- 用户名密码登陆 start -->
        <div class="modal-content" id="login-account">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">用户名密码登录 &nbsp;&nbsp;<small id="loginInfo" class="text-danger"></small></h4>
            </div>
            <form class="form-horizontal" method="post">
                <div class="modal-body">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">用户名：</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="text" id="userName" placeholder="请输入用户名">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">密&nbsp;&nbsp;&nbsp;&nbsp;码：</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="password" id="userPassword" placeholder="请输入密码">
                        </div>
                    </div>
                </div>
                <div class="modal-footer" style="text-align: center">
                    <a class="btn-link">忘记密码？</a> &nbsp;
                    <button type="button" class="btn btn-warning" data-dismiss="modal" aria-label="Close">关&nbsp;&nbsp;闭</button>
                    <button type="button" class="btn btn-warning" onclick="loginByAccount()">登&nbsp;&nbsp;陆</button> &nbsp;&nbsp;
                    <a class="btn-link" id="btn-sms-back">短信快捷登录</a>
                </div>
            </form>
        </div>
        <!-- 用户名密码登陆 end -->

        <!-- 短信快捷登陆 start -->
        <div class="modal-content" id="login-sms" style="display: none;">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">短信快捷登陆<small id="loginInfo1" class="text-danger"></small></h4>
            </div>
            <form class="form-horizontal" method="post">
                <div class="modal-body">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">手机号：</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="text" placeholder="请输入手机号" id="phone">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">验证码：</label>
                        <div class="col-sm-4">
                            <input class="form-control" type="text" placeholder="请输入验证码" id="verificationCode">
                        </div>
                        <div class="col-sm-2">
                            <button class="pass-item-timer" type="button" onclick="sendSMS(this)">发送验证码</button>
                        </div>
                    </div>
                </div>
                <div class="modal-footer" style="text-align: center">
                    <a class="btn-link">忘记密码？</a> &nbsp;
                    <button type="button" class="btn btn-warning" data-dismiss="modal" aria-label="Close">关&nbsp;&nbsp;闭</button>
                    <button type="button" class="btn btn-warning" onclick="loginBySMS()">登&nbsp;&nbsp;陆</button> &nbsp;&nbsp;
                    <a class="btn-link" id="btn-account-back">用户名密码登录</a>
                </div>
            </form>
        </div>
        <!-- 短信快捷登陆 end -->
    </div>
</div>
<!-- 登录模态框 end  -->

<!-- 注册模态框 start -->
<div class="modal fade" id="registModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel" >会员注册 &nbsp;&nbsp;&nbsp;&nbsp;<small id="registerInfo" class="text-danger"></small></h4>
            </div>
            <form id="registerForm" class="form-horizontal" method="post">
                <div class="modal-body">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">用户姓名:</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="text" name="name" id="name">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">登陆账号:</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="text" name="loginName" id="loginName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">登录密码:</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="password" name="password" id="password">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">联系电话:</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="text" name="phone" id="registerPhone">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">联系地址:</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="text" name="address" id="address">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal" aria-label="Close">关&nbsp;&nbsp;闭</button>
                    <button type="reset" class="btn btn-warning">重&nbsp;&nbsp;置</button>
                    <button type="button" class="btn btn-warning" onclick="register()">注&nbsp;&nbsp;册</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- 注册模态框 end -->
