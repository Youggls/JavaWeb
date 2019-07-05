<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<head>
    <title>ueditor</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <script type="text/javascript" charset="utf-8"
            src="${pageContext.request.contextPath}/ueditor1_4_3_3-utf8-jsp/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8"
            src="${pageContext.request.contextPath}/ueditor1_4_3_3-utf8-jsp/ueditor.all.min.js"></script>


    <script type="text/javascript" charset="utf-8"
            src="${pageContext.request.contextPath}/ueditor1_4_3_3-utf8-jsp/lang/zh-cn/zh-cn.js"></script>

    <style type="text/css">
        #editor {
            width:1024px;
            height:500px;
        }
    </style>
    <%--<style type="text/css">--%>
        <%--div{--%>
            <%--width:100%;--%>
        <%--}--%>
    <%--</style>--%>
</head>
<script id="editor" type="text/plain" ></script>
<script type="text/javascript">
var ue = UE.getEditor('editor');
</script>