<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
Enumeration en = request.getHeaderNames();
while(en.hasMoreElements()){
	String header = (String)en.nextElement();
	out.println("<tr>");
	out.println("<td>" + header + "</td>");
	out.println("<td>" + request.getHeader(header) + "</td>");
	out.println("</tr>");
}
%>
</body>
</html>