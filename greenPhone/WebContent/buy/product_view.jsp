<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
ProductInfo pi = (ProductInfo)request.getAttribute("pi");
//화면에서 보여줄 상품 정보들을 저장한 ProductInfo형 인스턴스 pi를 받아옴

int realPrice = 0;	// 수량 변경에 따른 가격 계산을 위한 변수
int price = pi.getPi_min();
if (pi.getPi_dc() > 0) {	// 할인율이 있으면
	realPrice = pi.getPi_min();
	price = realPrice * (100 - pi.getPi_dc()) / 100;	// 최종 가격
} else if (pi.getPi_dc() == 0) {
	realPrice = pi.getPi_min();
}
%>
<style>
#buypage {
	display:flex;
	width:1000px;
	margin:0 auto;
	font-size:25px;
}
#buymenu {
	width:50%;
	display: flex;
    flex-direction: column;
    align-items: center;
}
#buymenu p {
	margin:10%;
}
#imgsrc {
	margin:5%;
	display:flex;
    flex-direction: column;
    align-items: center;
}
#imgcl{
	display:flex;
}
#imgcl div {
	width:20px;
    height:20px;
    border:1px solid black;
    border-radius:50%;
    cursor:pointer;
}
.bselect { width:20px; height:20px; border:1px solid black; background-color:black; cursor:pointer;}
.wselect { width:20px; height:20px; border:1px solid black; background-color:white; cursor:pointer;}
#buyimg {
	width:300px;
	height:300px;
}
div li {
	display:flex;
	justify-content: space-between;
	font-weight:bold;
}
#btn {
	margin:3%;
	display:flex;
	justify-content: space-evenly;
}
#btnsz {
	margin:5%;
	width:200px;
	height:60px;
	font-size:18px;
}
#buyoption {
	width:50%;
}
h2 {
	margin:5% 0;
}
#select1 {
	width:150px;
	font-size:20px;
}
#select2, #select3 {
	width:200px;
	font-size:20px;
}
#buyoption li p a {
	display:flex;
	justify-content: space-between;
}
#btncl {
	width:120px;
	height:50px;
	font-size:18px;
}
#btnpm {
	font-size:20px;
}
#before {
	text-decoration-line: line-through;
}
#after {
	text-decoration-line: underline;
}
#cnt { font-size:20px; }
#total { font-size:20px; vertical-align:top;}
#totalhidden {
	
}
</style>
<script>
function showPic(obj) {
	var pic = document.getElementById("buyimg");
	pic.src = "/greenPhone/img/pdt_list/" + obj;
}

function setCnt(chk) {
	var price = <%=realPrice %>;
	var priceB = <%=price %>
	
	var frm = document.frm;
	var cnt = parseInt(frm.cnt.value);
	
	if (chk == "+" && cnt < 9)			frm.cnt.value = cnt + 1;
	else if (chk == "-" && cnt > 1)		frm.cnt.value = cnt - 1;
	
	var obj = document.getElementById("total");
	var obj2 = document.getElementById("totalB");
	total.innerHTML = price * frm.cnt.value;
	totalB.innerHTML = priceB * frm.cnt.value;
}

function buy(chk) {
	var frm = document.frmSell;
<% if (isLogin) { %>
	var color = frm.colorSelect.value;
	var memory = frm.memorySelect.value;
	var rank = frm.rankSelect.value;
	if (memory == "" || color == "" || rank == "") {
		alert("옵션을 선택하세요.");	return;
	}
	
	if (chk == "c") {	// 장바구니 담기일 경우
		var cnt = frm.cnt.value;
		$.ajax({
			type : "POST", 
			url : "/greenPhone/cart_proc_in", 
			data : {"piid" : "<%=pi.getPi_id() %>", "option" : option, "cnt" : cnt}, 
			success : function(chkRs) {
				if (chkRs == 0) {	// 장바구니 담기에 실패했을 경우
					alert("장바구니 담기에 실패했습니다.\n다시 시도해 보세요.");
					return;
				} else {	// 장바구니 담기에 성공했을 경우
					if (confirm("장바구니에 담았습니다.\n장바구니로 이동하시겠습니까?")) {
						location.href="cart_view";
					}
				}
			}
		});
	} else {	// 바로 구매일 경우
		frm.action = "order_form";
		frm.submit();
	}
	
<% } else { %>
	location.href="login_form?url=/mvcSite/product_view?piid=<%=pi.getPi_id() %>";
<% } %>
}

