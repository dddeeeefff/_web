<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="_inc/inc_head.jsp" %>

<%
if (login_info != null){	// 이미 로그인이 되어 있다면
	out.println("<script>");
	out.println("alert('잘못된 경로로 들어오셨습니다.'); history.back();");
	out.println("</script>");
	out.close();
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>로그인 폼</h2>
<form name="frmLogin" action="login_proc.jsp" method="post">
아이디 : <input type="text" name="uid" value="test1" /><br />
비밀번호 : <input type="password" name="pwd" value="1234" /><br />
<input type="submit" value="로그인" />
</form>
</body>
</html>