<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>response test1</h2>
<!-- 현재 페이지가 열리면 자동으로 response_test3.jsp?from=test1 으로 이동시킴 -->
<script>
location.href = "response_test3.jsp?from=test1";
</script>
</body>
</html>