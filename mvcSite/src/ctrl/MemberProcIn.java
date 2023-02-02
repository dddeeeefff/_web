package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/member_proc_in")
public class MemberProcIn extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public MemberProcIn() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		// �޾ƿ� ȸ���������� ������ �ν��Ͻ� ����
		MemberInfo memberInfo = new MemberInfo();
		MemberAddr memberAddr = new MemberAddr();
		
		memberInfo.setMi_id(request.getParameter("mi_id").trim().toLowerCase());
		memberInfo.setMi_pw(request.getParameter("mi_pw"));
		memberInfo.setMi_name(request.getParameter("mi_name").trim());
		memberInfo.setMi_gender(request.getParameter("mi_gender"));
		memberInfo.setMi_birth(request.getParameter("by") + "-" + request.getParameter("bm") + "-" + request.getParameter("bd"));
		memberInfo.setMi_phone(request.getParameter("p1") + "-" + request.getParameter("p2") + "-" + request.getParameter("p3"));
		memberInfo.setMi_email(request.getParameter("e1").trim() + "@" + request.getParameter("e3").trim());
		memberInfo.setMi_point(1000);
		
		memberAddr.setMi_id(request.getParameter("mi_id").trim().toLowerCase());
		memberAddr.setMa_name("�⺻ �ּ�");
		memberAddr.setMa_zip(request.getParameter("ma_zip").trim());
		memberAddr.setMa_addr1(request.getParameter("ma_addr1").trim());
		memberAddr.setMa_addr2(request.getParameter("ma_addr2").trim());
		
		MemberProcInSvc memberProcInSvc = new MemberProcInSvc();
		int result = memberProcInSvc.memberProcIn(memberInfo, memberAddr);
		if (result == 3) {	// ���������� ȸ�������� �̷�� ������
			response.sendRedirect("login_form");
		} else {	// ȸ�� ���� ����
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('ȸ�� ���Կ� �����߽��ϴ�.\\n�ٽ� �õ��ϼ���.')");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
	}
}
