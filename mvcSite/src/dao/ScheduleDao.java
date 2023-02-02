package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class ScheduleDao {
// 일정 관리에 관련된 쿼리 작업(일정 목록, 보기, 등록, 수정, 삭제)들을 모두 처리하는 클래스
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
	// 지정한 특정 일정의 정보를 리턴하는 메소드
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
			System.out.println("ScheduleDao 클래스의 getScheduleInfo() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return si;
	}
	
	public ArrayList<ScheduleInfo> getScheduleList(String uid, int y, int m) {
	// 지정한 연월에 해당하는 특정 회원의 일정 목록을 ArrayList<ScheduleInfo>로 리턴하는 메소드
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
				// 하나의 일정 정보를 저장할 ScheduleInfo형 인스턴스 생성
				si.setSi_idx(rs.getInt("si_idx"));
				si.setMi_id(rs.getString("mi_id"));
				si.setSi_start(rs.getString("si_start"));
				si.setSi_end(rs.getString("si_end"));
				si.setSi_content(rs.getString("si_content"));
				si.setSi_date(rs.getString("si_date"));
				scheduleList.add(si);
			}
			
		} catch(Exception e) {
			System.out.println("ScheduleDao 클래스의 getScheduleList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return scheduleList;
	}
	
	public int scheduleInsert(ScheduleInfo si) {
	// 사용자가 입력한 일정을 등록시키는 메소드
		Statement stmt = null;
		int result = 0;
		
		try {
			String sql = "insert into t_schedule_info (mi_id, si_start, si_content) " +
			"values ('" + si.getMi_id() + "', '" + si.getSi_start() + "', '" + si.getSi_content() + "')";
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
		} catch(Exception e) {
			System.out.println("ScheduleDao 클래스의 scheduleInsert() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
	}
	
	public int scheduleUpdate(ScheduleInfo si) {
	// 지정한 특정 일정을 수정시키는 메소드
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
			System.out.println("ScheduleDao 클래스의 scheduleUpdate() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
	}
	
	public int scheduleDelete(ScheduleInfo si) {
	// 지정한 특정 일정을 삭제시키는 메소드
		Statement stmt = null;
		int result = 0;
		
		try {
			String sql = "delete from t_schedule_info where mi_id = '" + si.getMi_id() + 
						"' and si_idx = " + si.getSi_idx() ;
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
		} catch(Exception e) {
			System.out.println("ScheduleDao 클래스의 scheduleDelete() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
	}
}
