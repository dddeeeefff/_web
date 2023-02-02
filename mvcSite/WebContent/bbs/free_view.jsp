<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
BbsFree bf = (BbsFree)request.getAttribute("bf");

int bfidx = bf.getBf_idx();
int cpage = Integer.parseInt(request.getParameter("cpage"));
String args = "?cpage=" + cpage;	// 링크에서 사용할 쿼리스트링

String schtype = request.getParameter("schtype");
String keyword = request.getParameter("keyword");
if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) {
	args += "&schtype=" + schtype + "&keyword=" + keyword;
}
%>
<style>
.reList { width:700px; }
.reWriter { 
	width:700px; display:flex; padding:5px; 
	justify-content:space-between; border:1px solid black; 
	}
.reContent { 
	width:700px; padding:5px; border:1px solid black; 
	border-top:none; margin-bottom:5px;
}
</style>
<script>
function replyIn() {
// ajax를 이용한 댓글 등록 함수
	var writer = document.frmReply.writer.value;
	var pw = document.frmReply.pw.value;
	var content = document.frmReply.content.value;
	
<% if (!isLogin) { %>
	if (writer == "" || pw == "") {
		alert("작성자와 비밀번호 입력하세요.");
		document.frmReply.writer.focus();
		return;
	}
<% } %>	
	if (content != "") {
		$.ajax({
			type : "POST", url : "/mvcSite/free_reply_proc_in", 
			data : {"bfidx" : "<%=bfidx %>", "writer" : writer, "pw" : pw, "content" : content}, 
			success : function(chkRs) {
				if (chkRs == 0) {
					alert("댓글 등록에 실패했습니다.\n다시 시도해 보세요.");
				} else {
					location.reload();
				}
			}
		});
	} else {
		alert("댓글 내용을 입력하세요.");
		document.frmReply.content.focus();
	}
}

function replyDel(ismem, bfridx) {
	if (confirm("정말 삭제하시겠습니까?")) {
		if (ismem == 'n') {	// 삭제하려는 댓글이 비회원 글일 경우
			location.href = "free_reply_form_pw<%=args %>&bfidx=<%=bfidx %>&bfridx=" + bfridx;
		} else if (ismem == 'y') {	// 삭제하려는 댓글이 회원 글일 경우
			location.href = "free_reply_proc_del<%=args %>&ismem=y&bfidx=<%=bfidx %>&bfridx=" + bfridx;
		}
	}	
}

function replyGnb(gnb, bfridx) {
// ajax를 이용한 댓글 좋아요/싫어요 등록 함수
<% if (isLogin) { %>
	var msg = "좋아요";
	if (gnb == "b")	msg = "싫어요";
	$.ajax({
		type : "POST", url : "/mvcSite/free_reply_proc_gnb", 
		data : {"gnb" : gnb, "bfridx" : bfridx}, 
		success : function(chkRs) {
			if (chkRs == 2) {
//				location.reload();
				var a = parseInt($("#" + gnb + bfridx).text());
				$("#" + gnb + bfridx).text(a + 1);
			} else if (chkRs == -1) {
				alert("이미 참여했습니다.");
			} else {
				alert(msg + " 처리에 실패했습니다.\n다시 시도해 보세요.");
			}
		}
	});
<% } else { %>
	alert("로그인 후 사용하실 수 있습니다.");
<% } %>
}
</script>
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
<br /><hr align="left" width="700" /><br />
<p style="width:700px" align="center">
	<input type = "button" value="목록" onclick="location.href='free_list<%=args %>';" />
</p>
<br /><hr align="left" width="700" /><br />
<!-- 댓글 영역 시작 -->
<form name="frmReply">
<% if (!isLogin) { 	// 로그인을 하지 않은 상태면(비회원이면) %>
<table width="700" cellpadding="5">
<tr>
<th width="15%">작성자</th>
<td width="35%"><input type="text" name="writer" /></td>
<th width="15%">비밀번호</th>
<td width="35%"><input type="password" name="pw" /></td>
</tr>
</table>
<% } else { %>
<input type="hidden" name="writer" value="" />
<input type="hidden" name="pw" value="" />
<% } %>
<table width="700" cellpadding="5">
<tr>
<th width="10%">댓글</th>
<td width="*"><textarea name="content" rows="3" cols="70"></textarea></td>
<th width="20%"><input type="button" value="댓글 달기" onclick="replyIn();" /></th>
</tr>
</table>
</form>
<br /><hr align="left" width="700" /><br />
<%
ArrayList<BbsFreeReply> replyList = (ArrayList<BbsFreeReply>)request.getAttribute("replyList");
if (replyList.size() > 0) {	// 보여줄 댓글 목록이 있으면
	for (int i = 0 ; i < replyList.size() ; i++) {
		BbsFreeReply bfr = replyList.get(i);
		String writer = bfr.getBfr_writer();
		if (bfr.getBfr_ismem().equals("y"))	// 회원 댓글일 경우
			writer = writer.substring(0, 4) + "***";
		
		String lnkTu = "", lnkTd = "";	// 좋아요, 싫어요 링크
		if (isLogin) {	// 현재 사용자가 로그인을 한 상태이면
			lnkTu = "javascript:replyGnb('g', " + bfr.getBfr_idx() + ");";	// 좋아요 링크
			lnkTd = "javascript:replyGnb('b', " + bfr.getBfr_idx() + ");";	// 싫어요 링크
		} else {	// 로그인 전이면
			lnkTu = lnkTd = "javascript:alert('로그인 후 사용하실 수 있습니다.');";
		}
%>
<div class="reWriter">
	<%=writer %>&nbsp;&nbsp;&nbsp;&nbsp;<%=bfr.getBfr_date() %>
	<span>
		<a href="<%=lnkTu %>"><img src="img/thumbs-up.png" width="12" title="좋아요" /></a>
		<span id="g<%=bfr.getBfr_idx() %>"><%=bfr.getBfr_good() %></span>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="<%=lnkTd %>"><img src="img/thumbs-down.png" width="12" title="싫어요" /></a>
		<span id="b<%=bfr.getBfr_idx() %>"><%=bfr.getBfr_bad() %></span>
<%
		String lnkDel = "";
		boolean isDel = false;	// 삭제 버튼 보여주기 여부를 저장할 변수
		if (bfr.getBfr_ismem().equals("n")) {	// 비회원 글이면
			isDel = true;
			lnkDel = "javascript:replyDel('n', " + bfr.getBfr_idx() + ");";
		} else if (bfr.getBfr_ismem().equals("y") && loginInfo != null && 
				bfr.getBfr_writer().equals(loginInfo.getMi_id())) {
		// 회원글이면서 글쓴이가 현재 로그인한 회원이면
			isDel = true;
			lnkDel = "javascript:replyDel('y', " + bfr.getBfr_idx() + ");";
		}

if (isDel) {
%>
		&nbsp;&nbsp;&nbsp;&nbsp;<a href="<%=lnkDel %>"><img src="img/close.png" width="15" /></a>
<% } %>
	</span>
</div>
<div class="reContent"><xmp><%=bfr.getBfr_content() %></xmp></div>
<%
	}
	
} else {	// 보여줄 댓글 목록이 없으면
	out.println("<p class='reList' align='center'>아직 댓글이 없습니다.</p>");
}
%>
<!-- 댓글 영역 종료 -->
</body>
</html>
