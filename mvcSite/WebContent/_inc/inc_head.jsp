<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.time.*" %>
<%@ page import="vo.*" %>
<%
MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
boolean isLogin = false;
if (loginInfo != null)	isLogin = true;
// 로그인 여부를 판단할 변수 isLogin 생성
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
boby, th, td, div, p { font-size:12px; }
a:link { text-decoration:none; color:black; }
a:visited { text-decoration:none; color:black; }
a:hover { text-decoration:none; color:red; }
.hand { cursor:pointer; }
.bold{ font-weight:bold; }
</style>
<script src="/mvcSite/js/jquery-3.6.1.js"></script>
<script>
function onlyNum(obj) {
	if (isNaN(obj.value)) {
		obj.value = "";
	}
}
</script>
</head>
<body>
<a href="/mvcSite/index.jsp">HOME</a>&nbsp;&nbsp;&nbsp;&nbsp;
<% if (isLogin) { %>
<a href="/mvcSite/logout.jsp">로그아웃</a>&nbsp;&nbsp;&nbsp;&nbsp;
<a href="member_form_up">정보수정</a>
<% } else { %>
<a href="login_form">로그인</a>&nbsp;&nbsp;&nbsp;&nbsp;
<a href="member_form_in">회원가입</a>
<% } %>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="product_list?pcb=AA">구두</a>&nbsp;&nbsp;&nbsp;
<a href="product_list?pcb=BB">운동화</a>
<hr />