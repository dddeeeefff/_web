<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="_inc/inc_head.jsp" %>

<% if (login_info == null) { %>
<a href="login_form.jsp">로그인</a>
<% } else { %>
<%=login_info.getMi_name() %>님, 환영합니다.<br />
<a href="logout.jsp">로그아웃</a>	
<% } %>

<br />
<hr />
<a href="bbs/notice_list.jsp">공지 사항</a>
<hr />
<a href="bbs/free_list.jsp">자유 게시판</a>

<%@ include file="_inc/inc_foot.jsp" %>