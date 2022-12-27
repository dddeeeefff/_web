<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%=getString(str) %>
<!-- 멤버변수 및 메소드를 사용하는 것이므로 선언한 위치에 상관없이 사용가능 -->
<hr />
<%! // 선언문으로 멤버(변수 및 메소드)를 선언 및 정의하는 영역으로 위치에 상관없이 파일 전체에서 사용가능
String str = "JSP & Servlet";

// 문자열을 인수로 받아 null이면 "no"를, 아니면 받은 문자열 뒤에 "_ok"를 붇여서 리턴하는  getString() 작성
public String getString(String s){
	if(s == null){
		return "no";
	}else{
		return s + "_ok";
	}
} 
%>
<hr />
<%
String str2 = getString(null);
out.println(str2);
%>
</body>
</html>