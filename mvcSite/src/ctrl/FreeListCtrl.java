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
		// ���� ������ ��ȣ, ������ ũ��, ��� ũ��, ���ڵ�(�Խñ�) ����, ������ ����, ���� ������ ���� ������ ������
		if (request.getParameter("cpage") != null) 
			cpage = Integer.parseInt(request.getParameter("cpage"));
		// cpage ���� ������ �޾Ƽ� int������ ����ȯ ��Ŵ(���Ȼ��� ������ ��������� �ؾ� �ϱ� ����)
		
		String schtype = request.getParameter("schtype");	// �˻�����(����, ����, ����+����)
		String keyword = request.getParameter("keyword");	// �˻���
		String where = " where bf_isdel = 'n' ";	// �˻� ������ ���� ��� where���� ������ ����
		if (schtype == null || keyword == null) {
			schtype = "";	keyword = "";
			// ȭ��� �˻�� 'null'�� ������ �ʰ� �ϱ� ���� �� ���ڿ��� ä��
		} else if (!schtype.equals("") && !keyword.equals("")) {
		// �˻����ǰ� �˻�� ��� ���� ���
			URLEncoder.encode(keyword, "UTF-8");
			// ������Ʈ������ �ְ� �޴� �˻�� �ѱ��� ��� �������� ���� ������ �߻��� �� �����Ƿ� �����ڵ�� ��ȯ
			if (schtype.equals("tc")) {	// �˻������� '����+����'�� ���
				where += " and (bf_title like '%" + keyword + "%' or bf_content like '%" + keyword + "%')";
			} else {	// �˻������� '����'�̳� '����'�� ���
				where += " and bf_" + schtype + " like '%" + keyword + "%' ";
			}
		}
		
		FreeListSvc freeListSvc = new FreeListSvc();
		rcnt = freeListSvc.getFreeListCount(where);
		// �˻��� �Խñ��� �� ������ �Խñ� �Ϸù�ȣ ��°� ��ü ������ �� ����� ���� �ʿ��� ��
		ArrayList<BbsFree> freeList = freeListSvc.getFreeList(where, cpage, psize);
		// ���ȭ�鿡�� ������ �Խñ� ����� ArrayList<BbsFree>������ �޾ƿ�
		// �ʿ��� ��ŭ�� �޾ƿ��� ���� cpage�� psize�� �ʿ�
		
		PageInfo pageInfo = new PageInfo();
		pageInfo.setBsize(bsize);		pageInfo.setCpage(cpage);
		pageInfo.setPcnt(pcnt);			pageInfo.setPsize(psize);
		pageInfo.setRcnt(rcnt);			pageInfo.setSpage(spage);
		pageInfo.setSchtype(schtype);	pageInfo.setKeyword(keyword);
		// ����¡�� �˻��� �ʿ��� �������� PageInfo�� �ν��Ͻ��� ����
		
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("freeList", freeList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("bbs/free_list.jsp");
		dispatcher.forward(request, response);
	}
}
