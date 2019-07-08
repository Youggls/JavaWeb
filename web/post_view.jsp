<%--
  Created by IntelliJ IDEA.
  User: Raymond
  Date: 2019-07-08
  Time: 13:20
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="static java.nio.charset.StandardCharsets.UTF_8" %>
<%@ page import="indi.RDY.JavaWeb.bean.User" %>
<%@ page import="indi.RDY.JavaWeb.util.*" %>
<%@ page import="indi.RDY.JavaWeb.bean.Post" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Connection" %>
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
            background-color: #F6F6F6;
        }

        a:link {
            color: #000000;
            text-decoration: none;
        }

        a:hover {
            color: #175199;
            text-decoration: none;
        }

        hr {
            -moz-border-bottom-colors: none;
            -moz-border-image: none;
            -moz-border-left-colors: none;
            -moz-border-right-colors: none;
            -moz-border-top-colors: none;
            border-color: #EEEEEE;
            border-style: solid none;
            border-width: 1px 0;
            margin: 16px 0;
        }
    </style>
</head>
<body>
<%
    Cookie[] cookies = request.getCookies();
    String nickname = "";
    User user = null;
    Connection conn = DbUtil.getConnection();
    boolean login = false;
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("nickname")) {
                nickname = new String(cookie.getValue().getBytes(UTF_8), UTF_8);
                List<User> users = SearchUtil.searchUser(nickname, conn);
                if (users.size() > 0) {
                    user = users.get(0);
                    login = true;
                }
                pageContext.setAttribute("user", user);
                request.setAttribute("user", user);
                break;
            }
        }
        conn.close();
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

<%
    int parentPostID = 0;
    pageContext.setAttribute("parentPostID", parentPostID);
%>

<div class="col-md-8">
    <div class="container-fluid">
        <div class="row">
            <!-- 内容面板 -->
            <div class="panel panel-default">
                <div class="panel-body">
                    <%

                    %>


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
