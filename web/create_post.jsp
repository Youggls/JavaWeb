<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>发表帖子——JavaWeb论坛</title>
    <link rel="stylesheet" href="bootstrap-responsive.css">
    <link rel="stylesheet" href="bootstrap.min.css">
    <script src="jquery.min.js"></script>
    <script src="bootstrap.min.js"></script>
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
<script type="text/javascript">

</script>
<body>
<jsp:include page="head_login.jsp"></jsp:include>
<input type="hidden" name="postid" id="formhash">
<div id="ct">
    <input>
    <div id="editor">
        <p>欢迎使用 <b>wangEditor</b> 富文本编辑器</p>
    </div>
    <button id="btn1">获取html</button>
    <button id="btn2">获取text</button>

    <!-- 注意， 只需要引用 JS，无需引用任何 CSS ！！！-->
    <script type="text/javascript" src="./wangEditor.min.js"></script>
    <script type="text/javascript">
        var E = window.wangEditor;
        var editor = new E('#editor');
        editor.create();
        // document.getElementById('btn1').addEventListener('click', function () {
        //     // 读取 html
        //     alert(editor.txt.html());
        //
        // }, false);
        document.getElementById('btn1').addEventListener('click', function () {
            alert("click function");
            var myForm = document.createElement("form");
            var content = editor.txt.html();
            var params = {"content": content, "title": "testtitle", "nickname": "10000"};
            alert("click function2");
            myForm.method = "post";
            myForm.action = "/JavaWeb/CreatePost";
            myForm.style.display = "none";

            for (var k in params) {
                var myInput = document.createElement("input");
                myInput.name = k;
                alert(k);
                myInput.value = params[k];
                myForm.appendChild(myInput);
            }
            document.body.appendChild(myForm);
            myForm.submit();
            //document.body.removeChild(myForm);
            return myForm;
        }, false);
    </script>
</div>
</body>
</html>