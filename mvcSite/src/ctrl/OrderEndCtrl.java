package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/order_end")
public class OrderEndCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;      
    public OrderEndCtrl() { super();}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String oiid = request.getParameter("oiid");	// �ֹ� ��ȣ
		HttpSession session = request.getSession();
		MemberInfo mi = (MemberInfo)session.getAttribute("loginInfo");
		String miid = mi.getMi_id();	// ���� �α����� ȸ�� ���̵�
		
		OrderEndSvc orderEndSvc = new OrderEndSvc();
		OrderInfo orderInfo = orderEndSvc.getOrderInfo(miid, oiid);
		
		if (orderInfo == null) {	// �ֹ� ������ ���� ���
			response.setContentType("text/html; charSet=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('�߸��� ��η� �����̽��ϴ�.');");
			out.println("location.replace('/mvcSite/');");
			out.println("</script>");
			out.close();
		} else {	// �ֹ� ������ ���� ���
			request.setAttribute("orderInfo", orderInfo);
			RequestDispatcher dispatcher = 
					request.getRequestDispatcher("order/order_end.jsp");
			dispatcher.forward(request, response);
		}
	}
}
