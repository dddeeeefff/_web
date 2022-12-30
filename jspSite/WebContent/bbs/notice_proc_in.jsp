<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String bn_ctgr = request.getParameter("bn_ctgr");
String bn_title = getRequest(request.getParameter("bn_title"));
String bn_content = getRequest(request.getParameter("bn_content"));
String bn_isview = request.getParameter("bn_isview");

try {
	stmt = conn.createStatement();
	int idx = 1;	// 등록할 게시글의 글번호를 저장할 변수
	sql = "select max(bn_idx) + 1 from t_bbs_notice";
	rs = stmt.executeQuery(sql);
	if (rs.next())	idx = rs.getInt(1);
	// 쿼리의 결과가 있으면 그 값을 글번호로 사용
	
	sql = "insert into t_bbs_notice (bn_idx, bn_ctgr, ai_idx, bn_title, " + 
	"bn_content, bn_isview) values (" + idx + ", '" + 	bn_ctgr + 
	"', 1, '" + bn_title + "', '" + bn_content + "', '" + bn_isview + "')";
//	System.out.println(sql);
	int result = stmt.executeUpdate(sql);
	if (result == 1) {
		response.sendRedirect("notice_view.jsp?cpage=1&idx=" + idx);
	} else {
		out.println("<script>");
		out.println("alert('공지 글 등록에 실패했습니다.\n다시 시도하세요.');");
		out.println("history.back();");
		out.println("</script>");
		out.close();
	}

} catch(Exception e) {
	out.println("공지사항 등록시 문제가 발생했습니다.");
	e.printStackTrace();
}
%>
<%@ include file="../_inc/inc_foot.jsp" %>
