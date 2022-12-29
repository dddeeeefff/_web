<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%
String driver = "com.mysql.cj.jdbc.Driver";
String url = "jdbc:mysql://localhost:3306/mall?useUnicode=true&" + 
	"characterEncoding=UTF8&verifyServerCertificate=false&" + 
	"useSSL=false&serverTimezone=UTC";

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sql = "select mi_id, mi_name, concat(mi_gender, '자') gender, " + 
"concat(left(mi_birth, 4), '년 ', mid(mi_birth, 6, 2), '월 ', " + 
"right(mi_birth, 2), '일') birth, concat(mi_point, 'P') pnt, " + 
"mi_joindate, if(mi_status = 'a', '정상 회원', if(mi_status = 'b', " + 
"'휴면 계정', '탈퇴 회원')) status from t_member_info";

try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement(
		ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	// ResultSet 내에서 커서의 위치를 자유롭게 이동시킬 수 있는 Statement 생성
	rs = stmt.executeQuery(sql);

} catch(Exception e) {
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
if (rs.next()) {	// rs에 데이터가 있으면
	int num = 1;
	do {
%>
<tr align="center">
<td><%=num %></td><td><%=rs.getString("mi_id") %></td>
<td><%=rs.getString("mi_name") %></td><td><%=rs.getString("gender") %></td>
<td><%=rs.getString("birth") %></td><td><%=rs.getString("pnt") %></td>
<td><%=rs.getString("mi_joindate") %></td><td><%=rs.getString("status") %></td>
</tr>
<%
		num++;
	} while (rs.next());

	out.println("<tr><td colspan='8' bgcolor='#c1c1c1'></td></tr>");

	while (rs.previous()) {
%>
<tr align="center">
<td><%=num %></td><td><%=rs.getString("mi_id") %></td>
<td><%=rs.getString("mi_name") %></td><td><%=rs.getString("gender") %></td>
<td><%=rs.getString("birth") %></td><td><%=rs.getString("pnt") %></td>
<td><%=rs.getString("mi_joindate") %></td><td><%=rs.getString("status") %></td>
</tr>
<%
		num++;
	}

	out.println("<tr><td colspan='8' bgcolor='#c1c1c1'></td></tr>");

	rs.absolute(3);	// ResultSet에서 3번째 레코드로 커서를 이동시킴
	// 행번호를 잘못 입력하면 "After end of result set" 오류 발생
%>
<tr align="center">
<td><%=num %></td><td><%=rs.getString("mi_id") %></td>
<td><%=rs.getString("mi_name") %></td><td><%=rs.getString("gender") %></td>
<td><%=rs.getString("birth") %></td><td><%=rs.getString("pnt") %></td>
<td><%=rs.getString("mi_joindate") %></td><td><%=rs.getString("status") %></td>
</tr>
<%
} else {			// rs에 데이터가 없으면
	out.println("<tr><td colspan='8' align='center'>");
	out.println("결과가 없습니다.</td></tr>");
}
%>
</table>
</body>
</html>
<%
try {
	rs.close();		stmt.close();	conn.close();
} catch(Exception e) {
	e.printStackTrace();
}
%>
