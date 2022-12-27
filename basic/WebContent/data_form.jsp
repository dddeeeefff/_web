<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>데이터 전송(get 방식)</h2>
<form name="frmGet" action="data_proc.jsp?t1=v1&t2=v2" method="get">
<!-- get방식으로 전송할 경우 action의 url에 쿼리스트링을 붙이면 그 데이터는 전송되지 않음 -->
<input type="hidden" name="kind" value="a" /><br />
<label for="uid">아이디 : </label>
<input type = "text" name="uid" id="uid" /><br />
<label for="pwd">비밀번호 : </label>
<input type = "password" name="pwd" id="pwd" /><br />
<input type = "submit" value="로그인" />
</form>
<hr />
<h2>데이터 전송(post 방식)</h2>
<form name="frmPost" action="data_proc.jsp?t1=v1&t2=v2" method="post">
<!-- post방식으로 전송할 경우 action의 url에 쿼리스트링을 붙이면 그 데이터도 전송됨 -->
<input type="hidden" name="kind" value="b" />
<label for="name">이름 : </label>
<input type="text" name="name" id="name" /><br />
<label for="e1">이메일 : </label>
<input type="text" name="e1" id="e1" /><br />
<select name="e2">
	<option value="naver.com">네이버</option>
	<option value="nate.com">네이트</option>
	<option value="gmail.com">지메일</option>
</select><br />
<input type = "submit" value="아이디 찾기" />
</form>
<hr />
<h2>여러 데이터 전송(post 방식)</h2>
<form name="frm" action="data_proc.jsp" method="post">
<input type="hidden" name="kind" value="c" /><br />
성별 : 
<input type="radio" name="gender" value = "m" id="m" />
<label for="m">남자</label>
<input type="radio" name="gender" value = "f" id="f" />
<label for="f">여자</label><br />
취미 : 
<input type="checkbox" name="hobby" value="영화" id="mv" />
<label for="mv">영화</label>
<input type="checkbox" name="hobby" value="음악" id="ms" />
<label for="ms">음악</label>
<input type="checkbox" name="hobby" value="운동" id="sp" />
<label for="sp">운동</label>
<input type="checkbox" name="hobby" value="등산" id="tr" />
<label for="tr">등산</label>
<input type="checkbox" name="hobby" value="낚시" id="fs" />
<label for="fs">낚시</label>
<input type="checkbox" name="hobby" value="독서" id="rb" />
<label for="rb">독서</label><br />
<input type="submit" value="데이터 전송" />

</form>
</body>
</html>