package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class ScheduleSvc {
	public ArrayList<ScheduleInfo> getScheduleList(String uid, int y, int m) {
		ArrayList<ScheduleInfo> scheduleList = new ArrayList<ScheduleInfo>();
		Connection conn = getConnection();
		ScheduleDao scheduleDao = ScheduleDao.getInstance();
		scheduleDao.setConnection(conn);
		
		scheduleList = scheduleDao.getScheduleList(uid, y, m);
		close(conn);
		
		return scheduleList;
	}
}
