package act;

import javax.servlet.http.*;
import javax.servlet.*;
import java.util.*;
import java.time.*;
import java.io.*;
import svc.*;
import vo.*;

public class ScheduleAct implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("utf-8");
		ArrayList<ScheduleInfo> scheduleList = new ArrayList<ScheduleInfo>();
		// 해당 연월에 저장되어 있는 일정들을 ScheduleInfo형 인스턴스로 저장할 ArrayList 생성
		
		// 오늘 날짜(연월일)와 달력 시작 날짜(연월일)를 저장할 변수들 선언
		int cYear, cMonth, cDay, sYear, sMonth, sDay;
		LocalDate today = LocalDate.now(); // 오늘날짜를 가진 인스턴스 생성
		cYear = today.getYear();
		cMonth = today.getMonthValue();
		cDay = today.getDayOfMonth();
		
		if (request.getParameter("schYear") == null) {
			sYear = cYear;	sMonth = cMonth;	sDay = cDay;
		} else {
			sYear = Integer.parseInt(request.getParameter("schYear"));
			sMonth = Integer.parseInt(request.getParameter("schMonth"));
			sDay = 1;
		}
		CalendarInfo ci = new CalendarInfo();
		ci.setcYear(cYear);	ci.setcMonth(cMonth);	ci.setcDay(cDay);
		ci.setsYear(sYear);	ci.setsMonth(sMonth);	ci.setsDay(sDay);
		// 달력 출력에 필요한 정보들을 CalendarInfo형 인스턴스 ci에 저장
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		
		ScheduleSvc scheduleSvc = new ScheduleSvc();
		scheduleList = scheduleSvc.getScheduleList(loginInfo.getMi_id(), sYear, sMonth);
		
		request.setAttribute("ci", ci);
		request.setAttribute("scheduleList", scheduleList);
		// 달력 출력용 정보 인스턴스와 일정 목록 인스턴스를 request 객체에 저장
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);	// 디스패치 방식으로 이동
		forward.setPath("/member/schedule.jsp");
		
		return forward;
	}
}
