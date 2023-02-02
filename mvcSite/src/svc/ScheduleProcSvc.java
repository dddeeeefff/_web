package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class ScheduleProcSvc {
	public int scheduleProc(String kind, ScheduleInfo si) {
		int result = 0;
		Connection conn = getConnection();
		ScheduleDao scheduleDao = ScheduleDao.getInstance();
		scheduleDao.setConnection(conn);
		
		if (kind.equals("in")) {		// 老沥 殿废老 版快
			result = scheduleDao.scheduleInsert(si);
		} else if (kind.equals("up")) {	// 老沥 荐沥老 版快
			result = scheduleDao.scheduleUpdate(si);
		} else if (kind.equals("del")) {// 老沥 昏力老 版快
			result = scheduleDao.scheduleDelete(si);
		}
		
		if (result == 1)	commit(conn);
		else				rollback(conn);
		close(conn);
		
		return result;
	}
}
