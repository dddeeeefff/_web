<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String kind = request.getParameter("kind");
String subject = "등록";
String action = "notice_proc_in.jsp";
String ctgr = "", title = "", content = "", isview = "n";
int idx = 0;	// 글번호를 저장할 변수로 '수정'일 경우에만 사용
int cpage = 1;	// 페이지 번호를 저장할 변수로 '수정'일 경우에만 사용
String schtype = request.getParameter("schtype");	// 검색조건
String keyword = request.getParameter("keyword");	// 검색어
String args = ""; // 쿼리스트링(페이지 번호와 검색조건)을 저장할 변수
if (schtype != null && !schtype.equals("") && 
	keyword != null && !keyword.equals("")) {	// 검색조건이 있으면
	args = "&schtype=" + schtype + "&keyword=" + keyword;
	// 링크에 검색 관련 값들을 쿼리스트링으로 연결해줌
}

if (kind.equals("up")) {	// 글 수정폼일 경우
	subject = "수정";
	cpage = Integer.parseInt(request.getParameter("cpage"));
	idx = Integer.parseInt(request.getParameter("idx"));
	// 페이지 번호와 글번호 모두 글 수정시 필수 사항이므로 int형으로 변환하여 받음
	action = "notice_proc_up.jsp?cpage=" + cpage + args;
	
	try {
		stmt = conn.createStatement();
		sql = "select * from t_bbs_notice where bn_idx = " + idx;
		rs = stmt.executeQuery(sql);
		if (rs.next()) {
			ctgr = rs.getString("bn_ctgr");
			title = rs.getString("bn_title");
			content = rs.getString("bn_content");
			isview = rs.getString("bn_isview");
		} else {
			out.println("<script>");
			out.println("alert('존재하지 않는 게시물입니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
	
	} catch(Exception e) {
		out.println("공지사항 글수정폼에서 문제가 발생했습니다.");
		e.printStackTrace();
	} finally {
		try {
			rs.close();		stmt.close();
		} catch(Exception e) { e.printStackTrace(); }
	}
}
%>
<h2>공지사항 글 <%=subject %> 폼</h2>
<form name="frm" action="<%=action %>" method="post">
<% if (kind.equals("up")) { %>
<input type="hidden" name="idx" value="<%=idx %>" />
<%
}
%>
<table width="600" cellpadding="5">
<tr>
<th width="15%">글 제목</th>
<td width="*">
	<select name="bn_ctgr">
		<option <% if (ctgr.equals("공지")) { %>selected="selected"<% } %>>공지</option>
		<option <% if (ctgr.equals("이벤트")) { %>selected="selected"<% } %>>이벤트</option>
		<option <% if (ctgr.equals("보도자료")) { %>selected="selected"<% } %>>보도자료</option>
	</select>
	<input type="text" name="bn_title" size="50" value="<%=title %>" />
</td>
</tr>
<tr>
<th>글 내용</th>
<td>
	<textarea name="bn_content" rows="10" cols="65"><%=content %></textarea>
	현재 <%=subject %>하는 공지글을
	<input type="radio" name="bn_isview" id="viewN" value="n" 
	<% if (isview.equals("n")) { %>checked="checked"<% } %> />
	<label for="viewN">미게시</label>
	<input type="radio" name="bn_isview" id="viewY" value="y" 
	<% if (isview.equals("y")) { %>checked="checked"<% } %> />
	<label for="viewY">게시</label>
	하겠습니다.
</td>
</tr>
<tr><td colspan="2" align="center">
	<input type="submit" value="글 <%=subject %>" />
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="reset" value="다시 입력" />
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" value="글목록" 
	onclick="location.href='notice_list.jsp?cpage=<%=cpage + args %>';" />
</td></tr>
</table>
</form>
<%@ include file="../_inc/inc_foot.jsp" %>
