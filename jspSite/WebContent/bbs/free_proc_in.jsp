<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String bf_writer = request.getParameter("bf_writer");
String bf_pw = request.getParameter("bf_pw");
String bf_header = request.getParameter("bf_header");
String bf_title = getRequest(request.getParameter("bf_title"));
String bf_content = getRequest(request.getParameter("bf_content"));
String bf_ismem = "n";
String bf_ip = request.getRemoteAddr();

if (login_info != null) {	// 현재 로그인이 되어 있다면(회원이 작성하는 글일 경우)
	bf_writer = login_info.getMi_id();
	bf_pw = "";
	bf_ismem = "y";
} else {
	bf_writer = getRequest(bf_writer);
	bf_pw = getRequest(bf_pw);
}

try {
	stmt = conn.createStatement();
	int idx = 1;	// 등록할 게시글의 글번호를 저장할 변수
	sql = "select max(bf_idx) + 1 from t_bbs_free";
	rs = stmt.executeQuery(sql);
	if (rs.next())	idx = rs.getInt(1);
	// 쿼리의 결과가 있으면 그 값을 글번호로 사용
	
	sql = "insert into t_bbs_free (bf_idx, bf_ismem, bf_writer, " + 
	"bf_pw, bf_header, bf_title, bf_content, bf_ip) value (" + 
	idx + ", '" + bf_ismem + "', '" + bf_writer + "', '" + bf_pw + 
	"', '" + bf_header + "', '" + bf_title + "', '" + bf_content + 
	"', '" +  bf_ip + "')";

//	System.out.println(sql);
	int result = stmt.executeUpdate(sql);
	if (result == 1) {
		response.sendRedirect("free_view.jsp?cpage=1&idx=" + idx);
	} else {
		out.println("<script>");
		out.println("alert('게시 글 등록에 실패했습니다.\n다시 시도하세요.');");
		out.println("history.back();");
		out.println("</script>");
		out.close();
	}

} catch(Exception e) {
	out.println("게시글 등록시 문제가 발생했습니다.");
	e.printStackTrace();
}
%>
<%@ include file="../_inc/inc_foot.jsp" %>
