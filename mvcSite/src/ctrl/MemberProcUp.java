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
		
		// �޾ƿ� ȸ���������� ������ �ν��Ͻ� ����
		MemberInfo memberInfo = new MemberInfo();
		memberInfo.setMi_id(loginInfo.getMi_id());
		memberInfo.setMi_phone(request.getParameter("p1") + "-" + 
		request.getParameter("p2") + "-" + request.getParameter("p3"));
		memberInfo.setMi_email(request.getParameter("e1") + "@" 
		+ request.getParameter("e3").trim());
			
		MemberProcUpSvc memberProcUpSvc = new MemberProcUpSvc();
		int result = memberProcUpSvc.memberProcUp(memberInfo);
		if (result == 1) {	// ���������� ���������� �̷�� ������
			loginInfo.setMi_phone(memberInfo.getMi_phone());
			loginInfo.setMi_email(memberInfo.getMi_email());
			
			response.sendRedirect("member_form_up");
		} else {	// ȸ�� ���� ����		
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('���������� �����߽��ϴ�.\\n�ٽ� �õ��ϼ���.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
	}
}
