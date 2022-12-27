<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String name = "", value = "";	// 쿠키의 이름과 값을 저장할 변수
String cook = request.getHeader("Cookie");	// request 객체에서 쿠키를 받음
if (cook != null){	// 쿠키가 있으면
	Cookie[] cookies = request.getCookies();
	// cookies 배열에 'name'이라는 이름을 가진 쿠키가 있으면 이름과 값을 name과 value 변수에 저장
	for(int i = 0 ; i < cookies.length; i++){
		if(cookies[i].getName().equals("name")){
		// 현 쿠키(i인덱스의 쿠키)의 이름이 "name"이면
			name = cookies[i].getName();
			value = cookies[i].getValue();
			break;
		}
	}
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>쿠키 이름 : <%=name %></h3>
<h3>쿠키 값 : <%=value %></h3>
</body>
</html>