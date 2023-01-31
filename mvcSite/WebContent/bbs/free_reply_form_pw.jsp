<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
int bfidx = Integer.parseInt(request.getParameter("bfidx"));
int bfridx = Integer.parseInt(request.getParameter("bfridx"));
%>
<h2>비밀번호 입력 폼</h2>
<form name="frmPw" action="free_reply_proc_del" method="post">
<input type="hidden" name="ismem" value="n" />
<input type="hidden" name="bfidx" value="<%=bfidx %>" />
<input type="hidden" name="bfridx" value="<%=bfridx %>" />
비밀번호 : <input type="password" name="pw" /><br />
<input type="submit" value="삭제" />
<input type="button" value="돌아가기" onclick="history.back();" />
</form>
</body>
</html>