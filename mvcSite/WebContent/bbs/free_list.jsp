<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
ArrayList<BbsFree> freeList = (ArrayList<BbsFree>)request.getAttribute("freeList");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
int bsize = pageInfo.getBsize(), cpage = pageInfo.getCpage();
int pcnt = pageInfo.getPcnt(), psize = pageInfo.getPsize();
int rcnt = pageInfo.getRcnt(), spage = pageInfo.getSpage();
String schtype = pageInfo.getSchtype();
String keyword = pageInfo.getKeyword();

String schargs = "", args = "";
if (schtype != null && schtype.equals("") && 
	keyword != null && keyword.equals("")){
// 검색조건(schtype)과 검색어(keyword)가 있으면 검색관련 쿼리스트링 생성
	schargs = "&schtype=" + schtype + "&keyword=" + keyword;
}
args = "&cpage=" + cpage + schargs;
%>
<style>
#list tr { height:30px; }
#list th, #list td { padding:8px 3px; }
#list th { border-bottom: double black 3px; }
#list td { border-bottom: double black 1px; }
</style>
<h2>자유 게시판 목록</h2>
<table width="700" cellpadding="0" cellspacing="0" id="list">
<tr>
<th width="10%">번호</th><th width="*">제목</th>
<th width="15%">작성자</th><th width="15%">작성일</th>
<th width="10%">조회</th>
</tr>
<%
if (freeList.size() > 0) {	// 게시글 목록이 있으면
	int num = rcnt - (psize * (cpage- 1));
	for (int i = 0; i < freeList.size(); i++) {
		BbsFree bf = freeList.get(i);
		String title = bf.getBf_title();
		if (title.length() > 30)
			title = title.substring(0, 27) + "...";
		title = "<a href='free_view?bfidx=" + bf.getBf_idx() + 
				args + "'>" + title + "</a>";
		if (bf.getBf_reply() > 0)
			title += " [" + bf.getBf_reply() + "]";
	
%>
<tr align="center">
<td><%=num %></td><td align="left">&nbsp;&nbsp;<%=title %></td>
<td><%=bf.getBf_writer() %></td><td><%=bf.getBf_date() %></td>
<td><%=bf.getBf_read() %></td>
</tr>
<%
		num--;
	}
} else {	// 게시글 목록이 없으면
	out.print("<tr><td colspan='5' align='center'>");
	out.println("검색 결과가 없습니다.</td></tr>");
}
%>
</table>
<br />
<table width="700" cellpadding="5">
<tr>
<td width="600">
<%
if (rcnt > 0) {	// 게시글이 있으면 - 페이징 영역을 보여줌
	String lnk = "free_list?cpage=";
	pcnt = rcnt / psize;
	if (rcnt % psize > 0)	pcnt++;	// 전체 페이지 수(마지막 페이지 번호)
	
	if (cpage == 1){
		out.println("[처음]&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;&nbsp;");
	} else{
		out.println("<a href='" + lnk + 1 + schargs + "'>[처음]</a>&nbsp;&nbsp;&nbsp;");
		out.println("<a href='" + lnk + (cpage - 1) + schargs + "'>[이전]</a>&nbsp;&nbsp;");
	}
	
	spage = (cpage - 1) / bsize * bsize + 1;	// 현재 블록에서의 시작 페이지 번호
	for (int i = 1, j = spage; i <= bsize && j <= pcnt; i++, j++) {
	// i : 블록에서 보여줄 페이지의 개수만큼 루프를 돌릴 조건으로 사용되는 변수
	// j : 실제 출력 페이지 번호로 전체 페이지 개수(마지막 페이지 번호)를 넘지 않게 사용해야 함
		if (cpage == 1) {
			out.println("&nbsp;<strong>" + j + "</strong>&nbsp;");
		} else {
			out.println("&nbsp;<a href='" + lnk + j + schargs + "'>");
			out.println(j + "&nbsp;");
		}
	}
	
	if (cpage == pcnt){
		out.println("&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]&nbsp;&nbsp;&nbsp;");
	} else{
		out.println("&nbsp;&nbsp;<a href='" + lnk + (cpage + 1) + schargs + "'>[다음]</a>");
		out.println("&nbsp;&nbsp;&nbsp;<a href='" + lnk + pcnt + schargs + "'>[마지막]</a>");
	}
	
	
} 
%>
</td>
<td width="*">
	<input type="button" value="글등록" />
</td>
</tr>
<tr><td colspan="2">
	<form name="frmSch" method="get">
	<fieldset>
		<legend>게시판 검색</legend>
		<select name="schtype">
			<option value="">검색조건</option>
			<option value="title" 
			<% if(schtype.equals("title")) { %>selected="selected"<% } %>>제목</option>
			<option value="content" 
			<% if(schtype.equals("content")) { %>selected="selected"<% } %>>내용</option>
			<option value="tc" 
			<% if(schtype.equals("tc")) { %>selected="selected"<% } %>>제목+내용</option>
		</select>
		<input type="text" name="keyword" value="<%=keyword %>" />
		<input type="submit" value="검색" />
		<input type="button" value="전체 글" onclick="location.href='free_list'" />
	</fieldset>
	</form>
</td></tr>
</table>
</body>
</html>