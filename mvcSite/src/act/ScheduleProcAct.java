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
		
		// 입력 또는 수정을 위한 데이터를 인스턴스에 저장
		ScheduleInfo si = new ScheduleInfo();
		si.setMi_id(mi.getMi_id());
		
		if (!kind.equals("del")) {
		// 일정 삭제가 아니면(일정 등록이나 일정 수정일 경우)
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
			// 일정 등록이 아니면(일정 수정이나 일정 삭제일 경우)	
			int idx = Integer.parseInt(request.getParameter("idx"));
			si.setSi_idx(idx);
			// 수정이나 삭제시 조건에 필요한 primary key인 idx값을 si에 저장
		}
		
		ScheduleProcSvc scheduleProcSvc = new ScheduleProcSvc();
		int result = scheduleProcSvc.scheduleProc(kind, si);
		
		if (result == 0) {	// 작업 실패시
			PrintWriter out = response.getWriter();
			response.setContentType("text/html charSet=utf-8");
			out.println("<script>");
			out.println("alert('작업에 실패했습니다'); history.back();");
			out.println("</script>");
			out.close();
		}
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(true);
		forward.setPath("schedule.sch?schYear=" + y + "&schMonth=" + m);
		
		return forward;
	}
}
