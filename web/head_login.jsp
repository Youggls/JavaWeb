<%--
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
    //设置cookie
    function setCookie(cname, cvalue, exdays) {
        var d = new Date();
        d.setTime(d.getTime() + (exdays*24*60*60*1000));
        var expires = "expires="+d.toUTCString();
        document.cookie = cname + "=" + cvalue + "; " + expires;
    }
    //清除cookie
    function logOut() {
        setCookie("id", "", 0);
    }
</script>
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
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
                        <span class="glyphicon glyphicon-user"></span> username
                        <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="profile.jsp" target="_blank">个人主页</a></li>
                        <li class="divider"></li>
                        <li><a href="${pageContext.request.contextPath}/JavaWeb/LogIn" >登出</a></li>
                    </ul>
                </li>
            </ul>
            <form class="navbar-form navbar-right" role="search">
                <div class="form-group" style="padding-top: 0.18em;">
                    <input type="text" class="form-control" placeholder="搜索关键词" style="height: 2em;">
                    &nbsp;&nbsp;&nbsp;<strike><a href="#" class="glyphicon glyphicon-search" title="Search" target="_blank"></a></strike>
                </div>
                <!-- <button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-search textmuted" title="Search">搜索</span></button> -->
            </form>
        </div>
    </div>
</nav>

