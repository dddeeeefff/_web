package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class ScheduleDao {
// ���� ������ ���õ� ���� �۾�(���� ���, ����, ���, ����, ����)���� ��� ó���ϴ� Ŭ����
	private static ScheduleDao scheduleDao;
	private Connection conn;
	private ScheduleDao() {}
	
	public static ScheduleDao getInstance() {
		if (scheduleDao == null)	scheduleDao = new ScheduleDao();
		
		return scheduleDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public ScheduleInfo getScheduleInfo(String mi_id, int idx) {
	// ������ Ư�� ������ ������ �����ϴ� �޼ҵ�
		Statement stmt = null;
		ResultSet rs = null;
		ScheduleInfo si = null;
		
		try {
			String sql = "select * from t_schedule_info where mi_id = '" + mi_id + "' and si_idx = " + idx;
//			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			if (rs.next()) {
				si = new ScheduleInfo();
				si.setSi_idx(rs.getInt("si_idx"));
				si.setMi_id(rs.getString("mi_id"));
				si.setSi_start(rs.getString("si_start"));
				si.setSi_content(rs.getString("si_content"));
				si.setSi_date(rs.getString("si_date"));
			}
			
		} catch(Exception e) {
			System.out.println("ScheduleDao Ŭ������ getScheduleInfo() �޼ҵ� ����");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return si;
	}
	
	public ArrayList<ScheduleInfo> getScheduleList(String uid, int y, int m) {
	// ������ ������ �ش��ϴ� Ư�� ȸ���� ���� ����� ArrayList<ScheduleInfo>�� �����ϴ� �޼ҵ�
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<ScheduleInfo> scheduleList = new ArrayList<ScheduleInfo>();
		ScheduleInfo si = null;
		
		try {
			String sql = "select * from t_schedule_info where mi_id = '" + uid + 
			"' and left(si_start, 7) = '" + y + "-" + (m < 10 ? "0" + m : m) + "' order by si_start";
//			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				si = new ScheduleInfo();
				// �ϳ��� ���� ������ ������ ScheduleInfo�� �ν��Ͻ� ����
				si.setSi_idx(rs.getInt("si_idx"));
				si.setMi_id(rs.getString("mi_id"));
				si.setSi_start(rs.getString("si_start"));
				si.setSi_end(rs.getString("si_end"));
				si.setSi_content(rs.getString("si_content"));
				si.setSi_date(rs.getString("si_date"));
				scheduleList.add(si);
			}
			
		} catch(Exception e) {
			System.out.println("ScheduleDao Ŭ������ getScheduleList() �޼ҵ� ����");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return scheduleList;
	}
	
	public int scheduleInsert(ScheduleInfo si) {
	// ����ڰ� �Է��� ������ ��Ͻ�Ű�� �޼ҵ�
		Statement stmt = null;
		int result = 0;
		
		try {
			String sql = "insert into t_schedule_info (mi_id, si_start, si_content) " +
			"values ('" + si.getMi_id() + "', '" + si.getSi_start() + "', '" + si.getSi_content() + "')";
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
		} catch(Exception e) {
			System.out.println("ScheduleDao Ŭ������ scheduleInsert() �޼ҵ� ����");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
	}
	
	public int scheduleUpdate(ScheduleInfo si) {
	// ������ Ư�� ������ ������Ű�� �޼ҵ�
		Statement stmt = null;
		int result = 0;
		
		try {
			String sql = "update t_schedule_info set " + 
			" si_start = '" + si.getSi_start() + "', " + 
			" si_content = '" + si.getSi_content() + "' " + 
			" where mi_id = '" + si.getMi_id() + "' and si_idx = " + si.getSi_idx() ;
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
		} catch(Exception e) {
			System.out.println("ScheduleDao Ŭ������ scheduleUpdate() �޼ҵ� ����");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
	}
	
	public int scheduleDelete(ScheduleInfo si) {
	// ������ Ư�� ������ ������Ű�� �޼ҵ�
		Statement stmt = null;
		int result = 0;
		
		try {
			String sql = "delete from t_schedule_info where mi_id = '" + si.getMi_id() + 
						"' and si_idx = " + si.getSi_idx() ;
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
		} catch(Exception e) {
			System.out.println("ScheduleDao Ŭ������ scheduleDelete() �޼ҵ� ����");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
	}
}
