<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
int idx = Integer.parseInt(request.getParameter("idx"));
String bf_pw = request.getParameter("bf_pw");
String bf_ismem = request.getParameter("ismem");
String bf_header = request.getParameter("bf_header");
String bf_title = getRequest(request.getParameter("bf_title"));
String bf_content = getRequest(request.getParameter("bf_content"));

int cpage = Integer.parseInt(request.getParameter("cpage"));
String schtype = request.getParameter("schtype");
String keyword = request.getParameter("keyword");
String args = "?cpage=" + cpage + "&idx=" + idx; 
if (schtype != null && !schtype.equals("") && 
	keyword != null && !keyword.equals("")) {
	args += "&schtype=" + schtype + "&keyword=" + keyword;
}

String where = " where bf_isdel = 'n' and bf_idx = " + idx;
if (bf_ismem.equals("n")){	// 비회원이 작성한 글일 경우
	where += " and bf_pw = '" + bf_pw + "' ";
} else {	// 회원이 작성한 글일 경우
	where += " and bf_writer = '" + login_info.getMi_id() + "' ";		
}

try {
	stmt = conn.createStatement();
	sql = "update t_bbs_free set " + 
		  "bf_header = '"  + bf_header 		+ "', " +
		  "bf_title = '"   + bf_title 		+ "', " +
		  "bf_content = '" + bf_content 	+ "' "  + where;
//	System.out.println(sql);
	int result = stmt.executeUpdate(sql);
	out.println("<script>");
	if (result == 1) {
		out.println("location.replace('free_view.jsp" + args + "');");
	} else {
		out.println("alert('게시 글 수정에 실패했습니다.\\n다시 시도하세요.');");
		out.println("history.back();");
	}
	out.println("</script>");
	out.close();

} catch(Exception e) {
	out.println("게시글 수정시 문제가 발생했습니다.");
	e.printStackTrace();
}
%>
<%@ include file="../_inc/inc_foot.jsp" %>
