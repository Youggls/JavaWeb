<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>发表帖子——JavaWeb论坛</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap-responsive.css">
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style>
        body {
            padding: 90px 30px;
        }
    </style>
</head>
<%
    boolean login = false;
    Cookie[] cookies = request.getCookies();
    String nickName = null;
    for (Cookie cookie : cookies) {
        if (cookie.getName().equals("nickname")) {
            login = true;
            nickName = cookie.getValue();
            break;
        }
    }
    if (!login) {
        response.sendRedirect("/JavaWeb/main.jsp");
    }
%>
<body>
<jsp:include page="head_login.jsp"></jsp:include>
<form method="post" id="postform" action="${pageContext.request.contextPath}/CreatePost?postid=xxxx">
    <input type="hidden" name="postid" id="formhash">
    <div id="ct">
        <div>
            <h2>发表帖子</h2>
            <label>
                <input type="text" name="posttitle">
            </label><br/>
            <jsp:include page="ueditor1_4_3_3-utf8-jsp/index2.jsp"></jsp:include>
            <input type="hidden" name="plateid" value="<%=request.getParameter("pid") %>">
            <button type="submit">发表</button>
        </div>
    </div>
</form>
</body>
</html>