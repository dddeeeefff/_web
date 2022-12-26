<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
application 영역 속성<br />
이름 : <%=application.getAttribute("name") %> /
ID : <%=application.getAttribute("uid") %>
<hr />
★session 영역 속성<br />
메일 : <%=session.getAttribute("mail") %> /
주소 : <%=session.getAttribute("addr") %>
<hr />
★request 영역 속성<br />
req : <%=request.getAttribute("req") %> 

<hr />
page 영역 속성<br />
메일 : <%=pageContext.getAttribute("page") %> /

<hr />
</body>
</html>