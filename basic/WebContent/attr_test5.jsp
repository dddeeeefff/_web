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
request.setAttribute("req", "requestValue");
pageContext.setAttribute("page", "pageValue");

pageContext.forward("attr_test6.jsp");
// dispatch 방식으로 attr_test6.jsp로 이동시킴
%>
</body>
</html>