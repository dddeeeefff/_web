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
		// cos.jar를 이용한 방법과 다르게 request객체를 이용하여 문자열 데이터를 받을 수 있음
		Part part = request.getPart("file1");
		// 업로드되는 파일을 Part형 인스턴스에 저장
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		String contentDisposition = part.getHeader("content-disposition");
		// 예) form-data; name="file1"; filename="업로드할 파일명.확장자"
		System.out.println("contentDisposition : " + contentDisposition);
		
		String uploadFileName = getUploadFileName(contentDisposition);
		
		part.write(uploadFileName);
		out.println("업로더" + name + "님이 " + uploadFileName + " 파일을 업로드 했습니다.");
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
