<%--
  Created by IntelliJ IDEA.
  User: Raymond
  Date: 2019-07-08
  Time: 13:20
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="fmt" uri="/WEB-INF/fmt.tld" %>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

    .inoneline {
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
              <img id="${currentUserId}" class="img-thumbnail" align="center" style="width: 50px; height:50px;" alt="Me"
                   src=${currentUser.photoUrl}><br>
              <span class="glyphicon glyphicon-user textmuted"
                    title="nickname" style="font-size: x-small">${currentUser.nickName}</span><br>
              <span class="glyphicon glyphicon-heart-empty textmuted"
                    title="following" style="font-size: x-small">关注：${currentUser.following}</span><br>
              <span class="glyphicon glyphicon-heart textmuted"
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
              <img id="${currentUserId}" class="img-thumbnail" align="center" style="width: 40px; height:40px;" alt="Me"
                   src=${currentUser.photoUrl}>
              <span class="glyphicon glyphicon-user textmuted"
                    title="nickname" style="font-size: x-small">${currentUser.nickName}</span><br>
              <span class="glyphicon glyphicon-heart-empty textmuted"
                    title="following" style="font-size: x-small">关注：${currentUser.following}</span><br>
              <span class="glyphicon glyphicon-heart textmuted"
                    title="follower" style="font-size: x-small">被关注：${currentUser.follower}</span>
            </div>
            <div class="col-md-11">
              <span style="margin-top: 30px">${floor.content}</span>
              <ul style="float: right" class="inoneline">
                <li class="inoneline">
                  <span style="font-size: x-small; color: #8c8c8c"><fmt:formatDate value="${floor.time}"
                                                                                   pattern="yyyy-MM-dd HH:mm:ss"/></span>
                </li>
                <li class="inoneline">
                  <span style="font-size: small; color: #8c8c8c">#${floor.floorNum}</span>
                </li>
                <li class="inoneline">
                  <%if (login) {%>
                  <div class="dropdown inoneline">
                        <button type="button"
                                class="btn btn-light btn-sm dropdown-toggle glyphicon glyphicon-triangle-bottom"
                                id="dropdownMenu1" data-toggle="dropdown"></button>
                        <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
                          <li role="presentation">
                            <a role="menuitem" tabindex="-1" onclick="comment(this, ${floor.id}, '-1')"
                               class="glyphicon glyphicon-pencil" title="Back">回复</a>
                          </li>
                          <li role="presentation">

                            <a role="menuitem" tabindex="-1" onclick="deleteFloor('${floor.id}', '${user.nickName}')" class="glyphicon glyphicon-trash"
                               title="Delete">删除</a>

                      </li>
                    </ul>
                  </div>
                  <%}%>
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
              <div class="panel-body col-md-10 col-md-offset-1" style="background-color:rgba(191, 191, 191,0.45);">
                <div id="comment-${comment.id}">
                  <%
                    conn = DbUtil.getConnection();
                    currentUser = SearchUtil.searchUser(comment.getUserId(), conn).get(0);
                    pageContext.setAttribute("currentUser", currentUser);
                    conn.close();
                  %>
                  <img id="${currentUserId}" class="img-thumbnail" align="center" style="width: 30px; height:30px;"
                       alt="Me" src=${currentUser.photoUrl}>
                  <%
                      if (comment.getPreCommentId() == -1) {
                  %>
                  <span style="margin-top: 30px; font-size: small">${comment.content}</span>
                  <%
                      }
                      else {
                          Comment targetComment = null;
                          User targetUser = null;
                          int preCommentId;
                          preCommentId = comment.getPreCommentId();
                          conn = DbUtil.getConnection();
                          String searchComment = "SELECT * FROM comment WHERE comment_id = ?";

                          ResultSet rs = null;
                          try {
                              PreparedStatement prepared = conn.prepareStatement(searchComment);
                              prepared.setInt(1, preCommentId);
                              prepared.execute();
                              rs = prepared.getResultSet();
                              rs.next();
                              targetComment = new Comment(rs.getInt(1),
                                      rs.getInt(2),
                                      rs.getInt(3),
                                      rs.getInt(4),
                                      rs.getString(5),
                                      rs.getTimestamp(6),
                                      rs.getBoolean(7));
                              targetUser = SearchUtil.searchUser(targetComment.getUserId(), conn).get(0);
                          } catch (SQLException e) {
                              e.printStackTrace();
                          }
                          conn.close();
                          pageContext.setAttribute("targetComment", targetComment);
                          pageContext.setAttribute("targetUser", targetUser);
                  %>
                  <c:if test="${fn:length(targetComment.content)>5 }">
                  <span style="margin-top: 30px; font-size: small">回复 ${targetUser.nickName}"${fn:substring(targetComment.content, 0, 5)}..."：${comment.content}</span>
                  </c:if>
                  <c:if test="${fn:length(targetComment.content)<=5 }">
                    <span style="margin-top: 30px; font-size: small">回复 ${targetUser.nickName}"${targetComment.content}"：${comment.content}</span>
                  </c:if>
                  <%}%>
                  <%if (login) {%>
                  <a onclick="comment(this, ${floor.id}, ${comment.id})" class="glyphicon glyphicon-pencil"
                     title="Back" style="float: right; font-size: x-small">回复</a>
                  <%}%>
                </div>
                <span style="font-size: x-small; color: #8c8c8c; float: right"><fmt:formatDate value="${comment.time}"
                                                                                               pattern="yyyy-MM-dd HH:mm:ss"/></span>
              </div>
              <%}%>
            </div>
            <div id="input-${floor.id}" class="input-group col-md-8 col-md-offset-2 hidden">
              <input id="input1-${floor.id}" type="text" class="form-control" data-reply="">
              <span name="submitbutton" class="input-group-btn">
                                <button class="btn btn-default" type="button"
                                        onclick="submitComment(this, ${floor.floorNum}, ${floor.id})">提交</button>
                                </span>
            </div>
          </div>

          <hr/>
          <%}%>
          <br>
          <div class="row col-md-8 col-md-offset-2">
            <div id="tool-bar" class="tool-bar"></div>
            <%--<div class="col-md-1"></div>--%>
            <hr/>
            <%if (login) {%>
            <div id="editor" class="editor" style="margin-bottom: 10px;-webkit-scrollbar: none"></div>
            <div style="text-align: center;">
              <button id="follow" type="button" class="btn btn-primary"
                      data-complete-text="跟帖成功">跟帖！
              </button>
            </div>
            <script type="text/javascript" src="./wangEditor.min.js"></script>
            <script type="text/javascript">
                var E = window.wangEditor;
                var editor = new E("#tool-bar", "#editor");
                editor.create();
                document.getElementById('follow').addEventListener('click', function () {
                    var content = editor.txt.html();
                    if (editor.txt.text().length === 0) {
                        alert("内容不能为空！");
                    } else if (editor.txt.text().length > 500) {
                        alert("内容不能多于100个字符！" + editor.txt.text().length);
                    } else {
                        $.post("/JavaWeb/CreateFloor", {
                            "content": content,
                            "userId": "${user.id}",
                            "parentPostId": "${post.id}"
                        }, function (data) {
                            if (data === "true") {
                                $('#follow').innerText = "跟帖成功!";
                                location.reload(true);
                            }
                        });
                    }
                }, false);
            </script>
            <%}%>
          </div>
        </div>

      </div>
    </div>
  </div>
