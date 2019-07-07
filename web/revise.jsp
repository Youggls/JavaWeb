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
<div class="container">
    <div class="row">
        <div class="col-md-10" style="margin-top: 100px;white-space:nowrap" align="left">
            <img id="photo" src="img/default_profile_photo.jpg" class="img-responsive img-thumbnail img-circle"
                      align="center" width="160px" height="160px" alt="Me" onclick="fileSelect()">
            <h1 style="display: inline">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${user.nickName}</h1>
            <form id="form_face" name="testName" action="${pageContext.request.contextPath}/UploadImage" method="post" enctype="multipart/form-data" style="width:auto;">
                <input type="file" id="fileToUpload" name="fileName"  accept=".jpg,.TIFF,.RAW,.GIF,.png,.bmp" onchange="fileSelected();" style="display:none;">
                <input type="text" name="nickname" style="display: none" value=${user.nickName}>
                <input type="submit" id="submit" value="上传" style="display:none"/>
            </form>
        </div>
    </div>
        <div class="row">
            <div class="col-md-2" style="margin-top: 100px;" align="center">
            </div>
            <div class="col-md-6" style="margin-top: 100px;" align="center">
                <div class="input-group input-group-lg" style="margin-bottom: 50px;">
                    <input id="gender" type="text" class="form-control" placeholder="性别"
                           aria-describedby="sizing-addon1">
                </div>
                <div class="input-group input-group-lg" style="margin-bottom: 50px;">
                    <input id="address" type="text" class="form-control" placeholder="地址"
                           aria-describedby="sizing-addon1">
                </div>
                <div class="input-group input-group-lg" style="margin-bottom: 50px;">
                    <input id="phone" type="text" class="form-control" placeholder="电话"
                           aria-describedby="sizing-addon1">
                </div>
                <div class="input-group input-group-lg" style="margin-bottom: 50px;">
                    <input id="email" type="text" class="form-control" placeholder="邮箱"
                           aria-describedby="sizing-addon1">
                    <span class="input-group-addon" id="basic-addon2">@example.com</span>
                </div>
            </div>
        </div>
    </div>
<script type="text/javascript">
    function fileSelect() {
        document.getElementById("fileToUpload").click();
    }

    function fileSelected() {
        //文件选择后触发次函数
        document.getElementById("submit").click();
    }
</script>
</body>
</html>
