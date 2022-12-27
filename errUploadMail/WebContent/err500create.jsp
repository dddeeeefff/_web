<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String name = request.getParameter("name");
if(name == null){
	throw new NullPointerException();
	// 강제로 NullPointerException을 발생시킴
}
%>
</body>
</html>