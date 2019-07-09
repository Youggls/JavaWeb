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
<%@ page import="indi.RDY.JavaWeb.util.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="indi.RDY.JavaWeb.bean.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javafx.geometry.Pos" %>
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
    int postId = 0;
    postId = Integer.parseInt(request.getParameter("postid"));
    int floorId = 0;
    List<Floor> floorContent = SortByTimeLine.sortFloor(postId);
    pageContext.setAttribute("floorContent", floorContent);
    User current = null;
    int currentUserId = 0;
    pageContext.setAttribute("currentUserId", currentUserId);
    pageContext.setAttribute("currentUser", current);
%>
<%--
    Post post = null;
    conn = DbUtil.getConnection();
    String sql = "SELECT * FROM post WHERE post_id = ?";
    try {
        PreparedStatement search = conn.prepareStatement(sql);
        search.setInt(1, postId);
        search.execute();
        ResultSet rs = search.getResultSet();
        rs.next();
        post = new Post(rs.getInt(1),
                rs.getInt(2),
                rs.getString(3),
                rs.getString(4),
                rs.getTimestamp(5));
        conn.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
--%>

<div class="col-md-10 col-md-offset-1">
    <div class="container-fluid">
        <div class="row">
            <!-- 内容面板 -->
            <div class="panel panel-default">
                <div class="panel-body" style="margin: 30px">
                    <div>
                        <%
                            Post post = null;
                            conn = DbUtil.getConnection();
                            String sql = "SELECT * FROM post WHERE post_id = ?";
                            try {
                                PreparedStatement search = conn.prepareStatement(sql);
                                search.setInt(1, postId);
                                search.execute();
                                ResultSet rs = search.getResultSet();
                                rs.next();
                                post = new Post(rs.getInt(1),
                                        rs.getInt(2),
                                        rs.getString(3),
                                        rs.getString(4),
                                        rs.getTimestamp(5));
                                conn.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                            pageContext.setAttribute("post", post);
                            conn = DbUtil.getConnection();
                            User currentUser = SearchUtil.searchUser(post.getUserId(), conn).get(0);
                            conn.close();
                            pageContext.setAttribute("currentUser", currentUser);
                        %>
                        <img id="${currentUserId}" class="img-thumbnail" align="center" style="width: 50px; height:50px;" alt="Me" src=${currentUser.photoUrl}>
                        <span style="font-size: x-large;margin-top: 5px;height: 30px;font-weight: 900">&nbsp;&nbsp;${currentUser.nickName}:&nbsp;${post.postName}</span><br><br>
                        <span style="margin-top: 30px; font-size: medium">${post.text}</span>
                    </div>
                    <hr/>
                    <%
                        for (Floor floor : floorContent) {
                            pageContext.setAttribute("floor", floor);
                    %>
                    <div id="floor-${floor.id}">
                        <%
                            conn = DbUtil.getConnection();
                            currentUser = SearchUtil.searchUser(floor.getUserId(), conn).get(0);
                            pageContext.setAttribute("currentUser", currentUser);
                            conn.close();
                        %>
                        <img id="${currentUserId}" class="img-thumbnail" align="center" style="width: 50px; height:50px;" alt="Me" src=${currentUser.photoUrl}>
                        <span style="margin-top: 30px">&nbsp;${floor.text}</span>
                        <a onclick="this" class="glyphicon glyphicon-pencil" title="Back" style="float: right">回复</a>
                        <%
                            floorId = floor.getId();
                            List<Comment> commentContent = SortByTimeLine.sortComment(floorId);
                            pageContext.setAttribute("commentContent", commentContent);
                            for (Comment comment : commentContent) {
                                pageContext.setAttribute("comment", comment);
                        %>
                        <div class="panel-body col-md-10 col-md-offset-1" style="background-color: #cccccc">
                            <div id="${comment.id}">
                            <%
                                conn = DbUtil.getConnection();
                                currentUser = SearchUtil.searchUser(comment.getUserId(), conn).get(0);
                                pageContext.setAttribute("currentUser", currentUser);
                                conn.close();
                            %>
                            <img id="${currentUserId}" class="img-thumbnail" align="center" style="width: 30px; height:30px;" alt="Me" src=${currentUser.photoUrl}>
                            <span style="margin-top: 30px; font-size: small">&nbsp;${comment.text}</span>
                            <a onclick="this" class="glyphicon glyphicon-pencil" title="Back" style="float: right">回复</a>
                        </div>
                        </div>
                        <%}%>
                    </div>
                    <div class="input-group col-md-10 col-md-offset-1">
                        <input type="text" class="form-control">
                        <span class="input-group-btn">
                                <button class="btn btn-default" type="button">提交</button>
                                </span>
                    </div>
                    <hr/>
                    <%}%>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
