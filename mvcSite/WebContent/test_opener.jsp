<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function callPopup() {
	awin = window.open("test_popup.jsp", "aa", 
		"left=100,top=50,width=200,height=150");
}
</script>
</head>
<body>
<form name="frm">
값1 : <input type="text" name="v1" /><br />
값2 : <input type="text" name="v2" /><br />
값3 : <input type="text" name="v3" /><br />
<input type="button" value="팝업 호출" onclick="callPopup();" />
</form>
</body>
</html>