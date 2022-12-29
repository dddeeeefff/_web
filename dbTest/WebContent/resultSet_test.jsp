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
String sql = "select mi_id, mi_name, mi_gender, mi_birth, mi_point, mi_joindate, mi_status from t_member_info";


try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();
	rs = stmt.executeQuery(sql);
	// sql 변수에 담긴 select 쿼리의 실행 결과를 ResultSet인 rs에 저장

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
<h2>회원 목록</h2>
<table border="1" cellpadding="5">
<tr>
<th>번호</th><th>아이디</th><th>이름</th><th>성별</th>
<th>생일</th><th>포인트</th><th>가입일</th><th>상태</th>
</tr>
<%
// rs를 이용하여 회원목록을 출력, 없을 경우 '결과가 없습니다.' 출력
if (rs.next()){	// rs의 데이터가 있으면
	int num = 1;
	do{
		String birth = rs.getString("mi_birth");
		birth = birth.substring(0, 4) + "년 " +  birth.substring(5, 7) + "월  " +  birth.substring(8) + "일";
		
		String status = "정상회원";
		if(rs.getString("mi_status").equals("b"))
			status = "휴면 계정";
		else if(rs.getString("mi_status").equals("c"))
			status = "탈퇴 계정";
%>
<tr align="center">
	<td><%=num %></td>
	<td><%=rs.getString("mi_id") %></td>
	<td><%=rs.getString("mi_name") %></td>
	<td><%=rs.getString("mi_gender").concat("자") %></td>
	<td><%=birth %></td>
	<td><%=rs.getString("mi_point")%>P</td>
	<td><%=rs.getString("mi_joindate") %></td>
	<td><%=status %></td>
</tr>
<%	
		num++;
	}while(rs.next());

} else{			// rs의 데이터가 있으면
	out.println("<tr><td colapan='8' align='center'>");
	out.println("결과가 없습니다.</td><tr>");
}
%>
</table>
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