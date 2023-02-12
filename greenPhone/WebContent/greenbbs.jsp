<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	div {
		display:flex;
		justify-content:center;
		padding:20px;
	}
	#menu { 
		display:flex; justify-content:center;
		align-items:center;
		width:100px; height:40px;
		border:2px solid black; 
	}
	a {
		text-decoration: none;
	}
	table {
		width:800px;
		border-collapse:collapse;
	}
	th, tr, td {
		padding:5px;
		border:1px solid black;
		text-align:center;
	}
	th {
		background-color:lightgray;
	}
	th:nth-child(1) {
		width:10%
	}
	th:nth-child(3) {
		width:10%
	}
	th:nth-child(4) {
		width:10%
	}
	th:nth-child(5) {
		width:15%
	}
	td:nth-child(2) {
		text-align:left
	}
</style>
<body>
<div>
	<a id="menu" href="">공지사항</a>
	<a id="menu" href="">FAQ</a>
	<a id="menu" href="">이벤트</a>
	<a id="menu" href="">리뷰</a>
	<a id="menu" href="">자유게시판</a>
</div>
<div>
	<table>
		<th>글 번호</th>
		<th>제목</th>
		<th>작성자</th>
		<th>조회수</th>
		<th>등록일</th>
		<tr>
			<td>1</td>
			<td><a href="">공지사항 입니다.</a></td>
			<td>관리자</td>
			<td>21</td>
			<td>2023-01-12</td>
		</tr>
	</table>
</div>
</body>
</html>