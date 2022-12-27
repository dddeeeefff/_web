<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="beanTest" class="test.BeanTest" scope="page" />
<!-- test패키지에 있는 BeanTest클래스의 인스턴스 beanTest를 생성하여 page영역(현재페이지)에서 
사용하겠다는 의미  -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>자바빈 사용예제</h2>
이름 : <%=beanTest.getName() %><br />
성별 : <%=beanTest.getGender() %><br />
<hr />
<!-- name을 '성춘향', gender를 '여자'로 변경 후 출력(액션 태그 사용) -->
<jsp:setProperty name="beanTest" property="name" value="성춘향" />
<jsp:setProperty name="beanTest" property="gender" value="여자" />

이름 : <jsp:getProperty name="beanTest" property="name" /><br />
성별 : <jsp:getProperty name="beanTest" property="gender" /><br />
</body>
</html>