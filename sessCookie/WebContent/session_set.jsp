<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// session 객체에 name 이라는 속성을 만들고 그 값으로 "Session Test!!"를 저장
// 저장 후 session_test.jsp로 이동시킴
request.setCharacterEncoding("utf-8");
session.setAttribute("name", "Session Test!!");
%>
<script>
location.href="session_test.jsp";
</script>
