<%--
  Created by IntelliJ IDEA.
  User: Raymond
  Date: 2019-07-03
  Time: 09:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JavaWeb——Sign up</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap-responsive.css">
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style>
        .main {
            position: absolute;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%);
        }
    </style>
</head>
<body>
<div>
    <%@ include file="head.jsp" %>
</div>
<div class="container">
    <div class="row">
        <div class="col-md-4"></div>
    </div>
    <div class="col-md-4 main">
        <form class="form-singin" method="post" action="/LogIn">
            <br>
            <br>
            <h2 class="form-signin-heading">注册JavaWeb论坛账号</h2>
            <br>
            <div align="center">
            <img src="img/default_profile_photo.jpg" class="rounded mx-auto d-block img-circle" align="center" width="140px" height="140px" alt="error">
            </div>
            <br><br>
            <label>用户名</label>
            <input type="text" name="nickname" id="username" class="form-control" style="height: 3.5em;" placeholder="请输入用户名" required autofocus>
            <br>
            <label>密码</label>
            <input type="password" name="password" id="password" class="form-control" style="height: 3.5em;" placeholder="请输入密码" required>
            <br>
            <label>确认密码</label>
            <input type="password" name="repassword" id="repassword" class="form-control" style="height: 3.5em;" placeholder="请再次输入密码" required>
            <br><br>
            <button type="submit" onclick="window.location.href='register_to_login.jsp'" class="btn btn-primary btn-lg btn-block" id="register">注册</button>
            <br>
            <a href="index.jsp" class="btn btn-default btn-lg btn-block">返回登录</a>
        </form>
    </div>
    <div class="col-md-4">
    </div>
</div>
</body>
</html>
