package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/free_view")
public class FreeViewCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public FreeViewCtrl() {  super(); }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int bfidx = Integer.parseInt(request.getParameter("bfidx"));
		
		FreeViewSvc freeViewSvc = new FreeViewSvc();
		int result = freeViewSvc.readUpdate(bfidx);
		// ����ڰ� ������ �Խñ��� ��ȸ���� ������Ű�� �޼ҵ� ȣ��
		BbsFree bf = freeViewSvc.getFreeInfo(bfidx);
		// ����ڰ� ������ �Խñ��� ������� BbsFree�� �ν��Ͻ��� �޾ƿ�
		
		if (bf == null) {	// ������ �Խñ��� ������
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('�߸��� ��η� �����̽��ϴ�.');");
			out.println("history.back()");
			out.println("</script>");
		} else {	// ������ �Խñ��� ������
			request.setAttribute("bf", bf);
			RequestDispatcher dispatcher =
					request.getRequestDispatcher("/bbs/free_view.jsp");
			dispatcher.forward(request, response);
			
		}
	}
}
