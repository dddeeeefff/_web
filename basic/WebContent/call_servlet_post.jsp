<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>서블릿 호출(POST 방식)</h2>
<form action = "callServlet" method = "post">
<input type = "hidden" name = "idx" values = "qqq"><br />
id : <input type = "text" name = "id" /><br />
pw : <input type = "password" name = "pw" /><br />
idx : <input type = "checkbox" name="idx" value="a" />
<input type = "checkbox" name="idx" value="b" />
<input type = "checkbox" name="idx" value="c" /><br />
<input type = "text" name="idx" /><br />
<select name = "idx" disabled>
	<option value = "1">1</option>
	<option value = "2">2</option>
	<option value = "3">3</option>
</select><br />
<input type = "submit" value = "전송" />
</form>
</body>
</html>