<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<style>
.price {
	position: fixed;
	top: 250px;
    left: 50px;
    border: 1px solid #000;
    border-radius: 20px;
    z-index: 99;
    background-color : #ccf;
}
.price > p {
	white-space: pre-line;
	text-align: center;
	font-size: 20px;
	font-weight: bold;
	margin-top: 0;
}
.price img {
	margin:30px;
}
.price_pop { display : none; }
</style>
<a href="#"><div class="price">
	<img src="./img/searchPrice.png" width="150" />
	<p>내 폰 가격
	알아보기</p>
</div></a>

<div class="price_pop">
	<div class="brand">
		<p>애플</p>
		<p>삼성</p>
	</div>
</div>