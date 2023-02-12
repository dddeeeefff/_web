<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.time.*" %>
<%@ page import="vo.*" %>
<%
MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
boolean isLogin = false;
if (loginInfo != null)	isLogin = true;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
ul li {
	list-style-type: none;
}
a {
	text-decoration-line:none; 
	color:black;
}

header {

}
.login {
	position:absolute;
	top:0;
	right:0;
	margin-right:30px;
	display:flex;
	justify-content: flex-end;
}
.login span {
	height:22px;
	width:1px;
	background-color: #000;
	margin:0 13px;
}

.header {
	display: flex;
}	
.menu {
	width:100%;
	max-width:1200px;
	margin:0 auto;
	display: flex;
	align-items: center;
    justify-content: space-around;
    font-size:20px;
}
</style>
<script src="/greenPhone/js/jquery-3.6.1.js"></script>
<script src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css" /><script>
function onlyNum(obj) {
	if (isNaN(obj.value)) {
		obj.value = "";
	}
}
</script>
</head>
<header>
	<div id="login">
<% if (!isLogin) { %>
		<ul class="login">
			<li><a href="login_form">로그인</a></li>
			<span></span>
			<li><a href="member_form_in">회원가입</a></li>
			<span></span>
			<li><a href="login_form?url=cart_view">장바구니</a></li>
		</ul>

<% } else { %>
		<ul class="login">
			<li><a href="/greenPhone/logout.jsp">로그아웃</a></li>
			<span></span>
			<li><a href="member_form_up">마이페이지</a></li>
			<span></span>
			<li><a href="cart_view">장바구니</a></li>
		</ul>
<% } %>
	</div>
	<div class="header">
		<a href="/greenPhone/index.jsp"><img src="./img/greenlogo.png" width="150" /></a>
		<br />
		<ul class="menu">
			<li><a href="product_list">내 폰 사기</a></li>
			<li><a href="sell_index">내 폰 팔기</a></li>
			<li><a href="/bbs/sell_chart.jsp">시세</a></li>
			<li><a href="notice_list">게시판</a></li>
		</ul>
	</div>
	
</header>
<body>

	
	
	
	
	
	
	
	
	
	
