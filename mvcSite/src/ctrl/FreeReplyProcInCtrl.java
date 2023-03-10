package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/free_reply_proc_in")
public class FreeReplyProcInCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public FreeReplyProcInCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int bfidx = Integer.parseInt(request.getParameter("bfidx"));
		String writer = request.getParameter("writer");
		if (writer != null)		writer = getStr(writer);
		String pw = request.getParameter("pw");
		if (pw != null)			pw = getStr(pw);
		String content = request.getParameter("content");
		if (content != null)	content = getStr(content);
		String ismem = "n";
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		if (loginInfo != null) {
			ismem = "y";	writer = loginInfo.getMi_id();	pw = "";
		}
		
		BbsFreeReply bfr = new BbsFreeReply();
		bfr.setBf_idx(bfidx);	bfr.setBfr_writer(writer);
		bfr.setBfr_pw(pw);		bfr.setBfr_content(content);
		bfr.setBfr_ismem(ismem);bfr.setBfr_ip(request.getRemoteAddr());
		
		FreeReplyProcInSvc freeReplyProcInSvc = new FreeReplyProcInSvc();
		int result = freeReplyProcInSvc.replyInsert(bfr);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(writer);
		// 댓글 등록 기능을 호출했던 ajax를 사용한 곳으로 결과값을 리턴
	}
	
	private String getStr(String str) {
	// 사용자가 입력한 문자열에 대한 처리를 해서 리턴하는 메소드
		return str.trim().replace("'", "''").replace("<", "&lt;");
	}
}
