<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%

String driver = "com.mysql.cj.jdbc.Driver";
String url = "jdbc:mysql://localhost:3306/mall?useUnicode=true&characterEncoding=UTF8&verifyServerCertificate=false&useSSL=false&serverTimezone=UTC";

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
ResultSetMetaData rsmd = null;

String sql = "select mi_id, mi_name, mi_gender, mi_birth, mi_point, mi_joindate, mi_status from t_member_info";


try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();
	rs = stmt.executeQuery(sql);
	rsmd = rs.getMetaData();
	// 생성된 ResultSet인 rs의 메타데이터를 사용하기 위해 ResultSetMetaData 객체 생성


}catch(Exception e){
	out.println("회원 목록 쿼리에서 문제가 발생했습니다.");
	e.printStackTrace();
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>받아온 컬럼 개수 : <%=rsmd.getColumnCount() %></h3>
<!-- 
각 컬럼의 이름, 레이블, 자료형 등을 출력
 -->
 <% 
 for(int i = 1; i <= rsmd.getColumnCount(); i++) {
	 out.print(i + "번째 컬럼명 : " + rsmd.getColumnName(i) + " / ");
	 out.print("컬럼 레이블 : " + rsmd.getColumnLabel(i) + " / ");
	 out.println("컬럼 자료형 : " + rsmd.getColumnTypeName(i) + " / " + "<br />");
 } %>
</body>
</html>
<%
try{
	rs.close();
	stmt.close();
	conn.close();
}catch(Exception e){
	e.printStackTrace();
}
%>