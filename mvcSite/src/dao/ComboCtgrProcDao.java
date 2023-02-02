package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class ComboCtgrProcDao {
// 상품 분류 관련 뭐리 작업들을 모두 처리하는 클래스
	private static ComboCtgrProcDao comboCtgrProcDao;
	private Connection conn;
	private ComboCtgrProcDao() {}
	
	public static ComboCtgrProcDao getInstance() {
		if (comboCtgrProcDao == null)	comboCtgrProcDao = new ComboCtgrProcDao();
		
		return comboCtgrProcDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public ArrayList<ProductCtgrBig> getBigList() {
	// 상품 대분류 목록을 ArrayList<ProductCtgrBig>로 리턴하는 메소드
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<ProductCtgrBig> bigList = new ArrayList<ProductCtgrBig>();
		ProductCtgrBig pcb = null;
		
		try {
			stmt = conn.createStatement();
			String sql = "select * from t_product_ctgr_big";
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				pcb = new ProductCtgrBig();
				pcb.setPcb_id(rs.getString("pcb_id"));
				pcb.setPcb_name(rs.getString("pcb_name"));
				bigList.add(pcb);
			}
			
		} catch(Exception e) {
			System.out.println("ComboCtgrProcDao 클래스의 getBigList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return bigList;
	}
	
	public ArrayList<ProductCtgrSmall> getSmallList() {
		// 상품 대분류 목록을 ArrayList<ProductCtgrBig>로 리턴하는 메소드
			Statement stmt = null;
			ResultSet rs = null;
			ArrayList<ProductCtgrSmall> smallList = new ArrayList<ProductCtgrSmall>();
			ProductCtgrSmall pcs = null;
			
			try {
				stmt = conn.createStatement();
				String sql = "select * from t_product_ctgr_small";
				rs = stmt.executeQuery(sql);
				while(rs.next()) {
					pcs = new ProductCtgrSmall();
					pcs.setPcs_id(rs.getString("pcs_id"));
					pcs.setPcb_id(rs.getString("pcb_id"));
					pcs.setPcs_name(rs.getString("pcs_name"));
					smallList.add(pcs);
				}
				
			} catch(Exception e) {
				System.out.println("ComboCtgrProcDao 클래스의 getSmallList() 메소드 오류");
				e.printStackTrace();
			} finally {
				close(rs);	close(stmt);
			}
			
			return smallList;
		}
}
