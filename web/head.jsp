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
            <a class="navbar-brand" href="#">JavaWeb</a>
        </div>
        <div>
            <ul class="nav navbar-nav navbar-left">
                <li class="active"><a href="#">首页</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        排行榜
                        <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="#">发帖数排行</a></li>
                        <li><a href="#">回复数排行</a></li>
                        <li><a href="#">注册时间排行</a></li>
                        <li class="divider"></li>
                        <li><a href="#">分离的链接test</a></li>
                    </ul>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#"><span class="glyphicon glyphicon-user"></span> 注册</a></li>
                <li><a href="#"><span class="glyphicon glyphicon-log-in"></span> 登录</a></li>
            </ul>
            <form class="navbar-form navbar-right" role="search">
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="Search">
                </div>
                <button type="submit" class="btn btn-default">提交</button>
            </form>
        </div>
    </div>
</nav>
