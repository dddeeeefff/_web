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
		// 현재 로그인이 되어 있지 않은 상태라면
			response.setContentType("text/html; charSet=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
			
		}
		// sendredirect - url 바뀜 - proc일때 주로 사용
		// 디스패쳐 - 바뀌지 않음 - proc이 아닐때 사용
		RequestDispatcher dispatcher =
			request.getRequestDispatcher("/member/member_form_up.jsp");
		dispatcher.forward(request, response);
	}


}
