<%--
  Created by IntelliJ IDEA.
  User: Raymond
  Date: 2019-07-03
  Time: 15:07
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
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
<div class="container-fluid row">
    <div class="col-md-10 col-md-offset-1">
        <div class="row">
            <div class="col-md-10" style="margin-top: 100px;white-space:nowrap" align="left">
                <div id="photo_and_upload">
                    <img id="photo" class="img-responsive img-thumbnail img-circle"
                         align="center" style="width: 160px; height: 160px; overflow: hidden" alt="Me" onclick="fileSelect()" src=${user.photoUrl}>
                    <h1 style="display: inline">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${user.nickName}</h1>
                </div>

                <form id="photo_upload" name="testName" action="${pageContext.request.contextPath}/UploadImage"
                      method="post" enctype="multipart/form-data" style="width:auto;">
                    <input type="file" id="fileToUpload" name="fileName" accept=".jpg,.TIFF,.RAW,.GIF,.png,.bmp"
                           onchange="fileSelected();" style="display:none;">
                    <input type="text" name="nickname" style="display: none" value=${user.nickName}>
                </form>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2" style="margin-top: 100px;" align="center"></div>
            <div class="col-md-6" style="margin-top: 100px;" align="center">
                <div class="input-group input-group-lg" style="margin-bottom: 50px;width: 100%;">
                    <input id="gender" type="text" class="form-control" placeholder="性别"
                           aria-describedby="sizing-addon1">
                </div>
                <div class="input-group input-group-lg" style="margin-bottom: 50px;width: 100%;">
                    <input id="address" type="text" class="form-control" placeholder="地址"
                           aria-describedby="sizing-addon1">
                </div>
                <div class="input-group input-group-lg" style="margin-bottom: 50px;width: 100%;">
                    <input id="phone" type="text" class="form-control" placeholder="电话"
                           aria-describedby="sizing-addon1">
                </div>
                <div class="input-group input-group-lg" style="margin-bottom: 50px;">
                    <input id="email" type="text" class="form-control" placeholder="邮箱"
                           aria-describedby="sizing-addon1">
                    <span class="input-group-addon" id="basic-addon2">@example.com</span>
                </div>
                <button id="submit" type="button" class="btn btn-default" style="color:#286090">提交</button>
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
        // document.getElementById("submit").click();
        var form = new FormData($('#photo_upload')[0]);
        form.append("nickname", "${user.nickName}");
        $.ajax({
            url: '/JavaWeb/UploadImage',
            type: 'POST',
            cache: false,
            dataType: "json",
            data: form,
            processData: false,
            contentType: false,
            success: function (data) {
                var str = JSON.stringify(data);
                var url = JSON.parse(str);
                $('#photo').attr("src", url.photoURL);
            }
        })
    }

    document.getElementById("submit").addEventListener('click', function () {
        var gender = document.getElementById("gender").value;
        var address = document.getElementById("address").value;
        var phone = document.getElementById("phone").value;
        var email = document.getElementById("email").value;

        if (gender === undefined || gender.length === 0) {
            alert('性别不能为空');
        } else if (address === undefined || address.length === 0) {
            alert('地址不能为空');
        } else if (phone === undefined || phone.length === 0) {
            alert('电话不能为空');
        } else if (email === undefined || email.length === 0) {
            alert('邮箱不能为空');
        } else {
            var myForm = document.createElement("form");
            var params = {
                "gender": gender,
                "address": address,
                "phone": phone,
                "email": email,
                "nickname": "${user.nickName}"
            };
            myForm.method = "post";
            myForm.action = "/JavaWeb/ChangeProfile";
            myForm.style.display = "none";

            for (var k in params) {
                var myInput = document.createElement("input");
                myInput.name = k;
                myInput.value = params[k];
                myForm.appendChild(myInput);
            }
            document.body.appendChild(myForm);
            myForm.submit();
        }
    })

</script>
</body>
</html>
