<%--
  Created by IntelliJ IDEA.
  User: tude
  Date: 2019/7/1
  Time: 16:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>$Title$</title>
</head>
<body>
$END$
<jsp:useBean id="user" class="indi.RDY.JavaWeb.User" scope="page">
    <%
        user.setNickName("test");
        user.setPassWord("1234565");
    %>
    <p>名字是：<%out.println(user.getNickName());%></p>
</jsp:useBean>
</body>
</html>
