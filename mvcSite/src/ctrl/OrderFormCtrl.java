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
		// 장바구니를 통한 구매(c)인지, 바로 구매(d)인지 여부를 판단할 데이터
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		if (loginInfo == null) {
			response.setContentType("text/html; charset=utf-8;");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인 후 사용하실 수 있습니다.');");
			out.println("location.replace('login_form.jsp?url=cart_view');");
			out.println("</script>");
			out.close();
		}
		String miid = loginInfo.getMi_id();
		
		String select = "select a.pi_id, a.pi_img1, a.pi_name, b.ps_size, a.pi_price, a.pi_dc, ";
		String from = " from t_product_info a, t_product_stock b ";
		String where = " where a.pi_id = b.pi_id and a.pi_isview = 'y' and b.ps_isview = 'y' ";
		
		if (kind.equals("c")) {	// 장바구니를 통한 구매(c)일 경우
			select += "c.oc_cnt cnt, c.oc_idx ";
			from += ", t_order_cart c ";
			where += " and a.pi_id = c.pi_id and b.ps_idx = c.ps_idx and c.mi_id = '" + miid + "' and (";
			String[] arr = request.getParameterValues("chk");
			for (int i = 1 ; i < arr.length ; i++) {
				if (i == 1)	where += "c.oc_idx = " + arr[i];
				else		where += " or c.oc_idx = " + arr[i];
			}
			where += ") order by a.pi_id, c.ps_idx";
			
		} else {	// 바로 구매(d)일 경우
			String piid = request.getParameter("piid");
			int size = Integer.parseInt(request.getParameter("size"));
			int cnt = Integer.parseInt(request.getParameter("cnt"));
			select += cnt + " cnt ";
			where += " and a.pi_id = '" + piid + "' and b.ps_idx = " + size;
		}
		
		OrderFormSvc orderFormSvc = new OrderFormSvc();
		ArrayList<OrderCart> pdtList = orderFormSvc.getBuyList(kind, select + from + where);
		// 구매할 상품 목록을 ArrayList로 받아옴
		ArrayList<MemberAddr> addrList = orderFormSvc.getAddrList(miid);
		// 현재 로그인한 회원의 주소 목록을 ArrayList로 받아옴
		System.out.println(select + from + where);
		
		request.setAttribute("pdtList", pdtList);
		request.setAttribute("addrList", addrList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("order/order_form.jsp");
		dispatcher.forward(request, response);
	}
}
