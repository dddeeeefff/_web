<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>response test3</h2>
<%
String from = request.getParameter("from");
out.println("FROM : " + from);
%>
</body>
</html>