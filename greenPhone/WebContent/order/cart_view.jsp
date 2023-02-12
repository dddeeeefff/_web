<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
ArrayList<SellCart> cartList = (ArrayList<SellCart>)request.getAttribute("cartList");
// 장바구니 화면에서 보여줄 상품 목록을 받아옴
%>
<script>
function chkAll(all) {
	var chk = document.frmCart.chk;
	for (var i = 0; i < chk.length; i++){
		chk[i].checked = all.checked;
	}
}

function getSelectedValues() {
// 체크박스 중 선택된 체크박스 값들을 쉼표로 구분하여 문자열로 리턴
	var chk = document.frmCart.chk;
	var idxs = "";	// chk 컨트롤 배열에서 선택된 체크박스의 값들을 누적 저장 변수
	for (var i = 1; i < chk.length; i++) {
		if (chk[i].checked)	idxs += "," + chk[i].value;
	}
	return idxs.substring(1);
}

function cartDel(scidx) {
// 장바구니 내 특정 상품을 삭제하는 함수
	if (confirm("정말 삭제하시겠습니까?")) {
		// cart_proc_del <-> CartProcDelCtrl
		$.ajax({
			type : "POST",
			url : "/greenPhone/cart_proc_del",
			data : { "scidx" : scidx },
			success : function(chkRs) {
				if (chkRs == 0){
					alert("상품 삭제에 실패했습니다.\n다시 시도하세요.");
				}
				location.reload();
			}
		});
	}
}

function cartUp(scidx, cnt) {
// 장바구니 내 수량 변경
	$.ajax({
		type : "POST",
		url : "/greenPhone/cart_proc_up",
		data : {"scidx" : scidx, "cnt" : cnt},
		success : function(chkRs) {
			if (chkRs == 0) {
				alert("상품 변경에 실패했습니다.\n다시 시도하세요.");
			}
			location.reload();
		}
	});
}

function setCnt(chk, scidx) {
// 버튼 수량 변경
	var frm = document.frmCart;
	var cnt = parseInt(eval("frm.cnt" + scidx + ".value"));
	
	if (chk == "+" && cnt < 9){
		cartUp(scidx, cnt + 1)
	} else if (chk == "-" && cnt > 1) {
		cartUp(scidx, cnt - 1);
	}
}

function chkDel() {
// 체크박스 선택 상품 삭제
	var scidx = getSelectedValues();
	if (scidx == "")	alert("삭제할 상품을 선택하세요.");
	else				cartDel(scidx);
}

function chkBuy() {
// 선택 상품 구매
	var scidx = getSelectedValues();
	if (scidx = "")		alert("구매할 상품을 선택하세요.");
	else				document.frmCart.submit();
}
</script>
<style>
table{ margin:0 auto; border-collapse: collapse; width:700px;}
.tableHead, .tPrice{ border-top:1px solid blue; border-bottom:1px solid blue; padding:8px; }
.tPrice, .cartButton { width:700px; margin:0 auto; }
.cartButton{ display:flex; justify-content: space-evenly; }
.tPrice { padding: 10px 0px 10px 0px; }
</style>

	<form name="frmCart" action="order_form" method="post" width="700">
	<input type="hidden" name="chk" value="" />
	<input type="hidden" name="kind" value="c" />
		<table width="1000" cellpadding="8" class="topTable">
				<tr class="tableHead" align="center">
					<th width="22%"><input type="checkbox" name="all" id="all" checked="checked" onclick="chkAll(this);" /></th>
					<th width="17%">제품명</th>
					<th width="26%">옵션</th>
					<th width="16%">수량</th>
					<th width="25%">가격</th>
				</tr>
<%
if (cartList.size() > 0) {	// 장바구니에 담긴 상품이 있을 경우
	int total = 0;	// 총 구매 가격의 누적값을 저장할 변수
	for (int i = 0 ; i < cartList.size() ; i++) {
		SellCart sc = cartList.get(i);
		int scidx = sc.getSc_idx();
		int price = sc.getPi_min() * sc.getSc_cnt();
		if (sc.getPi_dc() > 0) {	// 할인율이 있으면
			price = sc.getPi_min() * (100 - sc.getPi_dc()) / 100 * sc.getSc_cnt();
		}
%>

			<!-- 장바구니에 담긴 상품 -->

			<tr align="center">
				<td width="22%">
					<input type="checkbox" name="chk" value="<%=scidx %>" checked="checked" />
					<img src="/greenPhone/img/pdt_list/<%=sc.getPi_img1() %>" width="40" height="30" />
				</td>
				<td width="17%">
					<a href="product_view?piid=<% %>"><%=sc.getPi_name() %></a>
				</td>
				<td width="26%">
					<%=sc.getPo_name() %>
				</td>
				<td width="16%">
					<input type="button" value="-" onclick="setCnt(this.value, <%=scidx %>);" />
					<input type="text" name="cnt<%=scidx %>" id="cnt" style="width:20px; text-align:right;" 
						value="<%=sc.getSc_cnt() %>" readonly="readonly" />
					<input type="button" value="+" onclick="setCnt(this.value, <%=scidx %>);" />
				</td>
				<td width="25%" style="font-size:12px; ">
					<%=price %>원
					<input type="button" value="삭제" onclick="cartDel(<%=scidx %>);" />
				</td>
			</tr>
<%	
		total += price;
	}
%>
		</table>
		<p class="tPrice" align="right" style="font-size:0.7em; ">총&nbsp;<%=total %>원</p>
		<br />
		<div class="cartButton">
			<input type="button" value="선택 삭제" onclick="chkDel();" />
			<input type="button" value="선택 상품 구매" onclick="chkBuy();" />
			<input type="button" value="전체 구매" onclick="allBuy();" />
		</div>
<%
} else {	// 장바구니에 담긴 상품이 없을 경우
	out.println("<tr><td align='center'>장바구니에 상품이 없습니다.</td></tr></table>");
}
%>
	</form>
</body>
</html>