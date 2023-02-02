<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
int bfidx = Integer.parseInt(request.getParameter("bfidx"));
int bfridx = Integer.parseInt(request.getParameter("bfridx"));
int cpage = Integer.parseInt(request.getParameter("cpage"));
String schtype = request.getParameter("schtype");
if (schtype == null || schtype.equals(""))	schtype="";
String keyword = request.getParameter("keyword");
if (keyword == null || keyword.equals(""))	keyword="";
%>
<h2>비밀번호 입력 폼</h2>
<form name="frmPw" action="free_reply_proc_del" method="post">
<input type="hidden" name="ismem" value="n" />
<input type="hidden" name="bfidx" value="<%=bfidx %>" />
<input type="hidden" name="bfridx" value="<%=bfridx %>" />
<input type="hidden" name="cpage" value="<%=cpage %>" />
<input type="hidden" name="schtype" value="<%=schtype %>" />
<input type="hidden" name="keyword" value="<%=keyword %>" />
비밀번호 : <input type="password" name="pw" /><br />
<input type="submit" value="삭제" />
<input type="button" value="돌아가기" onclick="history.back();" />
</form>
</body>
</html>