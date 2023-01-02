<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String kind = request.getParameter("kind");
String subject = "등록";
String action = "free_proc_in.jsp";

String ismem = request.getParameter("ismem");
// 비회원 글 수정일 경우에만 값(n)이 존재함
if (ismem == null)	ismem = "";

//수정 폼에서 보여줄 게시글의 기존 정보들을 저장할 변수들
String bf_pw = "", writer = "", header = "", title = "";
String content = "", ip = "", date = "";

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
	action = "free_proc_up.jsp";
	
	cpage = Integer.parseInt(request.getParameter("cpage"));
	idx = Integer.parseInt(request.getParameter("idx"));
	bf_pw = request.getParameter("bf_pw");
	if (bf_pw == null)	bf_pw = "";
	
	// 회원글과 비회원글의 각기 다른 where 절을 생성
	String where = " where bf_isdel = 'n' and bf_idx = " + idx;
	if (ismem.equals("n")){	// 비회원이 작성한 글일 경우
		where += " and bf_pw = '" + bf_pw + "' ";
	} else {	// 회원이 작성한 글일 경우
		where += " and bf_writer = '" + login_info.getMi_id() + "' ";		
	}
	sql = "select * from t_bbs_free " + where;
	try{
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		if (rs.next()){	// 게시글이 있으면
			writer = rs.getString("bf_writer");
			header = rs.getString("bf_header");
			title = rs.getString("bf_title");
			content = rs.getString("bf_content");			
		}else {	// 게시글이 없으면
			out.println("<script>");
			if (ismem.equals("n")) {
				out.println("alert('암호가 틀렸습니다. \\n다시 시도해 보세요.');");
			} else{
				out.println("alert('잘못된 경로로 들어오셨습니다.');");
			}
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
	}catch(Exception e){
		out.println("자유게시판 비밀번호 수정 폼에서 문제가 발생했습니다.");
		e.printStackTrace();
	}finally{
		try{
			rs.close();		stmt.close();
		}catch(Exception e){ e.printStackTrace(); }	
	}
}
%>
<h2>자유게시판 글 <%=subject %> 폼</h2>
<form name="frm" action="<%=action %>" method="post">
<% if (kind.equals("up")) { %>
<input type="hidden" name="idx" value="<%=idx %>" />
<input type="hidden" name="bf_pw" value="<%=bf_pw %>" />
<input type="hidden" name="ismem" value="<%=ismem %>" />
<input type="hidden" name="cpage" value="<%=cpage %>" />
<%
	if (schtype != null && !schtype.equals("") && 
		keyword != null && !keyword.equals("")) {
%>
<input type="hidden" name="schtype" value="<%=schtype %>" />
<input type="hidden" name="keyword" value="<%=keyword %>" />
<%
	}
}
%>
<table width="600" cellpadding="5">
<% if (kind.equals("in") && login_info == null) { // 게시글 등록이면서 비회원일 경우 %>
<tr>
<th width="15%">작성자</th>
<td width="35%"><input type="text" name="bf_writer" /></td>
<th width="15%">비밀번호</th>
<td width="35%"><input type	="password" name="bf_pw" /></td>
</tr>
<% } %>
<tr>
<th width="15%">글 제목</th>
<td colspan="3">
	<select name="bf_header">
		<option <% if (header.equals("국제")) { %>selected="selected"<% } %>>국제</option>
		<option <% if (header.equals("스포츠")) { %>selected="selected"<% } %>>스포츠</option>
		<option <% if (header.equals("사회")) { %>selected="selected"<% } %>>사회</option>
		<option <% if (header.equals("경제")) { %>selected="selected"<% } %>>경제</option>
		<option <% if (header.equals("연예")) { %>selected="selected"<% } %>>연예</option>
	</select>
	<input type="text" name="bf_title" size="50" value="<%=title %>" />
</td>
</tr>
<tr>
<th>글 내용</th>
<td colspan="3">
	<textarea name="bf_content" rows="10" cols="65"><%=content %></textarea>
	
</td>
</tr>
<tr><td colspan="4" align="center">
	<input type="submit" value="글 <%=subject %>" />
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="reset" value="다시 입력" />
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" value="글목록" 
	onclick="location.href='free_list.jsp?cpage=<%=cpage + args %>';" />
</td></tr>
</table>
</form>
<%@ include file="../_inc/inc_foot.jsp" %>
