package dao;

import static db.JdbcUtil.*;
import java.sql.*;
import java.util.*;
import vo.*;


public class ProductProcDao {
// ��ǰ ���õ� ���� �۾�(���, �󼼺���)���� ��� ó���ϴ� Ŭ����
	private static ProductProcDao productProcDao;
	private Connection conn;
	private ProductProcDao() {}
	
	public static ProductProcDao getInstance() {
		if (productProcDao == null)	productProcDao = new ProductProcDao();
		
		return productProcDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	

	public int getProductCount(String where){
	// �˻��Ǵ� ��ǰ�� ����(select ���� �������� ���ڵ� ����)�� �����ϴ� �޼ҵ�
		Statement stmt = null;
		ResultSet rs = null;
		int rcnt = 0;
		
		try {			
			String sql = "select count(*) from t_product_info a " + 
			" where a.pi_isview = 'y' " + where;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next())	rcnt = rs.getInt(1);
			
		} catch(Exception e) {
			System.out.println("ProductProcDao Ŭ������ getProductCount() �޼ҵ� ����");
			e.printStackTrace();
		}finally {
			close(rs);	close(stmt);
		}
		return rcnt;
	}
	
	public ArrayList<ProductInfo> getProductList(int cpage, int psize, String where, String orderBy) {
	// �˻��Ǵ� ��ǰ ����� ������ �������� ���� ArrayList<ProductInfo>������ �����ϴ� �޼ҵ�
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<ProductInfo> productList = new ArrayList<ProductInfo>();
		ProductInfo pi = null;
		
		try {			
			String sql = "select a.pi_id, a.pi_img1, a.pi_name, a.pi_price, a.pi_dc, " +
						" a.pi_special, a.pi_score, a.pi_review, sum(b.ps_stock) stock " +
						" from t_product_info a, t_product_stock b " + 
						" where a.pi_id = b.pi_id and a.pi_isview = 'y' " + 
						where + " group by a.pi_id " + orderBy + 
						" limit " + ((cpage - 1) * psize) + ", " + psize;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				pi = new ProductInfo();
				pi.setPi_id(rs.getString("pi_id"));
				pi.setPi_img1(rs.getString("pi_img1"));
				pi.setPi_name(rs.getString("pi_name"));
				pi.setPi_price(rs.getInt("pi_price"));
				pi.setPi_dc(rs.getInt("pi_dc"));
				pi.setPi_special(rs.getString("pi_special"));
				pi.setPi_score(rs.getFloat("pi_score"));
				pi.setPi_review(rs.getInt("pi_review"));
				pi.setStock(rs.getInt("stock"));
				productList.add(pi);
			}
			
		} catch(Exception e) {
			System.out.println("ProductProcDao Ŭ������ getProductList() �޼ҵ� ����");
			e.printStackTrace();
		}finally {
			close(rs);	close(stmt);
		}
		
		return productList;
	}
	
	public ArrayList<ProductBrand> getBrandList() {
	// �귣�� ����� �����ϴ� �޼ҵ�
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<ProductBrand> brandList = new ArrayList<ProductBrand>();
		ProductBrand pb = null;
		
		try {			
			String sql = "select * from t_product_brand";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				pb = new ProductBrand();
				pb.setPb_id(rs.getString("pb_id"));
				pb.setPb_name(rs.getString("pb_name"));
				brandList.add(pb);
			}
			
		} catch(Exception e) {
			System.out.println("ProductProcDao Ŭ������ getBrandList() �޼ҵ� ����");
			e.printStackTrace();
		}finally {
			close(rs);	close(stmt);
		}
		return brandList;
	}
	
	public ArrayList<ProductCtgrSmall> getCtgrSmallList(String pcb) {
	// �Һз� ����� �����ϴ� �޼ҵ�
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<ProductCtgrSmall> smallList = new ArrayList<ProductCtgrSmall>();
		ProductCtgrSmall pcs = null;
		
		try {			
			String sql = "select * from t_product_ctgr_small where pcb_id = '" + pcb + "' ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				pcs = new ProductCtgrSmall();
				pcs.setPcs_id(rs.getString("pcs_id"));
				pcs.setPcb_id(rs.getString("pcb_id"));
				pcs.setPcs_name(rs.getString("pcs_name"));
				smallList.add(pcs);
			}
			
		} catch(Exception e) {
			System.out.println("ProductProcDao Ŭ������ getCtgrSmallList() �޼ҵ� ����");
			e.printStackTrace();
		}finally {
			close(rs);	close(stmt);
		}
		return smallList;
	}
}
