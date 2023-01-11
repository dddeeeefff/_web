<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");

// 페이징과 검색조건을 저장하고 있는 PageInfo형 인스턴스 pageInfo를 request에서 받아옴
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo"); 
// 상품 목록
ArrayList<ProductInfo> productList = (ArrayList<ProductInfo>)request.getAttribute("productList"); 
// 브랜드
ArrayList<ProductBrand> brandList = (ArrayList<ProductBrand>)request.getAttribute("brandList"); 
// 소분류
ArrayList<ProductCtgrSmall> smallList = (ArrayList<ProductCtgrSmall>)request.getAttribute("smallList"); 

int cpage = pageInfo.getCpage(), psize = pageInfo.getPsize();
int rcnt = pageInfo.getRcnt(), spage = pageInfo.getSpage();
int bsize = pageInfo.getBsize(), pcnt = pageInfo.getPcnt();

// 쿼리 스트링으로 각각 상세보기, 검색, 정렬, 보기방식용 쿼리스트링을 저장할 변수
String args = "", sargs = "", oargs = "", vargs = "";

// 검색용 쿼리스트링 만듬
String pcb = pageInfo.getPcb(), pcs = pageInfo.getPcs();
String sch = pageInfo.getSch(), o = pageInfo.getO(), v = pageInfo.getV();
if(pcb != null && !pcb.equals("")) sargs += "&pcb=" + pcb;
if(pcs != null && !pcs.equals("")) sargs += "&pcs=" + pcs;
if(sch != null && !sch.equals("")) sargs += "&sch=" + sch;
if(o != null && !o.equals("")) oargs += "&o=" + o;
if(v != null && !v.equals("")) vargs += "&v=" + v;
// 상품 상세보기 링크용 쿼리스트링
args = "&cpage=" + cpage + sargs + oargs + vargs;

String name = "", chkBrd = "", sp = "", ep = "";
// 검색 조건이 있으면
if(sch != null && !sch.equals("")) {
	String[] arrSch = sch.split(",");
	for(int i = 0; i < arrSch.length; i++) {
		char c = arrSch[i].charAt(0);
		if(c == 'n') {
			name = arrSch[i].substring(1);
		}
		else if(c == 'b') {
			chkBrd = arrSch[i].substring(1);
		}
		else if(c == 'p') {
			sp = arrSch[i].substring(1, arrSch[i].indexOf('~'));
			ep = arrSch[i].substring(arrSch[i].indexOf('~') + 1);
		}
	}
}
else {
	sch = "";
}
%>
<style>
.bigCata {
	width: 100px; height: 30px; font-size: 1.5em; background: #efefef;
	text-align: center; border: 1px solid #c1c1c1; margin: 10px;
	padding: 5px; display: inline;
}
#pcb {background: lightgreen;}
#pdt {width: 140px; border: none; border-bottom: 1px solid black;}
.price {
	width: 48px; border: none; border-bottom: 1px solid black;
	font-size: 0.8em; text-align: right;
}
.btn {width: 70px; font-size: 0.7em; margin-top: 5px;}
li {list-style-type: none;}
</style>
<script>
// 검색 조건들로 sch의 값을 만듬
function makeSch() {
	var frm = document.frm2;
	var sch = "";
	
	// 상품명
	var pdt = frm.pdt.value; // 상품명 검색
	if(pdt != "") sch += "n" + pdt;
	
	// 브랜드
	var arrBrd = frm.brd // 브랜드 선택 체크박스들을 배열로 받아옴
	var isFirst = true;  //  브랜드 체크박스들중 첫번째로 선택한 값인지 여부를 저장할 변수
	for(var i = 1; i < arrBrd.length; i++) {
		// i 인덱스에 해당하는 체크박스가 선택되어 있다면
		if(arrBrd[i].checked) {
			if(isFirst) { // 첫번째 선택한 브랜드 이면
				isFirst = false;
				if(sch != "") sch += ",";
				sch += "b" + arrBrd[i].value;
			}
			else {
				sch += ":" + arrBrd[i].value;
			}
		}
	}
	
	// 가격대
	var sp = frm.sp.value, ep = frm.ep.value;
	if(sp != "" || ep != "") {// 가격대중 하나라도 값이 있으면
		if(sch != "") sch += ",";
		sch += "p" + sp + "~" + ep;
	}
	
	document.frm1.sch.value = sch;
	document.frm1.submit();
}

