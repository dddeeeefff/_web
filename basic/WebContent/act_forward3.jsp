<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String name = request.getParameter("name");
String age = request.getParameter("age");
String addr = request.getParameter("addr");
String tel = request.getParameter("tel");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>포워드된 페이지(act_forward.jsp)</h2>
이름 : <%=name %><br />
나이 : <%=age %><br />
주소 : <%=addr %><br />
전화 : <%=tel %><br />
</body>
</html>