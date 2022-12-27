<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>영역(scope)과 속성(attribute) 테스트1</h2>
<form name="frm" action="attr_test2.jsp" method="post">
<table border="1">
<tr><th colspan="2">Application 영역에 저장할 내용들</th></tr>
<tr><th>이름</th><td><input type="text" name="name" /></td></tr>
<tr><th>ID</th><td><input type="text" name="uid" /></td></tr>
<tr><td colspan="2"><input type="submit" name="전송" /></td></tr>
</table>
</form>
</body>
</html>