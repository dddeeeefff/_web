<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%!
public int gugudan(int e){
	for(int i = 1; i < 10; i++){
		return (e * i) + "<br />";
	}
}
%>

<table>
	<tr>
		<td><% gugudan(2); %></td>
		<td><% gugudan(3); %></td>
		<td><% gugudan(4); %></td>
		<td><% gugudan(5); %></td>
		<td><% gugudan(6); %></td>
		<td><% gugudan(7); %></td>
		<td><% gugudan(8); %></td>
		<td><% gugudan(9); %></td>
	</tr>
</table>
</body>
</html>