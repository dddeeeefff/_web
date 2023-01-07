<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");

if (!isLogin) {
	out.println("<script>");
	out.println("alert('로그인 후 사용하실 수 있습니다.')");
	out.println("location.href='../login_form?url=schedule.sch';");
	out.println("</script>");
	out.close();
}

CalendarInfo ci = (CalendarInfo)request.getAttribute("ci");
// 달력 출력을 위한 정보(현재 연월일, 검색 연월)들을 저장하고 있는 인스턴스
ArrayList<ScheduleInfo> scheduleList = 
	(ArrayList<ScheduleInfo>)request.getAttribute("scheduleList");
// 검색 연월에 해당하는 일정들의 목록을 저장하고 있는 ArrayList

int sy = ci.getsYear(), sm = ci.getsMonth();
LocalDate sdate = LocalDate.of(sy, sm, 1);	// 달력 시작일
LocalDate edate = sdate.plusMonths(1);		// 시작일의 다음달 1일
edate = edate.minusDays(1);					// 달력 종료일
int sWeek = sdate.getDayOfWeek().getValue();// 시작일의 요일번호(1~7, 1: 월요일)
int eDay = edate.getDayOfMonth();			// 검색 연월의 말일(루프의 조건)

int minYear = 1990, maxYear = ci.getcYear() + 10;
// 연도 선택의 최소값과 최대값

int nextYear = sy + 1, nextMonth = sm + 1;	// 내년과 다음달 값
int prevYear = sy - 1, prevMonth = sm - 1;	// 작년돠 이전달 값

// '내년' 링크
String nextYearLink = "location.href='schedule.sch?schYear=" +
	nextYear + "&schMonth=" + sm + "';";
if (nextYear > maxYear)	nextYearLink="alert('다음 연도가 없습니다.');";

// '다음달' 링크
String nextMonthLink = "location.href='schedule.sch?schYear=" +
	sy + "&schMonth=" + nextMonth + "';";
if (nextMonth > 12){
	nextMonth = 1;	nextYear = sy + 1;
	if (nextYear > maxYear)	{
		nextMonthLink="alert('다음 연도가 없습니다.');";
	} else {
		nextMonthLink = "location.href='schedule.sch?schYear=" +
			nextYear + "&schMonth=" + nextMonth + "';";
	}
}

// '작년' 링크
String prevYearLink = "location.href='schedule.sch?schYear=" +
		prevYear + "&schMonth=" + sm + "';";
if (prevYear < minYear)	prevYearLink="alert('이전 연도가 없습니다.');";

//'이전달' 링크
String prevMonthLink = "location.href='schedule.sch?schYear=" +
	sy + "&schMonth=" + prevMonth + "';";
if (prevMonth < 1){
	prevMonth = 12;	prevYear = sy - 1;
	if (prevYear < minYear)	{
		prevMonthLink="alert('이전 연도가 없습니다.');";
	} else {
		prevMonthLink = "location.href='schedule.sch?schYear=" +
				prevYear + "&schMonth=" + prevMonth + "';";
	}
}

%>
<style>
#searchBox { text-align:center; margin:0 0 20px 0; }
#calendar { border-collapse:collapse; }
#calendar th, #calendar td { border:1px solid black; }
#calendar td { height:60px; font-size:1.1em; padding:5px 0 0 5px;}
.txtRed { color:red; font-weight:bold; }
.txtBlue { color:blue; font-weight:bold; }
#txtToday { background:pink; }
.scheduleBox {
	width:400px; height:150px; background:#fbef84; padding:10px 5px;
	overflow:auto; position:absolute; top:200px; left:150px; display:none;
}
</style>
<script>
function showSchedule(num) {
	var obj = document.getElementById("box" + num);
	obj.style.display="block";
}
function hideSchedule(num) {
	var obj = document.getElementById("box" + num);
	obj.style.display="none";
}
function callDel(idx) {
	if (confirm("정말 삭제하시겠습니까?")) {
		location.href = "schedule_proc.sch?kind=del&idx=" + idx + "&y=<%=sy %>&m=<%=sm %>";
	}
}
</script>
<div id="searchBox">
	<h2>일정 관리 - <%=sy %>년 <%=sm %>월</h2>
	<form name="frmCalendar">
		<input type="button" value="작년" onclick="<%=prevYearLink %>" />
		<input type="button" value="이전달" onclick="<%=prevMonthLink %>" />
		<select name="schYear" onchange="this.form.submit();">
	<% for (int i = minYear; i <= maxYear; i++) { %>
			<option <% if (i == sy) { %> selected="selected"<% } %>><%=i %></option> 
	<% } %>
		</select>년
		<select name="schMonth" onchange="this.form.submit();">
	<% for (int i = 1; i <= 12; i++) { %>
			<option <% if (i == sm) { %> selected="selected"<% } %>><%=i %></option> 
	<% } %>
		</select>월
		<input type="button" value="오늘" onclick="location.href='schedule.sch';" />
		<input type="button" value="다음달" onclick="<%=nextMonthLink %>" />
		<input type="button" value="내년" onclick="<%=nextYearLink %>" />
	</form>
