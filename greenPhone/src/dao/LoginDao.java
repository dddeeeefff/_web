package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class LoginDao {
	private static LoginDao loginDao;
	private Connection conn;
	private LoginDao() {}

	public static LoginDao getInstance() {
		if (loginDao == null)	loginDao = new LoginDao();
		
		return loginDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public MemberInfo getLoginInfo(String uid, String pwd) {
		Statement stmt = null;
		ResultSet rs = null;
		MemberInfo loginInfo = null;
		
		try {
			String sql = "select * from t_member_info " + 
					"where mi_status = 'a' and mi_id = '" + uid + "' and mi_pw = '" + pwd + "' ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				loginInfo = new MemberInfo();
				loginInfo.setMi_id(rs.getString("mi_id"));
				loginInfo.setMi_pw(rs.getString("mi_pw"));
				loginInfo.setMi_name(rs.getString("mi_name"));
				loginInfo.setMi_gender(rs.getString("mi_gender"));
				loginInfo.setMi_birth(rs.getString("mi_birth"));
				loginInfo.setMi_phone(rs.getString("mi_phone"));
				loginInfo.setMi_email(rs.getString("mi_email"));
				loginInfo.setMi_zip(rs.getString("mi_zip"));
				loginInfo.setMi_addr1(rs.getString("mi_addr1"));
				loginInfo.setMi_addr2(rs.getString("mi_addr2"));
				loginInfo.setMi_point(rs.getInt("mi_point"));
				loginInfo.setMi_joindate(rs.getString("mi_joindate"));
				loginInfo.setMi_status(rs.getString("mi_status"));
			}
			
		} catch(Exception e) {
			System.out.println("LoginDao Ŭ������ getLoginInfo() �޼ҵ� ����");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return loginInfo;
	}
}
