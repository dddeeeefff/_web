package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class MemberProcInSvc {
	public int memberProcIn(MemberInfo memberInfo, MemberAddr memberAddr) {
		int result = 0;
		Connection conn = getConnection();
		MemberProcInDao memberProcInDao = MemberProcInDao.getInstance();
		memberProcInDao.setConnection(conn);
		
		result = memberProcInDao.memberProcIn(memberInfo, memberAddr);
		if (result == 3)	commit(conn);
		else				rollback(conn);
		// ����� ������ insert, update, delete �� ��� �ݵ�� Ʈ������� �Ϸ��ؾ� ��
		close(conn);
		
		return result;
	}
}
