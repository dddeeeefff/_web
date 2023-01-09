package dao;

import static db.JdbcUtil.*;	// JdbcUtil Ŭ������ ��� ������� �����Ӱ� �����
import java.util.*;
import java.sql.*;
import vo.*;

public class MemberProcUpDao {
	private static MemberProcUpDao memberProcUpDao;
	private Connection conn;
	private MemberProcUpDao() {}
	
	public static MemberProcUpDao getInstance() {
		if (memberProcUpDao == null)	memberProcUpDao = new MemberProcUpDao();
		return memberProcUpDao;	
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public int memberProcUp(MemberInfo memberInfo) {
	// ����ڰ� �Է��� �����͵�� ȸ�� ���������� �ϴ� �޼ҵ�

		Statement stmt = null;		
		int result = 0;
		
		try {
			String sql = "update t_member_info set " +
			" mi_phone = '" + memberInfo.getMi_phone() + "', " + 
			" mi_email = '" + memberInfo.getMi_email() + "' " + 
			" where mi_id = '" + memberInfo.getMi_id() + "' ";
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);			
			
		}catch(Exception e) {
			System.out.println("MemberProcUpDao Ŭ������ memberProcUp() �޼ҵ� ����");
			e.printStackTrace();
		}finally {
			close(stmt);
		}
		
		return result;
	}
}
