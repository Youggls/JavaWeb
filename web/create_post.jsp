<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>发表帖子——JavaWeb论坛</title>
  <%--<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap-responsive.css">--%>
  <%--<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">--%>
  <%--<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>--%>
  <%--<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>--%>
  <%--<link rel="stylesheet" href="./bootstrap-3.3.7-dist/css/bootstrap-responsive.css">--%>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap-3.3.7-dist/css/bootstrap.min.css">
  <script src="${pageContext.request.contextPath}/jquery-2.1.1/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
  <style>
    body {
      padding: 90px 30px;
      background-color: #ffffff;
    }

    .tool-bar {
      border: none;
    }

    .editor {
      border: none;
      height: 1000px;
      background-color: #FFFFFF;
    }

    hr {
      -moz-border-bottom-colors: none;
      -moz-border-image: none;
      -moz-border-left-colors: none;
      -moz-border-right-colors: none;
      -moz-border-top-colors: none;
      border-color: #EEEEEE;
      -moz-use-text-color #FFFFFF;
      border-style: solid none;
      border-width: 1px 0;
      margin: 18px 0;
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
      pageContext.setAttribute("nickname", nickName);
      break;
    }
  }
  if (!login) {
    response.sendRedirect("/JavaWeb/main.jsp");
  }
%>

<body>
<div style="position:absolute;z-index: 999">
  <jsp:include page="head_login.jsp"></jsp:include>
</div>
<input type="hidden" name="postid" id="formhash" style="height: 3em; border-style: none;">
<div class="col-md-3"></div>
<div id="ct" class="col-md-6" style="position:relative;z-index: 1">
  <div class="row">
    <div style="margin-top: 10px;" align="center">
      <input id="title" placeholder="请输入标题"
             style="border: none;width: 100%;height: 40px;font-size: 35px;padding:4px;text-align:center">
    </div>
    <%--<div class="col-md-1"></div>--%>
    <hr/>


    <div id="tool-bar" class="tool-bar"></div>
    <%--<div class="col-md-1"></div>--%>
    <hr/>

    <div id="editor" class="editor" style="margin-bottom: 10px;-webkit-scrollbar: none"></div>
    <%--<div class="col-md-1"></div>--%>
  </div>
  <div style="text-align: center;">
    <button id="submit" type="button" class="btn btn-default">发帖！</button>
  </div>
  <!-- 注意， 只需要引用 JS，无需引用任何 CSS ！！！-->
  <script type="text/javascript" src="./wangEditor.min.js"></script>
  <script type="text/javascript">
      var E = window.wangEditor;
      var editor = new E("#tool-bar", "#editor");
      editor.create();
      document.getElementById('submit').addEventListener('click', function () {
          var titleLength = document.getElementById("title").value.length;
          if (titleLength === undefined || titleLength === 0) {
              alert("必须要有标题");
          } else if (titleLength > 30) {
              alert("标题不能大于30");
          } else if (editor.txt.text().length === 0) {
              alert("内容不能为空！");
          } else if (editor.txt.text().length > 500) {
              alert("内容不能多于100个字符！" + editor.txt.text().length);
          } else {
              var myForm = document.createElement("form");
              var content = editor.txt.html();
              var params = {
                  "content": content,
                  "title": document.getElementById("title").value,
                  "nickname": "${nickname}"
              };
              myForm.method = "post";
              myForm.action = "/JavaWeb/CreatePost";
              myForm.style.display = "none";

              for (var k in params) {
                  var myInput = document.createElement("input");
                  myInput.name = k;
                  myInput.value = params[k];
                  myForm.appendChild(myInput);
              }
              document.body.appendChild(myForm);
              myForm.submit();
              //document.body.removeChild(myForm);
              return myForm;
          }
      }, false);
  </script>
</div>
<div class="col-md-3"></div>
</body>
</html>