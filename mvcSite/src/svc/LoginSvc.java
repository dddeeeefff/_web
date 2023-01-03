package svc;

import static db.JdbcUtil.*;	// JdbcUtil Ŭ������ ��� ������� �����Ӱ� �����
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class LoginSvc {
// �α��ο� �ʿ��� ���̵�� ��ȣ�� �޾� ����Ͻ� ������ ó��(���� �۾� ����)�ϴ� Ŭ����
	public MemberInfo getLoginInfo(String uid, String pwd) {
		Connection conn = getConnection();
		LoginDao loginDao = LoginDao.getInstance();
		loginDao.setConnection(conn);
		
		MemberInfo loginInfo = loginDao.getLoginInfo(uid, pwd);
		close(conn);
		
		return loginInfo;
	}
}
