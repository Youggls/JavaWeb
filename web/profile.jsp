<%--
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
    <title>JavaWeb——Sign in</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap-responsive.css">
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style>

    </style>
</head>
<body>
<div>
    <%@include file="head.jsp"%>
</div>
<br>
<br>
<br>
<br>
<div class="container">
    <div class="row" style="background: url(img/jungle.jpg)">
        <div class="col-md-9">
            <br>
            <br>
            <div class="row">
                <div class="col-md-3" align="center">
                    <br>
                    <img src="img/default_profile_photo.jpg" class="img-responsive img-thumbnail img-circle" align="center" width="140px" height="140px" alt="Me">
                    <br>
                </div>
                <div class="col-md-6">
                    <div class="panel-body">
                        <address>
                            <br>
                            <h3 title="username"> username</h3>
                            &nbsp;<span class="glyphicon glyphicon-user textmuted" title="Sex"> 男</span><br>
                            &nbsp;<span class="glyphicon glyphicon-home textmuted" title="Address"> 南开大学泰达学院</span><br>
                            &nbsp;<span class="glyphicon glyphicon-phone textmuted" title="Mobile"> 13820813777</span><br>
                            &nbsp;<span class="glyphicon glyphicon-envelope textmuted" title="Email"> 1712950@mail.nankai.edu.cn</span>
                        </address>
                    </div>
                </div>
                <div class="col-md-3" style="float: right;">
                    <a href="revise.jsp" style="float: right;" class="btn btn-default btn-block right"><font style="vertical-align: inherit;">修改个人信息</font></a>
                </div>
            </div>
        </div>

    </div>
</div>
</body>
</html>
