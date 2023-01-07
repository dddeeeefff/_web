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
				
		ScheduleInfo si = null;	// ���� �۾��� ������ ������ �����ϱ� ���� �ν��Ͻ�
		HttpSession session = request.getSession();
		MemberInfo mi = (MemberInfo)session.getAttribute("loginInfo");
		if(mi == null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/html charSet=utf-8");
			out.println("<script>");
			out.println("alert('�α��� �� ����Ͻ� �� �ֽ��ϴ�.');");
			out.println("location.href='login_form?url=schedule.sch';");
			out.println("</script>");
			out.close();
		}
		
		if (kind.equals("up")) {
			int idx = Integer.parseInt(request.getParameter("idx"));
			ScheduleFormSvc scheduleFormSvc = new ScheduleFormSvc();
			si = scheduleFormSvc.getScheduleInfo(mi.getMi_id(), idx);
			if (si == null) {
				PrintWriter out = response.getWriter();
				response.setContentType("text/html charSet=utf-8");
				out.println("<script>");
				out.println("alert('�߸��� ��η� ��� ���̽��ϴ�.');");
				out.println("history.back();");
				out.println("</script>");
				out.close();
			}
		}
		
		request.setAttribute("ci", ci);
		request.setAttribute("si", si);
		
		ActionForward forward = new ActionForward();
		forward.setPath("/member/schedule_form.jsp");
		
		return forward;
	}
}
