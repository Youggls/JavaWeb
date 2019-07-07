<%--
  Created by IntelliJ IDEA.
  User: Raymond
  Date: 2019-07-04
  Time: 01:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="static java.nio.charset.StandardCharsets.ISO_8859_1" %>
<%@ page import="static java.nio.charset.StandardCharsets.UTF_8" %>
<%@ page import="indi.RDY.JavaWeb.bean.User" %>
<%@ page import="indi.RDY.JavaWeb.util.SearchUtil" %>
<%@ page import="indi.RDY.JavaWeb.util.DbUtil" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>首页——JavaWeb论坛</title>
  <%--<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap-responsive.css">--%>
  <%--<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">--%>
  <%--<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>--%>
  <%--<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>--%>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap-3.3.7-dist/css/bootstrap.min.css">
  <script src="${pageContext.request.contextPath}/jquery-2.1.1/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
  <style>
    ul li {
      list-style-type: none;
    }

    body {
      padding: 90px 30px;
    }
  </style>
</head>
<body>
<%
  Cookie[] cookies = request.getCookies();
  String nickname = "";
  User user = null;
  boolean login = false;
  if (cookies != null) {
    for (Cookie cookie : cookies) {
      if (cookie.getName().equals("nickname")) {
        nickname = new String(cookie.getValue().getBytes(UTF_8), UTF_8);
        System.out.println(nickname);
        List<User> users = SearchUtil.searchUser(nickname, DbUtil.getConnection());
        if (users.size() > 0) {
          user = users.get(0);
          login = true;
        }
        pageContext.setAttribute("user", user);
        request.setAttribute("user", user);
        break;
      }
    }
    if (login) {%>
<div>
  <%@include file="head_login.jsp" %>
</div>
<%} else {%>
<div>
  <%@include file="head_visitor.jsp" %>
</div>
<%
    }
  }
%>

<div class="col-md-8">
  <div class="container-fluid">
    <div class="row">
      <!-- 内容面板 -->
      <div class="panel panel-default">
        <!-- 导航栏 -->
        <nav class="navbar navbar-default" role="navigation">
          <div>
            <ul class="nav navbar-nav">
              <li class="dropdown active">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  推荐
                  <b class="caret"></b>
                </a>
                <ul class="dropdown-menu">
                  <li><a href="#">按时间排序</a></li>
                  <li><a href="#">按热度排序</a></li>
                  <li class="divider"></li>
                  <li><a href="#">预留分离的链接test</a></li>
                </ul>
              </li>
              <li><a href="#">关注</a></li>
              <li><a href="#">xx</a></li>
              <li><a href="#">xx</a></li>
            </ul>
          </div>
        </nav>
        <div class="panel-body">
          这里放内容
        </div>
      </div>
    </div>
  </div>
</div>
<div class="col-md-4">
  <div class="container-fluid">
    <div class="row">
      <!-- 内容面板 -->
      <div class="panel panel-default">
        <div class="panel-body">
          <ul>
            <li><a href="create_post.jsp" class="glyphicon glyphicon-edit" title="Edit"><br>发帖</a></li>
          </ul>
        </div>
      </div>
    </div>
    <div class="row">
      <!-- 内容面板 -->
      <div class="panel panel-default">
        <div class="panel-body">
          test
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
