<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="test.*" %>
<%
request.setCharacterEncoding("utf-8");
String name = request.getParameter("name");
String gender = request.getParameter("gender");

BeanTest beanTest2 = new BeanTest();
beanTest2.setName(name);
beanTest2.setGender(gender);
%>
<jsp:useBean id="beanTest" class="test.BeanTest" scope="page" />
<!-- 
<jsp:setProperty name="beanTest" property="name" param="name" />
<jsp:setProperty name="beanTest" property="gender" param="gender" />
 -->
<jsp:setProperty name="beanTest" property="*" />
<!-- 자바빈의 멤버변수와 받아오는 파라미터의 개수와 이름이 동일하면 '*'로 한 번에 모든 setter를
실행시킬 수 있음 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>자바빈즈 테스트 결과</h2>
이름 : <jsp:getProperty name="beanTest" property="name" /> <br />
성별 : <jsp:getProperty name="beanTest" property="gender" />
</body>
</html>