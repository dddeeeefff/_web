<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// session 객체에 "name"이라는 속성이 존재하면 그 값을 출력하고,
// 없으면 "세션값 없음"이라고 출력
String name = (String)session.getAttribute("name");
if (name == null)	name = "세션값 없음";
// getAttribute() 메소드 사용시 해당 속성(attribute)이 없으면  null을 리턴
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>세션 테스트</h2>
<p>세션 ID : <%=session.getId() %> </p>
<input type="button" value="세션 값 저장" onclick="location.href='session_set.jsp';" /><!-- session_set.jsp -->
<input type="button" value="세션 값 삭제" onclick="location.href='session_del.jsp';" /><!-- session_del.jsp -->
<input type="button" value="세션 값 초기화" onclick="location.href='session_init.jsp';" /><!-- session_init.jsp -->
<h3>이름 : <%=name %></h3>
</body>
</html>