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
	sql = "select bf_idx, bf_ismem, bf_writer, bf_header, bf_title, bf_reply, " + 
	" bf_read, if(curdate() = date(bf_date), mid(bf_date, 12, 5), " + 
	" replace(mid(bf_date, 6, 5), '-', '.')) wdate, bf_date " + 
	" from t_bbs_free " + where + " order by bf_idx desc " + 
	" limit " + start + ", " + psize;
	rs = stmt.executeQuery(sql);
	System.out.println(sql);

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
		int titleCnt = 24;
		String reply = "";
		if (rs.getInt("bf_reply") > 0) {	// 댓글이 있으면
			titleCnt = 21;
			reply = " [" + rs.getInt("bf_reply") + "]";
		}
		
		String title = rs.getString("bf_title");
		if (title.length() > titleCnt)
			title = title.substring(0, 21) + "...";
		title = "<a href='free_view.jsp?idx=" + rs.getInt("bf_idx") + 
		"&cpage=" + cpage + schargs + "'>" + title + "</a>" + reply;
		
		String writer = rs.getString("bf_writer");
		if (rs.getString("bf_ismem").equals("y"))
			writer = writer.substring(0, 4) + "***";
%>
<tr height="30" align="center">
<td><%=num %></td>
<td><%=rs.getString("bf_header") %></td>
<td align="left"><%=title %></td>
<td><%=writer %></td>
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
</table>
<br />
<table width="700" border="0" cellpadding="5">
<tr>
<td width="600">
<%
if (rcnt > 0) {	// 게시글이 있으면
	String link = "free_list.jsp?cpage=";
	if (cpage == 1) {
		out.println("[처음]&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;");
	} else {
		out.println("<a href='" + link + "1" + schargs + 
			"'>[처음]</a>&nbsp;&nbsp;&nbsp;");
		out.println("<a href='" + link + (cpage - 1) + schargs + 
			"'>[이전]</a>&nbsp;&nbsp;");
	}

	int spage = (cpage - 1) / bsize * bsize + 1;	// 블록 시작 페이지 번호
	for (int i = 1, j = spage ; i <= bsize && j <= pcnt ; i++, j++) {
	// i : 블록에서 보여줄 페이지의 개수만큼 루프를 돌릴 조건으로 사용되는 변수
	// j : 실제 출력할 페이지 번호로 전체 페이지 개수(마지막 페이지 번호)를 넘지 않게 할 변수
		if (cpage == j) {
			out.println("&nbsp;<strong>" + j + "</strong>&nbsp;");
		} else {
			out.println("&nbsp;<a href='" + 
			link + j + schargs + "'>" + j + "</a>&nbsp;");
		}
	}

	if (cpage == pcnt) {
		out.println("&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]");
	} else {
		out.println("&nbsp;&nbsp;<a href='" + link + 
			(cpage + 1) + schargs + "'>[다음]</a>");
		out.println("&nbsp;&nbsp;&nbsp;<a href='" + link + 
			pcnt + schargs + "'>[마지막]</a>");
	}
}
%>
</td>
<td width="*" align="right">
	<input type="button" value="글 등록" 
	onclick="location.href='free_form.jsp?kind=in';" />
</td>
</tr>
<tr><td colspan="2">
	<form name="frmSch">
	<fieldset>
		<legend>게시판 검색</legend>
		<select name="schtype">
			<option value="">검색 조건</option>
			<option value="title" <% if (schtype.equals("title")) { %>selected="selected"<% } %>>제목</option>
			<option value="content" <% if (schtype.equals("content")) { %>selected="selected"<% } %>>내용</option>
			<option value="writer" <% if (schtype.equals("writer")) { %>selected="selected"<% } %>>작성자</option>
			<option value="tc" <% if (schtype.equals("tc")) { %>selected="selected"<% } %>>제목+내용</option>
		</select>
		<input type="text" name="keyword" value="<%=keyword %>" />
		<input type="submit" value="검색" />&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="전체 글보기" 
		onclick="location.href='free_list.jsp';" />
	</fieldset>
	</form>
</td></tr>
</table>

<%@ include file="../_inc/inc_foot.jsp" %>
