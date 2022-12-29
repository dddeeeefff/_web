<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%

String driver = "com.mysql.cj.jdbc.Driver";
String url = "jdbc:mysql://localhost:3306/mall?useUnicode=true&characterEncoding=UTF8&verifyServerCertificate=false&useSSL=false&serverTimezone=UTC";

Connection conn = null;
CallableStatement cstmt = null;
String sql = "{call sp_free_manage(?, ?, ?, ?, ?, ?, ?, ?, ?)}";		
// CallableStatement를 사용하려면 CallableStatement를 생성하기 전에 쿼리를
// 먼저 만들어 놔야 함. 단, 쿼리에 사용할 값들은 '?'로 채운 형태로 쿼리 생성
// 값들은 후에 파라미터 형태로 전달하게 됨

try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	
	cstmt = conn.prepareCall(sql);
	cstmt.setString(1, "i");
	cstmt.setInt(2, 2);
	cstmt.setString(3, "y");
	cstmt.setString(4, "test1");
	cstmt.setString(5, "");
	cstmt.setString(6, "국제");
	cstmt.setString(7, "전쟁 언제 끝나나?");
	cstmt.setString(8, "나야 모르지");
	cstmt.setString(9, request.getRemoteAddr()); // 글쓴이의 ip주소
	
	cstmt.execute();
	out.println("정상적으로 글이 등록되었습니다.");

}catch(Exception e){
	out.println("등록시 문제가 발생했습니다.");
	e.printStackTrace();
}finally{
	try{
		cstmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	
}

%>
