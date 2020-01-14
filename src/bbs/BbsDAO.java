package bbs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import util.JDBCUtil;

public class BbsDAO {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	public int write(Bbs bbs, String INPUT_ID) {
		String sql = "insert into board(club_id,board_no,board_cd,title,contents,input_id,input_date) "
				+ "values(?,(select nvl(max(board_no),0)+1 from board),?,?,?,?,TO_DATE(?,'yyyy-mm-dd hh24:mi:ss'))";
		if (bbs.getStart_date() != null || bbs.getEnd_date() != null) {
			sql = "insert into board(club_id,board_no,board_cd,title,contents,input_id,input_date,start_date,end_date)"
					+ "values(?,(select nvl(max(board_no),0)+1 from board),?,?,?,?,TO_DATE(?,'yyyy-mm-dd hh24:mi:ss'), "
					+ " TO_DATE(?,'yyyy-mm-dd'), TO_DATE(?,'yyyy-mm-dd'))";
		}
		java.util.Date dt = new java.util.Date();
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String today = sdf.format(dt);

		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bbs.getClub_id());
			pstmt.setString(2, bbs.getBoard_cd());
			pstmt.setString(3, bbs.getTITLE());
			pstmt.setString(4, bbs.getCONTENTS());
			pstmt.setString(5, INPUT_ID);
			pstmt.setString(6, today);
			if (bbs.getStart_date() != null || bbs.getEnd_date() != null) {
				pstmt.setString(7, bbs.getStart_date());
				pstmt.setString(8, bbs.getEnd_date());
			}

			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(pstmt, conn);
		}

		return -1;

	}

	public int getClubIds(String club_NM) {
		String SQL = "SELECT CLUB_ID FROM club where CLUB_NM='" + club_NM + "'";
		int answer = -1;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				answer = rs.getInt(1);
			}

			return answer;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return answer;// 디비 오류
	}

	public int getTotal(int club_id, String board_cd, String condition) {
		String sql = "SELECT COUNT(*) FROM BOARD "
				+ "WHERE BBSAVAILABLE = 1 AND TITLE LIKE ? AND CLUB_ID = ? AND BOARD_CD = ? ORDER BY BOARD_NO DESC";
		int total = 0;
		try{
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + condition + "%");
			pstmt.setInt(2, club_id);
			pstmt.setString(3, board_cd);
			rs = pstmt.executeQuery();
			if(rs.next()){
				total = rs.getInt(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return total;
	}

	public ArrayList<Bbs> getclub_search(int club_id, String board_cd, int pageNumber, String condition) {
		String sql = "SELECT * FROM (SELECT * FROM (SELECT ROWNUM RNUM, BOARD.* FROM BOARD "
				+ "WHERE BBSAVAILABLE = 1 AND TITLE LIKE ? AND CLUB_ID = ? AND BOARD_CD = ? ORDER BY BOARD_NO DESC)BOARD WHERE RNUM <= ?) "
				+ "WHERE RNUM > ?";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, "%" + condition + "%");
			pstmt.setInt(2, club_id);
			pstmt.setString(3, board_cd);
			pstmt.setInt(4, pageNumber * 10);
			pstmt.setInt(5, (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bbs bbs = new Bbs();
				int hit = rs.getInt("OPEN_CNT");
				bbs.setClub_id(rs.getInt("CLUB_ID"));
				bbs.setBOARD_NO(rs.getInt("BOARD_NO"));
				bbs.setBoard_cd(rs.getString("BOARD_CD"));
				bbs.setTITLE(rs.getString("TITLE"));
				bbs.setCONTENTS(rs.getString("CONTENTS"));
				bbs.setOPEN_CNT(hit);
				bbs.setINPUT_ID(rs.getString("INPUT_ID"));
				bbs.setINPUT_DATE(rs.getString("INPUT_DATE"));
				bbs.setBbsAvailable(rs.getInt("BBSAVAILABLE"));
				list.add(bbs);
				hit++;
			}
			if(!list.isEmpty()){
				list.get(0).setRow_count(getTotal(club_id, board_cd, condition));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return list;
	}

	public int cnt_update(int BOARD_NO) {

		String SQL = "UPDATE board set open_cnt = open_cnt+1 where board_no=? ";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, BOARD_NO);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(pstmt, conn);
		}
		return -1;
	}

	public Bbs getBbs(int BOARD_NO) {
		cnt_update(BOARD_NO);
		String SQL = "SELECT * FROM board WHERE BOARD_NO = ?";

		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, BOARD_NO);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				Bbs bbs = new Bbs();
				int hit = rs.getInt("OPEN_CNT");
				bbs.setClub_id(rs.getInt("CLUB_ID"));
				bbs.setBOARD_NO(rs.getInt("BOARD_NO"));
				bbs.setBoard_cd(rs.getString("BOARD_CD"));
				bbs.setTITLE(rs.getString("TITLE"));
				bbs.setCONTENTS(rs.getString("CONTENTS"));
				bbs.setOPEN_CNT(hit);
				bbs.setINPUT_ID(rs.getString("INPUT_ID"));
				bbs.setINPUT_DATE(rs.getString("INPUT_DATE"));
				bbs.setBbsAvailable(rs.getInt("BBSAVAILABLE"));
				bbs.setStart_date(rs.getString("START_DATE"));
				bbs.setEnd_date(rs.getString("END_DATE"));
				return bbs;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return null;
	}

	public int update(Bbs bbs) {
		String SQL = "UPDATE board SET TITLE = ?, CONTENTS = ? WHERE BOARD_NO = ?";
		if (bbs.getStart_date() != null || bbs.getEnd_date() != null) {
			SQL = "UPDATE board SET TITLE = ?, CONTENTS = ?, START_DATE = '" + bbs.getStart_date() + "', END_DATE = '"
					+ bbs.getEnd_date() + "' WHERE BOARD_NO = ?";
		}
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbs.getTITLE());
			pstmt.setString(2, bbs.getCONTENTS());
			pstmt.setInt(3, bbs.getBOARD_NO());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(pstmt, conn);
		}
		return -1;
	}

	public int delete(int BOARD_NO) {
		String SQL = "UPDATE board SET bbsAvailable = 0 WHERE BOARD_NO = ?";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, BOARD_NO);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(pstmt, conn);
		}
		return -1;
	}

	// 추가 , 메인화면 공지사항  가져오기
	public ArrayList<Bbs> get_intro(int club_id, String board_cd) {
		String SQL = "SELECT * FROM (SELECT TITLE, BOARD_NO, INPUT_DATE FROM BOARD WHERE CLUB_ID = 1 AND BOARD_CD = ? " +
				" AND BBSAVAILABLE = 1 ORDER BY BOARD_NO DESC)X WHERE ROWNUM <= 6";
		ArrayList<Bbs> list = null;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, board_cd);
			rs = pstmt.executeQuery();
			list = new ArrayList<Bbs>();
			while (rs.next()) {
				Bbs vo = new Bbs();
				vo.setTITLE(rs.getString("TITLE"));
				vo.setBOARD_NO(rs.getInt("BOARD_NO"));
				vo.setINPUT_DATE(rs.getString("INPUT_DATE").substring(0, 10));
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return list;
	}

	public String getCalendar(int club_id) {
		String jsonInfo = null;
		JSONArray personArray = new JSONArray();
		JSONObject personInfo = new JSONObject();

		String sql = "select title, start_date, end_date, board_no, club_id from board where club_id=? and start_date is not null "
				+ " and bbsAvailable = 1";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, club_id);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				personInfo = new JSONObject();
				personInfo.put("title", rs.getString(1));
				personInfo.put("start", rs.getString(2).substring(0, 10));
				personInfo.put("end", rs.getString(3).substring(0, 10) + " 04:00");
				personInfo.put("url",
						"myview.jsp?BOARD_NO=" + rs.getInt(4) + "&club_id=" + rs.getInt(5) + "&board_cd=007004");

				personArray.add(personInfo);
				// 2019-10-15 00:30:00.0
			}

			jsonInfo = personArray.toJSONString();
		} catch (Exception e) {

			e.printStackTrace();

		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return jsonInfo;
	}

	public ArrayList<String[]> get_CalendarTitle(int club_id) {

		String SQL = "SELECT TITLE,BOARD_NO FROM BOARD WHERE CLUB_ID =" + club_id
				+ " AND BOARD_CD='007004' AND BBSAVAILABLE=1";
		ArrayList<String[]> titleList = new ArrayList<String[]>();
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				String arr[] = new String[2];
				arr[0] = rs.getString(1);
				arr[1] = rs.getString(2);
				titleList.add(arr);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return titleList;
	}
}