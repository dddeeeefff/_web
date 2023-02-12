package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.time.*;
import java.sql.*;
import vo.*;

public class OrderDao {
	private static OrderDao orderDao;
	private Connection conn;
	private OrderDao() {}
	
	public static OrderDao getInstance() {
		if (orderDao == null)	orderDao = new OrderDao();
		
		return orderDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public ArrayList<SellCart> getCartList (String kind, String sql) {
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<SellCart> cartList = new ArrayList<SellCart>();
		SellCart sc = null;
		
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				sc = new SellCart();
				if (kind.equals("c"))	sc.setSc_idx(rs.getInt("sc_idx"));
				// 장바구니를 통한 구매일 경우 장바구니 인덱스를 추가
				sc.setPi_id(rs.getString("pi_id"));
				sc.setPi_img1(rs.getString("pi_img1"));
				sc.setPi_name(rs.getString("pi_name"));
				sc.setPi_min(rs.getInt("pi_min"));
				sc.setPi_dc(rs.getInt("pi_dc"));
				sc.setSc_cnt(rs.getInt("cnt"));
				sc.setPo_idx(rs.getInt("po_idx"));
				sc.setPo_name(rs.getString("po_name"));
				cartList.add(sc);
			}
			
		} catch(Exception e) {
			System.out.println("OrderDao 클래스의 getCartList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return cartList;
	}
	
	public ArrayList<MemberInfo> getAddrList(String miid) {
	// 주문 폼에서 현재 로그인한 회원의 주소정보, 및 보유포인트 목록을 ArrayList로 리턴
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<MemberInfo> addrList = new ArrayList<MemberInfo>();
		MemberInfo mi = null;
		
		try {
			String sql = "select mi_id, mi_name, mi_phone, mi_zip, mi_addr1, mi_addr2, mi_point " +
						 " from t_member_info where mi_id = '" + miid + "' ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				mi = new MemberInfo();
				mi.setMi_id(rs.getString("mi_id"));
				mi.setMi_name(rs.getString("mi_name"));
				mi.setMi_phone(rs.getString("mi_phone"));
				mi.setMi_zip(rs.getString("mi_zip"));
				mi.setMi_addr1(rs.getString("mi_addr1"));
				mi.setMi_addr2(rs.getString("mi_addr2"));
				mi.setMi_point(rs.getInt("mi_point"));
				addrList.add(mi);
			}
			
		} catch(Exception e) {
			System.out.println("OrderDao 클래스의 getAddrList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return addrList;
	}
	
}
