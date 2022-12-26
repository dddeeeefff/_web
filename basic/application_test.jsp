<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>Application Test</h2>
Servlet 버전 = <%=application.getMajorVersion() + "." + application.getMinorVersion() %><br />
서버 정보 : <%=application.getServerInfo() %><br />
실제 경로 : <%=application.getRealPath("/") %><br />
</body>
</html>