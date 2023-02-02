package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class FreeReplyProcDao {
// �����Խ��� ��� ���� ���� �۾�(���, ���, ����, ���ƿ�/�Ⱦ��)���� ��� ó���ϴ� Ŭ����
	private static FreeReplyProcDao freeReplyProcDao;
	private Connection conn;
	private FreeReplyProcDao() {}
	
	public static FreeReplyProcDao getInstance() {
		if (freeReplyProcDao == null)	freeReplyProcDao = new FreeReplyProcDao();
		
		return freeReplyProcDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public ArrayList<BbsFreeReply> getReplyList(int bfidx) {
	// ������ �Խñۿ� ���� ��۵��� ����� ArrayList<BbsFreeReply>�� �����ϴ� �޼ҵ�
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<BbsFreeReply> replyList = new ArrayList<BbsFreeReply>();
		// ��� ����� ������ ��ü
		BbsFreeReply bfr = null;
		// replyList�� ������ �ϳ��� ��� ������ ���� �ν��Ͻ�
		
		try {
			String sql = "select * from t_bbs_free_reply where bfr_isdel = 'n' and bf_idx = " + bfidx;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				bfr = new BbsFreeReply();
				// �ϳ����� ��� �������� ������ BbsFreeReply�� �ν��Ͻ� ����
				bfr.setBfr_idx(rs.getInt("bfr_idx"));
				bfr.setBf_idx(bfidx);
				bfr.setBfr_ismem(rs.getString("bfr_ismem"));
				bfr.setBfr_writer(rs.getString("bfr_writer"));
				bfr.setBfr_content(rs.getString("bfr_content"));
				bfr.setBfr_good(rs.getInt("bfr_good"));
				bfr.setBfr_bad(rs.getInt("bfr_bad"));
				bfr.setBfr_ip(rs.getString("bfr_ip"));
				bfr.setBfr_date(rs.getString("bfr_date"));
				replyList.add(bfr);
			}
			
		} catch(Exception e) {
			System.out.println("FreeReplyProcDao Ŭ������ getReplyList() �޼ҵ� ����");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return replyList;
	}
	
	public int replyInsert(BbsFreeReply bfr) {
	// ����ڰ� �Է��� ����� ���̺� �����ϴ� �޼ҵ�
		Statement stmt = null;
		int result = 0;
		
		try {
			String sql = "insert into t_bbs_free_reply (bf_idx, bfr_ismem, bfr_writer, bfr_pw, bfr_content, bfr_ip) " + 
					" values ('" + bfr.getBf_idx() + "', '" + bfr.getBfr_ismem() + "', '" + bfr.getBfr_writer() + "', '" + 
					bfr.getBfr_pw() + "', '" + bfr.getBfr_content() + "', '" + bfr.getBfr_ip() + "')";
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
			sql = "update t_bbs_free set bf_reply = bf_reply + 1 where bf_idx = " + bfr.getBf_idx();
			stmt.executeUpdate(sql);

		} catch(Exception e) {
			System.out.println("FreeReplyProcDao Ŭ������ replyInsert() �޼ҵ� ����");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
	}
	
	public int replyDelete(BbsFreeReply bfr) {
	// ������ ����� �����ϴ� �޼ҵ�
		Statement stmt = null;
		int result = 0;
		
		try {
			String sql = "update t_bbs_free_reply set bfr_isdel = 'y' where bfr_ismem = '" + bfr.getBfr_ismem() + 
					"' and bfr_idx = " + bfr.getBfr_idx();
			if (bfr.getBfr_ismem().equals("y")) {	// ȸ�� ����̸�
				sql += " and bfr_writer = '" + bfr.getBfr_writer() + "' ";
			} else {	// ��ȸ�� ����̸�
				sql += " and bfr_pw = '" + bfr.getBfr_pw() + "' ";
			}
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
			sql = "update t_bbs_free set bf_reply = bf_reply - 1 where bf_reply > 0 and bf_idx = " + bfr.getBf_idx();
			stmt.executeUpdate(sql);

		} catch(Exception e) {
			System.out.println("FreeReplyProcDao Ŭ������ replyDelete() �޼ҵ� ����");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
	}
	
	public int replyGnb(BbsFreeReplyGnb bfrg) {
	// ������ ��ۿ� ���ƿ�/�Ⱦ�並 ó���ϴ� �޼ҵ�
	// �̹� �ߴ� ����̸� -1��, ���� ó�� ������ 2��, ó���� �ȵ����� 0�̳� 1�� ����
		Statement stmt = null;
		ResultSet rs = null;
		int result = 0;
		
		try {
			stmt = conn.createStatement();
			String sql = "select frg_gnb from t_bbs_free_reply_gnb where mi_id = '" + bfrg.getMi_id() + 
					"' and bfr_idx = " + bfrg.getBfr_idx();
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			if (rs.next()) {	// �����Ͱ� ������(�̹� ���ƿ�/�Ⱦ�並 ������)
				result = -1;
			} else {
				sql = "update t_bbs_free_reply set ";
				if (bfrg.getFrg_gnb().equals("g"))
					sql += " bfr_good = bfr_good + 1 ";
				else 
					sql += " bfr_bad = bfr_bad + 1 ";
				sql += " where bfr_idx = " + bfrg.getBfr_idx();
				System.out.println(sql);
				result = stmt.executeUpdate(sql);
				// ����� ���ƿ�/�Ⱦ�� �� �߰� ���� ����
				
				sql = "insert into t_bbs_free_reply_gnb (mi_id, bfr_idx, frg_gnb, frg_ip) " + 
					"values ('" + bfrg.getMi_id() + "', '" + bfrg.getBfr_idx() + "', '" + bfrg.getFrg_gnb() + "', '"+ bfrg.getFrg_ip() + "')";
				System.out.println(sql);
				result += stmt.executeUpdate(sql);
				// ���ƿ�/�Ⱦ�� ���� �߰� ����
			}

		} catch(Exception e) {
			System.out.println("FreeReplyProcDao Ŭ������ replyGnb() �޼ҵ� ����");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return result;
	}
}
