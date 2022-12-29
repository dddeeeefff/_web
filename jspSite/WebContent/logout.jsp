<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
session.invalidate();	// 세션의 모든 속성을 날림

response.sendRedirect("index.jsp");
%>