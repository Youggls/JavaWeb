<%--
  Created by IntelliJ IDEA.
  User: Raymond
  Date: 2019-07-03
  Time: 15:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/jquery-2.1.1/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<%
    Cookie[] cookies = request.getCookies();
    String nickname = "";
    User user = null;
    boolean login = false;
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("nickname")) {
                nickname = new String(cookie.getValue().getBytes(UTF_8), UTF_8);
                System.out.println(nickname);
                List<User> users = SearchUtil.searchUser(nickname, DbUtil.getConnection());
                if (users.size() > 0) {
                    user = users.get(0);
                    login = true;
                }
                pageContext.setAttribute("user", user);
                request.setAttribute("user", user);
                break;
            }
        }
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
</body>
</html>
