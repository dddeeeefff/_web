package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import java.net.*;
import svc.*;
import vo.*;

@WebServlet("/free_list")
public class FreeListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public FreeListCtrl() { super(); }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int cpage = 1, psize = 10, bsize = 10, rcnt = 0, pcnt = 0, spage = 0;
		// 현재 페이지 번호, 페이지 크기, 블록 크기, 레코드(게시글) 개수, 페이지 개수, 시작 페이지 등을 저장할 변수들
		if (request.getParameter("cpage") != null) 
			cpage = Integer.parseInt(request.getParameter("cpage"));
		// cpage 값이 있으면 받아서 int형으로 형변환 시킴(보안상의 이유와 산술연산을 해야 하기 때문)
		
		String schtype = request.getParameter("schtype");	// 검색조건(제목, 내용, 제목+내용)
		String keyword = request.getParameter("keyword");	// 검색어
		String where = " where bf_isdel = 'n' ";	// 검색 조건이 있을 경우 where절을 저장할 변수
		if (schtype == null || keyword == null) {
			schtype = "";	keyword = "";
			// 화면상에 검색어가 'null'로 보이지 않게 하기 위해 빈 문자열로 채움
		} else if (!schtype.equals("") && !keyword.equals("")) {
		// 검색조건과 검색어가 모두 있을 경우
			URLEncoder.encode(keyword, "UTF-8");
			// 쿼리스트링으로 주고 받는 검색어가 한글일 경우 브라우저에 따라 문제가 발생할 수 있으므로 유니코드로 변환
			if (schtype.equals("tc")) {	// 검색조건이 '제목+내용'일 경우
				where += " and (bf_title like '%" + keyword + "%' or bf_content like '%" + keyword + "%')";
			} else {	// 검색조건이 '제목'이나 '내용'일 경우
				where += " and bf_" + schtype + " like '%" + keyword + "%' ";
			}
		}
		
		FreeListSvc freeListSvc = new FreeListSvc();
		rcnt = freeListSvc.getFreeListCount(where);
		// 검색된 게시글의 총 개수로 게시글 일련번호 출력과 전체 페이지 수 계산을 위해 필요한 값
		ArrayList<BbsFree> freeList = freeListSvc.getFreeList(where, cpage, psize);
		// 목록화면에서 보여줄 게시글 목록을 ArrayList<BbsFree>형으로 받아옴
		// 필요한 만큼만 받아오기 위해 cpage와 psize가 필요
		
		PageInfo pageInfo = new PageInfo();
		pageInfo.setBsize(bsize);		pageInfo.setCpage(cpage);
		pageInfo.setPcnt(pcnt);			pageInfo.setPsize(psize);
		pageInfo.setRcnt(rcnt);			pageInfo.setSpage(spage);
		pageInfo.setSchtype(schtype);	pageInfo.setKeyword(keyword);
		// 페이징과 검색에 필요한 정보들을 PageInfo형 인스턴스에 저장
		
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("freeList", freeList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("bbs/free_list.jsp");
		dispatcher.forward(request, response);
	}
}
