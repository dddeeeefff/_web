<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>response test2</h2>
<%
response.sendRedirect("response_test3.jsp?from=test2");
// sendRedirect로 작업시 클라이언트에 파일을 응답라기 전에 이동할 파일로 먼저 이동한 후 그 파일로 응답함
%>
</body>
</html>