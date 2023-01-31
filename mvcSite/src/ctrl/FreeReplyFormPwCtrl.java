package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;


@WebServlet("/free_reply_form_pw")
public class FreeReplyFormPwCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public FreeReplyFormPwCtrl() { super();  }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		RequestDispatcher dispatcher = 
				request.getRequestDispatcher("bbs/free_reply_form_pw.jsp");
		dispatcher.forward(request, response);
	}
}
