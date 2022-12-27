<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Cookie cookie = new Cookie("name", "Hong-GilDong");
// 쿠키 생성으로 name이라는 이름을 가진 "Hong-GilDong"이라는 값을 저장
cookie.setMaxAge(600);	// 생성한 쿠키의 만료기간을 600초(10분)로 지정
response.addCookie(cookie);	// 클라이언트에 생성한 쿠키를 보내 클라이언트 PC에 저장
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<a href="cookie_test2.jsp">저장된 쿠키 보러가기</a>
</body>
</html>