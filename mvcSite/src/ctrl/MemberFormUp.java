package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;


@WebServlet("/member_form_up")
public class MemberFormUp extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public MemberFormUp() {  super(); }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		if (session.getAttribute("loginInfo") == null) {
		// ���� �α����� �Ǿ� ���� ���� ���¶��
			response.setContentType("text/html; charSet=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('�߸��� ��η� �����̽��ϴ�.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
			
		}
		// sendredirect - url �ٲ� - proc�϶� �ַ� ���
		// ������ - �ٲ��� ���� - proc�� �ƴҶ� ���
		RequestDispatcher dispatcher =
			request.getRequestDispatcher("/member/member_form_up.jsp");
		dispatcher.forward(request, response);
	}


}