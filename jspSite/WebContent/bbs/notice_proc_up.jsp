<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../_inc/inc_head.jsp" %>

<%
request.setCharacterEncoding("utf-8");
int cpage = Integer.parseInt(request.getParameter("cpage"));
int idx = Integer.parseInt(request.getParameter("idx"));
String bn_ctgr = request.getParameter("bn_ctgr");
String bn_title = getRequest(request.getParameter("bn_title"));
String bn_content = getRequest(request.getParameter("bn_content"));

try{
	stmt = conn.createStatement();
	
	
	sql = "update t_bbs_notice " + 
	" bn_ctgr = '"		+	bn_ctgr	 + "', " +
	" bn_title = '"		+	bn_title	 + "', " +
	" bn_content = '"	+	bn_content	 + "' " +
	" where bn_dx = " 	+ idx;
	// System.out.println(sql);
	int result = stmt.executeUpdate(sql);
	if (result == 1){
		response.sendRedirect("notice_view.jsp?cpage=" + cpage + "&idx=" + idx);
		
	}else {
		out.println("<script>");
		out.println("alert('공지 글 수정에 실패했습니다. \n다시 시도하세요.');");
		out.println("history.back();");
		out.println("</script>");
		out.close();
	}
	
}catch(Exception e){
	out.println("공지사항 수정시 문제가 발생했습니다.");
	e.printStackTrace();
}
%>

<%@ include file="../_inc/inc_foot.jsp" %>