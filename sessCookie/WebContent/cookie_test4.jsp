<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// cookie_test3에서 보낸 라디오 버튼값을 'language'라는 이름의 쿠키로 생성 후 저장
// 만료기간은 하루(24시간)로 지정한 후 다시 cookie_test3.jsp로 이동시킴
request.setCharacterEncoding("utf-8");
Cookie cookie = new Cookie("language", request.getParameter("language"));
cookie.setMaxAge(60 * 60 * 24);
response.addCookie(cookie);
response.sendRedirect("cookie_test3.jsp");
%>