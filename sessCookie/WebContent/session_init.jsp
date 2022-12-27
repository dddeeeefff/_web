<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// session 객체의 모든 데이터를 삭제한 후 session_test.jsp로 이동
// 세션 객체를 삭제하므로 클라이언트의 브라우저에 새로운 세션을 부여함
session.invalidate();
%>
<script>
location.replace("session_test.jsp");
</script>