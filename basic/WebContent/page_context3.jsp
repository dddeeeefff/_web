<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 
 pageContext2.jsp에서 psgeContext 객체의 include() 메소드로 include되는 파일이므로 
  page_context2에서 선언한 변수 등의 값을 사용할 수 없음(page 지시어의 include와 다른점)
 -->
<h2>page_context3</h2>
이 파일은 pageContext2.jsp에서 psgeContext 객체를 이용하여 
include된 pageContext3.jsp 파일입니다.