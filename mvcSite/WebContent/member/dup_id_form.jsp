<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%
request.setCharacterEncoding("utf-8");
String isChk = request.getParameter("isChk");
String uid = request.getParameter("uid");
String msg = "중복 검사할 아이디를 입력하세요.";		// 중복 여부에 따라 보여줄 메시지를 저장할 변수
boolean isDup = true;	// 중복 여부를 저장할 변수

if (isChk == null) {	// 검사한 상태가 아니면
	uid = "";
} else {	// 중복 검사를 할 경우
	String dbDriver = "com.mysql.cj.jdbc.Driver";
	String dbUrl = "jdbc:mysql://localhost:3306/mall?useUnicode=true&" + 
		"characterEncoding=UTF8&verifyServerCertificate=false&" + 
		"useSSL=false&serverTimezone=UTC";
	
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String sql = null;

	try {
		Class.forName(dbDriver);
		conn = DriverManager.getConnection(dbUrl, "root", "1234");
		stmt = conn.createStatement();
		sql = "select 1 from t_member_info where mi_id = '" + uid + "'";
		rs = stmt.executeQuery(sql);
		if (rs.next()) {
			isDup = true;
			msg = "이미 사용중인 아이디 입니다.";
		} else {
			isDup = false;
			msg = "사용 가능한 아이디 입니다.";		
		}

	} catch(Exception e) {
		out.println("DB연결에 문제가 발생했습니다.");
		e.printStackTrace();
	}
}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function trans(id) {
	opener.document.frmJoin.mi_id.value = id;
	self.close();
}
function chkVal(frm) {
	var uid = frm.uid.value;
	if (uid == "") {
		alert('검사할 아이디를 입력하세요');
		frm.uid.focus();	return false;
	}
	return true;
}
</script>
</head>
<body>
<h2>아이디 중복 체크</h2>
<form name="frmId" method="post" onsubmit="return chkVal(this);">
<input type="hidden" name="isChk" value="y" />
<p align="center">아이디 : <input type="text" name="uid" value="<%=uid %>" /></p>
<p align="center"><%=msg %></p>
<p align="center">
	<input type="submit" value="중복 검사" />
<% if (!isDup) { 	// 검사한 아이디가 사용 가능한 아이디일 경우 %>
	<input type="button" value="아이디 적용" onclick="trans('<%=uid %>');" />
<% } %>
</p>
</form>
</body>
</html>
