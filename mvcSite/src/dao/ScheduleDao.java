package dao;

import static db.JdbcUtil.*;
import java.sql.*;
import java.util.*;
import vo.*;

public class ScheduleDao {
// ���� ������ ���õ� ���� �۾�(���� ���, ����, ��� , ����, ����)���� ��� ó���ϴ� Ŭ����
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
	
	public ArrayList<ScheduleInfo> getScheduleList(String uid, int y, int m){
	// ������ ������ �ش��ϴ� Ư�� ȸ���� ���� ����� ArrayList<ScheduleInfo>�� �����ϴ� �޼ҵ�
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<ScheduleInfo> scheduleList = new ArrayList<ScheduleInfo>();
		ScheduleInfo si = null;
		
		try {
			String sql = "select * from t_schedule_info " + 
			" where mi_id = '" + uid + "' and left(si_start, 7) = '" +
			y + "-" + (m < 10 ? "0" + m : m) + "' order by si_start";
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				si = new ScheduleInfo();
				// �ϳ��� ���� ������ ������ ScheduleInfo�� �ν��Ͻ� ����
				si.setSi_idx(rs.getInt("si_idx"));
				si.setMi_id(rs.getString("mi_is"));
				si.setSi_start(rs.getString("si_start"));
				si.setSi_end(rs.getString("si_end"));
				si.setSi_content(rs.getString("si_content"));
				si.setSi_date(rs.getString("si_date"));
				scheduleList.add(si);
			}
					
		} catch(Exception e) {
			System.out.println("ScheduleDao Ŭ������ getScheduleList() �޼ҵ� ����");
			e.printStackTrace();
		}finally {
			close(rs);	close(stmt);
		}
		
		return scheduleList;
	}
}
