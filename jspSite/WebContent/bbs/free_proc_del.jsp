<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
int idx = Integer.parseInt(request.getParameter("idx"));
String bf_pw = request.getParameter("bf_pw");
String bf_ismem = request.getParameter("ismem");

String where = " where bf_isdel = 'n' and bf_idx = " + idx;
if (bf_ismem != null && bf_ismem.equals("n")){	// 비회원이 작성한 글일 경우
	where += " and bf_pw = '" + bf_pw + "' ";
} else {	// 회원이 작성한 글일 경우
	where += " and bf_writer = '" + login_info.getMi_id() + "' ";
}

try {
	stmt = conn.createStatement();
	sql = "update t_bbs_free set bf_isdel = 'y' " + where;
//	System.out.println(sql);
	int result = stmt.executeUpdate(sql);
	out.println("<script>");
	if (result == 1) {
		out.println("location.replace('free_list.jsp');");
	} else {
		out.println("alert('게시 글 삭제에 실패했습니다.\\n다시 시도하세요.');");
		out.println("history.back();");
	}
	out.println("</script>");
	out.close();

} catch(Exception e) {
	out.println("게시글 삭제시 문제가 발생했습니다.");
	e.printStackTrace();
}
%>
<%@ include file="../_inc/inc_foot.jsp" %>
