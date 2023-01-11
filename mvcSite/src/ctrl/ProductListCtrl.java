package ctrl;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;
import java.util.*;

@WebServlet("/product_list")
public class ProductListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L; 
    public ProductListCtrl() { super();}

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int cpage = 1, psize = 12, bsize = 10, rcnt = 0, pcnt = 0, spage = 0;
		// 현재 페이지 번호, 페이지 크기, 블록 크기, 레코드(상품) 개수
		// 전체 페이지 개수, 시작 페이지 번호 등을 저장할 변수들 선언
		if (request.getParameter("cpage") != null)
			cpage = Integer.parseInt(request.getParameter("cpage"));
		
		// 검색 조건 where절 생성
		String where = "";
		String pcb = request.getParameter("pcb");	// 대분류
		String pcs = request.getParameter("pcs");	// 소분류
		String sch = request.getParameter("sch");	// 검색조건(가격대, 상품명, 브랜드)
		if (pcb != null && !pcb.equals(""))
			where += " and left(a.pcs_id, 2) = '" + pcb + "' ";
		if (pcs != null && !pcs.equals(""))
			where += " and a.pcs_id = '" + pcs + "' ";
		if (sch != null && !sch.equals("")) {
		// 검색조건 : &sch=ntest,bB1:B2:B3,p100000~200000
			String[] arrSch = sch.split(",");
			for (int i = 0; i < arrSch.length; i++) {
				char c = arrSch[i].charAt(0);
				if (c == 'n') {	// 상품명 검색일 경우(n검색어)
					where += " and a.pi_name like '%" + arrSch[i].substring(1) + "%' ";
					
				} else if (c == 'b') { // 브랜드 검색일 경우
					String[] arr = arrSch[i].substring(1).split(":");
					where += " and (";
					for (int j = 0; j < arr.length; j++) {
						where += (j == 0 ? "" : " or ") + "a.pb_id = '" + arr[j] + "' ";
					}
					where += ") ";
					
				} else if (c == 'p') { // 가격대 검색일 경우(p시작가~종료가)
					String sp = arrSch[i].substring(1, arrSch[i].indexOf('~'));
					if (sp != null && !sp.equals(""))
						where += " and a.pi_price >= " + sp;
					
					String ep = arrSch[i].substring(arrSch[i].indexOf('~') + 1);
					if (ep != null && !ep.equals("")) 
						where += " and a.pi_price <= " + ep;
				}
			}
		}
		
		String orderBy = "";
		String o = request.getParameter("o");	// 정렬조건
		if (o == null || o.equals(""))	o = "a";
		switch (o) {
		case "a" : // 등록 역순
			orderBy = " order by a.pi_date desc";	break;
		case "b" : // 판매량순
			orderBy = " order by a.pi_sale desc";	break;
		case "c" : // 낮은 가격순
			orderBy = " order by a.pi_price asc";	break;
		case "d" : // 높은 가격순
			orderBy = " order by a.pi_price desc";	break;
		case "e" : // 평점 높은순
			orderBy = " order by a.pi_score desc";	break;
		case "f" : // 리뷰 많은순
			orderBy = " order by a.pi_review desc";	break;
		case "g" : // 조회수 높은순
			orderBy = " order by a.pi_read desc";	break;
		}
		String v = request.getParameter("v");	// 보기 방식
		if (v == null)	v = "g";
		// 목록형과 갤러리형 모두 페이지 크기는 12로 동일함
/*		
		if (v != null && v.equals("l"))	psize = 10;
		// 보기 방식이 목록형일 경우 페이지의 크기를 10으로 변경
		else	v = "g";
*/	
		ProductListSvc productListSvc = new ProductListSvc();
		
		rcnt = productListSvc.getProductCount(where);
		// 검색된 상품의 총 개수로 전체 페이지수를 구할때 사용
		
		ArrayList<ProductInfo> productList = 
		productListSvc.getProductList(cpage, psize, where, orderBy);
		// 검색된 상품들 중 현재 페이지에서 보여줄 상품 목록을 받아옴
		
		ArrayList<ProductBrand> brandList = productListSvc.getBrandList();
		
		ArrayList<ProductCtgrSmall> smallList = new ArrayList<ProductCtgrSmall>();
		if (pcb != null && !pcb.equals("")) {	// 검색 조건 중 대분류가 있으면
			smallList = productListSvc.getCtgrSmallList(pcb);
			// 검색조건의 대분류에 속하는 소분류 목록을 받아옴
			
		}
		
		pcnt = rcnt / psize;
		if (rcnt % psize > 0)	pcnt++;	// 전체 페이지 수(마지막 페이지 번호)
		spage = (cpage - 1) / psize * psize + 1;	// 블록 시작 페이지 번호
		
		PageInfo pageInfo = new PageInfo();
		pageInfo.setBsize(bsize);	pageInfo.setCpage(cpage);
		pageInfo.setPcnt(pcnt);		pageInfo.setPsize(psize);
		pageInfo.setRcnt(rcnt);		pageInfo.setSpage(spage);
		pageInfo.setPcb(pcb);		pageInfo.setPcs(pcs);
		pageInfo.setSch(sch);		pageInfo.setO(o);
		pageInfo.setV(v);
		// 페이징 관련 정보들과 검색 및 정렬 정보들을 PageInfo 인스턴스에 저장
		
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("productList", productList);
		request.setAttribute("brandList", brandList);
		request.setAttribute("smallList", smallList);
		// dispatcher 방식으로 view를 보여주므로 request 객체에 필요한 정보를 담아 넘겨줌
		
		RequestDispatcher dispatcher =
				request.getRequestDispatcher("/product/product_list.jsp");
			dispatcher.forward(request, response);
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
