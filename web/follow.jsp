<%--
  Created by IntelliJ IDEA.
  User: tude
  Date: 2019/7/8
  Time: 3:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="static java.nio.charset.StandardCharsets.ISO_8859_1" %>
<%@ page import="static java.nio.charset.StandardCharsets.UTF_8" %>
<%@ page import="indi.RDY.JavaWeb.util.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="indi.RDY.JavaWeb.bean.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>关注——JavaWeb论坛</title>
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
            color:#000000;
            text-decoration:none;
        }
        a:hover {
            color:#175199;
            text-decoration:none;
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
<%}else{response.sendRedirect("/JavaWeb/main.jsp");}}%>
<%
    List<TextContainer> content = SortByTimeLine.sortFollowing(user.getId());
    pageContext.setAttribute("content", content);
    User current = null;
    int currentUserId = 0;
    pageContext.setAttribute("currentUserId", currentUserId);
    pageContext.setAttribute("currentUser", current);
%>
<div class="col-md-1"></div>
<div class="col-md-9">
    <div class="container-fluid">
        <div class="row">
            <!-- 内容面板 -->
            <div class="panel panel-default">
                <!-- 导航栏 -->
                <nav class="navbar navbar-default" role="navigation">
                    <div>
                        <ul class="nav navbar-nav">
                            <li class="dropdown">
                                <a href="${pageContext.request.contextPath}/" class="dropdown-toggle" data-toggle="dropdown">
                                    推荐
                                    <b class="caret"></b>
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a href="${pageContext.request.contextPath}/main.jsp">按时间排序</a></li>
                                    <li><a href="#">按热度排序</a></li>
                                </ul>
                            </li>
                            <li class="active"><a href="${pageContext.request.contextPath}/follow.jsp">关注</a></li>
                        </ul>
                    </div>
                </nav>
                <div class="panel-body">
                    <%
                        for (TextContainer text : content) {
                            pageContext.setAttribute("text", text);
                    %>
                    <div id="${text.id}">
                        <%
                            conn = DbUtil.getConnection();
                            User currentUser = SearchUtil.searchUser(text.getUserId(), conn).get(0);
                            String detail = "";
                            String postUrl = "/JavaWeb/post.jsp?postid=";
                            String postName = "";
                            if (text.getClass() == Post.class) {
                                detail = currentUser.getNickName() + "发表了帖子";
                                postUrl += text.getId();
                                Post post = (Post)text;
                                postName = post.getPostName();
                                pageContext.setAttribute("postname", postName);
                                pageContext.setAttribute("text", post);
                            } else if (text.getClass() == Floor.class) {
                                detail = currentUser.getNickName() + "发表了评论";
                                Floor floor = (Floor) text;
                                postUrl += floor.getParentPostId();
                                String sql = "SELECT post_name FROM post WHERE id = ?";

                                try {
                                    PreparedStatement prepared = conn.prepareStatement(sql);
                                    prepared.setInt(1, floor.getParentPostId());
                                    prepared.execute();
                                    ResultSet rs1 = prepared.getResultSet();
                                    rs1.next();
                                    postName = rs1.getString(1);
                                    pageContext.setAttribute("postname", postName);
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                                pageContext.setAttribute("text", (Floor)text);
                            }

                            conn.close();
                            pageContext.setAttribute("currentUser", currentUser);
                            pageContext.setAttribute("posturl", postUrl);
                            pageContext.setAttribute("detail", detail);
                        %>
                        <img id="${currentUserId}" class="img-thumbnail" align="center" style="width: 50px; height:50px;" alt="Me" src=${currentUser.photoUrl}>
                        <span>${detail}</span><br>
                        <a style="font-size: 25px;margin-top: 5px;height: 30px;font-weight: 900"
                           href=${posturl}>${postname}</a><br>
                        <span style="margin-top: 30px">${currentUser.nickName}：&nbsp;&nbsp;${text.text}</span>
                    </div>
                    <hr/>
                    <%}%>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="col-md-1">
    <div class="row panel panel-default">
        <div class="panel-body" align="center">
            <a href="create_post.jsp" class="glyphicon glyphicon-edit" title="Edit" style="font-size: medium"><br>发帖</a>
        </div>
    </div>
</div>
<div class="col-md-1"></div>
</body>
</html>

</body>
</html>
