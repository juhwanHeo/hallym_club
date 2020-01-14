package club_Agree;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import util.JDBCUtil;

public class clubAgreeDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	public int agree_save(int club_id, int board_no, String student_id) {
		java.util.Date dt = new java.util.Date();
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");

		String currentTime = sdf.format(dt);

		String SQL = "INSERT INTO club_agree_member(CLUB_ID,BOARD_NO,STUDENT_ID,INPUT_DATE) VALUES(?,?,?,TO_DATE(?,'yyyy-mm-dd'))";

		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, club_id);
			pstmt.setInt(2, board_no);
			pstmt.setString(3, student_id);
			pstmt.setString(4, currentTime);
			pstmt.executeUpdate();
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(pstmt, conn);
		}
		return -1; // 데이터베이스 오류
	}

	public int disagree_save(int club_id, int board_no, String student_id) {

		String SQL = "Delete from club_agree_member where CLUB_ID= ? AND BOARD_NO= ? AND STUDENT_ID= ? ";

		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, club_id);
			pstmt.setInt(2, board_no);
			pstmt.setString(3, student_id);
			pstmt.executeUpdate();
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(pstmt, conn);
		}
		return -1;
	}

	public int check_agree(int club_id, int board_no, String student_id) {
		String SQL = "select * from club_agree_member where CLUB_ID= ? AND BOARD_NO=? AND STUDENT_ID= ? ";

		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, club_id);
			pstmt.setInt(2, board_no);
			pstmt.setString(3, student_id);
			rs = pstmt.executeQuery();
			if (rs.next())
				return 1;
			else
				return 0;

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}

		return -1;
	}

	public ArrayList<String> getAgreeMember(int club_id,int board_no) {
		String SQL = "select STUDENT_ID from club_agree_member where CLUB_ID= ? AND board_no= ? ";
		ArrayList<String> AgreeList = new ArrayList<String>();
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, club_id);
			pstmt.setInt(2, board_no);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				AgreeList.add(rs.getString(1));
			}

			return AgreeList;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}

		return null;
		
	}
/*
	public ArrayList<String[]> getAgreeMember_info(ArrayList<String> AgreeList) {
		for (int i = 0; i < AgreeList.size(); i++) {
			String SQL = "select STUDENT_ID from club_agree_member where CLUB_ID=" + club_id;
		}

		String SQL = "select STUDENT_ID from club_agree_member where CLUB_ID=" + club_id;
		return null;
	}
*/
}
