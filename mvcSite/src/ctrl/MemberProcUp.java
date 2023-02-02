package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/member_proc_up")
public class MemberProcUp extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public MemberProcUp() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		
		// 받아온 회원정보들을 저장할 인스턴스 생성
		MemberInfo memberInfo = new MemberInfo();
		memberInfo.setMi_id(loginInfo.getMi_id());
		memberInfo.setMi_phone(request.getParameter("p1") + "-" + request.getParameter("p2") + "-" + request.getParameter("p3"));
		memberInfo.setMi_email(request.getParameter("e1").trim() + "@" + request.getParameter("e3").trim());
		
		MemberProcUpSvc memberProcUpSvc = new MemberProcUpSvc();
		int result = memberProcUpSvc.memberProcUp(memberInfo);
		if (result == 1) {	// 정상적으로 회원 정보수정이 이루어 졌으면
			loginInfo.setMi_phone(memberInfo.getMi_phone());
			loginInfo.setMi_email(memberInfo.getMi_email());
			
			response.sendRedirect("member_form_up");
		} else {	// 정보 수정 실패
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('회원 정보수정에 실패했습니다.\\n다시 시도하세요.')");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
	}
}
