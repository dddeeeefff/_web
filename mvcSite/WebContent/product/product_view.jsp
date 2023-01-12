<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
ProductInfo pi = (ProductInfo)request.getAttribute("pi");
// 화면에서 보여줄 상품 정보들을 저장한 ProductInfo형 인스턴스 pi를 받아옴 
ArrayList<ProductStock> stockList = pi.getStockList();
// pi에 들어있는 옵션별 재고량 목록을 받아옴

int realPrice = pi.getPi_price();	// 수량 변경에 따른 가격 계산을 위한 변수
String price = pi.getPi_price() + "원";	// 가격 출력을 위한 변수
if (pi.getPi_dc() > 0) {	// 할인율이 있으면
	realPrice = realPrice * (100 - pi.getPi_dc()) / 100;
	price = "<del>" + pi.getPi_price() + "</del>" + 
		"&nbsp;&nbsp;&nbsp;" + realPrice + "원";
}
%>
<style>
#cnt { width:20px; text-align:right; }
.smt { width:150px; height:30px; }
</style>
<script>
function showBig(obj) {
	var big = document.getElementById("bigImg");
	big.src = "/mvcSite/product/pdt_img/" + obj;
}
function setCnt(chk) {
	var price = <%=realPrice %>;
	var frm = document.frm;
	var cnt = parseInt(frm.cnt.value);
	
	if (chk == "+" && cnt < 99)		frm.cnt.value = cnt + 1;
	else if (chk == "-" && cnt > 1)	frm.cnt.value = cnt - 1;
	
	var obj = document.getElementById("total");
	total.innerHTML = price * frm.cnt.value;
}

function buy(chk) {
// [장바구니 담기] 또는 [바로 구매] 버튼 클릭시 작업할 함수
	var frm = document.frm;
<% if (isLogin) { %>
	var size = frm.size.value;
	if (size == "") {
		alert("옵션(사이즈)을 선택하세요.");	return;
	}
	
	if (chk == "c") {	// 장바구니 담기일 경우
		var cnt = frm.cnt.value;
		$.ajax({
			type : "POST",
			url : "/mvcSite/cart_proc_in",
			data : {"piid : "<%=pi.getPi_id() %>", "psidx" : size, "cnt" : cnt},
			success : function(chkRs) {
				if (chkRs == 0) {	// 장바구니 담기에 실패했을 경우
					alert("장바구니 담기에 실패했습니다.\n다시 시도해 보세요.");
					return;
				} else {	// 장바구니 담기에 성공했을 경우
					if (confirm("장바구니에 담았습니다.\n장바구니로 이동하시겠습니까?")){
						location.href = "cart_view";
					}
				}
			}
		});
	} else {	// 바로 구매일 경우
		frm.action = "order_form";
		frm.submit();
	}
<% } else { %>
	location.href = "login_form?url=/mvcSite/product_view?piid=<%=pi.getPi_id() %>";
<% } %>
}
</script>
<h2>상품 상세 화면</h2>
<table width="600" cellpadding="5">
<tr align="center">
<td width="35%">
	<!-- 이미지 관련 영역 -->
	<table width="100%" cellpadding="5">
	<tr><td colspan="3" align="center">
		<img src="/mvcSite/product/pdt_img/<%=pi.getPi_img1() %>"
		width="210" height="210" id="bigImg" />
	</td></tr>
	<tr align="center">
	<td width="33.3%">
		<img src="/mvcSite/product/pdt_img/<%=pi.getPi_img1() %>"
		width="70" height="70" onclick="showBig('<%=pi.getPi_img1() %>'); "/>
	</td>
	<td width="33.3%">
<% if (pi.getPi_img2() != null && !pi.getPi_img2().equals("")) { %>
		<img src="/mvcSite/product/pdt_img/<%=pi.getPi_img2() %>"
		width="70" height="70" onclick="showBig('<%=pi.getPi_img2() %>'); "/>
<% } %>	
	</td>
	<td width="33.3%">
<% if (pi.getPi_img3() != null && !pi.getPi_img3().equals("")) { %>
		<img src="/mvcSite/product/pdt_img/<%=pi.getPi_img3() %>"
		width="70" height="70" onclick="showBig('<%=pi.getPi_img3() %>'); "/>
<% } %>	
	</td>
	</tr>
	</table>
</td>
<td width="*" valign="top">
	<!-- 상품 정보 관련 영역 -->
	<form name="frm" method="post">
	<input type="hidden" name="kind" value="d" />
	<input type="hidden" name="piid" value="<%=pi.getPb_id() %>" />
	<table width="100%" cellpadding="5">
	<tr><td colspan="2">
		<a href="product_list?pcb=<%=pi.getPcs_id().substring(0,2) %>">
		<%=pi.getPcb_name() %></a> ->
		<a href="product_list?pcb=<%=pi.getPcs_id().substring(0,2) %>&pcs=<%=pi.getPcs_id()%>">
		<%=pi.getPcs_name() %></a>
	</td></tr>
	<tr>
	<td width="15%" align="right">상품명</td>
	<td width="*"><%=pi.getPi_name() %></td>
	</tr>
	<tr><td align="right">브랜드</td><td><%=pi.getPb_name() %></td></tr>
	<tr><td align="right">제조사</td><td><%=pi.getPi_com() %></td></tr>
	<tr><td align="right">가격</td><td><%=price %></td></tr>
	<tr>
	<td align="right">옵션</td>
	<td>
		<select name="size">
			<option value="" >사이즈 선택</option>
<%
for (int i = 0; i < stockList.size(); i++) {
	ProductStock ps = stockList.get(i);
	String opt = ps.getPs_size() + "mm (재고 : " + ps.getPs_stock() + "개)";
	String disabled = "";
	if (ps.getPs_stock() <= 0)	{
		disabled = " disabled=\"disabled\"";
		opt = ps.getPs_size() + "mm (재고 없음 : 품절)";
	}
	out.println("<option value='" + ps.getPs_idx() + "'" + disabled + ">" + opt + "</option>");
}
%>
		</select>
	</td>
	</tr>
	<tr>
	<td align="right">수량</td>
	<td>
		<input type="button" value="-" onclick="setCnt(this.value);" />
		<input type="text" name="cnt" id="cnt" value="1" readonly="readonly" />
		<input type="button" value="+" onclick="setCnt(this.value);" />
	</td>
	</tr>
	<tr><td colspan="2" align="right">
		구매 가격 : <span id="total"><%=realPrice %></span>원
	</td></tr>
	<tr><td colspan="2" align="center">
		<input type="button" value="장바구니 담기" class="smt" onclick="buy('c');" />
		<input type="button" value="바로 구매" class="smt" onclick="buy('d');" />
	</td></tr>
	</table>
	</form>
</td>
</tr>
</table>
</body>
</html>