package ctrl;

import static db.JdbcUtil.commit;

import java.io.*;
import java.lang.ProcessBuilder.Redirect;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/order_proc_in")
public class OrderProcInCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public OrderProcInCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		if (loginInfo == null) {
			response.setContentType("text/html; charset=utf-8;");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		String miid = loginInfo.getMi_id();
		String kind = request.getParameter("kind");
		int total = Integer.parseInt(request.getParameter("total"));
		
		// 배송지 및 경제 정보
		String rname = request.getParameter("oi_rname");
		String p1 = request.getParameter("p1");
		String p2 = request.getParameter("p2");
		String p3 = request.getParameter("p3");
		String phone = p1 + "-" + p2 + "-" + p3;
		String zip = request.getParameter("oi_zip");
		String addr1 = request.getParameter("oi_addr1");
		String addr2 = request.getParameter("oi_addr2");
		String payment = request.getParameter("oi_payment");
		
		OrderInfo oi = new OrderInfo();
		oi.setMi_id(miid);			oi.setOi_name(rname);
		oi.setOi_phone(phone);		oi.setOi_zip(zip);
		oi.setOi_addr1(addr1);		oi.setOi_addr2(addr2);
		oi.setOi_payment(payment);	oi.setOi_pay(total);
		oi.setOi_status((payment.equals("c") ? "a" : "b"));
		
		OrderProcInSvc orderProcInSvc = new OrderProcInSvc();
		String result = null, temp = "";
		// 실행결과를 저장할 변수로 주문번호, 적용된 레코드 개수, 적용되어야 할 레코드 개수
		if (kind.equals("c")) {	// 장바구니를 통한 구매일 경우
			temp = request.getParameter("ocidxs");
			// 장바구니에서 구매할 상품들의 인덱스번호들(쉼표로 구분)
		} else {	// 바로 구매일 경우
			
		}
		result = orderProcInSvc.orderInsert(kind, oi, temp);
		String[] arr = result.split(",");
		if (arr[1].equals(arr[2])) {	// 정상적으로 구매가 이루어졌으면
			response.sendRedirect("order_end?oiid=" + arr[0]);
/*	주문 번호를 쿼리스트링이 아닌 pots방식으로 보내 숨기는 방법
			response.setContentType("text/html; charSet=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<form name='frm' action='order_end' method='post'>");
			out.println("<intput type='hidden' name='oiid' value= '" + arr[0] + "' />");
			out.println("</form>");
			out.println("<script>");
			out.println("document.frm.submit();");
			out.println("</script>");
			out.close();	
*/
		}else {		// 정상적으로 구매가 이루어지지 않았으면
			response.setContentType("text/html; charSet=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('구매가 정상적으로 처리되지 않았습니다.\\n고객센터에 문의 하세요.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
	}

}
