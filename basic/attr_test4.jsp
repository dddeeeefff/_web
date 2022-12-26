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
<h2>영역(scope)과 속성(attribute) 테스트4</h2>
<table border="1">
<tr><th colspan="2">Application 영역에 저장한 내용들</th></tr>
<tr><th>이름</th><td><%=application.getAttribute("name") %></td></tr>
<tr><th>ID</th><td><%=application.getAttribute("uid") %></td></tr>
</table>
<hr />
<table border="1">
<tr><th colspan="2">Session 영역에 저장한 내용들</th></tr>
<%
// Session 객체 안에 있는 모든 attribute를 추출하여 이름과 값을 출력
Enumeration e = session.getAttributeNames();
// Session 객체 안에 있는 모든 attribute의 이름들을 Enumeration 형으로 받아옴

if (e == null){
	out.println("<tr><td colspan='2'>현재 session 객체에는 속성이 없습니다.</td></tr>");
} else{
	while(e.hasMoreElements()){
		String attName = (String) e.nextElement();
		String attValue = (String) session.getAttribute(attName);
		
		out.println("<tr>");
		out.println("<td>" + attName + "</td>");
		out.println("<td>" + attValue + "</td>");
		out.println("</tr>"); 
	}
}
%>
</table>
<br />
<a href="attr_test5.jsp">attr_test5.jsp</a>
</body>
</html>