</div>
<br />
<table width="700" id="calendar" align="center">
<tr height="30">
<th width="100">월</th><th width="100">화</th><th width="100">수</th>
<th width="100">목</th><th width="100">금</th>
<th width="100" class="txtBlue">토</th>
<th width="100" class="txtRed">일</th>
</tr>
<%
if (sWeek != 1) {	// 1일이 월요일이 아닐 경우(1일의 시작위치가 처음이 아니라면)
	out.println("<tr>");
	for (int i = 1; i < sWeek; i++)		out.println("<td></td>");
	// 1일의 요일 만큼 빈 칸으로 채워 1일의 출력위치를 잡도록 함
}

String txtClass = "", txtId = "", args = "", schImg = "", closeImg = "";
for (int i = 1, n = sWeek; i <= eDay; i++, n++) {
// i : 날짜의 일(day)을 출력하기 위한 변수 / n : 일주일이 지날 때마다 다른 줄로 내리기 위한 변수
	txtClass = "";	// 요일별 색상 스타일을 적용하기 위한 html 클래스용 변수
	txtId = "";		// 오늘 날짜인 경우 배경색 스타일을 적용하기 위한 html 아이디용 변수
	
	if (n % 7 == 1)	out.println("<tr>");
	// 요일번호가 1(월요일)이면 <tr>을 열어줌
	if (n % 7 == 6)	txtClass = " style=\"color:blue; font-weight:bold;\"";
	// 요일번호가 6(토요일)이면 글자색을 파란색으로 변경하는 html 클래스를 적용
	if (n % 7 == 0)	txtClass = " style=\"color:red; font-weight:bold;\"";
	// 요일번호가 7(일요일)이면 글자색을 빨간색으로 변경하는 html 클래스를 적용
	if (sy == ci.getcYear() && sm == ci.getcMonth() && i == ci.getcDay())
		txtId = " id=\"txtToday\"";
	// 현재 출력할 날짜가 오늘일 경우 배경색을 변경하는 html 아이디를 적용
	
	schImg = "";	closeImg = "";
	if (scheduleList.size() > 0) {
	// 검색 연월에 해당하는 일정이 있을 경우
		String schDate = sy + "-" + (sm < 10 ? "0" + sm : sm) + 
		"-" + (i < 10 ? "0" + i : i);	// 일정일자와 비교할 날짜 데이터
		
		out.println("<div class='scheduleBox' id='box" + i + "'>");
		for (int j = 0; j < scheduleList.size(); j++) {
			ScheduleInfo si = scheduleList.get(j);
			if (schDate.equals(si.getSi_start().substring(0, 10))){
			// 현재 출력하려는 날짜에 해당하는 일정이 있을 경우
				schImg = "<a href=\"javascript:showSchedule(" + i + ");\">" +
				"<img src='img/schedule_icon.png' width='20' " + 
				"style='margin-left:10px;' /></a>";
				closeImg = "<a href=\"javascript:hideSchedule(" + i + ");\">" +
				"<img src='img/close.png' width='20' " + 
				"style='margin-left:10px;' /></a>";
				
				args = "?kind=up&y=" + sy + "&m=" + sm + "&d=" + i;
%>
	<%=schDate %> 일정<%=closeImg %><br />
	일시 : <%=si.getSi_start().substring(11, 16) %>&nbsp;&nbsp;&nbsp;
	<input type="button" value="수정" 
	onclick="location.href='schedule_form.sch<%=args %>&idx=<%=si.getSi_idx() %>';" />
	<input type="button" value="삭제" onclick="callDel(<%=si.getSi_idx() %>);" />
	<br /><%=si.getSi_content().replace("\r\n", "<br />") %>
	<br /><br />등록일 : <%=si.getSi_date() %><hr />
<%
			}

		}
		out.println("</div>");
	}
	
	args = "?kind=in&y=" + sy + "&m=" + sm + "&d=" + i;
	out.println("<td valign='top'" + txtId + ">" + 
	"<a href='schedule_form.sch" + args + "'" + txtClass + 
	">" + i + "</a>" + schImg + "</td>");
	
	if (n % 7 == 0) {
		out.println("</tr>");
	} else if (i == eDay) {
	// 말일까지 출력했으나 요일번호가 7의 배수가 아니어서 종료가 되지 않았을 경우
	// 빈 칸으로 나머지를 채우고 종료</tr>
		for (int j = n % 7; j < 7; j++)	out.println("<td></td>");
		out.println("</tr>");
	}
}
%>
</table>
</body>
</html>