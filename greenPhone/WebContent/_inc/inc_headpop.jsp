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
ul,li {
    list-style-type: none;
    margin:0; padding:0;
}
header { width:100%; height:150px; }
#top { 
	display:flex; justify-content: space-between;
	margin:0 auto;
	position:fixed; top:0; left:0; right:0; background-color:gray;
	
}
#top_right { width:1050px; }
#top_right p { text-align:right; }
#toplist { width:100%; }
#toplist ul {
	display:flex;
    justify-content: space-between;
    align-items: center;
    text-align:center;
}
#toplist ul { width:100%; }
#toplist li { width:250px; height:40px; }
#topbbs {
	display:none;
    transform: translateY(-100%);
}
#topbbs a { display:block; }
#toplist ul li:nth-of-type(4):hover #topbbs { 
	transform: translateY(0%); display:block;
}
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
<header>
	<div id="top">
		<a href="/greenPhone/index.jsp"><img src="img/greenlogo.png" width="150" /></a>
		<div id="top_right">
<% if (isLogin) { %>
			<p>
				<a href="/greenPhone/logout.jsp">로그아웃</a>&nbsp;|&nbsp;
				<a href="member_form_up">마이페이지</a>&nbsp;|&nbsp;
				<a href="order_cart">장바구니</a>
			</p>
<% } else { %>
			<p>
				<a href="login_form">로그인</a>&nbsp;|
				<a href="member_form_in">회원가입</a>&nbsp;|
				<a href="login_form?url=order_cart">장바구니</a>
			</p>
<% } %>
			<br />
			<div id="toplist">
				<ul>
					<li><a href="product_list">내 폰 사기</a></li>
					<li><a href="sell_index">내 폰 팔기</a></li>
					<li><a href="/bbs/sell_chart.jsp">시세</a></li>
					<li>
						<a href="notice_list">게시판</a>
						<p></p>
						<div id="topbbs">
							<a href="notice_list">공지사항</a>&nbsp;&nbsp;&nbsp;
							<a href="faq">FAQ</a>&nbsp;&nbsp;&nbsp;
							<a href="event_list">이벤트</a>&nbsp;&nbsp;&nbsp;
							<a href="review_list">리뷰</a>&nbsp;&nbsp;&nbsp;
							<a href="free_list">자유 게시판</a>
						</div>
					</li>
				</ul>
			</div>		
		</div>
	</div>
</header>
