<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#pdt { border-collapse:collapse; }
#pdt,#pdt td { border:1px black solid; }
#pdt td { text-align:center;width:150px; height:100px }
#paging{ width:600px; }
</style>
</head>
<body>

<h2>상품목록</h2>
<table width="600" id="pdt">
<%
	int num = 0;
	for(int i = 1; i <= 10; i++){
		if(i % 4 == 1)	out.println("<tr>");
%>
<td>상품 <%=i %> </td>
<%	
		if(i % 4 == 0)	out.println("</tr>");
		num = i % 4;
	}
	
	if(num > 0){	// 상품 개수가 4의 배수가 아니면(정상적으로 tr을 닫은 것이 아니면)
		out.println("<td colspan=\"" + (4 - num) + "\"></td></tr>");
		
	}
%>	
</table>

<p id = "paging" align = "center">
	<a href="#">&lt;&lt;</a>&nbsp;&nbsp;
	<a href="#">&lt;</a>&nbsp;&nbsp;
<%
	int cpage = 3;
	for(int i = 1; i <= 10; i++){
		if(i == cpage) out.println("<strong>" + i + "<strong>&nbsp;&nbsp;");
		else
			out.println("<a href=\"#\">" + i + "</a>&nbsp;&nbsp;");
			
	} 
%>
	<a href="#">&gt;</a>
	&nbsp;&nbsp;<a href="#">&gt;&gt;</a>
	
</p>
</body>
</html>