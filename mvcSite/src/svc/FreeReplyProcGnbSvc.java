package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class FreeReplyProcGnbSvc {
	public int replyGnb(BbsFreeReplyGnb bfrg) {
		int result = 0;
		Connection conn = getConnection();
		FreeReplyProcDao freeReplyProcDao = FreeReplyProcDao.getInstance();
		freeReplyProcDao.setConnection(conn);
		
		result = freeReplyProcDao.replyGnb(bfrg);
		if (result == 2)	commit(conn);
		else				rollback(conn);
		close(conn);
		
		return result;
	}
}
