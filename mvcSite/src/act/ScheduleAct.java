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
		// �ش� ������ ����Ǿ� �ִ� �������� ScheduleInfo�� �ν��Ͻ��� ������ ArrayList ����
		
		// ���� ��¥(������)�� �޷� ���� ��¥(������)�� ������ ������ ����
		int cYear, cMonth, cDay, sYear, sMonth, sDay;
		LocalDate today = LocalDate.now(); // ���ó�¥�� ���� �ν��Ͻ� ����
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
		// �޷� ��¿� �ʿ��� �������� CalendarInfo�� �ν��Ͻ� ci�� ����
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		
		ScheduleSvc scheduleSvc = new ScheduleSvc();
		scheduleList = scheduleSvc.getScheduleList(loginInfo.getMi_id(), sYear, sMonth);
		
		request.setAttribute("ci", ci);
		request.setAttribute("scheduleList", scheduleList);
		// �޷� ��¿� ���� �ν��Ͻ��� ���� ��� �ν��Ͻ��� request ��ü�� ����
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);	// ����ġ ������� �̵�
		forward.setPath("/member/schedule.jsp");
		
		return forward;
	}
}
