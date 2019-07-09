<%--
  Created by IntelliJ IDEA.
  User: Raymond
  Date: 2019-07-08
  Time: 13:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="static java.nio.charset.StandardCharsets.UTF_8" %>
<%@ page import="indi.RDY.JavaWeb.util.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="indi.RDY.JavaWeb.bean.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>首页——JavaWeb论坛</title>
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
        .inoneline{
            display: inline;
            list-style-type: none;
            padding: 5px 5px;
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

<div class="col-md-10 col-md-offset-1">
    <div class="container-fluid">
        <div class="row">
            <!-- 内容面板 -->
            <div class="panel panel-default">
                <div class="panel-body" style="margin: 30px">
                    <div class="row">
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
                        <div class="col-md-1">
                            <img id="${currentUserId}" class="img-thumbnail" align="center" style="width: 50px; height:50px;" alt="Me" src=${currentUser.photoUrl}>
                            <span class="glyphicon glyphicon-user textmuted"
                                  title="Sex" style="font-size: x-small">${currentUser.gender}</span><br>
                            <span class="glyphicon glyphicon-user textmuted"
                                  title="following" style="font-size: x-small">关注：${currentUser.following}</span><br>
                            <span class="glyphicon glyphicon-user textmuted"
                                        title="follower" style="font-size: x-small">被关注：${currentUser.follower}</span>

                        </div>
                        <div class="col-md-11">
                            <span style="font-size: x-large;margin-top: 5px;height: 30px;font-weight: 900">${currentUser.nickName}:&nbsp;${post.postName}</span><br><br>
                            <span style="margin-top: 30px; font-size: medium">${post.content}</span>
                        </div>
                    </div>
                    <hr/>
                    <%
                        for (Floor floor : floorContent) {
                            pageContext.setAttribute("floor", floor);
                    %>
                    <div class="row" id="floor-${floor.id}">
                        <%
                            conn = DbUtil.getConnection();
                            currentUser = SearchUtil.searchUser(floor.getUserId(), conn).get(0);
                            pageContext.setAttribute("currentUser", currentUser);
                            conn.close();
                        %>
                        <div class="col-md-1">
                            <img id="${currentUserId}" class="img-thumbnail" align="center" style="width: 40px; height:40px;" alt="Me" src=${currentUser.photoUrl}>
                            <span class="glyphicon glyphicon-user textmuted"
                                  title="Sex" style="font-size: x-small">${currentUser.gender}</span><br>
                            <span class="glyphicon glyphicon-user textmuted"
                                  title="following" style="font-size: x-small">关注：${currentUser.following}</span><br>
                            <span class="glyphicon glyphicon-user textmuted"
                                  title="follower" style="font-size: x-small">被关注：${currentUser.follower}</span>
                        </div>
                        <div class="col-md-11">
                            <span style="margin-top: 30px">${floor.content}</span>
                            <ul style="float: right" class="inoneline">
                                <li class="inoneline">
                                    <span style="font-size: x-small; color: #8c8c8c"><fmt:formatDate value="${floor.time}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                                </li>
                                <li class="inoneline">
                                    <span style="font-size: small; color: #8c8c8c">#${floor.floorNum}</span>
                                </li>
                                <li class="inoneline">
                                    <div class="dropdown inoneline">
                                        <button type="button" class="btn btn-light btn-sm dropdown-toggle glyphicon glyphicon-triangle-bottom" id="dropdownMenu1" data-toggle="dropdown"></button>
                                        <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
                                            <li role="presentation">
                                                <a role="menuitem" tabindex="-1" onclick="comment(this, ${floor.floorNum}, '-1')" class="glyphicon glyphicon-pencil" title="Back">回复</a>
                                            </li>
                                            <li role="presentation">
                                                <a role="menuitem" tabindex="-1" onclick="this" class="glyphicon glyphicon-trash" title="Delete">删除</a>
                                            </li>
                                        </ul>
                                    </div>
                                </li>
                            </ul>
                            <br>
                            <%
                                floorId = floor.getId();
                                List<Comment> commentContent = SortByTimeLine.sortComment(floorId);
                                pageContext.setAttribute("commentContent", commentContent);
                                for (Comment comment : commentContent) {
                                    pageContext.setAttribute("comment", comment);
                            %>
                            <div class="panel-body col-md-10 col-md-offset-1" style="background-color:rgba(191, 191, 191,0.5);">
                                <div id="comment-${comment.id}">
                                    <%
                                        conn = DbUtil.getConnection();
                                        currentUser = SearchUtil.searchUser(comment.getUserId(), conn).get(0);
                                        pageContext.setAttribute("currentUser", currentUser);
                                        conn.close();
                                    %>
                                    <img id="${currentUserId}" class="img-thumbnail" align="center" style="width: 30px; height:30px;" alt="Me" src=${currentUser.photoUrl}>
                                    <span style="margin-top: 30px; font-size: small">${comment.content}</span>
                                    <a onclick="comment(this, ${floor.floorNum}, ${floor.id})" class="glyphicon glyphicon-pencil" title="Back" style="float: right">回复</a>
                                </div>
                            </div>
                            <%}%>
                        </div>
                        <div id="input-${floor.floorNum}" class="input-group col-md-8 col-md-offset-2 hidden">
                            <input id="input1-${floor.floorNum}" type="text" class="form-control" data-reply="">
                            <span name="submitbutton" class="input-group-btn">
                                <button class="btn btn-default" type="button" onclick="submitComment(this, ${floor.floorNum})">提交</button>
                                </span>
                        </div>
                    </div>

                    <hr/>
                    <%}%>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function comment(tag, floorNum, parentId) {
        floorNum = parseInt(floorNum);
        parentId = parseInt(parentId);
        console.log("input-" + floorNum);
        var inputDiv = document.getElementById("input-" + floorNum);
        var input = document.getElementById("input1-" + floorNum);
        inputDiv.setAttribute("class", "input-group col-md-8 col-md-offset-2");
        input.setAttribute("data-reply", "" + parentId);
        console.log(input.getAttribute("data-reply"))
    }
    function submitComment(tag, floorNum) {
        console.log("submit click");
        var input = tag.parentNode.previousElementSibling;
        var parentId = input.getAttribute("data-reply");
        console.log(parentId);
        var content = input.value;
        if (content === undefined) {
            alert("请输入内容！");
        }
    }
</script>
</body>
</html>
