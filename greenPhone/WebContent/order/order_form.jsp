<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
ArrayList<SellCart> cartList = (ArrayList<SellCart>)request.getAttribute("cartList");
ArrayList<MemberInfo> addrList = (ArrayList<MemberInfo>)request.getAttribute("addrList");


if (!isLogin || cartList.size() == 0 || addrList.size() == 0) {
// 로그인이 안되어 있거나 구매할 상품 또는 배송지 정보가 하나도 없으면
	out.println("<script>");
	out.println("alert('잘못된 경로로 들어오셨습니다.');");
	out.println("history.back();");
	out.println("</script>");
	out.close();
}
%>
<style>
body{ margin:0 5% 0 5% }
table{ border-top:1.2px solid blue; border-bottom:1px solid blue; margin:0 auto; border-collapse: collapse; z-index:9;}
.addr {  margin:0 5% 0 5%; z-index:10; border-top:1px solid blue; padding:2px 0;}
.p1{ font-size:10px;  margin: 5px 0 5px 0; }
.p2{ font-size:10px;  margin: 1px 0 1px 0; }
.addr1 { display:flex; justify-content: space-between; }
.orderPrice { display:flex; justify-content: space-between; border-top:1px solid blue; border-bottom:1px solid blue; margin:0 auto; width:90%; padding:2px 10px;}
.usePoint { border-bottom:1px solid blue; margin:0 auto; width:90%; padding:5px 3px;}
.usePoint1 { display:flex; justify-content: space-between; }
.usePoint2 { display:flex; justify-content: flex-end; font-size:10px; padding:5px 0 0 0;}
.payment{ border-bottom:1px solid blue; margin:0 auto; width:90%; padding:2px 10px; }
.finalPay{ margin:0 auto; width:90%; padding:2px 10px; }
.fp{ border-bottom:1px solid #E0E0E0; display:flex; justify-content: space-between; font-size:12px; padding:5px 0;}
</style>
<script>
function popup(){
    var url = "/greenPhone/order/addr_popup.jsp";
    var name = "popup";
    var option = "width = 900, height = 900, top = 50%, left = 50%";
    awin = window.open(url, name, option);
}
</script>
<h2 style="text-align: center;">상품 구매</h2>
<table width="90%" cellpadding="5" >
<%
int total = 0;		// 총 구매 가격의 누적치 저장 변수
String scidxs = "";	// 장바구니 인덱스 번호들을 저장할 변수
for (int i = 0; i < cartList.size(); i++) {
	SellCart sc = cartList.get(i);
	scidxs += "," + sc.getSc_idx();
	int realPrice = sc.getPi_min() * sc.getSc_cnt();
	if (sc.getPi_dc() > 0)
		realPrice = sc.getPi_min() * (100 - sc.getPi_dc()) / 100 * sc.getSc_cnt();	
%>
<tr align="left" style="border-bottom:1px solid #E0E0E0;">
	<td width="10%" style="text-align: center;"><img src="/greenPhone/img/pdt_list/<%=sc.getPi_img1() %>" width="80" height="65" /></td>
	<td>
		<%=sc.getPi_name() %><br />
		<p class="p1"><%=sc.getPo_name() %></p>
		<p class="p1">수량&nbsp;<%=sc.getSc_cnt() %>개</p>
	</td>
	<td style="text-align: right;"><%=realPrice %>원</td>
</tr>
<%
	total += realPrice;
}	// 상품목록 for문
scidxs = (scidxs.indexOf(',') >= 0) ? scidxs.substring(1) : scidxs;
%>
</table>
<form name="frmOrder" action="order_proc_in" method="post">
<input type="hidden" name="total" value="" />
<input type="hidden" name="kind" value="" />
<input type="hidden" name="scidxs" value="" />
<div class="addr">
	<div class="addr1">
	<div>
		<h3 style="margin:3px 0; font-size:12px;">배송지</h3>
		<%
		for (int i = 0; i < addrList.size(); i++){
			MemberInfo mi = addrList.get(i);
		%>
		<p class="p2">&nbsp;<%=mi.getMi_name() %></p>
		<p class="p2">&nbsp;<%=mi.getMi_phone() %></p>
		<p class="p2">&nbsp;<%=mi.getMi_addr1() %></p>
		<p class="p2">&nbsp;<%=mi.getMi_addr2() %></p>
		<%
		}
		%>
	</div>
	<div>
		<input type="button" value="배송지 변경" onclick="popup();" />
	</div>
	</div>
	<select name="memo" style="width:100%;">
		<option value="선택하세요.">선택하세요.</option>
		<option value="배송전에 미리 연락바랍니다.">배송전에 미리 연락바랍니다.</option>
		<option value="부재시 경비실에 맡겨주세요.">부재시 경비실에 맡겨주세요.</option>
		<option value="문앞에다 놓아주세요.">문앞에다 놓아주세요.</option>
		<option value="부재시 전화하거나 문자 남겨주세요.">부재시 전화하거나 문자 남겨주세요.</option>
		<option value="직접입력" type="text">직접입력</option>
	</select>
	<input type="text" style="width:99%; height:90px; vertical-align:top;" />
</div><br />
<div class="orderPrice">
	<div><h3 style="margin:3px 0; font-size:12px;">주문금액</h3></div>
	<div><%=total %>원</div>
</div>
<div class="usePoint">
	<div class="usePoint1">
		<div><h3 style="margin:3px 0; font-size:12px;">포인트</h3></div>
		<%
		for (int i = 0; i < addrList.size(); i++) {
			MemberInfo mi = addrList.get(i);
		%>
		<div><input type="button" value="모두 사용" />보유 : <%=mi.getMi_point() %>P</div>
		<% } %>
	</div>
	<div class="usePoint2">
		*&nbsp;사용&nbsp;<input type="text" style="width:88%; text-align:right;" /><input type="button" value="적용" />
	</div>
</div>
<div class="payment">
	<h3 style="margin:3px 0; font-size:12px;">결제수단</h3>
	<input type="radio" name="si_payment" value="a" id="payA" />
	<label for="payA" style="font-size:11px;">카드 결제</label>&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="radio" name="si_payment" value="b" id="payB" />
	<label for="payB" style="font-size:11px;">휴대폰 결제</label>&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="radio" name="si_payment" value="c" id="payC" />
	<label for="payC" style="font-size:11px;">무통장 입금</label>&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="radio" name="si_payment" value="d" id="payD" />
	<label for="payD" style="font-size:11px;">포인트 결제</label>
</div>
<div class="finalPay">
	<h3 style="margin:3px 0; font-size:12px;">최종 결제 금액</h3>
	<div class="fp">
		<div>&nbsp;상품금액</div><div><%=total %>원</div>
	</div>
	<div class="fp">
		<div>&nbsp;사용 포인트</div><div>-<% %>P</div>
	</div>
	<div class="fp">
		<div>&nbsp;결제금액</div><div><% %>원</div>
	</div>
	<div class="fp">
		<div>&nbsp;적립 예정 포인트(결제 금액의 10%)</div><div><% %>P</div>
	</div>
</div>
<p text-align="center" style="display:flex; justify-content: center;">
	<input type="submit" value="구매 하기" />
</p>
</form>
</body>
</html>