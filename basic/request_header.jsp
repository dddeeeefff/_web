<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>Request 헤더 정보</h2>
<table border="1">
<tr><th>헤더이름</th><th>헤더 값</th></tr>
<tr>
<td>쿠키</td>
<td>
<%Cookie[] Coo =  request.getCookies();
out.println(Coo);
out.println(); %>
</td>
</tr>

<!-- 정리 요망 -->

<tr>
<td>서버 도메인명</td>
<td>
<%String serv = request.getServerName();
out.println(serv);
out.println(); %>
</td>
</tr>

<tr>
<td>서버 포트번호</td>
<td>
<%int sp = request.getServerPort();
out.println(sp);
out.println(); %>
</td>
</tr>

<tr>
<td>요청 URL</td>
<td>
<%StringBuffer URL =request.getRequestURL();
out.println(URL);
out.println(); %>
</td>
</tr>

<tr>
<td>요청  URI</td>
<td>
<%String uri = request.getRequestURI();
out.println(uri);
out.println(); %>
</td>
</tr>

<tr>
<td>요청  URI</td>
<td>
<%String qs = request.getQueryString();
out.println(qs);
out.println(); %>
</td>
</tr>

<tr>
<td>쿼리스트링</td>
<td>
<%String rh = request.getRemoteHost();
out.println(rh);
out.println(); %>
</td>
</tr>

<tr>
<td>클라이언트 호스트명</td>
<td>
<%String ra = request.getRemoteAddr();
out.println(ra);
out.println(); %>
</td>
</tr>

<tr>
<td>클라이언트 IP주소</td>
<td>
<%String pl = request.getProtocol();
out.println(pl);
out.println(); %>
</td>
</tr>

<tr>
<td>요청 방식</td>
<td>
<%String mtd = request.getMethod();
out.println(mtd);
out.println(); %>
</td>
</tr>

<tr>
<td>JSP 경로</td>
<td>
<%String cp = request.getContextPath();
out.println(cp);
out.println();
%>
</td>
</tr>




















</table>
</body>
</html>