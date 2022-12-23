<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String idx = request.getParameter("idx");
String val = request.getParameter("val");
	
String num = request.getParameter("num");
String name = request.getParameter("name");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>page context2</h2>
idx : <%=idx %> / val : <%=val %><br />
num : <%=num %> / name : <%=name %><br />
</body>
</html>