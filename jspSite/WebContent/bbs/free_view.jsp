<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
int cpage = Integer.parseInt(request.getParameter("cpage"));
int idx = Integer.parseInt(request.getParameter("idx"));
String schtype = request.getParameter("schtype");	// 검색조건
String keyword = request.getParameter("keyword");	// 검색어
String args = "?cpage=" + cpage; // 쿼리스트링(페이지 번호와 검색조건)을 저장할 변수
if (schtype != null && !schtype.equals("") && 
	keyword != null && !keyword.equals("")) {	// 검색조건이 있으면
	args += "&schtype=" + schtype + "&keyword=" + keyword;
	// 링크에 검색 관련 값들을 쿼리스트링으로 연결해줌
}

// view 화면에서 보여줄 게시글의 정보들을 저장할 변수들
String ismem = "", writer = "", header = "", title = "";
String content = "", ip = "", date = "";
int reply = 0, read = 0;

try {
	stmt = conn.createStatement();
	sql = "update t_bbs_free set bf_read = bf_read + 1 " + 
		" where bf_idx = " + idx;
	stmt.executeUpdate(sql);	// 조회수 증가 쿼리 실행
	
	sql = "select * from t_bbs_free where bf_idx = " + idx;
	rs = stmt.executeQuery(sql);
	if (rs.next()) {
		ismem = rs.getString("bf_ismem");
		writer = rs.getString("bf_writer");
		header = rs.getString("bf_header");
		title = rs.getString("bf_title");
		content = rs.getString("bf_content").replace("\r\n", "<br />");
		// 엔터(\r\n)를 <br />태그로 변경하여 content변수에 저장
		ip = rs.getString("bf_ip").substring(0, 7) + "***.***";
		date = rs.getString("bf_date");
		read = rs.getInt("bf_read");
		reply = rs.getInt("bf_reply");
		
	} else {
		out.println("<script>");
		out.println("alert('존재하지 않는 게시물입니다.');");
		out.println("history.back();");
		out.println("</script>");
		out.close();
	}

} catch(Exception e) {
	out.println("자유게시판 글보기시 문제가 발생했습니다.");
	e.printStackTrace();
} finally {
	try {
		rs.close();		stmt.close();
	} catch(Exception e) { e.printStackTrace(); }
}
%>
<h2>자유게시판 글 보기</h2>
<table width="600" cellpadding="5">
<tr>
<th width="10%">작성자</th>
<td width="13%"><%=(ismem.equals("y")) ? writer.substring(0, 4) + "***" : writer %></td>
<th width="10%">작성일</th>
<td width="19%"><%=date %></td>
<th width="10%">조회수</th>
<td width="7%"><%=read %> 회</td>
</tr>
<tr><th>글 제목</th><td colspan="5">[<%=header %>] <%=title %></td></tr>
<tr><th>글 내용</th><td colspan="5"><%=content %></td></tr>
<tr><td colspan="4" align="center">
<%
boolean isPms = false;	// 수정과 삭제 버튼을 현 사용자에게 보여줄지 여부를 저장할 변수
String upLink = "", delLink = "";	// 수정과 삭제용 링크를 저장할 변수
if (ismem.equals("n")) {	// 현재 글이 비회원 글일 경우
	isPms = true;
	upLink = "free_form_pw.jsp" + args + "&kind=up&idx=" + idx;
	delLink = "free_form_pw.jsp" + args + "&kind=del&idx=" + idx;
} else {	// 현재 글이 회원 글일 경우
	// 현재 로그인한 사람이 작성자인지 여부
	if (login_info != null && writer.equals(login_info.getMi_id())) {
		isPms = true;
		upLink = "free_form.jsp" + args + "&kind=up&idx=" + idx;
		delLink = "free_proc_del.jsp?idx=" + idx;
	}
}

if (isPms) {
%>
	<input type="button" value="글수정" 
	onclick="location.href='<%=upLink %>';" />
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<script>
function isDel() {
	if (confirm("정말 삭제하시겠습니까?")) {
		location.href="<%=delLink %>";
	}
}
</script>
	<input type="button" value="글삭제" onclick="isDel();" />
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%
}
%>
	<input type="button" value="글목록" 
	onclick="location.href='free_list.jsp<%=args %>';" />
</td></tr>
</table>
<%@ include file="../_inc/inc_foot.jsp" %>
