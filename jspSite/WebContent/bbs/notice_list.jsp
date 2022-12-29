<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>

<h2>공지사항 목록</h2>
<table width="700" border="0" cellpadding="0" cellspacing="0" id="list">
<tr height="30">
<th width="10%">번호</th>
<th width="15%">분류</th>
<th width="*">제목</th>
<th width="15%">작성일</th>
<th width="10%">조회</th>
</tr>
</table>
<br />
<table width="700" border="0" cellpadding="5">
<tr>
<td width="600"><!-- 페이징 영역 --></td>
<td width="*" align="right">
	<input type="button" value="공지사항 등록" 
	onclick="location.href='notice_form.jsp?kind=in';" />
</td>
</tr>
<tr><td colspan="2">
	<!-- 검색 영역 -->
</td></tr>
</table>

<%@ include file="../_inc/inc_foot.jsp" %>