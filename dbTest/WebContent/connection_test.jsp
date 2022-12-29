<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
Connection conn = null;	// db와의 연결을 위한 Connection 인스턴스 선언
String driver = "com.mysql.cj.jdbc.Driver";
String url = "jdbc:mysql://localhost:3306/mall?useUnicode=true&characterEncoding=UTF8&verifyServerCertificate=false&useSSL=false&serverTimezone=UTC";
boolean isConnect = false;	// 연결 성공 여부를 저장할 변수

try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	isConnect = true;
}catch(Exception e){
	isConnect = false;
	e.printStackTrace();
}finally{
	try{
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2> DB 연결 <%=(isConnect) ? "성공" : "실패" %> </h2>


</body>
</html>