<%@ page import="indi.RDY.JavaWeb.bean.User" %>
<%@ page import="indi.RDY.JavaWeb.util.SearchUtil" %>
<%@ page import="indi.RDY.JavaWeb.util.DbUtil" %>
<%@ page import="static java.nio.charset.StandardCharsets.ISO_8859_1" %>
<%@ page import="static java.nio.charset.StandardCharsets.UTF_8" %><%--
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
    function redirect(url) {
        _response.redirect(url);
    }
</script>
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <%
        String nickname1 = "username";
        User user = null;
        Cookie[] cookies1 = request.getCookies();
        for (Cookie cookie : cookies1) {
            if (cookie.getName().equals("nickname")) {
                nickname1 = new String(cookie.getValue().getBytes(UTF_8), UTF_8);
                System.out.println(nickname1);
                user = SearchUtil.searchUser(nickname1, DbUtil.getConnection()).get(0);
                pageContext.setAttribute("user", user);
                request.setAttribute("user", user);
                break;
            }
        }
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
                        <li><a href="rank_deliver.jsp" target="_blank">发帖数排行</a></li>
                        <li><a href="rank_reply.jsp" target="_blank">回复数排行</a></li>
                        <li><a href="rank_time.jsp" target="_blank">注册时间排行</a></li>
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
                    <input type="text" class="form-control" placeholder="搜索关键词" style="height: 2em;">
                    &nbsp;&nbsp;&nbsp;<strike><a href="#" class="glyphicon glyphicon-search" title="Search"
                                                 target="_blank"></a></strike>
                </div>
                <!-- <button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-search textmuted" title="Search">搜索</span></button> -->
            </form>
        </div>
    </div>
</nav>

