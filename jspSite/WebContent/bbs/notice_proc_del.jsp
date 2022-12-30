<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
int idx = Integer.parseInt(request.getParameter("idx"));

try {
	stmt = conn.createStatement();
	sql = "update t_bbs_notice set bn_isview = 'n' where bn_idx = "	+ idx;
//	System.out.println(sql);
	int result = stmt.executeUpdate(sql);
	if (result == 1) {
		response.sendRedirect("notice_list.jsp");
	} else {
		out.println("<script>");
		out.println("alert('공지 글 삭제에 실패했습니다.\n다시 시도하세요.');");
		out.println("history.back();");
		out.println("</script>");
		out.close();
	}

} catch(Exception e) {
	out.println("공지사항 삭제시 문제가 발생했습니다.");
	e.printStackTrace();
}
%>
<%@ include file="../_inc/inc_foot.jsp" %>
