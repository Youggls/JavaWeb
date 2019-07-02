<%--
  Created by IntelliJ IDEA.
  User: Raymond
  Date: 2019-07-02
  Time: 23:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA_Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>JavaWeb——Sign in</title>
  <link href="css/bootstrap.min.css" rel="stylesheet">
  <style>
    .main {
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%,-50%);
  }
  </style>
</head>
<body>
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
<nav class="navbar navbar-default" role="navigation">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="#">Test Menu</a>
    </div>
    <div class="collapse navbar-collapse" id="sign_in">
      <ul class="nav navbar-nav navbar-right">
        <li><a href="sing_in.jsp">登录</a></li>
      </ul>
    </div>
  </div>
</nav>
<div class="container">
  <div class="row">
    <div class="col-md-4"></div>
  </div>
  <div class="col-md-4 main">
    <form class="form-singin" method="post">
      <h2 class="form-signin-heading">登录JavaWeb论坛</h2>
      <br>
      <label>用户名</label>
      <input type="text" name="username" id="username" class="form-control" placeholder="请输入用户名" required autofocus>
      <br>
      <label>密码</label>
      <input type="password" name="password" id="password" class="form-control" placeholder="请输入密码" required>
      <br>
      <div class="checkbox">
        <label>
          <input type="checkbox" value="remenber-me" checked="checked">记住密码
        </label>
        <label>
          <input type="reset" value="重置" name="reset">
        </label>
      </div>
      <button type="submit" class="btn btn-primary" id="bin-login">登录</button>
      <a href="sign_up.jsp" class="btn btn-default">注册</a>
    </form>
  </div>
  <div class="col-md-4">
  </div>
</div>
</body>
</html>
