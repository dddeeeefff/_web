<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
session.setMaxInactiveInterval(10);
// 세션의 유지시간을 10초로 지정(기본값은 1800초)
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>Session test</h2>
isNew() : <%=session.isNew() %><br />
세션 생성시간 : <%=session.getCreationTime() %><br />
최종 접근시간 : <%=session.getLastAccessedTime() %><br />
세션 ID : <%=session.getId() %><br />
세션 유지시간 : <%=session.getMaxInactiveInterval() %><br />
</body>
</html>