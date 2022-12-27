<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 
attr_test2에서 보낸 데이터들을 받아 session 객체에 속성으로 저장
application 객체에 있는 'name' 속성의 값을 추출하여 name 변수에 저장 후 출력
 -->
<%
request.setCharacterEncoding("utf-8");
String mail = request.getParameter("mail");
String addr = request.getParameter("addr");

session.setAttribute("mail", mail);
session.setAttribute("addr", addr);

String name = (String) application.getAttribute("name"); 
// getAttribute() 메소드의 리턴타입이 Object이므로 String으로 형변환을 해야 함 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3><%=name %>님의 정보가 모두 저장되었습니다.</h3>
<a href="attr_test4.jsp">속성값 확인</a>

</body>
</html>