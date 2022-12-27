package test;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet("/uploadPartProc1")
@MultipartConfig(
	fileSizeThreshold = 0,
	location = "D:/cks/web/work/errUploadMail/WebContent/upload"
)
public class UploadPartProc1 extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public UploadPartProc1() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String name = request.getParameter("name");
		// cos.jar�� �̿��� ����� �ٸ��� request��ü�� �̿��Ͽ� ���ڿ� �����͸� ���� �� ����
		Part part = request.getPart("file1");
		// ���ε�Ǵ� ������ Part�� �ν��Ͻ��� ����
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		String contentDisposition = part.getHeader("content-disposition");
		// ��) form-data; name="file1"; filename="���ε��� ���ϸ�.Ȯ����"
		System.out.println("contentDisposition : " + contentDisposition);
		
		String uploadFileName = getUploadFileName(contentDisposition);
		
		part.write(uploadFileName);
		out.println("���δ�" + name + "���� " + uploadFileName + " ������ ���ε� �߽��ϴ�.");
	}
	private String getUploadFileName(String contentDisposition) {
		String uploadFileName = null;
		String[] contentSplitStr = contentDisposition.split(";");
		
		int fIdx = contentSplitStr[2].indexOf("\"");
		int sIdx = contentSplitStr[2].lastIndexOf("\"");
		
		uploadFileName = contentSplitStr[2].substring(fIdx + 1, sIdx); 
		
		return uploadFileName;
	}
}
