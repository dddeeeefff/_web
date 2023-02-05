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
		int cnt= Integer.parseInt(request.getParameter("cnt"));
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();
		
		OrderCart oc = new OrderCart();
		oc.setMi_id(miid);		oc.setPi_id(piid);
		oc.setPs_idx(psidx);	oc.setOc_cnt(cnt);
		
		CartProcInSvc cartProcInSvc = new CartProcInSvc();
		int result = cartProcInSvc.cartInsert(oc);
		
		response.setContentType("text/html; charset=utf-8;");
		PrintWriter out = response.getWriter();
		out.println(result);
		// ��ٱ���? ���? �����? ȣ���ߴ� ajax�� �����? ������ �������? ����
	}
}