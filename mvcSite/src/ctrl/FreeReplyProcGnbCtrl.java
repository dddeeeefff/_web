package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/free_reply_proc_gnb")
public class FreeReplyProcGnbCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L; 
    public FreeReplyProcGnbCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String gnb = request.getParameter("gnb");
		int bfridx = Integer.parseInt(request.getParameter("bfridx"));
		
		HttpSession session = request.getSession();
		MemberInfo mi = (MemberInfo)session.getAttribute("loginInfo");
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		if (mi == null)	{	// 로그인이 안된 상태라면
			out.println("<script>");
			out.println("alert('로그인 후 사용하실 수 있습니다.');");
			out.println("</script>");
			out.close();
		}
		
		BbsFreeReplyGnb bfrg = new BbsFreeReplyGnb();
		bfrg.setBfr_idx(bfridx);	bfrg.setMi_id(mi.getMi_id());
		bfrg.setFrg_gnb(gnb);		bfrg.setFrg_ip(request.getRemoteAddr());
		
		FreeReplyProcGnbSvc freeReplyProcGnbSvc = new FreeReplyProcGnbSvc();
		int result = freeReplyProcGnbSvc.replyGnb(bfrg);
		out.println(result);
	}
}
