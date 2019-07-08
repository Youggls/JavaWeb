<%@ page import="indi.RDY.JavaWeb.bean.TextContainer" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="indi.RDY.JavaWeb.bean.Post" %>
<%@ page import="indi.RDY.JavaWeb.bean.Floor" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: tude
  Date: 2019/7/9
  Time: 0:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<html>
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
  </style>
</head>
<body>
<%
  boolean login = false;
  Cookie[] cookies = request.getCookies();
  String nickName = null;
  for (Cookie cookie : cookies) {
    if (cookie.getName().equals("nickname")) {
      login = true;
      nickName = cookie.getValue();
      pageContext.setAttribute("nickname", nickName);
      break;
    }
  }
  List<TextContainer> texts = new ArrayList<>();
  String content = request.getParameter("content");
  Connection conn = DbUtil.getConnection();
  boolean isText = false;
  if (request.getParameter("searchtype").equals("searchpost")) {
    texts.addAll(SearchUtil.searchPostByTitle(content, conn));
    isText = true;
  } else if (request.getParameter("searchtype").equals("searchcontent")) {
    texts.addAll(SearchUtil.searchTextByContentAndTitle(content, conn));
    isText = true;
  }
%>

<%if (login) {%>
<div class="col-md-12">
  <%@include file="head_login.jsp" %>
</div>
<%} else {%>
<div class="col-md-12">
  <%@include file="head_visitor.jsp" %>
</div>
<%}%>
<div class="col-md-3"></div>
<div class="col-md-5">
  <div class="container-fluid">
    <div class="row">
      <!-- 内容面板 -->
      <%--<div class="panel panel-default">--%>
      <%--<div class="panel-body">--%>
      <%
        if (isText) {
          for (TextContainer text : texts) {
            if (text.getClass() == Post.class) {
              Post post = (Post) text;
              conn = DbUtil.getConnection();
              User currentUser = SearchUtil.searchUser(post.getUserId(), conn).get(0);
              conn.close();
              pageContext.setAttribute("currentUser", currentUser);
              String postUrl = "/JavaWeb/post.jsp?postid=" + post.getId();
              pageContext.setAttribute("posturl", postUrl);
              pageContext.setAttribute("title", post.getPostName());
              pageContext.setAttribute("content", post.getText());
            } else if (text.getClass() == Floor.class) {
              Floor floor = (Floor) text;
              conn = DbUtil.getConnection();
              String sql = "SELECT post_name FROM post WHERE id = ?";
              User currentUser = SearchUtil.searchUser(floor.getParentPostId(), conn).get(0);
              pageContext.setAttribute("currentUser", currentUser);
              try {
                PreparedStatement prepared = conn.prepareStatement(sql);
                prepared.setInt(1, floor.getParentPostId());
                prepared.execute();
                ResultSet rs1 = prepared.getResultSet();
                rs1.next();
                String postName1 = rs1.getString(1);
                String postUrl = "/JavaWeb/post.jsp?postid=" + floor.getParentPostId();
                pageContext.setAttribute("title", postName1);
                pageContext.setAttribute("content", floor.getText());
                pageContext.setAttribute("posturl", postUrl);
                conn.close();
              } catch (SQLException e) {
                e.printStackTrace();
              }
            }%>
      <%--<span>${detail}</span><br>--%>
      <div class="panel panel-default">
        <div class="panel-body">
          <a style="font-size: 25px;margin-top: 5px;height: 30px;font-weight: 900"
             href=${posturl}>${title}</a><br>
          <span style="margin-top: 30px">${currentUser.nickName}：&nbsp;&nbsp;${content}</span>
        </div>
      </div>
      <%
        }
      %>
      <%
      } else {
        if (request.getParameter("searchtype").equals("searchuser")) {
          List<User> users = SearchUtil.searchUsers(content, conn);
          for (User user : users) {
            pageContext.setAttribute("currentUser", user);
            pageContext.setAttribute("url", "/JavaWeb/profile.jsp?nickname=" + user.getNickName());
      %>
      <div class="panel panel-default">
        <div class="panel-body">
          <div>
            <img src="${currentUser.photoUrl}" class="img-thumbnail" width="50px" height="50px">
            <a style="font-size: 15px;margin-top: 0px;height: 20px;font-weight: 900;line-height:0px"
               href=${url}>${currentUser.nickName}</a><br>
          </div>
        </div>
      </div>
      <%
            }
          }
        }
      %>
    </div>
  </div>
</div>

<div class="col-md-3"></div>
</body>
</html>
