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
		// GET 방식으로 요청했을 경우 요청을 받는 메소드
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			// 사용자의 요청에 들어있는 id와 pw의 값들을 각각 동일한 이름의 변수에 저장
			// 만약 사용자의 요청에 id와 pw가 없으면 각각 null 값이 들어감
			
			response.setContentType("text/html; charset=utf-8");
			// 요청자에게 응답(response)하기 위한 내용(content)의 종류 타입(type)을 지정(set)
			PrintWriter out = response.getWriter();
			//요청자에게 응답하기 위한 출력 객체(PrintWriter)의 인스턴스 out 생성
			
			// id와 pw의 값이 있으면 출력하고, null일 경우 경고창으로 "id와 pw가 없습니다." 메시지를 보여준 후 이전 화면으로 돌아감
				out.println("<html><head><title>타이틀바</title></head>");
				out.println("<body>");
			if(id == null && pw == null) {
				out.println("<script>");
			    out.println("alert('id와 pw가 없습니다.');");
			    out.println(" history.back();");
			    out.println("</script>");
			}else {
				out.println("<h2>GET방식으로 받은 값 출력!!</h2>");
				out.println("id : " + id + "<br />");
				out.println("pw : " + pw);
			}
				out.println("</body></html>");
	}		
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	// Post 방식으로 요청했을 경우 요청을 받는 메소드
		request.setCharacterEncoding("utf-8");
		// 사용자가 보낸 요청(request)의 글자들(character)의 인코딩(Encoding)을
		// 유니코드(utf-8)로 지정(set)하는 메소드 발생

		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String[] idxs = request.getParameterValues("idx");
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		out.println("<html><head><title>타이틀바</title></head>");
		out.println("<body>");
		out.println("<h2>Post방식으로 받은 값 출력!!</h2>");
		out.println("id : " + id + "<br />");
		out.println("pw : " + pw + "<br />");
		for(int i = 0; i < idxs.length; i++) {
			out.println("idxs[" + i + "] : " + idxs[i] + "<br />");
		}
		out.println("</body></html>");
	}

}
