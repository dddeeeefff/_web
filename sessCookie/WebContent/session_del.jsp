<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// session 객체에 name 이라는 속성을 삭제 후 "session_test.jsp"로 이동
session.removeAttribute("name");

response.sendRedirect("session_test.jsp");
%>