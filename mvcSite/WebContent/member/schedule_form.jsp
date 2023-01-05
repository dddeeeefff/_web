<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
CalendarInfo ci = (CalendarInfo)request.getAttribute("ci");
// 일정에 대한 일시가 들어있는 Calendar형 인스턴스를 받아옴
int y = ci.getsYear();	int m = ci.getsMonth();
int d = ci.getsDay();	int e = ci.getLastDay();

String kind = request.getParameter("kind");
int idx = 0;
String msg = "등록", sh = "", sn = "", content = "";
if (kind.equals("up")) {
	msg = "수정";
}

int minYear = 1990, maxYear = ci.getcYear() + 10;
//연도 선택의 최소값과 최대값
%>
<script src="/mvcSite/js/date_change.js"></script>
<h2>일정 <%=msg %> 폼</h2>
<form name="frm" action="schedule_proc.sch" method="post">
<input type="hidden" name="idx" value="<%=idx %>" />
<input type="hidden" name="kind" value="<%=kind %>" />
<input type="hidden" name="si_date" id="si_date" value="" />
<input type="hidden" name="si_time" id="si_time" value="" />
<table width="500" cellpadding="5">
<tr>
<th width="15%">일시</th>
<td width="*">
	<select name="y" 
	onchange="resetday(this.value, this.form.m.value, this.form.d);">
<% for (int i = minYear ; i <= maxYear ; i++) { %>
		<option <% if (i == y) { %>selected="selected"<% } %>><%=i %></option>
<% } %>
	</select>년&nbsp;&nbsp;
	<select name="m" 
	onchange="resetday(this.form.y.value, this.value, this.form.d);">
<%
for (int i = 1 ; i <= 12 ; i++) {
	String mm = (i < 10) ? "0" + i : "" + i;
%>
		<option <% if (i == m) { %>selected="selected"<% } %>><%=mm %></option>
<% } %>
	</select>월&nbsp;&nbsp;
	<select name="d">
<%
for (int i = 1 ; i <= e ; i++) {
	String dd = (i < 10) ? "0" + i : "" + i;
%>
		<option <% if (i == d) { %>selected="selected"<% } %>><%=dd %></option>
<% } %>
	</select>일&nbsp;&nbsp;&nbsp;&nbsp;
	<select name="h">
<%
for (int i = 0 ; i <= 23 ; i++) {
	String hh = (i < 10) ? "0" + i : "" + i;
%>
		<option <% if (sh.equals(hh)) { %>selected="selected"<% } %>><%=hh %></option>
<% } %>
	</select>시&nbsp;&nbsp;
	<select name="n">
<%
for (int i = 0 ; i <= 59 ; i++) {
	String nn = (i < 10) ? "0" + i : "" + i;
%>
		<option <% if (sn.equals(nn)) { %>selected="selected"<% } %>><%=nn %></option>
<% } %>
	</select>분
</td>
</tr>
<tr>
<th>내용</th>
<td><textarea name="content" rows="5" cols="45"><%=content %></textarea></td>
</tr>
<tr><td colspan="2" align="center">
	<input type="submit" value="일정 <%=msg %>" />
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" value="취소" onclick="history.back();" />
</td></tr>
</table>
</form>
</body>
</html>
