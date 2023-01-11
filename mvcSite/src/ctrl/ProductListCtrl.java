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
		// ���� ������ ��ȣ, ������ ũ��, ��� ũ��, ���ڵ�(��ǰ) ����
		// ��ü ������ ����, ���� ������ ��ȣ ���� ������ ������ ����
		if (request.getParameter("cpage") != null)
			cpage = Integer.parseInt(request.getParameter("cpage"));
		
		// �˻� ���� where�� ����
		String where = "";
		String pcb = request.getParameter("pcb");	// ��з�
		String pcs = request.getParameter("pcs");	// �Һз�
		String sch = request.getParameter("sch");	// �˻�����(���ݴ�, ��ǰ��, �귣��)
		if (pcb != null && !pcb.equals(""))
			where += " and left(a.pcs_id, 2) = '" + pcb + "' ";
		if (pcs != null && !pcs.equals(""))
			where += " and a.pcs_id = '" + pcs + "' ";
		if (sch != null && !sch.equals("")) {
		// �˻����� : &sch=ntest,bB1:B2:B3,p100000~200000
			String[] arrSch = sch.split(",");
			for (int i = 0; i < arrSch.length; i++) {
				char c = arrSch[i].charAt(0);
				if (c == 'n') {	// ��ǰ�� �˻��� ���(n�˻���)
					where += " and a.pi_name like '%" + arrSch[i].substring(1) + "%' ";
					
				} else if (c == 'b') { // �귣�� �˻��� ���
					String[] arr = arrSch[i].substring(1).split(":");
					where += " and (";
					for (int j = 0; j < arr.length; j++) {
						where += (j == 0 ? "" : " or ") + "a.pb_id = '" + arr[j] + "' ";
					}
					where += ") ";
					
				} else if (c == 'p') { // ���ݴ� �˻��� ���(p���۰�~���ᰡ)
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
		String o = request.getParameter("o");	// ��������
		if (o == null || o.equals(""))	o = "a";
		switch (o) {
		case "a" : // ��� ����
			orderBy = " order by a.pi_date desc";	break;
		case "b" : // �Ǹŷ���
			orderBy = " order by a.pi_sale desc";	break;
		case "c" : // ���� ���ݼ�
			orderBy = " order by a.pi_price asc";	break;
		case "d" : // ���� ���ݼ�
			orderBy = " order by a.pi_price desc";	break;
		case "e" : // ���� ������
			orderBy = " order by a.pi_score desc";	break;
		case "f" : // ���� ������
			orderBy = " order by a.pi_review desc";	break;
		case "g" : // ��ȸ�� ������
			orderBy = " order by a.pi_read desc";	break;
		}
		String v = request.getParameter("v");	// ���� ���
		if (v == null)	v = "g";
		// ������� �������� ��� ������ ũ��� 12�� ������
/*		
		if (v != null && v.equals("l"))	psize = 10;
		// ���� ����� ������� ��� �������� ũ�⸦ 10���� ����
		else	v = "g";
*/	
		ProductListSvc productListSvc = new ProductListSvc();
		
		rcnt = productListSvc.getProductCount(where);
		// �˻��� ��ǰ�� �� ������ ��ü ���������� ���Ҷ� ���
		
		ArrayList<ProductInfo> productList = 
		productListSvc.getProductList(cpage, psize, where, orderBy);
		// �˻��� ��ǰ�� �� ���� ���������� ������ ��ǰ ����� �޾ƿ�
		
		ArrayList<ProductBrand> brandList = productListSvc.getBrandList();
		
		ArrayList<ProductCtgrSmall> smallList = new ArrayList<ProductCtgrSmall>();
		if (pcb != null && !pcb.equals("")) {	// �˻� ���� �� ��з��� ������
			smallList = productListSvc.getCtgrSmallList(pcb);
			// �˻������� ��з��� ���ϴ� �Һз� ����� �޾ƿ�
			
		}
		
		pcnt = rcnt / psize;
		if (rcnt % psize > 0)	pcnt++;	// ��ü ������ ��(������ ������ ��ȣ)
		spage = (cpage - 1) / psize * psize + 1;	// ��� ���� ������ ��ȣ
		
		PageInfo pageInfo = new PageInfo();
		pageInfo.setBsize(bsize);	pageInfo.setCpage(cpage);
		pageInfo.setPcnt(pcnt);		pageInfo.setPsize(psize);
		pageInfo.setRcnt(rcnt);		pageInfo.setSpage(spage);
		pageInfo.setPcb(pcb);		pageInfo.setPcs(pcs);
		pageInfo.setSch(sch);		pageInfo.setO(o);
		pageInfo.setV(v);
		// ����¡ ���� ������� �˻� �� ���� �������� PageInfo �ν��Ͻ��� ����
		
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("productList", productList);
		request.setAttribute("brandList", brandList);
		request.setAttribute("smallList", smallList);
		// dispatcher ������� view�� �����ֹǷ� request ��ü�� �ʿ��� ������ ��� �Ѱ���
		
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
