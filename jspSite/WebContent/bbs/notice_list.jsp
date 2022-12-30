<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
int cpage = 1, psize = 3, bsize = 10, rcnt = 0, pcnt = 0;
// 현재 페이지 번호, 페이지 크기, 블록 크기, 레코드(게시글) 개수, 페이지 개수 등을 저장할 변수

if (request.getParameter("cpage") != null)
	cpage = Integer.parseInt(request.getParameter("cpage"));
// cpage 값이 있으면 int형으로 변환하여 받음(보안상의 이유와 산술연산을 해야 하기 때문)

String schtype = request.getParameter("schtype");	// 검색조건
String keyword = request.getParameter("keyword");	// 검색어
String schargs = "";	// 검색관련 쿼리스트링을 저장할 변수
String where = "";		// 검색 조건이 있을 경우 where절을 저장할 변수

if (schtype == null || keyword == null) {	// 검색을 하지 않은 경우
	schtype = "";	keyword = "";
} else {
	keyword = keyword.trim();
	if (!schtype.equals("") && !keyword.equals("")) {
	// 검색조건(schtype)과 검색어(keyword)가 있을 경우
		URLEncoder.encode(keyword, "UTF-8");
		// 쿼리스트링으로 주고 받는 검색어가 한글일 경우 IE에서 문제가 발생할 수 있으므로 유니코드로 변환
	
		if (schtype.equals("tc")) {	// 검색조건이 '제목+내용'일 경우
			where = " where bn_title like '%" + keyword + "%' " + 
			" or bn_content like '%" + keyword + "%' ";
		} else {
			where = " where bn_" + schtype + " like '%" + keyword + "%' ";
		}
		schargs = "&schtype=" + schtype + "&keyword=" + keyword;
		// 검색조건이 있을 경우 링크의 url에 붙일 쿼리스트링 완성
	}
}

try {
	stmt = conn.createStatement();
	
	sql = "select count(*) from t_bbs_notice " + where;
	// 검색된 레코드의 총 개수를 구하는 쿼리 : 페이지 개수를 구하기 위해
	rs = stmt.executeQuery(sql);
	rs.next();	rcnt = rs.getInt(1);
	// count() 함수를 사용하므로 ResultSet 안의 데이터 유무를 검사할 필요가 없음
	// if() 등의 제어문 없이 바로 next() 메소드를 사용
	// count() : 값이 없어도 null이 아닌 0을 리턴하는 함수로 값이 없는 경우가 없음
	
	pcnt = rcnt / psize;
	if (rcnt % psize > 0)	pcnt++;	// 전체 페이지 수

	int start = (cpage - 1) * psize;	// limit 절의 시작 인덱스 번호(0번 부터 시작)
	sql = "select bn_idx, bn_ctgr, bn_title, bn_read, bn_isview, " + 
	" if(curdate() = date(bn_date), mid(bn_date, 12, 5), " + 
	" mid(bn_date, 3, 8)) wdate, bn_date " + 
	" from t_bbs_notice " + where + " order by bn_idx desc " + 
	" limit " + start + ", " + psize;
	rs = stmt.executeQuery(sql);

} catch(Exception e) {
	out.println("공지사항 글목록에서 문제가 발생했습니다.");
	e.printStackTrace();
}
%>
<h2>공지사항 목록</h2>
<table width="700" border="0" cellpadding="0" cellspacing="0" id="list">
<tr height="30">
<th width="10%">번호</th><th width="15%">분류</th><th width="*">제목</th>
<th width="15%">작성일</th><th width="10%">조회</th>
</tr>
<%
if (rs.next()) {
	int num = rcnt - (psize * (cpage - 1));
	do {
		String title = rs.getString("bn_title");
		if (title.length() > 24)
			title = title.substring(0, 21) + "...";
		title = "<a href='notice_view.jsp?idx=" + rs.getInt("bn_idx") + 
		"&cpage=" + cpage + schargs + "'>" + title + "</a>";
%>
<tr height="30" align="center">
<td><%=num %></td>
<td><%=rs.getString("bn_ctgr") %></td>
<td align="left"><%=title %></td>
<td title="<%=rs.getString("bn_date")%>"><%=rs.getString("wdate")%></td>
<td><%=rs.getInt("bn_read") %></td>
</tr>
<%
		num--;
	} while(rs.next());

} else {	// 보여줄 게시글이 없을 경우
	out.print("<tr height='30'><td colspan='5' align='center'>");
	out.println("검색결과가 없습니다.</td></tr>");
}
%>
</table>
<br />
<table width="700" border="0" cellpadding="5">
<tr>
<td width="600">
<%
if (rcnt > 0) {	// 게시글이 있으면
	String link = "notice_list.jsp?cpage=";
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
	<input type="button" value="공지사항 등록" 
	onclick="location.href='notice_form.jsp?kind=in';" />
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
			<option value="tc" <% if (schtype.equals("tc")) { %>selected="selected"<% } %>>제목+내용</option>
		</select>
		<input type="text" name="keyword" value="<%=keyword %>" />
		<input type="submit" value="검색" />&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="전체 글보기" 
		onclick="location.href='notice_list.jsp';" />
	</fieldset>
	</form>
</td></tr>
</table>
<br /><br /><br /><br /><br /><br />
<%@ include file="../_inc/inc_foot.jsp" %>
