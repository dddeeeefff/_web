<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<style>
h2 {
	text-align:center;
}
hr {
	width:500px;
}
#agree {
	width:500px;
	margin:0 auto;
}
#agree2 {
	width:500px;
	margin:0 auto;
}
#agfrm {
	height:150px;
	border:1px solid black;
	overflow:auto;
}
#agree p {
	color:red;
}
#allag {
	text-align:center;
}
#agree {
	width:500px;
	margin:0 auto;
}

b {
	color:red;
}
#info {
	display:flex;
	align-items: center;
}
#info label {
	width:25%;
}

#infosub {
	width:75%;
}
#infosub span {
	font-size:5px;
	color:gray;
}

#box {
	width:270px;
}
#p1box {
	width:25px;
}
#p2box {
	width:30px;
}
#e1box {
	width:70px;
}
#e2box {
	width:100px;
}
#abox {
	width:100px;
}
#btn {
	margin:10px;
	display:flex;
	justify-content: space-evenly;
}
#btnsz {
	width:80px;
	height:40px;
	padding:5px 5px;
}
</style>

<body>
<h2>회원가입</h2>
<hr />
<div id="agree">
	<div>
		<div id="agfrm">
			이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의이용약관동의
		</div>
		<p><input type="checkbox" name="" value="">이용약관 동의 (필수)</p>
		<div id="agfrm">
			개인정보 보호정책 동의개인정보 보호정책 동의개인정보 보호정책 동의개인정보 보호정책 동의개인정보 보호정책 동의개인정보 보호정책 동의개인정보 보호정책 동의개인정보 보호정책 동의개인정보 보호정책 동의개인정보 보호정책 동의개인정보 보호정책 동의개인정보 보호정책 동의개인정보 보호정책 동의개인정보 보호정책 동의개인정보 보호정책 동의개인정보 보호정책 동의개인정보 보호정책 동의개인정보 보호정책 동의개인정보 보호정책 동의개인정보 보호정책 동의개인정보 보호정책 동의개인정보 보호정책 동의개인정보 보호정책 동의개인정보 보호정책 동의개인정보 보호정책 동의개인정보 보호정책 동의개인정보 보호정책 동의개인정보 보호정책 동의개인정보 보호정책 동의개인정보 보호정책 동의개인정보 보호정책 동의
		</div>
		<p><input type="checkbox" name="" value="">개인정보 보호정책 동의 (필수)</p>
		<p id="allag"><input type="checkbox" name="" value="">위 내용에 모두 동의합니다.</p>
	</div>
</div>
<div id="agree2">
	<b>* 표시는 회원가입시 꼭 필요한 항목입니다.</b>
	<hr />
	<div id="info">
		<label>
			<span><b>*</b> 아이디</span>
		</label>
		<p id="infosub"><input type="text" name="" id="box" placeholder="아이디를 입력하세요." value="" />
			<br />
			<span>4 ~ 12자의 영문, 숫자만 입력(ID는 가입 후 변경 불가능 합니다.)</span>
		</p>
	</div>
	<hr />
	<div id="info">
		<label>
			<span><b>*</b> 비밀번호</span>
		</label>
		<p id="infosub"><input type="text" name="" id="box" placeholder="비밀번호를 입력하세요." value="" />
			<br />
			<span>(한글 입력불가. 대소문자 구별. 8 ~ 12자리 입력)</span>
		</p>
	</div>
	<hr />
	<div id="info">
		<label>
			<span><b>*</b> 비밀번호 확인</span>
		</label>
		<p id="infosub"><input type="text" name="" id="box" placeholder="비밀번호를 입력하세요." value="" />
			<br />
			<span>비밀번호 확인을 위해 다시 한번 입력해주세요.</span>
		</p>
	</div>
	<hr />
	<div id="info">
		<label>
			<span><b>*</b> 생년월일</span>
		</label>
		<p id="infosub">
			<select name="" onchange="">
					<option value="" selected="">1990</option>
			</select>&nbsp;년&nbsp;&nbsp;
			<select name="" onchange="">
					<option value="" selected="">01</option>
			</select>&nbsp;월&nbsp;&nbsp;
			<select name="" onchange="">
					<option value="" selected="">01</option>
			</select>&nbsp;일&nbsp;&nbsp;
		</p>
	</div>
	<hr />
	<div id="info">
		<label>
			<span><b>*</b> 성별</span>
		</label>
		<p id="">	
			<input type="radio" name="radio" value="">남자&nbsp;&nbsp;
			<input type="radio" name="radio" value="">여자
		</p>
	</div>
	<hr />
	<div id="info">
		<label>
			<span><b>*</b> 이름</span>
		</label>
		<p id="infosub"><input type="text" name="" id="box" placeholder="이름을 입력하세요." value="" />
		</p>
	</div>
	<hr />
	<div id="info">
		<label>
			<span><b>*</b> 연락처</span>
		</label>
		<p id="infosub">
			<input type="text" name="" id="p1box" placeholder="010" value="" />
			-
			<input type="text" name="" id="p2box" placeholder="0000" value="" />
			-
			<input type="text" name="" id="p2box" placeholder="0000" value="" />
		</p>
	</div>
	<hr />
	<div id="info">
		<label>
			<span><b>*</b> E-mail</span>
		</label>
		<p id="infosub">
			<input type="text" name="" id="e1box" placeholder="" value="" />
			@
			<input type="text" name="" id="e2box" placeholder="" value="" />
			<select name="" onchange="">
					<option value="" selected="">직접입력</option>
			</select>
		</p>
	</div>
	<hr />
	<div id="info">
		<label>
			<span><b>*</b> 주소</span>
		</label>
		<p id="infosub">
			<input type="text" name="" id="abox" placeholder="우편번호" value="" /><br />
			<input type="text" name="" id="box" placeholder="" value="" /><br />
			<input type="text" name="" id="box" placeholder="상세주소 입력" value="" />
		</p>
	</div>
	<hr />
	<div id="btn">
		<input type="button" name="" id="btnsz" value="회원 가입">
		<input type="button" name="" id="btnsz" value="취 소">
	</div>
</div>
</body>
</html>