package svc;

import static db.JdbcUtil.*;	// JdbcUtil 클래스의 모든 멤버들을 자유롭게 사용함
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class LoginSvc {
// 로그인에 필요한 아이디와 암호를 받아 비즈니스 로직을 처리(쿼리 작업 제외)하는 클래스
	public MemberInfo getLoginInfo(String uid, String pwd) {
		Connection conn = getConnection();
		LoginDao loginDao = LoginDao.getInstance();
		loginDao.setConnection(conn);
		
		MemberInfo loginInfo = loginDao.getLoginInfo(uid, pwd);
		close(conn);
		
		return loginInfo;
	}
}
