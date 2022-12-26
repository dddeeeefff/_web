package test;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/callServlet")
public class CallServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public CallServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// GET ������� ��û���� ��� ��û�� �޴� �޼ҵ�
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			// ������� ��û�� ����ִ� id�� pw�� ������ ���� ������ �̸��� ������ ����
			// ���� ������� ��û�� id�� pw�� ������ ���� null ���� ��
			
			response.setContentType("text/html; charset=utf-8");
			// ��û�ڿ��� ����(response)�ϱ� ���� ����(content)�� ���� Ÿ��(type)�� ����(set)
			PrintWriter out = response.getWriter();
			//��û�ڿ��� �����ϱ� ���� ��� ��ü(PrintWriter)�� �ν��Ͻ� out ����
			
			// id�� pw�� ���� ������ ����ϰ�, null�� ��� ���â���� "id�� pw�� �����ϴ�." �޽����� ������ �� ���� ȭ������ ���ư�
				out.println("<html><head><title>Ÿ��Ʋ��</title></head>");
				out.println("<body>");
			if(id == null && pw == null) {
				out.println("<script>");
			    out.println("alert('id�� pw�� �����ϴ�.');");
			    out.println(" history.back();");
			    out.println("</script>");
			}else {
				out.println("<h2>GET������� ���� �� ���!!</h2>");
				out.println("id : " + id + "<br />");
				out.println("pw : " + pw);
			}
				out.println("</body></html>");
	}		
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	// Post ������� ��û���� ��� ��û�� �޴� �޼ҵ�
		request.setCharacterEncoding("utf-8");
		// ����ڰ� ���� ��û(request)�� ���ڵ�(character)�� ���ڵ�(Encoding)��
		// �����ڵ�(utf-8)�� ����(set)�ϴ� �޼ҵ� �߻�

		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String[] idxs = request.getParameterValues("idx");
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		out.println("<html><head><title>Ÿ��Ʋ��</title></head>");
		out.println("<body>");
		out.println("<h2>Post������� ���� �� ���!!</h2>");
		out.println("id : " + id + "<br />");
		out.println("pw : " + pw + "<br />");
		for(int i = 0; i < idxs.length; i++) {
			out.println("idxs[" + i + "] : " + idxs[i] + "<br />");
		}
		out.println("</body></html>");
	}

}
