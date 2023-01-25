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
		String oiid = request.getParameter("oiid");	// 주문 번호
		HttpSession session = request.getSession();
		MemberInfo mi = (MemberInfo)session.getAttribute("loginInfo");
		String miid = mi.getMi_id();	// 현재 로그인한 회원 아이디
		
		OrderEndSvc orderEndSvc = new OrderEndSvc();
		OrderInfo orderInfo = orderEndSvc.getOrderInfo(miid, oiid);
		
		if (orderInfo == null) {	// 주문 정보가 없을 경우
			response.setContentType("text/html; charSet=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.');");
			out.println("location.replace('/mvcSite/');");
			out.println("</script>");
			out.close();
		} else {	// 주문 정보가 있을 경우
			request.setAttribute("orderInfo", orderInfo);
			RequestDispatcher dispatcher = 
					request.getRequestDispatcher("order/order_end.jsp");
			dispatcher.forward(request, response);
		}
	}
}
