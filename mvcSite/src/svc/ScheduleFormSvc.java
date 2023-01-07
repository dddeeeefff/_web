package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class ScheduleFormSvc {
	public ScheduleInfo getScheduleInfo(String mi_id, int idx) {
		ScheduleInfo scheduleInfo = null;
		Connection conn = getConnection();
		ScheduleDao scheduleDao = ScheduleDao.getInstance();
		scheduleDao.setConnection(conn);
		
		scheduleInfo = scheduleDao.getScheduleInfo(mi_id, idx);
		close(conn);
		
		return scheduleInfo;
	}
}
