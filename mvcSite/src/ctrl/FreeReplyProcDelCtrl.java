package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/free_reply_proc_del")
public class FreeReplyProcDelCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public FreeReplyProcDelCtrl() { super(); }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
    	doGet(request, response);
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int bfidx = Integer.parseInt(request.getParameter("bfidx"));
		int bfridx = Integer.parseInt(request.getParameter("bfridx"));
		String ismem = request.getParameter("ismem");
		String pw = request.getParameter("pw");
		
		BbsFreeReply bfr = new BbsFreeReply();
		bfr.setBf_idx(bfidx);		bfr.setBfr_idx(bfridx);
		bfr.setBfr_ismem(ismem);	bfr.setBfr_pw(pw);
		
		if (ismem.equals("y")) {	// ȸ���� ������ ���
			HttpSession session = request.getSession();
			MemberInfo mi = (MemberInfo)session.getAttribute("loginInfo");
			bfr.setBfr_writer(mi.getMi_id());
		}
		
		int cpage = Integer.parseInt(request.getParameter("cpage"));
		String args = "?cpage=" + cpage;	// ��ũ���� ����� ������Ʈ��
		String schtype = request.getParameter("schtype");
		String keyword = request.getParameter("keyword");
		if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) {
			args += "&schtype=" + schtype + "&keyword=" + keyword;
		}
		
		FreeReplyProcDelSvc freeReplyProcDelSvc = new FreeReplyProcDelSvc();
		int result = freeReplyProcDelSvc.replyDelete(bfr);
		if (result == 1) {	// ���������� �����Ǿ��� ���
			response.sendRedirect("free_view" + args + "&bfidx=" + bfidx);
		} else {	// ����� �������� �ʾ��� ���
			response.setContentType("text/html; charset=utf-8;");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('��� ������ �����߽��ϴ�.\\n�ٽ� �õ��ϼ���.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
	}
}
