package act;

import javax.servlet.http.*;
import javax.servlet.*;
import java.util.*;
import java.time.*;
import java.time.temporal.*;
import java.io.*;
import svc.*;
import vo.*;

public class ScheduleProcAct implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("utf-8");
		String kind = request.getParameter("kind");
		String y = request.getParameter("y");
		String m = request.getParameter("m");
		
		HttpSession session = request.getSession();
		MemberInfo mi = (MemberInfo)session.getAttribute("loginInfo");
		
		// �Է� �Ǵ� ������ ���� �����͸� �ν��Ͻ��� ����
		ScheduleInfo si = new ScheduleInfo();
		si.setMi_id(mi.getMi_id());
		
		if (!kind.equals("del")) {
		// ���� ������ �ƴϸ�(���� ����̳� ���� ������ ���)
		String d = request.getParameter("d");
		String h = request.getParameter("h");
		String n = request.getParameter("n");
		String start = y + "-" + m + "-" + d + " " + h + ":" + n + ":00";
		String content = 
			request.getParameter("content").trim().replace("'", "''");
		
		si.setSi_start(start);
		si.setSi_content(content);
		}
		if(!kind.equals("in")) {
			// ���� ����� �ƴϸ�(���� �����̳� ���� ������ ���)	
			int idx = Integer.parseInt(request.getParameter("idx"));
			si.setSi_idx(idx);
			// �����̳� ������ ���ǿ� �ʿ��� primary key�� idx���� si�� ����
		}
		
		ScheduleProcSvc scheduleProcSvc = new ScheduleProcSvc();
		int result = scheduleProcSvc.scheduleProc(kind, si);
		
		if (result == 0) {	// �۾� ���н�
			PrintWriter out = response.getWriter();
			response.setContentType("text/html charSet=utf-8");
			out.println("<script>");
			out.println("alert('�۾��� �����߽��ϴ�'); history.back();");
			out.println("</script>");
			out.close();
		}
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(true);
		forward.setPath("schedule.sch?schYear=" + y + "&schMonth=" + m);
		
		return forward;
	}
}
