<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%

String driver = "com.mysql.cj.jdbc.Driver";
String url = "jdbc:mysql://localhost:3306/mall?useUnicode=true&characterEncoding=UTF8&verifyServerCertificate=false&useSSL=false&serverTimezone=UTC";

Connection conn = null;	// db와의 연결을 위한 Connection 객체 선언
Statement stmt = null;	// db에 쿼리를 보내기 위한 Statement 객체 선언
String sql = null;		// db에 쿼리를 보내기 위한 쿼리를 저장할 문자열 변수


// admin2라는 아이디를 가진 관리자 정보를 삭제
try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();
	
	sql = "delete from t_admin_info where ai_id = 'admin2'";
	
	int result = stmt.executeUpdate(sql);
	if (result == 1)	out.println("정상적으로 삭제되었습니다");
	else				out.println("삭제에 실패했습니다.");

}catch(Exception e){
	out.println("관리자 삭제시 문제가 발생했습니다.");
	e.printStackTrace();
}finally{
	try{
		stmt.close();	// 먼저 닫아줘야 함
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	
}

%>
