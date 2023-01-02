<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%!	// 공용으로 사용할 메소드 선언 및 정의 영역
public String getRequest(String req) {
	return req.trim().replace("<", "&lt;").replace("'", "''");
}
%>
<%
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

} catch(Exception e) {
	out.println("DB연결에 문제가 발생했습니다.");
	e.printStackTrace();
}

MemberInfo login_info = (MemberInfo)session.getAttribute("login_info");
// 로그인 여부와 로그인 시 정보를 추출하기 위해 세션의 로그인 속성을 저장
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#list th, #list td { padding:8px 3px; }
#list th { border-bottom:double black 3px; }
#list td { border-bottom:dotted black 1px; }
</style>
</head>
<body>
<a href="http://localhost:8086/jspSite/index.jsp">HOME</a>
<br /><hr />
