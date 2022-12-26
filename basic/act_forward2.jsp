<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String url = request.getParameter("fowardPage");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- act_forward3.jsp로 액션 태그를 이용하여 포워딩(tel이라는 이름의 파라미터도 가져감) -->
<jsp:forward page="<%=url %>">
	<jsp:param name="tel" value="010-1234-5678" />
</jsp:forward>
</body>
</html>