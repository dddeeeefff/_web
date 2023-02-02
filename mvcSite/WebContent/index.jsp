<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="_inc/inc_head.jsp" %>
<% if (isLogin) { %>
<a href="cart_view">장바구니</a>&nbsp;&nbsp;&nbsp;&nbsp;
<a href="schedule.sch">일정관리</a>
<% } else { %>
<a href="login_form?url=cart_view">장바구니</a>&nbsp;&nbsp;&nbsp;&nbsp;
<a href="login_form?url=schedule.sch">일정관리</a>
<% } %>
<hr />
<a href="free_list">자유 게시판</a>
<hr />
<h2>상품 목록</h2>
<form name="frm" action="product_list" method="get">
<input type="text" name="key" placeholder="상품명 검색" size="8" />
<input type="submit" value="검색" />
</form>
<hr />
<a href="combo_ctgr">상품분류</a>
</body>
</html>