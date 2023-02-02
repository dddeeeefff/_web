<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
OrderInfo oi = (OrderInfo)request.getAttribute("orderInfo");
// 주문 공통 정보(배송지 및 결제 관련 정보)를 저장한 인스턴스를 받아옴
ArrayList<OrderDetail> dl = oi.getDetailList();
// 주문내 상품 정보들을 ArrayList<OrderDetail>로 받아옴
%>
<style>
.oe { width:700px; }
</style>
<h2>주문 완료</h2>
<p class="oe">배송지 정보</p>
<p class="oe">
수취인 : <%=oi.getOi_name() %><br />우편변호 : <%=oi.getOi_zip() %><br />
주소 : <%=oi.getOi_addr1() + " " + oi.getOi_addr2() %>
<hr />
</p>
<p class="oe">상품정보</p>
<%
for (int i = 0 ; i < dl.size() ; i++) {
	OrderDetail od = dl.get(i);
	String img = "/mvcSite/product/pdt_img/" + od.getOd_img();
	String lnk = "/mvcSite/product_view?piid=" + od.getPi_id();
%>
<p class="oe">
	<a href="<%=lnk %>"><img src="<%=img %>" width="110" height="90" /></a>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="<%=lnk %>"><%=od.getOd_name() %></a>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	사이즈 : <%=od.getOd_size() %>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	수량 : <%=od.getOd_cnt() %>개
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	가격 : <%=od.getOd_price() %>원
</p>
<%
}
%>
<p class="oe" align="right">
<%
String payment = "카드 결제";
if (oi.getOi_payment().equals("b"))			payment = "휴대폰 결제";
else if (oi.getOi_payment().equals("c"))	payment = "무통장 입금";
%>
<%=payment %> : 총 <%=oi.getOi_pay() %>원
</p>
<p class="oe" align="center">
	<input type="button" value="메인화면으로 이동" onclick="location.href='/mvcSite/';" />
</p>
</body>
</html>
