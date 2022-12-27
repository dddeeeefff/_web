package test;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet("/uploadPartProc2")
@MultipartConfig(
	fileSizeThreshold = 0,
	location = "D:/cks/web/work/errUploadMail/WebContent/upload"
)
public class UploadPartProc2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public UploadPartProc2() {
        super();

    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		String name = request.getParameter("name");
		String uploadFileNameList = "";	// ���ε��� ���� �̸����� ������ ����
		
		for (Part part : request.getParts()) {
		// getParts() : ����ڰ� ���� ������(��Ʈ��)���� Collection<Part>�� ��� �����ϴ� �޼ҵ�
		// getParts()�� �޾ƿ� Part ��ü���� �ϳ��� Part�� �ν��Ͻ� part�� ��� ������ ��
			
			if (!part.getName().equals("name")) {
			// part�� �޾ƿ� �������� �̸��� 'name'�� �ƴϸ�(file��Ʈ�Ѹ� �۾��ϰڴٴ� �ǹ�)
				String cd = part.getHeader("content-disposition");
				// ��) form-data; name="file1"; filename="���ε��� ���ϸ�.Ȯ����"
				// file ��ü�� ������� form-data; name="file1"; filename=""
				
				String uploadFileName = getUploadFileName(cd);
				if (!uploadFileName.equals("")) {
				// ���ε��� ������ ������
					uploadFileNameList += ", " + uploadFileName;
					part.write(uploadFileName);
				}
			}
		}
		if(!uploadFileNameList.equals(""))
			uploadFileNameList = uploadFileNameList.substring(2);
		
		out.println("���δ�" + name + "����" + uploadFileNameList + " ���ϵ��� ���ε� �߽��ϴ�.");
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
