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
			out.println("alert('�߸��� ��η� �����̽��ϴ�.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		String miid = loginInfo.getMi_id();
		String kind = request.getParameter("kind");
		int total = Integer.parseInt(request.getParameter("total"));
		
		// ����� �� ���� ����
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
		// �������� ������ ������ �ֹ���ȣ, ����� ���ڵ� ����, ����Ǿ�� �� ���ڵ� ����
		if (kind.equals("c")) {	// ��ٱ��ϸ� ���� ������ ���
			temp = request.getParameter("ocidxs");
			// ��ٱ��Ͽ��� ������ ��ǰ���� �ε�����ȣ��(��ǥ�� ����)
		} else {	// �ٷ� ������ ���
			
		}
		result = orderProcInSvc.orderInsert(kind, oi, temp);
		String[] arr = result.split(",");
		if (arr[1].equals(arr[2])) {	// ���������� ���Ű� �̷��������
			response.sendRedirect("order_end?oiid=" + arr[0]);
/*	�ֹ� ��ȣ�� ������Ʈ���� �ƴ� pots������� ���� ����� ���
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
		}else {		// ���������� ���Ű� �̷������ �ʾ�����
			response.setContentType("text/html; charSet=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('���Ű� ���������� ó������ �ʾҽ��ϴ�.\\n�����Ϳ� ���� �ϼ���.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
	}

}
