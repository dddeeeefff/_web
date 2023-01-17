<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
ArrayList<OrderCart> cartList = 
	(ArrayList<OrderCart>)request.getAttribute("cartList");
// 장바구니 화면에서 보여줄 상품 목록을 받아옴
%>
<script>
function chkAll(all) {
	var chk = document.frmCart.chk;
	for (var i = 0; i < chk.length; i++) {
		chk[i].checked = all.checked;
	}
}
 function cartDel(ocidx){
// 장바구니내 특정 상품을 삭제하는 함수
	if (confirm("정말 삭제하시겠습니까?")){
		$.ajax({
			type : "POST",
			url : "/mvcSite/cart_proc_del",
			data : {"ocidx" : ocidx}, 
			success : function(chkRs) {
				if (chkRs == 0) {
					alert("상품 삭제에 실패했습니다.\n다시 시도하세요.");
				}
				location.reload();
			}
		});
	}
 }
 
function cartUp(ocidx, opt, cnt){
// 장바구니 내 특정 상품의 옵션 및 수량을 변경하는 함수
// cnt가 0이면 옵션 변경이고, opt가 0이면 수량 변경을 의미	

	$.ajax({
		type : "POST",
		url : "/mvcSite/cart_proc_Up",
		data : {"ocidx" : ocidx, "opt" : opt, "cnt" : cnt}, 
		success : function(chkRs) {
			if (chkRs == 0) {
				alert("제품 변경에 실패했습니다.\n다시 시도하세요.");
			}
			location.reload();
		}
	});
}

function setCnt(chk, ocidx) {
	var frm = document.frmCart;
	var cnt = parseInt(eval("frm.cnt" + ocidx + ".value"));
	
	alert((cnt + 1) + ":::" + (cnt - 1));
	if (chk == "+" && cnt < 99) {
		// cartUp(ocidx, 0, cnt + 1)
	} else if (chk == "-" && cnt > 1) {
		// cartUp(ocidx, 0, cnt - 1)
	}
}
</script>
<h2>장바구니</h2>
<form name="frmCart" action="order_form" method="post">
<input type="hidden" name="kind" value="c" />
<input type="checkbox" name="all" id="all" onclick="chkAll(this);" checked="checked" />
<label for="all">전체 선택</label>
<table width="800" cellpadding="5">
<%
if (cartList.size() > 0) {	// 장바구니에 담긴 상품이 있을 경우
	int total = 0;	// 총 구매 가격의 누적값을 저장할 변수
	for (int i = 0; i < cartList.size(); i++) {
		OrderCart oc = cartList.get(i);
		int ocidx = oc.getOc_idx();
		int price = oc.getPi_price() * oc.getOc_cnt();
		if (oc.getPi_dc() > 0) {	// 할인율이 있으면
			price = oc.getPi_price() * (100 - oc.getPi_dc()) / 100 * oc.getOc_cnt();
		}
%>
<tr align="center">
<td width="5%">
 	<input type="checkbox" name="chk" value="<%=oc.getOc_idx() %>" checked="checked" />
</td>
<td width="15%">
	<a href="product_view?piid=<%=oc.getPi_id() %>">
	<img src="product/pdt_img/<%=oc.getPi_img1() %>" width="110" height="90" /></a>
</td>
<td width="25%">
	<a href="product_view?piid=<%=oc.getPi_id() %>"><%=oc.getPi_name() %></a>
</td>
<td width="20%">
	<select name="size" onchange="cartUp(<%=ocidx %>, this.value, 0);">
<%
		ArrayList<ProductStock> stockList = oc.getStockList();
		for (int j = 0; j < stockList.size(); j++) {
			ProductStock ps = stockList.get(j);
			String txt = ps.getPs_size() + "mm (재고량 : " + ps.getPs_stock() + "개)";
			String selected = "";
			if (ps.getPs_idx() == oc.getPs_idx())
				selected = " selected='selected'";
			
			if (ps.getPs_stock() > 0) {	// 재고량이 있을 경우에만 보여줌
				
%>
		<option value="<%=ps.getPs_idx() %>"
			<%=selected %>><%=txt %></option>
<%		
			}
		}
%>
	</select>
</td>
<td width="15%">
		<input type="button" value="-" onclick="setCnt(this.value, <%=ocidx %>);" />
		<input type="text" name="cnt<%=ocidx %>" id="cnt" style="width:20px; text-align:right;"
		value="<%=oc.getOc_cnt() %>" readonly="readonly" />
		<input type="button" value="+" onclick="setCnt(this.value, <%=ocidx %>);" />
</td>
<td width="15%"><%=price %>원</td>
<td width="*">
		<input type="button" value="삭제" onclick="cartDel(<%=ocidx %>);" />
</td>
</tr>
<%		
		total += price;
	}
%>
</table>
<p align="right" style="width:800px; font-size:1.8em;">
	총 구매 가격 : <%=total %>원</p>
<p align="center" style="width:800px; font-size:1.3em;">
	<input type="button" value="선택한 상품 삭제" onclick="" />
	<input type="button" value="선택한 상품 구매" onclick="" />
	<input type="button" value="전체 상품 구매" onclick="" />
</p>
<%	
} else {	// 장바구니에 담긴 상품이 없을 경우
	out.println("<tr><td align='center'>장바구니에 상품이 없습니다.</td></tr></table>");
}
%>

</form>
</body>
</html>