function totalPrice() {
	if (($('#select1').val("b") || $('#select1').val("w")) || 
		($('#select2').val("b") || $('#select2').val("a") || $('#select2').val("s")) || 
		($('#select3').val("128") || $('#select3').val("256") || $('#select3').val("512"))
		) {
		document.getElementById("totalhidden").style.display = "block";		
	} else {
		alert("옵션을 모두 선택하세요.");	return;
	}

	
	$.ajax({
		type : "POST",
		url : "product_view",
		data : {"piid" : "<%=pi.getPi_id() %>", "color" : color, "rank" : rank, "memory" : memory, "cnt" : cnt },
		success : function(chkRs) {
			if (chkRs == -1) {
				alert("현재 선택하신 상품의 재고가 없습니다.");
			} else {
				var total = parseInt($("#total").text());
				var inc = parseInt(chkRs);
				total = (total * chkRs / 100) + total;
				$("#total").text(total);
			}
		}

	})
}

</script>

<body>

<div id="buypage">
	<div id="buymenu">
	<form name="frmSell" method="post">
		<div id="imgsrc">
			<img src="/greenPhone/img/pdt_list/<%=pi.getPi_img1() %>" id="buyimg">
			<br />
			<div id=imgcl>
				<div class="bselect" onclick="showPic('<%=pi.getPi_img1() %>');"></div>&nbsp;&nbsp;
				<div class="wselect" onclick="showPic('<%=pi.getPi_img2() %>');"></div>
			</div>
		</div>
		<p>위 이미지는 등급별로 <br/>차이가 있을 수 있습니다.</p>
		<div id="btn">
			<input type="button" id="btnsz" value="장바구니에 담기" onclick="buy('c');" />
			<input type="button" id="btnsz" value="바로 구매" onclick="buy('d');" />
		</div>
	</form>
	</div>
	<div id="buyoption">
	<form name="frm" method="post">
		<h2><%=pi.getPi_name() %></h2>
		<hr />
		<li>
			<p>가격</p>
			<% if (pi.getPi_dc() > 0) { %>
			<p><%=price %>&nbsp;원</p>
			<% } else if (pi.getPi_dc() == 0) { %><p><%=realPrice %>&nbsp;원</p><% } %>
		</li>
		<li>
			<p>색상</p>
			<p>
				<select name="select1" id="select1">
					<option value="">색상 선택</option>
					<option value="b">블랙</option>
					<option value="w">화이트</option>
				</select>
			</p>
		</li>
		<li>
			<p>등급</p>
			<p>
				<select name="select2" id="select2">
					<option value="">등급 선택</option>
					<option value="b">B</option>
					<option value="a">A</option>
					<option value="s">S</option>
				</select>
			</p>
		</li>
		<li>
			<p>용량</p>
			<p>
				<select name="select3" id="select3">
					<option value="">용량 선택</option>
					<option value="128">128 GB</option>
					<option value="256">256 GB</option>
					<option value="512">512 GB</option>
				</select>
			</p>
		</li>
		<li>
			<p></p>
			<p>
				<input type="button" name="btncl" id="btncl" value="옵션 선택" onclick="totalPrice();" />
			</p>
		</li>
		<li>
			<p>수량</p>
			<p>
				<input type="button" value="-" id="btnpm" onclick="setCnt(this.value);" />
				<input type="text" name="cnt" id="cnt" value="1" size="3" readonly="readonly" />
				<input type="button" value="+" id="btnpm" onclick="setCnt(this.value);" />
			</p>
		</li>
		<hr />
		<div id="totalhidden">
		<% if (pi.getPi_dc() > 0) { %>
			<li>
				<p></p>
				<p id="before">
					<span id="totalB"><%=realPrice %></span>&nbsp;원
				</p>
			</li>
		<% } %>
			<li>
				<p></p>
				<p id="after">가격&nbsp;&nbsp;&nbsp;
					<span id="total"><%=price %></span>&nbsp;원
				</p>
			</li>
		</div>
	</form>
	</div>
</div>

</body>
</html>