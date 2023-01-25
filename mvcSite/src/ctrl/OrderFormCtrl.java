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
    public OrderFormCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String kind = request.getParameter("kind");
		// ��ٱ��ϸ� ���� ����(c)����, �ٷ� ����(d)���� ���θ� �Ǵ��� ������
		
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
		
		String select = "select a.pi_id, a.pi_img1, a.pi_name, b.ps_size, a.pi_price, a.pi_dc, ";
		String from = " from t_product_info a, t_product_stock b ";
		String where = " where a.pi_id = b.pi_id and a.pi_isview = 'y' and b.ps_isview = 'y' ";
		
		if (kind.equals("c")) {	// ��ٱ��ϸ� ���� ����(c)�� ���
			select += "c.oc_cnt cnt, c.oc_idx ";
			from += ", t_order_cart c ";
			where += " and a.pi_id = c.pi_id and b.ps_idx = c.ps_idx and c.mi_id = '" + miid + "' and (";
			String[] arr = request.getParameterValues("chk");
			for (int i = 1 ; i < arr.length ; i++) {
				if (i == 1)	where += "c.oc_idx = " + arr[i];
				else		where += " or c.oc_idx = " + arr[i];
			}
			where += ") order by a.pi_id, c.ps_idx";
			
		} else {	// �ٷ� ����(d)�� ���
			String piid = request.getParameter("piid");
			int size = Integer.parseInt(request.getParameter("size"));
			int cnt = Integer.parseInt(request.getParameter("cnt"));
			select += cnt + " cnt ";
			where += " and a.pi_id = '" + piid + "' and b.ps_idx = " + size;
		}
		
		OrderFormSvc orderFormSvc = new OrderFormSvc();
		ArrayList<OrderCart> pdtList = orderFormSvc.getBuyList(kind, select + from + where);
		// ������ ��ǰ ����� ArrayList�� �޾ƿ�
		ArrayList<MemberAddr> addrList = orderFormSvc.getAddrList(miid);
		// ���� �α����� ȸ���� �ּ� ����� ArrayList�� �޾ƿ�
		System.out.println(select + from + where);
		
		request.setAttribute("pdtList", pdtList);
		request.setAttribute("addrList", addrList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("order/order_form.jsp");
		dispatcher.forward(request, response);
	}
}