</div>
<script>
    function comment(tag, floorId, parentId) {
        floorId = parseInt(floorId);
        parentId = parseInt(parentId);
        var inputDiv = document.getElementById("input-" + floorId);
        var input = document.getElementById("input1-" + floorId);
        inputDiv.setAttribute("class", "input-group col-md-8 col-md-offset-2");
        input.setAttribute("data-reply", "" + parentId);
    }

    function submitComment(tag, floorNum, floor_id) {
        console.log("submit click");
        var input = document.getElementById("input1-" + floor_id);
        var parentId = input.getAttribute("data-reply");
        var content = input.value;
        if (content === undefined || content.length === 0) {
            alert("请输入内容！");
        } else {
            $.post("/JavaWeb/CreateComment", {
                "nickname": "${user.nickName}",
                "rootFloorId": "" + floor_id,
                "preCommentId": "" + parentId,
                "content": content
            }, function (data) {
                console.log(data);
                if (data === "true") {
                    alert("评论成功！");
                    location.reload(true);
                } else {
                    alert("请重试");
                    location.reload(true);
                }
            });
        }
    }

    function deleteFloor(floorId, nickName) {
        $.post("/JavaWeb/Delete", {
            "type": "floor",
            "id": "" + floorId,
            "nickname": "" + nickName
        }, function (data) {
            console.log(data);
            if (data === "true") {
                alert("操作成功！");
                location.reload(true);
            } else {
                alert("操作失败，请检查您的权限");
                location.reload(true);
            }
        });
    }

</script>
</body>
</html>
