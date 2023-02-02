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
		
		if (kind.equals("in")) {		// ���� ����� ���
			result = scheduleDao.scheduleInsert(si);
		} else if (kind.equals("up")) {	// ���� ������ ���
			result = scheduleDao.scheduleUpdate(si);
		} else if (kind.equals("del")) {// ���� ������ ���
			result = scheduleDao.scheduleDelete(si);
		}
		
		if (result == 1)	commit(conn);
		else				rollback(conn);
		close(conn);
		
		return result;
	}
}
