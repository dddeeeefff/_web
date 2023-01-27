package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.time.*;
import java.sql.*;
import vo.*;

public class OrderProcDao {
// 주문 관련된 쿼리 작업(폼, 등록, 변경)들을 모두 처리하는 클래스
	private static OrderProcDao orderProcDao;
	private Connection conn;
	private OrderProcDao() {}
	
	public static OrderProcDao getInstance() {
		if (orderProcDao == null)	orderProcDao = new OrderProcDao();
		
		return orderProcDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public ArrayList<OrderCart> getBuyList(String kind, String sql) {
	// 주문 폼에서 보여줄 구매할 상품목록을 ArrayList로 리턴하는 메소드
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<OrderCart> pdtList = new ArrayList<OrderCart>();
		OrderCart oc = null;
		
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				oc = new OrderCart();
				if (kind.equals("c"))	oc.setOc_idx(rs.getInt("oc_idx"));
				// 장바구니를 통한 구매일 경우에만 장바구니 인덱스를 추가함
				oc.setPi_id(rs.getString("pi_id"));
				oc.setPi_img1(rs.getString("pi_img1"));
				oc.setPi_name(rs.getString("pi_name"));
				oc.setPi_price(rs.getInt("pi_price"));
				oc.setPi_dc(rs.getInt("pi_dc"));
				oc.setOc_cnt(rs.getInt("cnt"));
				oc.setPs_size(rs.getInt("ps_size"));
				pdtList.add(oc);
			}
			
		} catch(Exception e) {
			System.out.println("OrderProcDao 클래스의 getBuyList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return pdtList;
	}
	
	public ArrayList<MemberAddr> getAddrList(String miid) {
	// 주문 폼에서 보여줄 현재 로그인한 회원의 주소 목록을 ArrayList로 리턴하는 메소드
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<MemberAddr> addrList = new ArrayList<MemberAddr>();
		MemberAddr ma = null;
		
		try {
			String sql = "select * from t_member_addr where mi_id = '" + miid + "' ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				ma = new MemberAddr();
				ma.setMa_idx(rs.getInt("ma_idx"));
				ma.setMi_id(rs.getString("mi_id"));
				ma.setMa_name(rs.getString("ma_name"));
				ma.setMa_rname(rs.getString("ma_rname"));
				ma.setMa_phone(rs.getString("ma_phone"));
				ma.setMa_zip(rs.getString("ma_zip"));
				ma.setMa_addr1(rs.getString("ma_addr1"));
				ma.setMa_addr2(rs.getString("ma_addr2"));
				ma.setMa_basic(rs.getString("ma_basic"));
				ma.setMa_date(rs.getString("ma_date"));
				addrList.add(ma);
			}
			
		} catch(Exception e) {
			System.out.println("OrderProcDao 클래스의 getAddrList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return addrList;
	}
	
	public String getOrderId() {
	// 새로운 주문번호(yymmdd + 랜덤영문 2자리 + 일련번호 4자리(1001))를 생성하여 리턴하는 메소드
		Statement stmt = null;
		ResultSet rs = null;
		String oi_id = null;
		
		try {
			stmt = conn.createStatement();
			LocalDate today = LocalDate.now();	// yyyy-mm-dd
			String td = (today + "").substring(2).replace("-", "");	// yymmdd
			
			String alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
			Random rnd = new Random();
			String rn = alpha.charAt(rnd.nextInt(26)) + "";
			rn += alpha.charAt(rnd.nextInt(26)) + "";
			
			String sql = "select right(oi_id, 4) seq from t_order_info " + 
					" where left(oi_id, 6) = '" + td + "' order by oi_date desc limit 0, 1";
			// 같은 날 입력된 주문번호들 중 가장 최근 것을 가져오는 쿼리
			rs = stmt.executeQuery(sql);
			if (rs.next()) {	// 오늘 구매한 주문번호가 있으면
				int num = Integer.parseInt(rs.getString("seq")) + 1;
				oi_id = td + rn + num;
			} else {	// 오늘 첫 구매일 경우
				oi_id = td + rn + "1001";
			}
			
			
		} catch(Exception e) {
			System.out.println("OrderProcDao 클래스의 getOrderId() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return oi_id;
	}
	
	public String orderInsert(String kind, OrderInfo oi, String temp) {
	// 주문처리를 하는 메소드(장바구니나 바로 구매를 통한 주문)
		Statement stmt = null;
		ResultSet rs = null;
		String oi_id = getOrderId();
		String result = oi_id + ",";
		int rcount = 0, target = 0;
		// rcount : 실제 쿼리 실행결과로 정상적으로 적용되는 레코드 개수를 누적 저장할 변수
		// target : insert, update, delete 등의 쿼리 실행횟수로 적용되어야 할 레코드의 총 개수를 저장할 변수
		
		try {
			stmt = conn.createStatement();
			
			// t_order_info 테이블에 사용할 insert 문
			String sql = "insert into t_order_info (" + 
					"oi_id, mi_id, oi_name, oi_phone, oi_zip, oi_addr1, " + 
					"oi_addr2, oi_payment, oi_pay, oi_status) values ('" + 
					oi_id			+ "', '" + oi.getMi_id()	+ "', '" + 
					oi.getOi_name()	+ "', '" + oi.getOi_phone() + "', '" + 
					oi.getOi_zip()	+ "', '" + oi.getOi_addr1()	+ "', '" + 
					oi.getOi_addr2()+ "', '" + oi.getOi_payment()+"', '" + 
					oi.getOi_pay()	+ "', '" + oi.getOi_status()+ "') ";
			target++;	rcount = stmt.executeUpdate(sql);	
			
			if (kind.equals("c")) {	// 장바구니를 통한 구매일 경우
				// 장바구니에서 t_order_detail 테이블에 insert할 상품정보를 추출				
				sql = "select a.pi_id, a.ps_idx, a.oc_cnt, b.pi_name, b.pi_img1, c.ps_size, " + 
					" if(b.pi_dc > 0, (100 - b.pi_dc) / 100 *  b.pi_price, b.pi_price) price " + 
					" from t_order_cart a, t_product_info b,  t_product_stock c where a.pi_id = b.pi_id " + 
					" and a.ps_idx = c.ps_idx and a.mi_id = '" + oi.getMi_id()+ "' and (";
				String delWhere = " where mi_id = '" + oi.getMi_id() + "' and ( ";
				String[] arr = temp.split(",");
				// 장바구니 테이블의 인덱스번호들로 배열 생성
				for (int i = 0 ; i < arr.length ; i++) {
					if (i == 0)	{
						sql += "a.oc_idx = " + arr[i];
						delWhere += "oc_idx = " + arr[i];
					}
					else {
						sql += " or a.oc_idx = " + arr[i];
						delWhere += " or oc_idx = " + arr[i];
					}
				}
				sql += ")";
				delWhere += ")";
				rs = stmt.executeQuery(sql);
				if (rs.next()) {	// 장바구니에 구매할 상품정보가 있으면
					do {
						Statement stmt2 = conn.createStatement();
						
						// t_order_detail 테이블에 사용할 insert 문
						sql = "insert into t_order_detail (" + 
							"oi_id, pi_id, ps_idx, od_cnt, od_price, od_name, od_img, od_size) values ('" + 
							oi_id + "', '" + rs.getString("pi_id") + "', '" + rs.getInt("ps_idx") + "', '" + 
							rs.getInt("oc_cnt") + "', '" + rs.getInt("price") + "', '" + rs.getString("pi_name") + "', '" + 
							rs.getString("pi_img1") + "', '" + rs.getInt("ps_size") + "') ";
						target++;	rcount += stmt2.executeUpdate(sql);	
						
						// t_product_info 테이블의 판매수 증가 update 문
						sql = "update t_product_info set pi_sale = pi_sale + " + rs.getInt("oc_cnt") + 
							" where pi_id = '" + rs.getString("pi_id") + "' ";
						target++;	rcount += stmt2.executeUpdate(sql);
						
						// t_product_stock 테이블의 판매 및 재고 변경 update 문
						sql = "update t_product_stock set ps_stock = ps_stock - " + rs.getInt("oc_cnt") + 
							", ps_sale = ps_sale + " + rs.getInt("oc_cnt") + " where ps_idx = " + rs.getInt("ps_idx");
						target++;	rcount += stmt2.executeUpdate(sql);
						
					} while (rs.next());
					
					// t_order_cart 테이블의 구매 후 삭제 delete 문
					sql = "delete from t_order_cart " + delWhere;
					System.out.println(sql);
					stmt.executeUpdate(sql);
					// 실행시 문제가 발생해도 구매와는 상관없으므로 rcount에 누적하지 않음.
					
				} else {	// 장바구니에 구매할 상품정보가 없으면
					return result + "1,4";
				}
			} else {	// 바로 구매일 경우
				
			}
			
			// 포인트 사용 및 적립 관련 작업
			if(oi.getOi_upoint() > 0) {		// 구매시 포인트를 사용했으면 
				
			} else {	// 구매시 포인트를 사용 안했으면
				int pnt = oi.getOi_pay() * 2 / 100;	// 적립할 포인트
				// t_member_info 테이블의 보유 포인트 변경 쿼리
				sql = "update t_member_info set mi_point = mi_point + " + pnt + " where mi_id = '" + oi.getMi_id() + "' ";
				target++;	rcount += stmt.executeUpdate(sql);	
				
				// t_member_point 테이블의 포인트 사용 내역 추가 쿼리
				sql = "insert into t_member_point (mi_id, mp_su, " + 
					  " mp_point, mp_desc, mp_detail) values ('" +
					   oi.getMi_id() + "', 's', '" + pnt + "', " + 
					  "'상품구매', '" + oi_id  + "')"; 
				target++;	rcount += stmt.executeUpdate(sql);	
			}
			
		} catch(Exception e) {
			System.out.println("OrderProcDao 클래스의 orderInsert() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return result + rcount + "," + target;
		// 주문번호, 실제 적용된 레코드수, 적용되어야 할 레코드 수를 리턴
	}
	public OrderInfo getOrderInfo(String miid, String oiid) {
	// 받아온 회원아이디와 주문번호에 해당하는 정보들을 OrderInfo형 인스턴스에 담아 리턴하는 메소드
		Statement stmt = null;
		ResultSet rs = null;
		OrderInfo oi = null;
		ArrayList<OrderDetail> detailList = new ArrayList<OrderDetail>();
		// 주문의 상품들 정보
		
		try {
			String sql = "select a.oi_name, a.oi_phone, a.oi_zip, a.oi_addr1, a.oi_addr2, " + 
			" a.oi_payment, a.oi_pay, b.od_img, b.od_name, b.od_size, b.od_cnt, " +
			" b.od_price, b.pi_id, c.pi_isview from t_order_info a, t_order_detail b, " + 
			" t_product_info c where a.oi_id = b.oi_id and b.pi_id = c.pi_id " +
			" and a.mi_id = '" + miid + "' and a.oi_id = '" + oiid + "' " + 
			" order by c.pi_id, b.od_size ";
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			if (rs.next()) {	
				oi = new OrderInfo();
				oi.setOi_id(oiid);
				oi.setOi_name(rs.getString("oi_name"));
				oi.setOi_phone(rs.getString("oi_phone"));
				oi.setOi_zip(rs.getString("oi_zip"));
				oi.setOi_addr1(rs.getString("oi_addr1"));
				oi.setOi_addr2(rs.getString("oi_addr2"));
				oi.setOi_payment(rs.getString("oi_payment"));
				oi.setOi_pay(rs.getInt("oi_pay"));
				do {
					OrderDetail od = new OrderDetail();
					od.setOd_img(rs.getString("od_img"));
					od.setOd_name(rs.getString("od_name"));
					od.setOd_size(rs.getInt("od_size"));
					od.setOd_cnt(rs.getInt("od_cnt"));
					od.setOd_price(rs.getInt("od_price"));
					od.setPi_id(rs.getString("pi_id"));
					od.setPi_isview(rs.getString("pi_isview"));
					detailList.add(od);
				}while (rs.next());
				oi.setDetailList(detailList);	
			}
		} catch(Exception e) {
			System.out.println("OrderProcDao 클래스의 getOrderInfo() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return oi;
	}
}
