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
    public FreeReplyProcDelCtrl() { super();  }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int bfidx = Integer.parseInt(request.getParameter("bfidx"));
		int bfridx = Integer.parseInt(request.getParameter("bfridx"));
		String ismem = request.getParameter("ismem");
		String pw = request.getParameter("pw");
		
		BbsFreeReply bfr = new BbsFreeReply();
		bfr.setBf_idx(bfidx); 		bfr.setBfr_idx(bfridx);
		bfr.setBfr_ismem(ismem);	bfr.setBfr_pw(pw);
		
		FreeReplyFormDelSvc freeReplyFormDelSvc = new FreeReplyFormDelSvc();
		int result = freeReplyFormDelSvc.replyDelete(bfr);
		if (result == 1) {	// 정상적으로 삭제되었을 경우
			response.sendRedirect("free_view?bfidx=" + bfidx);
		} else {	// 댓글이 삭제되지 않았을 경우
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('댓글 삭제에 실패했습니다.'\\n 다시 시도하세요.);");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
	}

}
