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
		String uploadFileNameList = "";	// 업로드한 파일 이름들을 저장할 변수
		
		for (Part part : request.getParts()) {
		// getParts() : 사용자가 보낸 데이터(컨트롤)들을 Collection<Part>에 담아 리턴하는 메소드
		// getParts()로 받아온 Part 객체들을 하나씩 Part형 인스턴스 part에 담아 루프를 돔
			
			if (!part.getName().equals("name")) {
			// part로 받아온 컨르롤의 이름이 'name'이 아니면(file컨트롤만 작업하겠다는 의미)
				String cd = part.getHeader("content-disposition");
				// 예) form-data; name="file1"; filename="업로드할 파일명.확장자"
				// file 객체가 비었으면 form-data; name="file1"; filename=""
				
				String uploadFileName = getUploadFileName(cd);
				if (!uploadFileName.equals("")) {
				// 업로드할 파일이 있으면
					uploadFileNameList += ", " + uploadFileName;
					part.write(uploadFileName);
				}
			}
		}
		if(!uploadFileNameList.equals(""))
			uploadFileNameList = uploadFileNameList.substring(2);
		
		out.println("업로더" + name + "님이" + uploadFileNameList + " 파일들을 업로드 했습니다.");
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
