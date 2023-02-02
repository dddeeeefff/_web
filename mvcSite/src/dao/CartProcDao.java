package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class CartProcDao {
// 장바구니 관련된 쿼리 작업(목록, 등록, 수정, 삭제)들을 모두 처리하는 클래스
	private static CartProcDao cartProcDao;
	private Connection conn;
	private CartProcDao() {}
	
	public static CartProcDao getInstance() {
		if (cartProcDao == null)	cartProcDao = new CartProcDao();
		
		return cartProcDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public int cartInsert(OrderCart oc) {
	// 사용자가 선택한 상품을 장바구니에 담는 메소드
		Statement stmt = null;
		int result = 0;
		
		try { 
			String sql = "update t_order_cart set oc_cnt = oc_cnt + " + oc.getOc_cnt() + 
						" where mi_id = '" + oc.getMi_id() + "' " + 
						" and pi_id = '" + oc.getPi_id() + "' " + 
						" and ps_idx = " + oc.getPs_idx();
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			// 현재 로그인한 회원의 장바구니에 동일한 상품 및 옵션이 있으면 수량을 증가시키는 쿼리 실행
			if (result == 0) {
			// 동일한 상품(옵션 포함)이 없으면 장바구니에 새롭게 추가
				sql = "insert into t_order_cart (mi_id, pi_id, ps_idx, oc_cnt) " + 
					" values ('" + oc.getMi_id() + "', '" + oc.getPi_id() + "', '" +
					oc.getPs_idx() + "', '" + oc.getOc_cnt() + "')";
				result = stmt.executeUpdate(sql);
			}
			
		} catch(Exception e) {
			System.out.println("CartProcDao 클래스의 cartInsert() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
	}
	
	public int cartDelete(String where) {
	// 지정한 상품을 장바구니에서 삭제하는 메소드
		Statement stmt = null;
		int result = 0;
		
		try { 
			String sql = "delete from t_order_cart " + where;
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
		} catch(Exception e) {
			System.out.println("CartProcDao 클래스의 cartDelete() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
	}
	
	public int cartUpdate(OrderCart oc) {
	// 지정한 상품의 옵션이나 수량을 장바구니에서 변경하는 메소드
		Statement stmt = null;
		ResultSet rs = null;
		int result = 0;
		
		try {
			stmt = conn.createStatement();
			String sql = "update t_order_cart set ";
			String where = " where mi_id = '" + oc.getMi_id() + "' ";
			
			if (oc.getOc_cnt() == 0) {	// 옵션 변경일 경우
				String sql2 = "select oc_idx, oc_cnt from t_order_cart " + 
							where + " and ps_idx = " + oc.getPs_idx();
				// 변경하려는 옵션과 동일한 옵션의 상품이 장바구니에 이미 존재하는 지 여부를 검사할 쿼리
				rs = stmt.executeQuery(sql2);
				if (rs.next()) {
				// 변경하려는 옵션과 동일한 옵션의 상품이 장바구니에 있을 경우
				// 기존 상품의 수량을 추가 변경하려는 상품에 추가한 후 삭제
					int idx = rs.getInt("oc_idx");
					// stmt로 다른 쿼리를 실행하기 전에 사용할 값을 미리 rs에서 받아놓음
					sql += " ps_idx = " + oc.getPs_idx() + ", oc_cnt = oc_cnt + " + rs.getInt("oc_cnt") + 
							where + " and oc_idx = " + oc.getOc_idx();
					// 옵션 변경 및 동일한 옵션의 기존 상품 수량을 현 상품에 추가하는 쿼리
					result = stmt.executeUpdate(sql);
					
					sql = "delete from t_order_cart " + where + " and oc_idx = " + idx;
					// 동일한 옵션의 기존 상품을 장바구니에서 삭제하는 쿼리
					
				} else {
				// 변경하려는 옵션과 동일한 옵션의 상품이 장바구니에 없을 경우
				// 해당 상품의 옵션만 변경
					sql += " ps_idx = " + oc.getPs_idx() + where + " and oc_idx = " + oc.getOc_idx();
				}
				close(rs);
				
			} else {	// 수량 변경일 경우
				sql += " oc_cnt = " + oc.getOc_cnt() + where + " and oc_idx = " + oc.getOc_idx();
			}
			result = stmt.executeUpdate(sql);
			
		} catch(Exception e) {
			System.out.println("CartProcDao 클래스의 cartUpdate() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
	}
	
	public ArrayList<OrderCart> getCartList(String miid) {
	// 장바구니에서 보여줄 정보들을  ArrayList로 리턴하는 메소드
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<OrderCart> cartList = new ArrayList<OrderCart>();
		OrderCart oc = null;
		try {
			ProductProcDao ppd = ProductProcDao.getInstance();
			ppd.setConnection(conn);
			
			String sql = "select a.*, b.pi_name, b.pi_img1, b.pi_price, b.pi_dc, c.ps_stock " + 
					" from t_order_cart a, t_product_info b, t_product_stock c " + 
					" where a.pi_id = b.pi_id and a.pi_id = c.pi_id " + 
					" and a.ps_idx = c.ps_idx and b.pi_isview = 'y' and a.mi_id = '" + miid + "' ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				oc = new OrderCart();
				oc.setOc_idx(rs.getInt("oc_idx"));
				oc.setPi_id(rs.getString("pi_id"));
				oc.setPs_idx(rs.getInt("ps_idx"));
				oc.setOc_cnt(rs.getInt("oc_cnt"));
				oc.setPi_name(rs.getString("pi_name"));
				oc.setPi_img1(rs.getString("pi_img1"));
				oc.setPi_price(rs.getInt("pi_price"));
				oc.setPi_dc(rs.getInt("pi_dc"));
				oc.setPs_stock(rs.getInt("ps_stock"));
				oc.setStockList(ppd.getStockList(oc.getPi_id()));
				// 현재 상품의 옵션 및 재고량 목록
				cartList.add(oc);
			}
			
		} catch(Exception e) {
			System.out.println("CartProcDao 클래스의 getCartList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return cartList;
	}
}
