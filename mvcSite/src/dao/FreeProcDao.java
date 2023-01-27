package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.time.*;
import java.sql.*;
import vo.*;

public class FreeProcDao {
	private static FreeProcDao freeProcDao;
	private Connection conn;
	private FreeProcDao() {}
	
	public static FreeProcDao getInstance() {
		if (freeProcDao == null)	freeProcDao = new FreeProcDao();
		
		return freeProcDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int getFreeListCount(String where) {
	// �����Խ��ǿ��� �˻��� ����� ���ڵ�(�Խñ�) ������ �����ϴ� �޼ҵ�
		Statement stmt = null;
		ResultSet rs = null;
		int rcnt = 0;
		
		try {
			String sql = "select count(*) from t_bbs_free " + where;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next())	rcnt = rs.getInt(1);
			
		} catch(Exception e) {
			System.out.println("FreeProcDao Ŭ������ getFreeListCount() �޼ҵ� ����");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return rcnt;
	}
	
	public ArrayList<BbsFree> getFreeList(String where, int cpage, int psize){
	// �����Խ��ǿ��� �˻��� ����l ���ڵ�(�Խñ�) ����� ArrayList�� �����ϴ� �޼ҵ�
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<BbsFree> freeList = new ArrayList<BbsFree>();
		// �˻��� �Խñ۵��� ������ ArrayList<BbsFree>
		BbsFree bf = null;
		// freeList�� ������ �ϳ��� �Խñ� ������ ���� �ν��Ͻ�
		
		try {
			String sql = "select bf_idx, bf_title, bf_reply, bf_ismem, bf_writer, bf_read, " +
			" if(curdate() = date(bf_date), right(bf_date, 8), replace(mid(bf_date, 3, 8), '-', '.')) wdate " + 
			" from t_bbs_free " + where + " order by bf_idx desc " +
			" limit " + ((cpage - 1) * psize) + ", " + psize;
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				bf = new BbsFree();
				bf.setBf_idx(rs.getInt("bf_idx"));
				bf.setBf_title(rs.getString("bf_title"));
				bf.setBf_reply(rs.getInt("bf_reply"));
				bf.setBf_ismem(rs.getString("bf_ismem"));
				bf.setBf_writer(rs.getString("bf_writer"));
				bf.setBf_read(rs.getInt("bf_read"));
				bf.setBf_date(rs.getString("wdate"));
				freeList.add(bf);
			}
			
		} catch(Exception e) {
			System.out.println("FreeProcDao Ŭ������ getFreeList() �޼ҵ� ����");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return freeList;
	}
	
	public int readUpdate(int bfidx) {
	// ������ �Խñ��� ��ȸ���� ������Ű�� �޼ҵ�
		Statement stmt = null;
		int result = 0;
		try {
			String sql = "update t_bbs_free set bf_read = bf_read + 1 where bf_idx = " + bfidx;
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		} catch(Exception e) {
			System.out.println("FreeProcDao Ŭ������ readUpdate() �޼ҵ� ����");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
		
	}
	public BbsFree getFreeInfo(int bfidx) {
	// ������ �Խñ��� �������� BbsFree�� �ν��Ͻ��� �����ϴ� �޼ҵ�
		Statement stmt = null;
		ResultSet rs = null;
		BbsFree bf = null;
		try {
			String sql = "select * from t_bbs_free where bf_isdel = 'n' and bf_idx = " + bfidx;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				bf = new BbsFree();
				bf.setBf_idx(bfidx);
				bf.setBf_ismem(rs.getString("bf_ismem"));
				bf.setBf_writer(rs.getString("bf_writer"));
				bf.setBf_header(rs.getString("bf_header"));
				bf.setBf_title(rs.getString("bf_title"));
				bf.setBf_content(rs.getString("bf_content"));
				bf.setBf_date(rs.getString("bf_date"));
				bf.setBf_read(rs.getInt("bf_read"));
				bf.setBf_ip(rs.getString("bf_ip"));
			}
			
		} catch(Exception e) {
			System.out.println("FreeProcDao Ŭ������ getFreeInfo() �޼ҵ� ����");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		return bf;
	}
}
