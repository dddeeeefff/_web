<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
BbsFree bf = (BbsFree)request.getAttribute("bf");

int bfidx = bf.getBf_idx();
int cpage = Integer.parseInt(request.getParameter("cpage"));
String args = "?cpage=" + cpage;	// 링크에서 사용할 쿼리스트링 생성

String schtype = request.getParameter("schtype");
String keyword = request.getParameter("keyword");
if (schtype != null && schtype.equals("") && 
	keyword != null && keyword.equals("")){
	args = "&schtype=" + schtype + "&keyword=" + keyword;
}
%>
<h2>자유 게시판 글 보기</h2>
<table width="700" cellpadding="5">
<tr>
<th width="10%">작성자</th><td width="15%"><%=bf.getBf_writer() %></td>
<th width="10%">조회수</th><td width="10%"><%=bf.getBf_read() %></td>
<th width="10%">작성일</th><td width="*"><%=bf.getBf_date() %></td>
</tr>
<tr><th>제목</th><td colspan="5"><%=bf.getBf_title() %></td></tr>
<tr><th>내용</th><td colspan="5"><%=bf.getBf_content().replaceAll("\r\n", "<br />") %></td></tr>
</table>
</body>
</html>