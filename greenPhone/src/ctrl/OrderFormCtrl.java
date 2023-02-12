package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/order_form")
public class OrderFormCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public OrderFormCtrl() {  super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String kind = request.getParameter("kind");
		// ��ٱ��� ����(c) �ٷα���(d) ���� ������
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		if (loginInfo == null) {
			response.setContentType("text/html; charset=utf-8;");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('�α��� �� ����Ͻ� �� �ֽ��ϴ�.');");
			out.println("location.replace('login_form.jsp?url=cart_view');");
			out.println("</script>");
			out.close();
		}
		String miid = loginInfo.getMi_id();
		
		String select = "select a.pi_id, a.pi_name, a.pi_min, a.pi_dc, a.pi_img1, b.po_name, ";
		String from = " from t_product_info a, t_product_option b ";
		String where = " where a.pi_id = b.pi_id and a.pi_isview = 'y' and b.po_isview = 'y' ";
		
		if (kind.equals("c")) {		// ��ٱ��� ����(c)
			select += "c.sc_cnt cnt, c.sc_idx, b.po_idx ";
			from += ", t_sell_cart c ";
			where += " and a.pi_id = c.pi_id and b.po_idx = c.po_idx and c.mi_id = '" + miid + "' and (";
			String[] arr = request.getParameterValues("chk");
			for (int i = 1; i < arr.length; i++) {
				if (i == 1)	where += "c.sc_idx = " + arr[i];
				else		where += " or c.sc_idx = " + arr[i];
			}
			where += ") order by a.pi_id, c.po_idx";
		} else {	// �ٷα���(d) �� ���
			
		}
		OrderFormSvc orderFormSvc = new OrderFormSvc();
		ArrayList<SellCart> cartList = orderFormSvc.getCartList(kind, select + from + where);
		// ������ ��ǰ ����� ArrayList�� �޾ƿ�
		ArrayList<MemberInfo> addrList = orderFormSvc.getAddrList(miid);
		// ���� �α����� ȸ���� �ּ� ����� ArrayList�� �޾ƿ�
		
		request.setAttribute("cartList", cartList);
		request.setAttribute("addrList", addrList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("order/order_form.jsp");
		dispatcher.forward(request, response);
	}

}