// 검색조건 초기화 (상품명, 브랜드, 가격대)
function initSch() {
	var frm = document.frm2;
	frm.pdt.value = "";
	frm.sp.value = "";
	frm.ep.value = "";
	
	var arrBrd = frm.brd
	for(var i = 1; i < arrBrd.length; i++) {arrBrd[i].checked = false;}
}
</script>
<h2>상품 목록</h2>
<div class="bigCata" <%if(pcb != null && pcb.equals("AA")) {%>id="pcb"<%} %>>
	<a href="product_list?pcb=AA<%=oargs + vargs %>">구두</a>
</div>
<div class="bigCata" <%if(pcb != null && pcb.equals("BB")) {%>id="pcb"<%} %>>
	<a href="product_list?pcb=BB<%=oargs + vargs %>">운동화</a>
</div>
<%
if(smallList.size() > 0) { // 검색 조건에 대분류가 있으면
	out.println("<br /><br />");
	for(int i = 0; i < smallList.size(); i++) {
		ProductCtgrSmall ps = smallList.get(i);
		String tmp = "pcb=" + pcb + "&pcs=" + ps.getPcs_id() + oargs + vargs;
%>
<a href="product_list?<%=tmp %>"><%=ps.getPcs_name() %></a>&nbsp;&nbsp;&nbsp;
<%
	}
} 
%>
<hr />
<table width="800">
<tr>
	<!-- 점색 조건 입력 -->
	<td width="150" valign="top">
		<!-- 검색조건으로 링크를 걸기위한 쿼리스트링용 컨트롤들의 집합 -->
		<form name="frm1">
			<input type="hidden" name="pcb" value="<%=pcb %>" />
			<%if(pcs != null && !pcs.equals("")) { %>
			<input type="hidden" name="pcs" value="<%=pcs %>" />
			<%} %>
			<input type="hidden" name="o" value="<%=o %>" />
			<input type="hidden" name="v" value="<%=v %>" />
			<input type="hidden" name="sch" value="<%=sch %>" />
		</form>
		<!-- 실제 검색조건을 선택 및 입력하는 폼 -->
		<form name="frm2">
		<input type="hidden" name="brd" value="" />
		<div>
			<input type="text" name="pdt" id="pdt" placeholder="상품명 검색" value="<%=name %>" /><br />
			<fieldset>
				<legend>브랜드</legend>
			<%
			for(int i = 0; i < brandList.size(); i++) { 
				ProductBrand pb = brandList.get(i);				
			%>
				<input type="checkbox" name="brd" id="brd<%=i %>" value="<%=pb.getPb_id() %>"
				<%if(chkBrd.indexOf(pb.getPb_id()) >= 0){ %> checked="checked" <%} %>/>
				<label for="brd<%=i %>"><%=pb.getPb_name() %></label><br />
			<%} %>
			</fieldset>
			<fieldset>
				<legend>가격대</legend>
				<input type="text" name="sp" class="price" onkeyup="onlyNum(this);" value="<%=sp %>" 
				placeholder="최저가" /> 
				~
				<input type="text" name="ep" class="price" onkeyup="onlyNum(this);" value="<%=ep %>" 
				placeholder="최고가" />
			</fieldset>
			<input type="button" value="상품 검색" class="btn" onclick="makeSch();" />
			<input type="button" value="조건 초기화" class="btn" onclick="initSch();" />
		</div>
		</form>
	</td>
	<!-- 상품 목록 및 페이징 -->
	<td width="*" valign="top">
	<%
	if(rcnt > 0) { // 검색된 상품 목록이 있으면
		// 보기방식(목록형, 갤러리형) 이미지 지정
		String imgList = "/mvcSite/img/ico_l.png";
		String imgGall = "/mvcSite/img/ico_g.png";
		if(v.equals("g")) imgGall = "/mvcSite/img/ico_g_on.png";
		else imgList = "/mvcSite/img/ico_l_on.png";
		
		// 정렬 및 보기 방식용 공통 링크
		String lnk = "product_list?capge=" + cpage + sargs;
	%>
		<p align="right">
			<select name="o" onchange="location.href='product_list?<%=lnk %>&v=<%=v %>&o=' + this.value;">
				<option value="a" <%if(o.equals("a")) { %> selected="selected" <%} %>>신상품 순</option>
				<option value="b" <%if(o.equals("b")) { %> selected="selected" <%} %>>인기 순</option>
				<option value="c" <%if(o.equals("c")) { %> selected="selected" <%} %>>낮은 가격순</option>
				<option value="d" <%if(o.equals("d")) { %> selected="selected" <%} %>>높은 가격순</option>
				<option value="e" <%if(o.equals("e")) { %> selected="selected" <%} %>>평점순</option>
				<option value="f" <%if(o.equals("f")) { %> selected="selected" <%} %>>리뷰순</option>
				<option value="g" <%if(o.equals("g")) { %> selected="selected" <%} %>>조회순</option>
			</select>&nbsp;&nbsp;&nbsp;
			<a href="<%=lnk + oargs %>&o=<%=o %>&v=l">
				<img src="<%=imgList %>" width="18" height="22" align="absmiddle" />
			</a>
			<a href="<%=lnk + oargs %>&o=<%=o %>&v=g">
				<img src="<%=imgGall %>" width="18" height="22" align="absmiddle" />
			</a>
		</p>
		<hr />
		<table width="100%" cellpadding="5" cellspacing="0">
	<%
		if(v.equals("g")) { // 보기 방식이 갤러리형일 경우
			int i = 0;
			for(i = 0; i < rcnt; i++) {
				ProductInfo pi = productList.get(i);
				lnk = "product_view?piid=" + pi.getPi_id() + args;
				
				String price = pi.getPi_price() + "원";
				if(pi.getPi_dc() > 0) {
					price = pi.getPi_price() * (100 - pi.getPi_dc()) / 100 + "원";
					price = "<del>" + pi.getPi_price() + "원</del>&nbsp;&nbsp;" + price;
				}
				
				if(i % 4 == 0) out.println("<tr>");
%>		
			<td width="25%" align="center" onmouseover="this.bgColor='efefef';" onmouseout="this.bgColor='';">
				<a href="<%=lnk %>">
				<img src="/mvcSite/product/pdt_img/<%=pi.getPi_img1() %>" width="100" height="100" border="0" />
				<br /><%=pi.getPi_name() %><br /></a>
				<%=price %><br />원
				재고량 : <%=pi.getStock() %>ea
			</td>
<% 			
				if(i % 4 == 3) out.println("</tr>");
			}
			if(i % 4 > 0) {
				for(int j = 0; j < (4 - (i % 4)); j++) {
					out.println("<td width='25%'align='center'><td>");
					out.println("</tr>");
				}
			}
		}
		else { // 보기 방식이 목록형일 경우
			for(int i = 0; i < rcnt; i++) {
				ProductInfo pi = productList.get(i);
				lnk = "product_view?piid=" + pi.getPi_id();
				
				String price = pi.getPi_price() + "원";
				if(pi.getPi_dc() > 0) {
					price = pi.getPi_price() * (100 - pi.getPi_dc()) / 100 + "원";
					price = "<del>" + pi.getPi_price() + "원</del><br />" + price;
				}
%>
	<tr align="center" onmouseover="this.bgColor='efefef';" onmouseout="this.bgColor='';">
		<td width="25%">
			<a href="<%=lnk %>">
			<img src="/mvcSite/product/pdt_img/<%=pi.getPi_img1() %>" width="100" height="100" border="0" />
			</a>
		</td>
		<td width="*%" align="left">&nbsp;&nbsp;
			<a href="<%=lnk %>"><%=pi.getPi_name() %></a>
		</td>
		<td width="15%"><%=price %></td>
		<td width="20%">재고량 : <%=pi.getStock() %>ea</td>
	</tr>
<% 
			}
		}
		out.println("</table>");
		
		// 페이징 영역 링크에서 사용할 쿼리 스트링
		String tmp = sargs + oargs + vargs;
		
		out.println("<p align='center'>");
		
		if(cpage == 1) {
			out.println("[&lt;&lt;]&nbsp;&nbsp;[&lt;]&nbsp;");
		}
		else {
			out.println("<a href=\"product_list?cpage=1" + tmp + "\">");
			out.println("[&lt;&lt;]</a>&nbsp;&nbsp;");
			out.println("<a href=\"product_list?cpage=" + (cpage - 1) + tmp + "\">");
			out.println("[&lt;&lt;]</a>&nbsp;");
		}
		
		for(int i = 1, j = spage; i < bsize && j <= pcnt; i++, j++) {
			if(cpage == j) {
				out.println("&nbsp;<strong>" + j + "</strong>&nbsp;");
			}
			else {
				out.print("&nbsp;<a href=\"product_list?cpage=");
				out.println(j + tmp + "\">" + j + "</a>&nbsp;");
			}
		}
		
		if(cpage == pcnt) {
			out.println("&nbsp;[&gt;]&nbsp;&nbsp;[&gt;&gt;]");
		}
		else {
			out.println("&nbsp;<a href=\"product_list?cpage=" + (cpage + 1) + tmp + "\">");
			out.println("[&gt;]</a>");
			out.println("&nbsp;&nbsp;<a href=\"product_list?cpage=1" + tmp + "\">");
			out.println("[&gt;&gt;]</a>");
		}
		
		out.println("</p>");
	}
	else { // 검색된 상품 목록이 업으면
		out.println("검색 결과가 없습니다.");
	}
	%>
	</td>
<tr>
</table>
</body>
</html>