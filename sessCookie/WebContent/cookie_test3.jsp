<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// language라는 쿠키가 있으면 그 값을 받아옴(없으면 기본값으로 한국어가 선택되게 함)
String language = "korean";
String cook = request.getHeader("Cookie");
if (cook != null){
	Cookie[] cookies = request.getCookies();
	for(int i = 0; i < cookies.length; i++){
		if(cookies[i].getName().equals("language")){
		// 현 쿠키(i인덱스의 쿠키)의 이름이 "language"이면
		language= cookies[i].getValue();
		break;
		}
	}
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- language라는 쿠키의 값으로 두 인삿말중 하나만 보이게 함 -->
<% if (language.equals("korean")) { %>
<h3>안녕하세요. 이것은 쿠키 예제 입니다.</h3>
<% } else { %>
<h3>Hello. This is Cookie example</h3>
<% } %>
<form action="cookie_test4.jsp" method="post">
<input type="radio" name="language" value="korean" id="korean" 
<% if (language.equals("korean")) { %>checked="checked"<% } %> />
<lable for="korean">한국어 패키지 보기</lable>
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="language" value="english" id="english" 
<% if (language.equals("english")) { %>checked="checked"<% } %> />
<lable for="english">영어 패키지 보기</lable><br />
<input type="submit" value="언어 설정" />
</form>
</body>
</html>