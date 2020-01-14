package item;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.JDBCUtil;

public class itemDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	public String getClubNMs(int club_id) {
		String sql = "SELECT CLUB_NM FROM club where club_id=?";
		String answer = "";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, club_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				answer = rs.getString(1);
			}
			return answer;
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.closeResource(rs,pstmt, conn);
		}
		return null;
	}

	public int modItme(int club_Id, ArrayList<itemVo> list) {
		String sql = "Delete from item where CLUB_ID=?";
		int answer = -1;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, club_Id);
			pstmt.executeUpdate();
			pstmt.close();
			int totalElements = list.size();// arrayList의 요소의 갯수를 구한다.
			sql = "INSERT INTO item(CLUB_ID,SEQ_NO,ITEM_NM,ITEM_CONT,TOT_CNT) VALUES(?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			for (int index = 0; index < totalElements; index++) {
				pstmt.setInt(1, club_Id);
				pstmt.setInt(2, index);
				pstmt.setString(3, list.get(index).getITEM_NM());
				pstmt.setString(4, list.get(index).getITEM_CONT());
				pstmt.setInt(5, list.get(index).getTOT_CNT());
				pstmt.executeUpdate();
				pstmt.clearParameters();
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(pstmt, conn);
		}
		return answer;
	}

	public int resetItme(int club_Id) {
		String sql = "Delete from item where CLUB_ID=?";
		int answer = -1;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, club_Id);
			pstmt.executeUpdate();
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(pstmt, conn);
		}
		return answer;
	}

}