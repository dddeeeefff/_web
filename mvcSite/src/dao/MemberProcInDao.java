package dao;

import static db.JdbcUtil.*;	// JdbcUtil Ŭ������ ��� ������� �����Ӱ� �����
import java.util.*;
import java.sql.*;
import vo.*;

public class MemberProcInDao {
	private static MemberProcInDao memberProcInDao;
	private Connection conn;
	private MemberProcInDao() {}
	
	public static MemberProcInDao getInstance() {
		if (memberProcInDao == null)	memberProcInDao = new MemberProcInDao();
		
		return memberProcInDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int memberProcIn(MemberInfo memberInfo, MemberAddr memberAddr) {
	// ����ڰ� �Է��� �����͵�� ȸ�������� ��Ű�� �޼ҵ�
		PreparedStatement pstmt = null;		
		int result = 0;
		
		try {
			String sql = "insert into t_member_info (mi_id, mi_pw, " +
			"mi_name, mi_gender, mi_birth, mi_phone, mi_email, " + 
			"mi_point) values(?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberInfo.getMi_id());
			pstmt.setString(2, memberInfo.getMi_pw());
			pstmt.setString(3, memberInfo.getMi_name());
			pstmt.setString(4, memberInfo.getMi_gender());
			pstmt.setString(5, memberInfo.getMi_birth());
			pstmt.setString(6, memberInfo.getMi_phone());
			pstmt.setString(7, memberInfo.getMi_email());
			pstmt.setInt(8, memberInfo.getMi_point());
			result = pstmt.executeUpdate();
			
			
			if (result == 1) {	
			// t_member_into ���̺� insert ������ ���������� ����������
				sql = "insert into t_member_addr(mi_id, ma_name, ma_phone, " +
					  "ma_zip, ma_addr1, ma_addr2) values (?, ?, ?, ?, ?, ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, memberInfo.getMi_id());
				pstmt.setString(2, memberAddr.getMa_name());
				pstmt.setString(3, memberInfo.getMi_phone());
				pstmt.setString(4, memberAddr.getMa_zip());
				pstmt.setString(5, memberAddr.getMa_addr1());
				pstmt.setString(6, memberAddr.getMa_addr2());
				result += pstmt.executeUpdate();
				
				
				if (result == 2) {
				// t_member_addr ���̺� insert ������ ���������� ����������(����Ʈ)
					sql = "insert into t_member_point(mi_id, mp_point, " +
						  "mp_desc) values (?, ?, '�������ϱ�')";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, memberInfo.getMi_id());
					pstmt.setInt(2, memberInfo.getMi_point());
					result += pstmt.executeUpdate();
				}
			}
			
		}catch(Exception e) {
			System.out.println("MemberProcInDao Ŭ������ memberProcIn() �޼ҵ� ����");
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;		
	}
}
