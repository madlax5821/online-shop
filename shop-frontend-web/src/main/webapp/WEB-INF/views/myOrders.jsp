<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>我的订单</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
</head>

<body>
    <div class="navbar navbar-default clear-bottom">
        <div class="container">
            <!-- logo start -->
            <div class="navbar-header">
                <a class="navbar-brand logo-style" href="http://edu.51cto.com/center/lec/info/index?user_id=12392007">
                        <img class="brand-img" src="images/com-logo1.png" alt="logo" height="70">
                    </a>
            </div>
            <!-- logo end -->
            <!-- navbar start -->
            <jsp:include page="top.jsp">
            <!-- navbar end -->
        </div>
    </div>
    <!-- content start -->
    <div class="container">
        <div class="row">
            <div class="col-xs-12">
                <div class="page-header" style="margin-bottom: 0px;">
                    <h3>我的订单</h3>
                </div>
            </div>
        </div>
        <table class="table table-hover   orderDetail">
            <tr>
                <td colspan="5">
                    <span>订单编号：<a href="orderDetail.html">4722456552315</a></span>
                    <span>成交时间：2017-01-01  11:58:49</span>
                </td>
            </tr>
            <tr>
                <td><img src="images/shop1.jpg" alt=""></td>
                <td class="order-content">
                    <p>
                        秋冬韩版轮廓型宽松连帽套头学生百搭毛呢卫衣+休闲裤两件套装
                    </p>
                    <p>颜色：单件粉色上衣</p>
                    <p>尺码：s</p>
                </td>
                <td>
                    ￥180.00
                </td>
                <td>
                    2
                </td>
                <td class="text-color">
                    ￥360.00
                </td>
            </tr>
            <tr>
                <td><img src="images/shop2.jpg" alt=""></td>
                <td class="order-content">
                    <p>
                        秋冬韩版轮廓型宽松连帽套头学生百搭毛呢卫衣+休闲裤两件套装
                    </p>
                    <p>颜色：单件粉色上衣</p>
                    <p>尺码：s</p>
                </td>
                <td>
                    ￥60.00
                </td>
                <td>
                    2
                </td>
                <td class="text-color">
                    ￥60.00
                </td>
            </tr>
            <tr>
                <td colspan="5">
                    <span class="pull-right"><button class="btn btn-danger">删除订单</button></span>
                    <span class="">总计:<span class="text-color">￥420.00</span></span>
                </td>
            </tr>
            <tr>
                <td colspan="5">
                    <span>订单编号：<a href="orderDetail.html">4722456552315</a></span>
                    <span>成交时间：2017-01-01  11:58:49</span>
                </td>
            </tr>
            <tr>
                <td><img src="images/shop1.jpg" alt=""></td>
                <td class="order-content">
                    <p>
                        秋冬韩版轮廓型宽松连帽套头学生百搭毛呢卫衣+休闲裤两件套装
                    </p>
                    <p>颜色：单件粉色上衣</p>
                    <p>尺码：s</p>
                </td>
                <td>
                    ￥180.00
                </td>
                <td>
                    2
                </td>
                <td class="text-color">
                    ￥360.00
                </td>
            </tr>
            <tr>
                <td><img src="images/shop2.jpg" alt=""></td>
                <td class="order-content">
                    <p>
                        秋冬韩版轮廓型宽松连帽套头学生百搭毛呢卫衣+休闲裤两件套装
                    </p>
                    <p>颜色：单件粉色上衣</p>
                    <p>尺码：s</p>
                </td>
                <td>
                    ￥60.00
                </td>
                <td>
                    2
                </td>
                <td class="text-color">
                    ￥60.00
                </td>
            </tr>
            <tr>
                <td colspan="5">
                    <span class="pull-right"><button class="btn btn-danger">删除订单</button></span>
                    <span class="">总计:<span class="text-color">￥420.00</span></span>
                </td>
            </tr>
        </table>
    </div>
    <!-- content end-->
    <!-- footers start -->
    <div class="footers">
        版权所有：南京网博
    </div>
    <!-- footers end -->
    <!-- 修改密码模态框 -->
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
    <!-- 登录模态框 -->
    <div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">登&nbsp;陆</h4>
                </div>
                <form action="" class="form-horizontal" method="post">
                    <div class="modal-body">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">登录帐号：</label>
                            <div class="col-sm-6">
                                <input class="form-control" type="password">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">密码：</label>
                            <div class="col-sm-6">
                                <input class="form-control" type="password">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">验证码：</label>
                            <div class="col-sm-6">
                                <input class="form-control" type="password">
                            </div>
                            <div class="col-sm-2 input-height">
                                1234
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-warning" data-dismiss="modal" aria-label="Close">关&nbsp;&nbsp;闭</button>
                        <button type="reset" class="btn btn-warning">重&nbsp;&nbsp;置</button>
                        <button type="submit" class="btn btn-warning">登&nbsp;&nbsp;陆</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- 注册模态框 -->
    <div class="modal fade" id="registModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">会员注册</h4>
                </div>
                <form action="" class="form-horizontal" method="post">
                    <div class="modal-body">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">用户姓名:</label>
                            <div class="col-sm-6">
                                <input class="form-control" type="text">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">登陆账号:</label>
                            <div class="col-sm-6">
                                <input class="form-control" type="text">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">登录密码:</label>
                            <div class="col-sm-6">
                                <input class="form-control" type="password">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">联系电话:</label>
                            <div class="col-sm-6">
                                <input class="form-control" type="text">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">联系地址:</label>
                            <div class="col-sm-6">
                                <input class="form-control" type="text">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-warning" data-dismiss="modal" aria-label="Close">关&nbsp;&nbsp;闭</button>
                        <button type="reset" class="btn btn-warning">重&nbsp;&nbsp;置</button>
                        <button type="submit" class="btn btn-warning">注&nbsp;&nbsp;册</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>

</html>