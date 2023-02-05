<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#list{ width:180px; height:60px; overflow:auto; }
</style>
<script>
function insert() {
	var v = document.frmPopup.list.value;
	var arr = v.split("|");
	
	var frm = opener.document.frm;
	// 오프너(팜업을 연 화면)의 폼을 받아옴
	frm.v1.value = arr[0];
	frm.v2.value = arr[1];
	frm.v3.value = arr[2];
	self.close();
}
</script>
</head>
<body onload="window.resizeTo(250, 220);">
<form name="frmPopup">
<div id="list">
	<input type="radio" name="list" value="v1-item01|v2-item01|v3-item01" />
	&nbsp;&nbsp;목록 - 아이템 01<br />
	<input type="radio" name="list" value="v1-item02|v2-item02|v3-item02" />
	&nbsp;&nbsp;목록 - 아이템 02<br /> 
	<input type="radio" name="list" value="v1-item03|v2-item03|v3-item03" />
	&nbsp;&nbsp;목록 - 아이템 03<br />
	<input type="radio" name="list" value="v1-item04|v2-item04|v3-item04" />
	&nbsp;&nbsp;목록 - 아이템 04<br /> 
	<input type="radio" name="list" value="v1-item05|v2-item05|v3-item05" />
	&nbsp;&nbsp;목록 - 아이템 05<br />
</div>
<hr />
<center>
<input type="button" value="적용" onclick="insert();" />&nbsp;&nbsp;
<input type="button" value="닫기" onclick="self.close();" />
</center>
</form>
</body>
</html>