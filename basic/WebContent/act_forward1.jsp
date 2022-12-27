<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>forward 액션 태크 테스트</h2>
<form name="frm" action="act_forward2.jsp" method="post">
<input type="hidden" name="fowardPage" value="act_forward3.jsp" />
이름 : <input type="text" name="name" /><br />
나이 : <input type="text" name="age" /><br />
주소 : <input type="text" name="addr" /><br />
<input type="submit" value="전송" />
</form>
</body>
</html>