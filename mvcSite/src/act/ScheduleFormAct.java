package act;

import javax.servlet.http.*;
import javax.servlet.*;
import java.util.*;
import java.time.*;
import java.time.temporal.*;
import java.io.*;
import svc.*;
import vo.*;

public class ScheduleFormAct implements Action{
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("utf-8");
		String kind = request.getParameter("kind");
		int y = Integer.parseInt(request.getParameter("y"));
		int m = Integer.parseInt(request.getParameter("m"));
		int d = Integer.parseInt(request.getParameter("d"));
		
		CalendarInfo ci = new CalendarInfo();
		ci.setsYear(y);		ci.setsMonth(m);	ci.setsDay(d);
		LocalDate schDate = LocalDate.of(y, m, d);
		LocalDate eDay = schDate.with(TemporalAdjusters.lastDayOfMonth());
		ci.setLastDay(eDay.getDayOfMonth());
		LocalDate cDate = LocalDate.now();
		ci.setcYear(cDate.getYear());
		
		ScheduleInfo si = null;	// 수정 작업시 기존의 일정을 저장하기 위한 인스턴스
		if (kind.equals("up")) {
			
		}
		
		request.setAttribute("ci", ci);
		request.setAttribute("si", si);
		
		ActionForward forward = new ActionForward();
		forward.setPath("/member/schedule_form.jsp");
		
		return forward;
	}
}
