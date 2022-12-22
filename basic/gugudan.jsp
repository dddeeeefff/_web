<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- 
2 x 1 = 2		...		9 X 1 = 9
...						...
2 X 9 = 18		...		9 X 9 = 81
 -->
<table border="1">
<tr>
<%
	for(int i =2; i < 10; i++){
		out.println("<td>");
		for(int j =1; j < 10; j++){
			out.println(i + " X " + j + " = " + (i * j) + "<br />");
		}
		out.println("</td>");
	} 
%>
	</tr>
</table>
</body>
</html>