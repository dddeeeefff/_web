<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
// 페이징과 검색 조건들을 저장하고 있는 PageInfo형 인스턴스 pageInfo를 request해서 받아옴
ArrayList<ProductInfo> productList = 
	(ArrayList<ProductInfo>)request.getAttribute("productList");
ArrayList<ProductBrand> brandList = 
	(ArrayList<ProductBrand>)request.getAttribute("brandList");
ArrayList<ProductCtgrSmall> smallList = 
	(ArrayList<ProductCtgrSmall>)request.getAttribute("smallList");

int cpage = pageInfo.getCpage(), psize = pageInfo.getPsize();
int rcnt = pageInfo.getRcnt(), spage = pageInfo.getSpage();
int bsize = pageInfo.getBsize(), pcnt = pageInfo.getPcnt();

String args = "", sargs = "", oargs = "", vargs = "";
// 쿼리 스트링으로 각각 상세보기, 검색, 정렬, 보기방식용 쿼리스트링을 저장할 변수
String pcb = pageInfo.getPcb(), pcs = pageInfo.getPcs();
String sch = pageInfo.getSch(), o = pageInfo.getO(), v= pageInfo.getV(); // o : 정렬, v : 보기방식
if (pcb != null && !pcb.equals(""))	sargs += "&pcb=" + pcb;
if (pcs != null && !pcs.equals(""))	sargs += "&pcs=" + pcs;
if (sch != null && !sch.equals(""))	sargs += "&sch=" + sch;
if (o != null && !o.equals(""))		oargs += "&o=" + o;
if (v != null && !v.equals(""))		vargs += "&v=" + v;
args = "&cpage=" + cpage + sargs + oargs + vargs;
// 상품 상세보기 링크용 쿼리스트링

String name = "", chkBrd = "", sp = "", ep = "";
if (sch != null && !sch.equals("")) {	// sch검색 조건이 있으면
// sch : ntest,bB1:B2:B3,p100000~200000
	String[] arrSch = sch.split(",");
		for (int i = 0; i < arrSch.length; i++) {
			char c = arrSch[i].charAt(0);
			if (c == 'n') {			// 상품명 검색일 경우(n검색어)
				name = arrSch[i].substring(1);
			} else if (c == 'b') { 	// 브랜드 검색일 경우
				chkBrd = arrSch[i].substring(1);
			} else if (c == 'p') { 	// 가격대 검색일 경우(p시작가~종료가)
				sp = arrSch[i].substring(1, arrSch[i].indexOf('~'));
				ep = arrSch[i].substring(arrSch[i].indexOf('~') + 1);
			}
		}
}
%>
<h2>상품 목록</h2>
<div class="bigCata">
<a href="product_list?pcb=AA<%=oargs + vargs %>">구두</a></div>
<div class="bigCata">
<a href="product_list?pcb=BB<%=oargs + vargs %>">운동화</a></div>
<%
if (smallList.size() > 0) {	// 소분류 목록이 있으면(검색조건에 대분류가 있으면)
	out.println("<br /><br />");
	for (int i = 0; i < smallList.size(); i++) {
		ProductCtgrSmall ps = smallList.get(i);
		String tmp = "pcb=" + pcb + "&pcs=" + ps.getPcs_id() + oargs + vargs;
%>
<a href="product_list?<%=tmp %>"><%=ps.getPcs_name() %></a>&nbsp;&nbsp;
<%
	}
}
%>
<hr />
</body>
</html>
