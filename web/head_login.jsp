<%@ page import="indi.RDY.JavaWeb.bean.User" %>
<%@ page import="indi.RDY.JavaWeb.util.SearchUtil" %>
<%@ page import="indi.RDY.JavaWeb.util.DbUtil" %>
<%@ page import="static java.nio.charset.StandardCharsets.ISO_8859_1" %>
<%@ page import="static java.nio.charset.StandardCharsets.UTF_8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Connection" %><%--
  Created by IntelliJ IDEA.
  User: Raymond
  Date: 2019-07-04
  Time: 01:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<script>
    function doFormRequest(url, action) {
        var form = document.createElement("form");
        form.action = url;
        form.method = action;

        // send post request
        document.body.appendChild(form);
        form.submit();

        // remove form from document
        document.body.removeChild(form);
    }
</script>
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
  <%
    String nickname1 = "username";
    User user1 = null;
    Cookie[] cookies1 = request.getCookies();
    Connection conn1 = DbUtil.getConnection();
    for (Cookie cookie : cookies1) {
      if (cookie.getName().equals("nickname")) {
        nickname1 = new String(cookie.getValue().getBytes(UTF_8), UTF_8);
        List<User> users1 = SearchUtil.searchUser(nickname1, conn1);
        if (users1.size() > 0) {
          user1 = users1.get(0);
        }
        pageContext.setAttribute("user", user1);
        request.setAttribute("user", user1);
        break;
      }
    }
    conn1.close();
    String redirectUrl = "/JavaWeb/profile.jsp?nickname=" + nickname1;
    pageContext.setAttribute("redirectUrl", redirectUrl);
  %>
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand">JavaWeb论坛</a>
    </div>
    <div>
      <ul class="nav navbar-nav navbar-left">
        <li class="active"><a href="main.jsp">首页</a></li>
        <li class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown">
            排行榜
            <b class="caret"></b>
          </a>
          <ul class="dropdown-menu">
            <li><a>用户</a></li>
            <li class="divider"></li>
            <li><a href="rank.jsp?ranktype=post" target="_blank">发帖数排行</a></li>
            <li><a href="rank.jsp?ranktype=floor" target="_blank">回复数排行</a></li>
            <li><a href="rank.jsp?ranktype=registertime" target="_blank">注册时间排行</a></li>
          </ul>
        </li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown">
            <span class="glyphicon glyphicon-user"></span> ${user.nickName}
            <b class="caret"></b>
          </a>
          <ul class="dropdown-menu">
            <li><a href=${redirectUrl}>个人主页</a></li>
            <li class="divider"></li>
            <li><a onclick="doFormRequest('/JavaWeb/LogOut', 'post')">登出</a></li>
          </ul>
        </li>
      </ul>
      <form class="navbar-form navbar-right" role="search">
        <div class="form-group" style="padding-top: 0.18em;">
          <div class="input-group">
            <div class="input-group-btn">
              <div class="input-group-btn">
                <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" tabindex="-1">
                  <span class="caret"></span>
                  <span class="sr-only">切换下拉菜单</span>
                </button>
                <ul id="search" class="dropdown-menu">
                  <li>
                    <a id="searchpost" href="#">搜索帖子</a>
                  </li>
                  <li>
                    <a id="searchcontent" href="#">搜索内容</a>
                  </li>
                  <li>
                    <a id="searchuser" href="#">搜索用户</a>
                  </li>
                </ul>
              </div>
            </div>
            <input id="searchInput" type="text" class="form-control" placeholder="搜索关键词" aria-label="...">
          </div>
          &nbsp;&nbsp;&nbsp;<strike><a id="beginsearch" class="glyphicon glyphicon-search" title="Search"
                                       target="_blank"></a></strike>
        </div>
      </form>
    </div>
  </div>
</nav>
<script type="text/javascript">
    var searchType;
    var searchSelect = document.getElementById("search");
    searchSelect.onclick = function(event) {
        searchType = event.target;
        searchType = searchType.id;
    };
    var beginSearch = document.getElementById("beginsearch");
    beginSearch.onclick = function (ev) {
        var content = document.getElementById("searchInput").value;
        if (searchType === undefined) {
            alert("请先选择搜索类型");
        } else if(content === undefined) {
            alert("请输入搜索内容")
        }
        else {
            doFormRequest("/JavaWeb/search.jsp?searchtype=" + searchType + "&content=" + content, "post");
            // doFormRequest("/JavaWeb/main.jsp", "post");
        }
    }
</script>
