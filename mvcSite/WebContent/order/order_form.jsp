<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
ArrayList<OrderCart> pdtList = (ArrayList<OrderCart>)request.getAttribute("pdtList");
ArrayList<MemberAddr> addrList = (ArrayList<MemberAddr>)request.getAttribute("addrList");

if (!isLogin || pdtList.size() == 0 || addrList.size() == 0) {
// 로그인이 안되어 있거나 구매할 상품 또는 배송지 정보가 하나도 없으면
	out.println("<script>");
	out.println("alert('잘못된 경로로 들어오셨습니다.');");
	out.println("history.back();");
	out.println("</script>");
	out.close();
}
%>
<style>
#name { border:none; }
</style>
<script>
function chAddr(val) {
	var frm = document.frmOrder;
	var arr = val.split("|");
	var phone = arr[2].split("-");
	frm.oi_name.value = arr[0];		frm.oi_rname.value = arr[1];
	frm.p1.value = phone[0];		frm.p2.value = phone[1];
	frm.p3.value = phone[2];		frm.oi_zip.value = arr[3];
	frm.oi_addr1.value = arr[4];	frm.oi_addr2.value = arr[5];
}
</script>

<h2>구매할 상품 목록</h2>
<table width="800" cellpadding="5">
<%
int total = 0;	// 총 구매 가격의 누적치를 저장할 변수
String ocidxs = "";	// 장바구니 인덱스 번호들을 누적 저장할 변수
for (int i = 0 ; i < pdtList.size() ; i++) {
	OrderCart oc = pdtList.get(i);
	ocidxs += "," + oc.getOc_idx();
	int realPrice = oc.getPi_price() * oc.getOc_cnt();
	if (oc.getPi_dc() > 0)
		realPrice = oc.getPi_price() * (100 - oc.getPi_dc()) / 100 * oc.getOc_cnt();
%>
<tr align="center">
<td width="15%">
	<img src="/mvcSite/product/pdt_img/<%=oc.getPi_img1() %>" width="110" height="90" />
</td>
<td width="25%" align="left">&nbsp;&nbsp;<%=oc.getPi_name() %></td>
<td width="20%"><%=oc.getPs_size() %>mm</td>
<td width="15%"><%=oc.getOc_cnt() %>개</td>
<td width="*"><%=realPrice %>원</td>
</tr>
<%
	total += realPrice;
}	// 상품목록 for문 종료
ocidxs = (ocidxs.indexOf(',') >= 0) ? ocidxs.substring(1) : ocidxs;
%>
</table>
<p style="width:800px;" align="right">총 결제 금액 : <%=total %>원</p>
<hr />
<form name="frmOrder" action="order_proc_in" method="post">
<input type="hidden" name="total" value="<%=total %>" />
<input type="hidden" name="kind" value="<%=request.getParameter("kind") %>" />
<input type="hidden" name="ocidxs" value="<%=ocidxs %>" />
<h2>배송지 정보</h2>
<table width="800" cellpadding="5">
<tr>
<th>배송지 선택</th>
<td colspan="3">
	<select onchange="chAddr(this.value);">
<%
String oiname = "", oirname = "", oiphone = "", oizip = "", oiaddr1 = "", oiaddr2 = "";
// 처음 페이지 로딩시 보여줄 기본주소의 값들을 저장할 변수
for (int i = 0 ; i < addrList.size() ; i++) {
	MemberAddr ma = addrList.get(i);
	if (ma.getMa_basic().equals("y")) {	// 기본 주소 이면
		oiname = ma.getMa_name();	oirname = ma.getMa_rname();	
		oiphone = ma.getMa_phone();	oizip = ma.getMa_zip();
		oiaddr1 = ma.getMa_addr1();	oiaddr2 = ma.getMa_addr2();
	}
	String val = "", txt = "";
	val = ma.getMa_name() + "|" + ma.getMa_rname() + "|" + ma.getMa_phone() + "|" + 
		ma.getMa_zip() + "|" + ma.getMa_addr1() + "|" + ma.getMa_addr2();
	txt = "[" + ma.getMa_name() + "] " + ma.getMa_addr1() + " " + ma.getMa_addr2();
	out.println("<option value=\"" + val + "\">" + txt + "</option>");
}
%>
	</select>
</td>
</tr>
<tr>
<th width="15%">주소명</th>
<td width="35%">
<input type="text" name="oi_name" id="name" value="<%=oiname %>" readonly="readonly" onfocus="this.blur();" />
</td>
<th width="15%">수취인명</th>
<td width="35%">
	<input type="text" name="oi_rname" value="<%=oirname %>" />
</td>
</tr>
<tr>
<th>전화번호</th>
<td>
<%
String[] arr = oiphone.split("-");
%>
	<select name="p1">
		<option <% if (arr[0].equals("010")) { %>selected="selected"<% } %>>010</option>
		<option <% if (arr[0].equals("011")) { %>selected="selected"<% } %>>011</option>
		<option <% if (arr[0].equals("016")) { %>selected="selected"<% } %>>016</option>
		<option <% if (arr[0].equals("019")) { %>selected="selected"<% } %>>019</option>
	</select> - 
	<input type="text" name="p2" value="<%=arr[1] %>" size="4" maxlength="4" /> - 
	<input type="text" name="p3" value="<%=arr[2] %>" size="4" maxlength="4" />
</td>
<th>우편번호</th>
<td><input type="text" name="oi_zip" value="<%=oizip %>" size="5" maxlength="5" /></td>
</tr>
<tr>
<th>주소</th>
<td colspan="3">
	<input type="text" name="oi_addr1" value="<%=oiaddr1 %>" size="40" />
	<input type="text" name="oi_addr2" value="<%=oiaddr2 %>" size="40" />
</td>
</tr>
</table>
<hr />
<h2>결제 정보</h2>
<p style="width:800px;">
	<input type="radio" name="oi_payment" value="a" id="payA" />
	<label for="payA">카드 결제</label>&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="radio" name="oi_payment" value="b" id="payB" />
	<label for="payB">휴대폰 결제</label>&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="radio" name="oi_payment" value="c" id="payC" />
	<label for="payC">무통장 입금</label>
</p>
<hr />
<p style="width:800px;" text-align="center;">
	<input type="submit" value="구매 하기" />
</p>
</form>
</body>
</html>
