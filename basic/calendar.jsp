<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
request.setCharacterEncoding("utf-8");
String tmpYear = request.getParameter("schYear");	// 달력 출력용 연도
String tmpMonth = request.getParameter("schMonth");	// 달력 출력용 월

int curYear, curMonth, curDay;	// 오늘 날짜의 연월일 값을 저장하기 위한 변수
Calendar today = Calendar.getInstance();	// 오늘 날짜를 저장할 인스턴스
curYear = today.get(Calendar.YEAR);		// 현재 연도
curMonth = today.get(Calendar.MONTH);	// 현재 월
curDay = today.get(Calendar.DATE);		// 현재 일

int schYear = curYear, schMonth = curMonth;	// 달력 출력용 연월을 저장할 변수
if(tmpYear != null && tmpMonth != null) { 	// 달력 출력용 연월을 받아왔을 경우
	schYear = Integer.parseInt(tmpYear);	// 달력 출력용으로 선택한 연도
	schMonth = Integer.parseInt(tmpMonth);	// 달력 출력용으로 선택한 월
}

Calendar sdate = Calendar.getInstance(); // 시작일을 저장할 인스턴스
Calendar edate = Calendar.getInstance(); // 종료일을 저장할 인스턴스
sdate.set(schYear, schMonth, 1); // 요일번호를 구하기 위한 시작일 지정
edate.set(schYear, schMonth + 1, 1);
edate.add(Calendar.DATE, -1); // 다음달 1일에서 하루를 뺀 날짜로 종료일 지정

int weekDay = sdate.get(Calendar.DAY_OF_WEEK);	
// 시작일의 요일번호이자 달력 출력시 1일의 시작 위치
int endDay = edate.get(Calendar.DATE);

int minYear = 1990, maxYear = curYear + 10;	//	연도 표현 범위

int prevYear = schYear - 1, prevMonth = schMonth - 1;
int nextYear = schYear + 1, nextMonth = schMonth + 1;

String prevYLink, prevMLink, nextYLink, nextMLink;
// 버튼들에서 사용할 링크 관련 문자열을 저장할 변수들

prevYLink = "?schYear=" + prevYear + "&schMonth=" + schMonth;
if (prevYear < minYear) prevYLink = "alert('이전연도가 없습니다');";
else	prevYLink = "location.href='calendar.jsp" + prevYLink + "';";

prevMLink = "?schYear=" + schYear + "&schMonth=" + prevMonth;
if (schMonth <= 0) {	// 현재 검색월이 1월일 경우
	if (schYear == minYear) prevMLink = "alert('이전연도가 없습니다');";
	else	prevMLink = "location.href='calendar.jsp?schYear=" + (schYear - 1) + "&schMonth=11';";
} else		prevMLink = "location.href='calendar.jsp" + prevMLink + "';";


nextYLink = "?schYear=" + nextYear + "&schMonth=" + schMonth;
if (nextYear > maxYear) nextYLink = "alert('다음연도가 없습니다');";
else	nextYLink = "location.href='calendar.jsp" + nextYLink + "';";

nextMLink = "?schYear=" + schYear + "&schMonth=" + nextMonth;
if (schMonth >= 11) {	// 현재 검색월이 12월일 경우
	if (schYear == maxYear) nextMLink = "alert('다음연도가 없습니다');";
	else	nextMLink = "location.href='calendar.jsp?schYear=" + (schYear + 1) + "&schMonth=0';";
} else		nextMLink = "location.href='calendar.jsp" + nextMLink + "';";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#searchBox { text-align:center; margin:0 0 20px 0; }
#calendar { border-collapse:collapse; }
#calendar th, #calendar td { border:1px solid black; }
#calendar td{ height:70px; }
.txtRed{ color:red; font-weight:bold; }
.txtBlue{ color:Blue; font-weight:bold; }
#txtToday{ background:pink; }
</style>
</head>
<body>
<div id="searchBox">
	<h2>일정관리 - <%=schYear %>년 <%=schMonth + 1 %>월</h2>
	<form>
	<!-- action과 method 속성은 기본값인 현재 파일과 get을 사용함 -->
	<input type="button" value="작년" onclick="<%=prevYLink %>" />
	<input type="button" value="이전달" onclick="<%=prevMLink %>" />&nbsp;&nbsp;&nbsp;
	
	<select name="schYear" onchange="this.form.submit()">
<% for (int i = minYear; i <= maxYear + 10; i++){ %>
		<option value="<%=i %>"<% if (i == schYear) {%> selected = "selected" <%} %>><%=i %></option>
<% } %>	
	</select>년
	<select name="schMonth" onchange="this.form.submit()">
<% for (int i = 0; i <= 11; i++){ %>
		<option value="<%=i %>"<% if (i == schMonth) {%> selected = "selected" <%} %>><%=i + 1 %></option>
<% } %>	
	</select>월	
	
	<input type="button" value="오늘" onclick="location.href='calendar.jsp';" />&nbsp;&nbsp;&nbsp;
	<input type="button" value="다음달" onclick="<%=nextMLink %>" />
	<input type="button" value="내년" onclick="<%=nextYLink %>" />
	</form>
</div>
<table width="700" align="center" id="calendar">
<tr height="30" >
	<th width="100" class="txtRed">일</th>
	<th width="100">월</th>
	<th width="100">화</th>
	<th width="100">수</th>
	<th width="100">목</th>
	<th width="100">금</th>
	<th width="100" class="txtBlue">토</th>
</tr>
<%
if (weekDay != 1){	// 1일이 일요일이 아니면(1일의 시작위치가 맨 앞이 아니면)
	out.println("<tr>");
	for(int i = 1; i < weekDay; i++) out.println("<td></td>");
	// 1일의 요일만큼 빈칸으로 채워 1일의 위치에서 출력되도록 함
}
String txtClass = "", txtID= "";
for (int i = 1, j = weekDay; i <= endDay; i++, j++){
// i : 날짜의 일(Day)을 표현하기 위한 변수
// j : 일주일 지날 때마다 다음 줄로 내리기 위한 변수
	txtClass = ""; txtID = "";
	
	if (j % 7 == 1) {
	// 현재 출력하려는 날짜의 요일 번호가 1(일요일)일 경우
		out.println("<tr>");
		txtClass = " class=\"txtRed\"";
	} else if (j % 7 == 0) txtClass = " class=\"txtBlue\"";
	
	if (schYear == curYear && schMonth == curMonth && i == curDay)
			txtID = " id=\"txtToday\" ";
	
	out.println("<td" + txtClass + txtID + " valign=\"top\">" + i + "</td>");
	
	if (j % 7 == 0) {
	// 방금 출력한 날짜의 요일 번호가 7(토요일)일 경우
		out.println("</tr>");
	} else if (i == endDay){
	// 말일까지 출력했으나 말일의 요일번호가 7의 배수가 아니어서 종료가 되지 않았을 경우
	// 남은 칸을  <td></td>로 채워준 후 </tr>로 닫아줌
		for (int k = j % 7; k < 7; k++)		out.println("<td></td>");
		out.println("</tr>");
	}
}
%>
</table>


<!-- 과제 : 로컬패키지로 바꿔서 만들기 -->


</body>
</html>