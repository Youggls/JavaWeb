<%--
  Created by IntelliJ IDEA.
  User: Raymond
  Date: 2019-07-03
  Time: 23:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap-responsive.css">
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <title>注册成功，正在跳转至登录界面</title>
</head>

<body>
<p style="text-indent: 2em; margin-top: 30px; text-align: center">

系统将在 <span id="time">3</span> 秒钟后自动跳转至登录界面，如果未能跳转，<a href="index.jsp" title="点击访问">请点击此处</a>。</p>

<script type="text/javascript">
    delayURL();
    function delayURL() {
        var delay = document.getElementById("time").innerHTML;
        var t = setTimeout("delayURL()", 1000);
        if (delay > 0) {
            delay--;
            document.getElementById("time").innerHTML = delay;
        } else {
     clearTimeout(t);
            window.location.href = "index.jsp";
        }
    }
</script>
</body>

