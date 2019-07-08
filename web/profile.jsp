<%@ page import="java.util.List" %>
<%@ page import="indi.RDY.JavaWeb.bean.TextContainer" %>
<%@ page import="java.util.Collection" %>
<%@ page import="indi.RDY.JavaWeb.bean.Post" %>
<%@ page import="indi.RDY.JavaWeb.bean.Floor" %>
<%@ page import="java.sql.*" %><%--
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
  List<User> users = SearchUtil.searchUser(targetNickname, conn);
  User targetUser = null;
  if (users.size() != 0) {
    targetUser = users.get(0);
    pageContext.setAttribute("targetUser", targetUser);
  } else {
    if (!login) {
      response.sendRedirect("main.jsp");
    } else {
      response.sendRedirect("profile.jsp?nickname=" + localUser.getNickName());
    }
  }

  boolean same = false;
  if (localUser != null) {
    same = (targetNickname.equals(localUser.getNickName()));
  }
  if (targetUser.getPhotoUrl() == null) {
    targetUser.setPhotoUrl("img/default_profile_photo.jpg");
  }
  conn.close();
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
          <img id="photo" class="img-responsive img-thumbnail img-circle"
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
          <%} else if (login) {%>
          <button id="follow" class="btn btn-default right" style="background-color: #286090;color: #FFFFFF">
            关注
          </button>
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
                  <li><a href="${pageContext.request.contextPath}/profile.jsp">按时间排序</a></li>
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
      <%
        conn = DbUtil.getConnection();
        List<TextContainer> texts = SearchUtil.searchTextByUser(targetUser.getId(), conn);
      %>
      <%
        for (TextContainer text : texts) {
          pageContext.setAttribute("currentText", text);
          if (text.getClass() == Post.class) {
            Post post = (Post) text;
            pageContext.setAttribute("title", post.getPostName());
            String detail = targetUser.getNickName() + "：发表了帖子";
            pageContext.setAttribute("detail", detail);
            pageContext.setAttribute("postUrl", "/JavaWeb/post.jsp?postid=" + post.getId());
          } else if (text.getClass() == Floor.class) {
            Floor floor = (Floor)text;
            String sql = "SELECT post_name, parent_post_id FROM post WHERE post_id = ?";
            PreparedStatement search = null;
            try {
              search = conn.prepareStatement(sql);
              search.setInt(1, floor.getParentPostId());
              search.execute();
              ResultSet rs = search.getResultSet();
              rs.next();
              String postName = rs.getString(1);
              int postId = rs.getInt(2);
              pageContext.setAttribute("title", postName);
              pageContext.setAttribute("postUrl", "/JavaWeb/post.jsp?postid=" + postId);
            } catch (SQLException e) {
              e.printStackTrace();
            }
          }
      %>
      <div id=${currentText.id}>
        <span>${detail}</span><br>
        <a style="font-size: 25px;margin-top: 5px;height: 30px;font-weight: 900"
           href=${postUrl}>${title}</a><br>
        <span style="margin-top: 30px">${targetUser.nickName}：&nbsp;&nbsp;${currentText.text}</span>
        <hr/>
      </div>
      <%
        }
        conn.close();
      %>
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
<script type="text/javascript">
    function submit() {
        var myForm = document.createElement("form");
        var params = {
            "follower_id": "${localUser.id}",
            "followed_id": "${targetUser.id}"
        };
        myForm.method = "post";
        myForm.action = "/JavaWeb/Follow";
        myForm.style.display = "none";

        for (var k in params) {
            var myInput = document.createElement("input");
            myInput.name = k;
            myInput.value = params[k];
            myForm.appendChild(myInput);
        }

        $.ajax({
            url: '/JavaWeb/Follow',
            type: 'POST',
            dataType: "text",
            data: "follower_id=" + "${localUser.id}" + "&followed_id=" + "${targetUser.id}",
            success: function (data) {
                var button = document.getElementById("follow");
                if (data === "followed!") {
                    button.innerText = "已关注~";
                    button.style.color = "#8590A6";
                    button.style.color = "#FFFFFF";
                    button.removeEventListener('click', submit);
                } else if (data === "ok") {
                    button.innerText = "已关注~";
                    button.style.color = "#8590A6";
                    button.style.color = "#FFFFFF";
                    button.removeEventListener('click', submit);
                }
            }
        })
    }

    document.getElementById("follow").addEventListener("click", submit);
</script>
</body>
</html>
