<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
String[] arrPhone = loginInfo.getMi_phone().split("-");
String email = loginInfo.getMi_email();
String eid = email.substring(0, email.indexOf('@'));
String domain = email.substring(email.indexOf('@') + 1);
String[] arrDomain = {"naver.com", "nate.com", "gmail.com" };
%>

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
<h2>회원 수정 폼</h2>
<form name="frmJoin" action="member_proc_up" method="post">
<div id="joinForm">
	아이디 : <%=loginInfo.getMi_id() %><br />
	이름 : <%=loginInfo.getMi_name() %><br />
	성별 : <%=loginInfo.getMi_gender() %><br />
	생년월일 : <%=loginInfo.getMi_birth() %><br />
	휴대폰 : 
	 <select name="p1">
	 	<option <% if (arrPhone[0].equals("010")) { %>selected="selected" <% } %>>010</option>
	 	<option <% if (arrPhone[0].equals("011")) { %>selected="selected" <% } %>>011</option>
	 	<option <% if (arrPhone[0].equals("016")) { %>selected="selected" <% } %>>016</option>
	 	<option <% if (arrPhone[0].equals("019")) { %>selected="selected" <% } %>>019</option>
	 </select> - 
	 <input type="text" name="p2" size="4" maxlength="4" onkeyup="onlyNum(this);" value="<%=arrPhone[1] %>" /> - 
	 <input type="text" name="p3" size="4" maxlength="4" onkeyup="onlyNum(this);" value="<%=arrPhone[2] %>" />
	 <br />
	 이메일 : 
	 <input type="text" name="e1" size="10" value="<%=eid %>"/> @
	 <select name="e2" id="e2">
	 	<option value="">도메인 선택</option>
<% for (int i = 0; i < arrDomain.length; i++) { %>
		<option <% if (arrDomain[i].equals(domain)) { %>selected="selected" <% } %>><%=arrDomain[i] %></option>
<% } %>
		<option value="direct">직접 입력</option>
	 </select>
	 <input type="text" name="e3" id="e3" size="10" value="<%=domain %>" />
	 <br /><hr />
	 <input type="submit" value="정보 수정" />
</div>
</form>
</body>
</html>