package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/cart_proc_in")
public class CartProcInCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public CartProcInCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String piid = request.getParameter("piid");
		int psidx = Integer.parseInt(request.getParameter("psidx"));
		int cnt = Integer.parseInt(request.getParameter("cnt"));
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();
	}
}
