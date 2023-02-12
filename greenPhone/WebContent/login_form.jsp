<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String url = request.getParameter("url");
if (url == null)	url = "index.jsp";
%>
<style>
#login { }
</style>
<div id="login">
<h2>로그인 화면</h2>
<a href="/greenPhone/index.jsp"><img src="img/greenlogo.png" width="150" /></a>
<form name="frmLogin" action="login" method="post">
	<input type="hidden" name="url" value="<%=url %>" />
	아이디  <input type="text" name="uid" value="test1" /><hr />
	비밀번호 <input type="password" name="pwd" value="1234" /><br /><br />
	<input type="submit" value="로그인" /><br /><br />
</form>
<input type="button" value="아이디 찾기" />&nbsp;&nbsp;
<input type="button" value="비밀번호 찾기" />&nbsp;&nbsp;
<input type="button" value="회원 가입" />
</div>
</body>
</html>