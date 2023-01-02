<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String kind = request.getParameter("kind");
int cpage = Integer.parseInt(request.getParameter("cpage"));
int idx = Integer.parseInt(request.getParameter("idx"));
String schtype = request.getParameter("schtype");	// 검색조건
String keyword = request.getParameter("keyword");	// 검색어


String action = "free_form.jsp";
if (kind.equals("del"))	action = "free_proc_del.jsp";

// 현재 게시글이 비회원 글이 맞는지 검사하는 영역
try{
	stmt = conn.createStatement();
	sql = "select 1 from t_bbs_free where bf_ismem = 'n' and bf_idx =" + idx;
	rs = stmt.executeQuery(sql);
	
	if (!rs.next()){	// rs에 데이터가 없으면(비회원글이 아니면)
		out.println("<script>");
		out.println("alert('잘못된 경로로 들어오셨습니다.'); history.back();");
		out.println("</script>");
		out.close();
	}
	
}catch(Exception e){
	out.println("자유게시판 비밀번호 입력 폼에서 문제가 발생했습니다.");
	e.printStackTrace();
} finally{
	try{
		rs.close();		stmt.close();
	}catch(Exception e){ e.printStackTrace(); }	
}
%>
<style>
#box { 
	width:200px; height:100px; margin:20px auto 0;
	border:1px solid black; text-align: center; font-size: 12px;
 }
 #bf_pw { margin-bottom: 10px; }
</style>
<h2 align = "center">비밀번호 입력 폼</h2>
<form name="frm" action="<%=action %>" method="post">
<input type="hidden" name="idx" value="<%=idx %>" />
<input type="hidden" name="kind" value="<%=kind %>" />
<input type="hidden" name="cpage" value="<%=cpage %>" />
<input type="hidden" name="ismem" value="n" />
<% if (schtype != null && !schtype.equals("") && 
keyword != null && !keyword.equals("")) { // 검색조건이 있으면 %>
<input type="hidden" name="schtype" value="<%=schtype %>" />
<input type="hidden" name="keyword" value="<%=keyword %>" />
<% } %>
<div id="box">
	<p>비밀번호를 입력하세요</p>
	<input type="password" name="bf_pw" id="bf_pw" />
	<input type="button" value="취소" onclick="history.back();" />
	&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="submit" value="확인" />
</div>
</form>
<script>
document.frm.bf_pw.focus();
</script>
<%@ include file="../_inc/inc_foot.jsp" %>