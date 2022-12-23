<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("utf-8");
// 사용자가 보낸 요청(데이터 포함)이 들어있는 객체인 request의 인코딩을 유니코드로 설정

String kind = request.getParameter("kind");

String uid = request.getParameter("uid");
String pwd = request.getParameter("pwd");
String t1 = request.getParameter("t1");
String t2 = request.getParameter("t2");

String name = request.getParameter("name");
String e1 = request.getParameter("e1");
String e2 = request.getParameter("e2");
String email = e1 + "@" + e2;

String g = request.getParameter("gender");
String gender = "";
if (g != null) gender = g.equals("m") ? "남자" : "여자";
// g의 값이 null이 아닐 경우에만 조건연산자를 통해 '남자' 또는 '여자'의 값을 gender에 저장
// g의 값이 null이면 equals()메소드 사용시  NullPointerException 발생

String[] arrHobby = request.getParameterValues("hobby");
String hobby = "";
if (arrHobby == null){
	hobby = "취미없음";
}else{
	for(int i = 0; i < arrHobby.length; i++){
		hobby = hobby + ", " + arrHobby[i];
}
	hobby = hobby.substring(2);
}


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% if (kind.equals("a")){ %>
아이디 : <%=uid %> / 비밀번호 : <%=pwd %><br />
t1 : <%=t1 %> / t2 : <%=t2 %>
<% } else if(kind.equals("b")){ %>
이름 : <%=name %> / 이메일 : <%=email %><br />
t1 : <%=t1 %> / t2 : <%=t2 %>	
<% } else if(kind.equals("c")){ %>
성별 : <%=gender %> / 취미 : <%=hobby %>
<% } %>


</body>
</html>