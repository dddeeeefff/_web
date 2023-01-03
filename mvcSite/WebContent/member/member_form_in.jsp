<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
LocalDate today = LocalDate.now();	// 오늘 날짜
int cyear = today.getYear();
int cmonth = today.getMonthValue();
int cday = today.getDayOfMonth();
int last = today.lengthOfMonth();

String[] arrDomain = {"naver.com", "nate.com", "gmail.com" };
%>
<style>
#agreement { width:400px; height:100px; overflow:auto; }
</style>
<script src="../js/date_change.js"></script>
<script>
$(document).ready(function() {
	$("#e2").change(function() {
		if ($(this).val() == ""){
			$("#e3").val("");
		} else if ($(this).val() == "direct") {
			$("#e3").val("");
			$("#e3").focus();
		} else {
			$("#e3").val($(this).val());
		}
	});
});
</script>
<h2>회원 가입 폼</h2>
<form name="frmJoin" action="member_proc_in" method="post">
<div id="agreement">
약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 <br /> 약관 내용 약관 내용 약관 내용 약관 내용 <br />
약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 <br /> 약관 내용 약관 내용 약관 내용 약관 내용 <br />
약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 <br /> 약관 내용 약관 내용 약관 내용 약관 내용 <br />
약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 <br /> 약관 내용 약관 내용 약관 내용 약관 내용 <br />
약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 <br /> 약관 내용 약관 내용 약관 내용 약관 내용 <br />
약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 <br /> 약관 내용 약관 내용 약관 내용 약관 내용 <br />
약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 <br /> 약관 내용 약관 내용 약관 내용 약관 내용 <br />
약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 <br /> 약관 내용 약관 내용 약관 내용 약관 내용 <br />
약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 <br /> 약관 내용 약관 내용 약관 내용 약관 내용 <br />
약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 <br /> 약관 내용 약관 내용 약관 내용 약관 내용 <br />
약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 <br /> 약관 내용 약관 내용 약관 내용 약관 내용 <br />
약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 <br /> 약관 내용 약관 내용 약관 내용 약관 내용 <br />
약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 <br /> 약관 내용 약관 내용 약관 내용 약관 내용 <br />
약관 내용 약관 내용 약관 내용 약관 내용 약관 내용 <br /> 약관 내용 약관 내용 약관 내용 약관 내용 <br />
</div>
<input type="radio" name="agree" value="y" id="agreeY" />
<label for="agreeY">동의함</label>
<input type="radio" name="agree" value="n" id="agreeN" />
<label for="agreeY">동의 안함</label>
<hr />
<div id="joinForm">
	<label id="mi_id">아이디 : </label>
	<input type="text" name="mi_id" id="mi_id" maxlength="20" />
	아이디는 4~20자로 입력하세요.
	<br />
	<label id="mi_pw">암호</label>
	<input type="password" name="mi_pw" id="mi_pw" maxlength="20" />
	<br />
	<label id="mi_name">이름</label>
	<input type="text" name="mi_name" id="mi_name" maxlength="20" />
	<br />성별
	<input type="radio" name="mi_gender" id="genderM" checked="checked" />
	<label for="genderM">남자</label>
	<input type="radio" name="mi_gender" id="genderF" checked="checked" />
	<label for="genderF">여자</label>
	<br />생년월일 : 
	<select name="by" onchange="resetday(this.value, this.form.bm.value, this.form.bd);">
<!-- 1930년 부터 올 해까지 option 지정 -->
	<% for (int i = 1930; i <= cyear; i++) { %>
			<option <% if (i == cyear) { %> selected="selected" <% } %>><%=i %></option>
	<% } %>
	</select>년
	<select name="bm" onchange="resetday(this.form.by.value, this.value, this.form.bd);">
<!-- 1월부터 12월까지 option 지정 -->
	<% for (int i = 1; i <= 12; i++) { 
			String bm = i + "";
			if (i < 10) bm = "0" + i;
	%>
			<option <% if (i == cmonth) { %> selected="selected" <% } %>><%=bm %></option>
	<% } %>
	</select>월
	<select name="bd">
<!-- 1일부터 31일까지 option 지정 -->
	<% for (int i = 1; i <= last; i++) { 
			String bd = i + "";
			if (i < 10) bd = "0" + i;
	%>
			<option <% if (i == cday) { %> selected="selected" <% } %>><%=bd %></option>
	<% } %>
	</select>일<br />
	 휴대폰 : 
	 <select name="p1">
	 	<option>010</option>
	 	<option>011</option>
	 	<option>016</option>
	 	<option>019</option>
	 </select> - 
	 <input type="text" name="p2" size="4" maxlength="4" /> - 
	 <input type="text" name="p3" size="4" maxlength="4" />
	 <br />
	 이메일 : 
	 <input type="text" name="e1" size="10" /> @
	 <select name="e2" id="e2">
	 	<option value="">도메인 선택</option>
<% for (int i = 0; i < arrDomain.length; i++) { %>
		<option value="<%=arrDomain[i] %>"><%=arrDomain[i] %></option>
<% } %>
		<option value="direct">직접 입력</option>
	 </select>
	 <input type="text" name="e3" id="e3" size="10" />
	 <br /><hr />
	 우편번호 : <input type="text" name="ma_zip" size="5" maxlength="5" /><br />
	 주소1 : <input type="text" name="ma_addr1" size="40" />
	 주소2 : <input type="text" name="ma_addr2" size="40" />
	 <br /><hr />
	 <input type="submit" value="회원 가입" />
</div>
</form>
</body>
</html>