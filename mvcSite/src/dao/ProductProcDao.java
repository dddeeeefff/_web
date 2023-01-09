package dao;

import static db.JdbcUtil.*;
import java.sql.*;
import java.util.*;
import vo.*;


public class ProductProcDao {
// 상품 관련된 쿼리 작업(목록, 상세보기)들을 모두 처리하는 클래스
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
	// 검색되는 상품의 개수(select 쿼리 실행결과의 레코드 개수)를 리턴하는 메소드
		Statement stmt = null;
		ResultSet rs = null;
		int rcnt = 0;
		
		try {			
			String sql = "select count(*) from t_product_info a " + where;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			if (rs.next())	rcnt = rs.getInt(1);
			
		} catch(Exception e) {
			System.out.println("ProductProcDao 클래스의 getProductCount() 메소드 오류");
			e.printStackTrace();
		}finally {
			close(rs);	close(stmt);
		}
		return rcnt;
	}
	
	public ArrayList<ProductInfo> getProductList(int cpage, int psize, String where, String orderBy) {
	// 검색되는 상품 목록을 지정한 페이지에 맞춰 ArrayList<ProductInfo>형으로 리턴하는 메소드
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<ProductInfo> productList = new ArrayList<ProductInfo>();
		ProductInfo pi = null;
		
		try {			
			String sql = "select a.pi_id, a.pi_img1, a.pi_name, a.pi_price, a.pi_dc, " +
						" a.pi_special, a.pi_score, a.pi_review, sum(b.ps_stock) stock " +
						" from t_product_info a, t_product_stock b " + 
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
			System.out.println("ProductProcDao 클래스의 getProductList() 메소드 오류");
			e.printStackTrace();
		}finally {
			close(rs);	close(stmt);
		}
		
		return productList;
	}
}
