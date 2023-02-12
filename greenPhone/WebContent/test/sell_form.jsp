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
div {
	margin:auto 2%;
}
p {
	font-size:20px;
}
#sellfrm {
	width:1000px;
	border:1px solid black;
	margin:0 auto;
}
#sellbox {
	padding:2% 0;
}
#frmbox {
	margin:2% 0;
	display:flex;
	justify-content: flex-start;
}
#file {
	visibility: hidden;
	width:0;
	height:0;
}
#fileup {
	background-color:lightgray;
	width:150px;
	border:1px solid black;
	margin:0;
	display:flex;
	align-items: center;
    justify-content: center;
}
#fileup a {
	font-size:20px;
	border:0;
	display:flex;
	justify-content: center;
}
#boxin {
	display:flex;
}
#boxin p {
	width:100px;
	border:1px solid black;
	margin:0;
	padding:2%;
	font-size:20px;
	text-align:center;
}
#select {
	width:250px;
	background-color:lightgray;
	font-size:20px;
	text-align:center;
}
#imgbox {
	display:flex;
	justify-content: space-around;
}
#imgbox p {
	width:150px;
	border:1px solid black;
	margin:0 auto;
	padding:2%;
	font-size:20px;
	text-align:center;
}
#content {
	width:100%;
	height:150px;
	margin:2% 0;
	border:1px solid black;
	overflow:auto;
	font-size:18px;
	resize: none;
}
#selbtn {
	display:flex;
	justify-content: flex-end;
}
#selbtnsz {
	margin:0 0 0 2%;
	width:100px;
	height:30px;
	font-size:18px;
}
</style>

<script>
	function onClickUpload() {
    	let file = document.getElementById("file");
    	file.click();
	}
</script>

<body>

<h2>판매 신청</h2>
<div id="sellfrm">
	<div id="sellbox">
		<p>상품 정보</p>
		<hr />
		<div id="frmbox">
			<div id="boxin">
				<p>브랜드</p>
				<select name="" onchange="" id="select">
					<option value="" selected="">삼성</option>
				</select>
			</div>
			<div id="boxin">
				<p>기종</p>
				<select name="" onchange="" id="select">
					<option value="" selected="">갤럭시 S21</option>
				</select>
			</div>
		</div>
	</div>
	<div id="sellbox">
		<p>세부 사항</p>
		<hr />
		<div id="frmbox">
			<div id="boxin">
				<p>용량</p>
				<select name="" onchange="" id="select">
					<option value="" selected="">512GB</option>
				</select>
			</div>
			<div id="boxin">
				<p>색상</p>
				<select name="" onchange="" id="select">
					<option value="" selected="">화이트</option>
				</select>
			</div>
		</div>
		<div>
			<div id="imgbox">
				<div id="frmbox">
					<p>전면 이미지</p>
					<div id="fileup" onclick="onClickUpload();">
						<a>파일 선택</a>
						<input id="file" type="file" />
			        </div>
				</div>
				<div id="frmbox">
					<p>후면 이미지</p>
					<div id="fileup" onclick="onClickUpload();">
						<a>파일 선택</a>
						<input id="file" type="file" />
			        </div>
				</div>
			</div>
			<div id="imgbox">
				<div id="frmbox">
					<p>측면1 이미지</p>
					<div id="fileup" onclick="onClickUpload();">
						<a>파일 선택</a>
						<input id="file" type="file" />
			        </div>
				</div>
				<div id="frmbox">
					<p>측면2 이미지</p>
					<div id="fileup" onclick="onClickUpload();">
						<a>파일 선택</a>
						<input id="file" type="file" />
			        </div>
				</div>
			</div>
		</div>
	</div>
	<div id="sellbox">
		<p>추가 입력 정보</p>
		<hr />
		<textarea name="content" id="content" cols="30" rows="10" placeholder="내용"></textarea>
		<p>2차 검수시 실물과 다른 상품 등록 및 분실 등록된 핸드폰 등 문제가 있는 상품에 대해서는 택배비 및 모든 책임이 본인에게 있음을 알려드립니다.</p>
		<div id=selbtn>
			<input type="button" name="" id="selbtnsz" value="취소">
			<input type="button" name="" id="selbtnsz" value="신청하기">
		</div>
	</div>
	
</div>

</body>
</html>