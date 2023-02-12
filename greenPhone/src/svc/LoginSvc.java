package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class LoginSvc {
	public MemberInfo getLoginInfo(String uid, String pwd) {
		Connection conn = getConnection();
		LoginDao loginDao = LoginDao.getInstance();
		loginDao.setConnection(conn);
		
		MemberInfo loginInfo = loginDao.getLoginInfo(uid, pwd);
		close(conn);
		
		return loginInfo;
	}
}
