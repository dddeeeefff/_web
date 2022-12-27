<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String name = request.getParameter("name");
String uid = request.getParameter("uid");

application.setAttribute("name", name);
application.setAttribute("uid", uid);
// application 객체의 새로운 속성 name과 uid 저장
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>영역(scope)과 속성(attribute) 테스트2</h2>
<h3><%=name %>님 반갑습니다.<br /><%=name %>님의 아이디는 <%=uid %>입니다. </h3>
<form name="frm" action="attr_test3.jsp" method="post">
<table border="1">
<tr><th colspan="2">Application 영역에 저장할 내용들</th></tr>
<tr><th>메일</th><td><input type="text" name="mail" /></td></tr>
<tr><th>주소</th><td><input type="text" name="addr" /></td></tr>
<tr><td colspan="2"><input type="submit" name="전송" /></td></tr>
</table>
</form>
</body>
</html>