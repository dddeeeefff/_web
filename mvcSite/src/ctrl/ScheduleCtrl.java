package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import act.*;
import vo.*;

@WebServlet("*.sch")	// .sch로 끝나는 모든 요청을 받겠다는 의미
public class ScheduleCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public ScheduleCtrl() { super(); }
    
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String requestUri = request.getRequestURI();
		// /mvcSite/schedule.sch
		String command = requestUri.substring(requestUri.lastIndexOf('/') + 1);
		// schedule.sch
		
		ActionForward forward = null;
		Action action = null;
		
		switch (command) {			// 일정관리 달력 요청
		case "schedule.sch" :
			action = new ScheduleAct();		break;
		case "schedule_form.sch" :	// 일정 등록 및 수정 폼 요청
			action = new ScheduleFormAct();	break;
		case "schedule_proc.sch" :	// 일정 등록, 수정, 삭제 처리 요청
			action = new ScheduleProcAct();	break;
		}
		
		try {
			forward = action.execute(request, response);
		} catch(Exception e) { e.printStackTrace(); }
		
		if (forward != null) {
			if (forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
			} else {
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}
		}
	}
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
}
