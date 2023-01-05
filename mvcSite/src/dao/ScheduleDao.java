package dao;

import static db.JdbcUtil.*;
import java.sql.*;
import java.util.*;
import vo.*;

public class ScheduleDao {
// 일정 관리에 관련된 쿼리 작업(일정 목록, 보기, 등록 , 수정, 삭제)들을 모두 처리하는 클래스
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
	// 지정한 연월에 해당하는 특정 회원의 일정 목록을 ArrayList<ScheduleInfo>로 리턴하는 메소드
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
				// 하나의 일정 정보를 저장할 ScheduleInfo형 인스턴스 생성
				si.setSi_idx(rs.getInt("si_idx"));
				si.setMi_id(rs.getString("mi_is"));
				si.setSi_start(rs.getString("si_start"));
				si.setSi_end(rs.getString("si_end"));
				si.setSi_content(rs.getString("si_content"));
				si.setSi_date(rs.getString("si_date"));
				scheduleList.add(si);
			}
					
		} catch(Exception e) {
			System.out.println("ScheduleDao 클래스의 getScheduleList() 메소드 오류");
			e.printStackTrace();
		}finally {
			close(rs);	close(stmt);
		}
		
		return scheduleList;
	}
}
