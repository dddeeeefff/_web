package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class FreeReplyProcDao {
// 자유게시판 댓글 관련 쿼리 작업(목록, 등록, 삭제, 좋아요/싫어요)들을 모두 처리하는 클래스
	private static FreeReplyProcDao freeReplyProcDao;
	private Connection conn;
	private FreeReplyProcDao() {}
	
	public static FreeReplyProcDao getInstance() {
		if (freeReplyProcDao == null)	freeReplyProcDao = new FreeReplyProcDao();
		
		return freeReplyProcDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public ArrayList<BbsFreeReply> getReplyList(int bfidx) {
	// 지정한 게시글에 속한 댓글들의 목록을 ArrayList<BbsFreeReply>로 리턴하는 메소드
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<BbsFreeReply> replyList = new ArrayList<BbsFreeReply>();
		// 댓글 목록을 저장할 객체
		BbsFreeReply bfr = null;
		// replyList에 저장할 하나의 댓글 정보를 담을 인스턴스
		
		try {
			String sql = "select * from t_bbs_free_reply where bfr_isdel = 'n' and bf_idx = " + bfidx;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				bfr = new BbsFreeReply();
				// 하나으ㅟ 댓글 정보들을 저장할 BbsFreeReply형 인스턴스 생성
				bfr.setBfr_idx(rs.getInt("bfr_idx"));
				bfr.setBf_idx(bfidx);
				bfr.setBfr_ismem(rs.getString("bfr_ismem"));
				bfr.setBfr_writer(rs.getString("bfr_writer"));
				bfr.setBfr_content(rs.getString("bfr_content"));
				bfr.setBfr_good(rs.getInt("bfr_good"));
				bfr.setBfr_bad(rs.getInt("bfr_bad"));
				bfr.setBfr_ip(rs.getString("bfr_ip"));
				bfr.setBfr_date(rs.getString("bfr_date"));
				replyList.add(bfr);
			}
			
		} catch(Exception e) {
			System.out.println("FreeReplyProcDao 클래스의 getReplyList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return replyList;
	}
	
	public int replyInsert(BbsFreeReply bfr) {
	// 사용자가 입력한 댓글을 테이블에 저장하는 메소드
		Statement stmt = null;
		int result = 0;
		
		try {
			String sql = "insert into t_bbs_free_reply (bf_idx, bfr_ismem, bfr_writer, bfr_pw, bfr_content, bfr_ip) " + 
					" values ('" + bfr.getBf_idx() + "', '" + bfr.getBfr_ismem() + "', '" + bfr.getBfr_writer() + "', '" + 
					bfr.getBfr_pw() + "', '" + bfr.getBfr_content() + "', '" + bfr.getBfr_ip() + "')";
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
			sql = "update t_bbs_free set bf_reply = bf_reply + 1 where bf_idx = " + bfr.getBf_idx();
			stmt.executeUpdate(sql);

		} catch(Exception e) {
			System.out.println("FreeReplyProcDao 클래스의 replyInsert() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
	}
	
	public int replyDelete(BbsFreeReply bfr) {
	// 지정한 댓글을 삭제하는 메소드
		Statement stmt = null;
		int result = 0;
		
		try {
			String sql = "update t_bbs_free_reply set bfr_isdel = 'y' where bfr_ismem = '" + bfr.getBfr_ismem() + 
					"' and bfr_idx = " + bfr.getBfr_idx();
			if (bfr.getBfr_ismem().equals("y")) {	// 회원 댓글이면
				sql += " and bfr_writer = '" + bfr.getBfr_writer() + "' ";
			} else {	// 비회원 댓글이면
				sql += " and bfr_pw = '" + bfr.getBfr_pw() + "' ";
			}
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
			sql = "update t_bbs_free set bf_reply = bf_reply - 1 where bf_reply > 0 and bf_idx = " + bfr.getBf_idx();
			stmt.executeUpdate(sql);

		} catch(Exception e) {
			System.out.println("FreeReplyProcDao 클래스의 replyDelete() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
	}
	
	public int replyGnb(BbsFreeReplyGnb bfrg) {
	// 지정한 댓글에 좋아요/싫어요를 처리하는 메소드
	// 이미 했던 댓글이면 -1을, 정상 처리 됐으면 2를, 처리가 안됐으면 0이나 1을 리턴
		Statement stmt = null;
		ResultSet rs = null;
		int result = 0;
		
		try {
			stmt = conn.createStatement();
			String sql = "select frg_gnb from t_bbs_free_reply_gnb where mi_id = '" + bfrg.getMi_id() + 
					"' and bfr_idx = " + bfrg.getBfr_idx();
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			if (rs.next()) {	// 데이터가 있으면(이미 좋아요/싫어요를 했으면)
				result = -1;
			} else {
				sql = "update t_bbs_free_reply set ";
				if (bfrg.getFrg_gnb().equals("g"))
					sql += " bfr_good = bfr_good + 1 ";
				else 
					sql += " bfr_bad = bfr_bad + 1 ";
				sql += " where bfr_idx = " + bfrg.getBfr_idx();
				System.out.println(sql);
				result = stmt.executeUpdate(sql);
				// 댓글의 좋아요/싫어요 값 추가 쿼리 실행
				
				sql = "insert into t_bbs_free_reply_gnb (mi_id, bfr_idx, frg_gnb, frg_ip) " + 
					"values ('" + bfrg.getMi_id() + "', '" + bfrg.getBfr_idx() + "', '" + bfrg.getFrg_gnb() + "', '"+ bfrg.getFrg_ip() + "')";
				System.out.println(sql);
				result += stmt.executeUpdate(sql);
				// 좋아요/싫어요 실행 추가 쿼리
			}

		} catch(Exception e) {
			System.out.println("FreeReplyProcDao 클래스의 replyGnb() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return result;
	}
}
