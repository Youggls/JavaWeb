<%--
  Created by IntelliJ IDEA.
  User: Raymond
  Date: 2019-07-03
  Time: 11:21
  To change this template use File | Settings | File Templates.
--%>
<%-- 用于展示论坛的头部信息 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
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
                        <li><a href="rank_deliver.jsp">发帖数排行</a></li>
                        <li><a href="rank_reply.jsp">回复数排行</a></li>
                        <li><a href="rank_time.jsp">注册时间排行</a></li>
                    </ul>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="register.jsp"><span class="glyphicon glyphicon-user"></span> 注册</a></li>
                <li><a href="index.jsp"><span class="glyphicon glyphicon-log-in"></span> 登录</a></li>
            </ul>
            <form class="navbar-form navbar-right" role="search">
                <div class="form-group" style="padding-top: 0.18em;">
                    <input type="text" class="form-control" placeholder="搜索关键词" style="height: 2em;">
                    &nbsp;&nbsp;&nbsp;<strike><a href="#" class="glyphicon glyphicon-search" title="Search"></a></strike>
                </div>
                <!-- <button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-search textmuted" title="Search">搜索</span></button> -->
            </form>
        </div>
    </div>
</nav>
