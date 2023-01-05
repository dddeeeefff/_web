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
		String args = "";
		String kind = request.getParameter("kind");
		int y = Integer.parseInt(request.getParameter("y"));
		int m = Integer.parseInt(request.getParameter("m"));
		int d = Integer.parseInt(request.getParameter("d"));
		int h = Integer.parseInt(request.getParameter("h"));
		int n = Integer.parseInt(request.getParameter("n"));
		String mi_id = request.getParameter("mi_id");
		String mi_start = request.getParameter("mi_start");
		String mi_content = request.getParameter("mi_content");
		
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(true);
		forward.setPath("schedule.sch" + args);
		
		return forward;
	}
}
