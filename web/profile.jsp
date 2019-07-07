<%@ page import="java.util.List" %>
<%@ page import="java.sql.Connection" %><%--
  Created by IntelliJ IDEA.
  User: Raymond
  Date: 2019-07-03
  Time: 11:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>个人主页——JavaWeb论坛</title>
    <%--<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap-responsive.css">--%>
    <%--<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">--%>
    <%--<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>--%>
    <%--<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/jquery-2.1.1/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <style>
        body {
            padding: 90px 30px;
        }
    </style>
</head>
<body style="background: url(img/bg.jpg)">
<%
    User localUser = null;
    Cookie[] cookies = request.getCookies();
    boolean login = false;
    Connection conn = DbUtil.getConnection();
    for (Cookie cookie : cookies) {
        if (cookie.getName().equals("nickname")) {
            String localNickName = cookie.getValue();
            List<User> users = SearchUtil.searchUser(localNickName, conn);
            if (users.size() != 0) {
                localUser = users.get(0);
            } else {
                break;
            }
            pageContext.setAttribute("localUser", localUser);
            login = true;
            break;
        }
    }
    String targetNickname = request.getParameter("nickname");
    System.out.println(targetNickname);
    List<User> users = SearchUtil.searchUser(targetNickname, conn);
    User targetUser = null;
    if (users.size() != 0) {
        targetUser = users.get(0);
        pageContext.setAttribute("targetUser", targetUser);
    } else {
        response.sendRedirect("profile.jsp?nickname="+localUser.getNickName());
    }

    boolean same = false;
    if (localUser != null) {
        same = (targetNickname.equals(localUser.getNickName()));
    }
    System.out.println(targetUser.getPhotoUrl());
    if (targetUser.getPhotoUrl() == null) {
        targetUser.setPhotoUrl("img/default_profile_photo.jpg");
    }
%>
<div>
    <%if (login) {%>
    <%@include file="head_login.jsp" %>
    <%} else {%>
    <%@include file="head_visitor.jsp" %>
    <%}%>
</div>
<div class="container">
    <div class="row" style="background: url(img/cover.jpg); background-size: cover;">
        <div class="col-md-12">
            <br>
            <br>
            <div class="row">
                <div class="col-md-2" align="center">
                    <br>
                    <img id="photo"  class="img-responsive img-thumbnail img-circle"
                         align="center" width="160px" height="160px" alt="Me" src=${targetUser.photoUrl}>
                    <br>
                </div>
                <div class="col-md-7">
                    <div class="panel-body">
                        <address>
                            <br>
                            <h3 title="username"> ${targetUser.nickName}</h3>
                            &nbsp;<span class="glyphicon glyphicon-user textmuted"
                                        title="Sex"> ${targetUser.gender}</span><br>
                            &nbsp;<span class="glyphicon glyphicon-home textmuted"
                                        title="Address"> ${targetUser.address}</span><br>
                            &nbsp;<span class="glyphicon glyphicon-phone textmuted"
                                        title="Mobile"> ${targetUser.phone}</span><br>
                            &nbsp;<span class="glyphicon glyphicon-envelope textmuted"
                                        title="Email"> ${targetUser.email}</span><br>
                            &nbsp;<span class="glyphicon glyphicon-user textmuted"
                                        title="follower"> 关注者：${targetUser.follower}</span><br>
                            &nbsp;<span class="glyphicon glyphicon-user textmuted"
                                        title="following"> 正在关注：${targetUser.following}</span>
                        </address>
                    </div>
                </div>
                <div class="col-md-3" style="float: right;">
                    <br><br><br><br><br><br><br>
                    <% if (same) {%>
                    <a href="revise.jsp" style="float: right;" class="btn btn-default right"><font
                            style="vertical-align: inherit;"> 修改个人信息 </font></a>
                    <%}%>
                </div>
            </div>
        </div>
    </div>
    <br>
    <div class="row">
        <div class="col-md-8">
            <nav class="navbar navbar-default" role="navigation">
                <div class="container-fluid">
                    <div>
                        <ul class="nav navbar-nav">
                            <li class="dropdown active">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    动态
                                    <b class="caret"></b>
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a href="#">按时间排序</a></li>
                                    <li><a href="#">按热度排序</a></li>
                                    <li class="divider"></li>
                                    <li><a href="#">预留分离的链接test</a></li>
                                </ul>
                            </li>
                            <li><a href="#">发帖</a></li>
                            <li><a href="#">评论</a></li>
                            <li><a href="#">回复</a></li>
                        </ul>
                    </div>
                </div>
            </nav>
        </div>
        <ul id="myTab" class="nav nav-tabs">
            <li class="active dropdown">
                <a href="#" id="myTabDrop1" class="dropdown-toggle"
                   data-toggle="dropdown">动态
                    <b class="caret"></b>
                </a>
                <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
                    <li><a href="#jmeter" tabindex="-1" data-toggle="tab">jmeter</a></li>
                    <li><a href="#ejb" tabindex="-1" data-toggle="tab">ejb</a></li>
                </ul>
            </li>
            <li><a href="#ios" data-toggle="tab">iOS</a></li>
            <li class="dropdown">
                <a href="#" id="myTabDrop2" class="dropdown-toggle"
                   data-toggle="dropdown">Java
                    <b class="caret"></b>
                </a>
                <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
                    <li><a href="#jmeter" tabindex="-1" data-toggle="tab">jmeter</a></li>
                    <li><a href="#ejb" tabindex="-1" data-toggle="tab">ejb</a></li>
                </ul>
            </li>
        </ul>
        <div class="col-md-4">

        </div>
    </div>
</div>
</body>
</html>
