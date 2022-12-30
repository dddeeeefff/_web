<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
int cpage = 1, psize = 10, bsize = 10, rcnt = 0, pcnt = 0;
//현재 페이지 번호, 페이지 크기, 블록 크기, 레코드(게시글) 개수, 페이지 개수 등을 저장할 변수

if (request.getParameter("cpage") != null)
	cpage = Integer.parseInt(request.getParameter("cpage"));

String schtype = request.getParameter("schtype");
String keyword = request.getParameter("keyword");
String schargs = "";
String where = " where bf_isdel = 'n' ";

if (schtype == null || keyword == null) {
	schtype = "";	keyword = "";
} else {
	keyword = keyword.trim().replace("'", "''");
	if (!schtype.equals("") && !keyword.equals("")) {
		URLEncoder.encode(keyword, "UTF-8");

		if (schtype.equals("tc")) {	// 검색조건이 '제목+내용'일 경우
			where += " and (bf_title like '%" + keyword + "%' " + 
			" or bf_content like '%" + keyword + "%') ";
		} else {
			where += " and bf_" + schtype + " like '%" + keyword + "%' ";
		}
		schargs = "&schtype=" + schtype + "&keyword=" + keyword;
		// 검색조건이 있을 경우 링크의 url에 붙일 쿼리스트링 완성
	}
}

try {
	stmt = conn.createStatement();
	
	sql = "select count(*) from t_bbs_free " + where;
	// 자유게시판 레코드의 개수(검색조건 포함)를 받아 올 쿼리
	rs = stmt.executeQuery(sql);
	rs.next();	rcnt = rs.getInt(1);
	
	pcnt = rcnt / psize;
	if (rcnt % psize > 0)	pcnt++;

	int start = (cpage - 1) * psize;
	sql = "select bf_idx, bf_writer, bf_header, bf_title, bf_reply, " + 
	" bf_read, if(curdate() = date(bf_date), mid(bf_date, 12, 5), " + 
	" replace(mid(bf_date, 6, 5), '-', '.')) wdate, bf_date " + 
	" from t_bbs_free " + where + " order by bf_idx desc " + 
	" limit " + start + ", " + psize;
	rs = stmt.executeQuery(sql);

} catch(Exception e) {
	out.println("자유게시판 글목록에서 문제가 발생했습니다.");
	e.printStackTrace();
}
%>
<h2>자유 게시판 목록</h2>
<table width="700" border="0" cellpadding="0" cellspacing="0" id="list">
<tr height="30">
<th width="7%">번호</th><th width="15%">분류</th><th width="*">제목</th>
<th width="15%">작성자</th><th width="10%">작성일</th><th width="7%">조회</th>
</tr>
<%
if (rs.next()) {
	int num = rcnt - (psize * (cpage - 1));
	do {
%>
<tr height="30" align="center">
<td><%=num %></td>
<td><%=rs.getString("bf_header") %></td>
<td align="left"><%=rs.getString("bf_title") %></td>
<td><%=rs.getString("bf_writer") %></td>
<td title="<%=rs.getString("bf_date")%>"><%=rs.getString("wdate")%></td>
<td><%=rs.getInt("bf_read") %></td>
</tr>
<%
		num--;
	} while(rs.next());

} else {	// 보여줄 게시글이 없을 경우
	out.print("<tr height='30'><td colspan='6' align='center'>");
	out.println("검색결과가 없습니다.</td></tr>");
}
%>
</table>
<br /><br /><br /><br /><br /><br />
<%@ include file="../_inc/inc_foot.jsp" %>
