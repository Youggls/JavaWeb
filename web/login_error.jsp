<%--
  Created by IntelliJ IDEA.
  User: Raymond
  Date: 2019-07-03
  Time: 23:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JavaWeb——Sign in</title>
    <%--<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap-responsive.css">--%>
    <%--<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">--%>
    <%--<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>--%>
    <%--<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/jquery-2.1.1/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <style>
        .main {
            position: absolute;
            left: 50%;
            top: 50%;
            transform: translate(-50%,-50%);
        }
        body {
            padding: 90px 30px;
        }
    </style>
</head>
<body class="text-center">

<%-- 进入登录界面首先判断是否存在cookies，如果存在则直接跳转到主界面 --%>
<%
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (int i=0; i<cookies.length; ++i){
            if(cookies[i].getName().equals("name")) {
                response.sendRedirect("main.jsp");
            }
        }
    }
%>
<div>
    <%@ include file="head_visitor.jsp" %>
</div>
<div class="container">
    <div class="row">
        <div class="col-md-4"></div>
    </div>
    <div class="col-md-4 main">
        <form class="form-signin" method="post" action="/LogIn">
            <h2 class="h3 mb-3 font-weight-normal"><font style="vertical-align: inherit;">登录JavaWeb论坛</font></h2>
            <br>
            <label for="username" class="sr-only"><font style="vertical-align: inherit;">用户名</font></label>
            <input type="text" name="id" id="username" class="form-control" style="height: 3.5em;" placeholder="请输入用户名" required="" autofocus="">
            <br>
            <label for="password" class="sr-only"><font style="vertical-align: inherit;">密码</font></label>
            <input type="password" name="password" id="password" class="form-control" style="height: 3.5em;" placeholder="请输入密码" required="">
            <!-- <br>
      <div class="checkbox mb-3">
        <label><input type="checkbox" value="remember-me"><font style="vertical-align: inherit;"> 记住账号 </font></label>
      </div>-->
            <br>
            <div class="alert alert-danger">密码或ID输入错误！</div>
            <button type="submit" class="btn btn-primary btn-lg btn-block" id="bin-login"><font style="vertical-align: inherit;">登入</font></button>
            <a href="register.jsp" class="btn btn-default btn-lg btn-block"><font style="vertical-align: inherit;">注册</font></a>
            <br>
            <p class="mt-5 mb-3 text-muted"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">©2019</font></font></p>
        </form>
    </div>
    <div class="col-md-4">
    </div>
</div>
</body>
</html>
