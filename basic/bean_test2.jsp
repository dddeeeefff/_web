<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>자바빈즈 테스트 폼</h2>
<!-- 
form 태그를 이용하여 name과 gender 값을 입력받아 bean_test3.jsp로 전송하는 폼 제작
단, gender는 라디오버튼으로 제작
 -->
<form action="bean_test3.jsp" method="post">
이름 : <input type="text" name="name" /><br />
성별	: <input type="checkbox" name="gender" value="남자" />남자  
	  <input type="checkbox" name="gender" value="여자" />여자<br />
	  <input type="submit" value="전송" />
</form>
</body>
</html>