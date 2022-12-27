<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#list tr { height:30px; }
#list th, #list td { padding:8px 3px; }
#list th { border-bottom:double black 3px; }
#list td { border-bottom:dotted black 1px; }
</style>
</head>
<body>
<table width="700" border="0" cellpadding="0" cellspacing="0" id="list">
<caption>게시판 목록 화면</caption>
	<tr>
		<th width = "7%">번호</th>
		<th width = "*">제목</th>
		<th width = "15%">작성자</th>
		<th width = "15%">작성일</th>
		<th width = "7%">조회</th>
	</tr>
	<%
	for(int i = 10; i > 0; i--){
	%>
	<tr align="center">
		<td><%=i %></td>
		<td alien="left">&nbsp;&nbsp;동해물과 백두산이 마르고 닳도록 하느님이 보우...</td>
		<td>홍길동</td>
		<td>22.09.06</td>
		<td>123</td>
	</tr>
	<% 
	}
	%>
</table>
</body>
</html>