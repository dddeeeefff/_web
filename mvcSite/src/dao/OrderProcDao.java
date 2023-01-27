package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.time.*;
import java.sql.*;
import vo.*;

public class OrderProcDao {
// �ֹ� ���õ� ���� �۾�(��, ���, ����)���� ��� ó���ϴ� Ŭ����
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
	// �ֹ� ������ ������ ������ ��ǰ����� ArrayList�� �����ϴ� �޼ҵ�
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
				// ��ٱ��ϸ� ���� ������ ��쿡�� ��ٱ��� �ε����� �߰���
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
			System.out.println("OrderProcDao Ŭ������ getBuyList() �޼ҵ� ����");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return pdtList;
	}
	
	public ArrayList<MemberAddr> getAddrList(String miid) {
	// �ֹ� ������ ������ ���� �α����� ȸ���� �ּ� ����� ArrayList�� �����ϴ� �޼ҵ�
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
			System.out.println("OrderProcDao Ŭ������ getAddrList() �޼ҵ� ����");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return addrList;
	}
	
	public String getOrderId() {
	// ���ο� �ֹ���ȣ(yymmdd + �������� 2�ڸ� + �Ϸù�ȣ 4�ڸ�(1001))�� �����Ͽ� �����ϴ� �޼ҵ�
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
			// ���� �� �Էµ� �ֹ���ȣ�� �� ���� �ֱ� ���� �������� ����
			rs = stmt.executeQuery(sql);
			if (rs.next()) {	// ���� ������ �ֹ���ȣ�� ������
				int num = Integer.parseInt(rs.getString("seq")) + 1;
				oi_id = td + rn + num;
			} else {	// ���� ù ������ ���
				oi_id = td + rn + "1001";
			}
			
			
		} catch(Exception e) {
			System.out.println("OrderProcDao Ŭ������ getOrderId() �޼ҵ� ����");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return oi_id;
	}
	
	public String orderInsert(String kind, OrderInfo oi, String temp) {
	// �ֹ�ó���� �ϴ� �޼ҵ�(��ٱ��ϳ� �ٷ� ���Ÿ� ���� �ֹ�)
		Statement stmt = null;
		ResultSet rs = null;
		String oi_id = getOrderId();
		String result = oi_id + ",";
		int rcount = 0, target = 0;
		// rcount : ���� ���� �������� ���������� ����Ǵ� ���ڵ� ������ ���� ������ ����
		// target : insert, update, delete ���� ���� ����Ƚ���� ����Ǿ�� �� ���ڵ��� �� ������ ������ ����
		
		try {
			stmt = conn.createStatement();
			
			// t_order_info ���̺� ����� insert ��
			String sql = "insert into t_order_info (" + 
					"oi_id, mi_id, oi_name, oi_phone, oi_zip, oi_addr1, " + 
					"oi_addr2, oi_payment, oi_pay, oi_status) values ('" + 
					oi_id			+ "', '" + oi.getMi_id()	+ "', '" + 
					oi.getOi_name()	+ "', '" + oi.getOi_phone() + "', '" + 
					oi.getOi_zip()	+ "', '" + oi.getOi_addr1()	+ "', '" + 
					oi.getOi_addr2()+ "', '" + oi.getOi_payment()+"', '" + 
					oi.getOi_pay()	+ "', '" + oi.getOi_status()+ "') ";
			target++;	rcount = stmt.executeUpdate(sql);	
			
			if (kind.equals("c")) {	// ��ٱ��ϸ� ���� ������ ���
				// ��ٱ��Ͽ��� t_order_detail ���̺� insert�� ��ǰ������ ����				
				sql = "select a.pi_id, a.ps_idx, a.oc_cnt, b.pi_name, b.pi_img1, c.ps_size, " + 
					" if(b.pi_dc > 0, (100 - b.pi_dc) / 100 *  b.pi_price, b.pi_price) price " + 
					" from t_order_cart a, t_product_info b,  t_product_stock c where a.pi_id = b.pi_id " + 
					" and a.ps_idx = c.ps_idx and a.mi_id = '" + oi.getMi_id()+ "' and (";
				String delWhere = " where mi_id = '" + oi.getMi_id() + "' and ( ";
				String[] arr = temp.split(",");
				// ��ٱ��� ���̺��� �ε�����ȣ��� �迭 ����
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
				if (rs.next()) {	// ��ٱ��Ͽ� ������ ��ǰ������ ������
					do {
						Statement stmt2 = conn.createStatement();
						
						// t_order_detail ���̺� ����� insert ��
						sql = "insert into t_order_detail (" + 
							"oi_id, pi_id, ps_idx, od_cnt, od_price, od_name, od_img, od_size) values ('" + 
							oi_id + "', '" + rs.getString("pi_id") + "', '" + rs.getInt("ps_idx") + "', '" + 
							rs.getInt("oc_cnt") + "', '" + rs.getInt("price") + "', '" + rs.getString("pi_name") + "', '" + 
							rs.getString("pi_img1") + "', '" + rs.getInt("ps_size") + "') ";
						target++;	rcount += stmt2.executeUpdate(sql);	
						
						// t_product_info ���̺��� �Ǹż� ���� update ��
						sql = "update t_product_info set pi_sale = pi_sale + " + rs.getInt("oc_cnt") + 
							" where pi_id = '" + rs.getString("pi_id") + "' ";
						target++;	rcount += stmt2.executeUpdate(sql);
						
						// t_product_stock ���̺��� �Ǹ� �� ��� ���� update ��
						sql = "update t_product_stock set ps_stock = ps_stock - " + rs.getInt("oc_cnt") + 
							", ps_sale = ps_sale + " + rs.getInt("oc_cnt") + " where ps_idx = " + rs.getInt("ps_idx");
						target++;	rcount += stmt2.executeUpdate(sql);
						
					} while (rs.next());
					
					// t_order_cart ���̺��� ���� �� ���� delete ��
					sql = "delete from t_order_cart " + delWhere;
					System.out.println(sql);
					stmt.executeUpdate(sql);
					// ����� ������ �߻��ص� ���ſʹ� ��������Ƿ� rcount�� �������� ����.
					
				} else {	// ��ٱ��Ͽ� ������ ��ǰ������ ������
					return result + "1,4";
				}
			} else {	// �ٷ� ������ ���
				
			}
			
			// ����Ʈ ��� �� ���� ���� �۾�
			if(oi.getOi_upoint() > 0) {		// ���Ž� ����Ʈ�� ��������� 
				
			} else {	// ���Ž� ����Ʈ�� ��� ��������
				int pnt = oi.getOi_pay() * 2 / 100;	// ������ ����Ʈ
				// t_member_info ���̺��� ���� ����Ʈ ���� ����
				sql = "update t_member_info set mi_point = mi_point + " + pnt + " where mi_id = '" + oi.getMi_id() + "' ";
				target++;	rcount += stmt.executeUpdate(sql);	
				
				// t_member_point ���̺��� ����Ʈ ��� ���� �߰� ����
				sql = "insert into t_member_point (mi_id, mp_su, " + 
					  " mp_point, mp_desc, mp_detail) values ('" +
					   oi.getMi_id() + "', 's', '" + pnt + "', " + 
					  "'��ǰ����', '" + oi_id  + "')"; 
				target++;	rcount += stmt.executeUpdate(sql);	
			}
			
		} catch(Exception e) {
			System.out.println("OrderProcDao Ŭ������ orderInsert() �޼ҵ� ����");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return result + rcount + "," + target;
		// �ֹ���ȣ, ���� ����� ���ڵ��, ����Ǿ�� �� ���ڵ� ���� ����
	}
	public OrderInfo getOrderInfo(String miid, String oiid) {
	// �޾ƿ� ȸ�����̵�� �ֹ���ȣ�� �ش��ϴ� �������� OrderInfo�� �ν��Ͻ��� ��� �����ϴ� �޼ҵ�
		Statement stmt = null;
		ResultSet rs = null;
		OrderInfo oi = null;
		ArrayList<OrderDetail> detailList = new ArrayList<OrderDetail>();
		// �ֹ��� ��ǰ�� ����
		
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
			System.out.println("OrderProcDao Ŭ������ getOrderInfo() �޼ҵ� ����");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return oi;
	}
}
