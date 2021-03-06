package club;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import club.ClubVO;
import user.UserDAO;
import user.UserNotExistException;
import user.UserVO;
import util.JDBCUtil;

public class ClubDAO {

	private Connection conn;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	public String getSavePosterName(int club_id) {

		
		String sql = "SELECT poster_save_file_nm FROM club WHERE club_id=?";
		String savePosterName = null;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, club_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				savePosterName = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return savePosterName;
	}
	public String getSaveIntroName(int club_id) {
		
		String sql = "SELECT intro_save_file_nm FROM club WHERE club_id=?";
		String saveIntroName = null;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, club_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				saveIntroName = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return saveIntroName;
	}
	
	public int setPosterName(int club_id, ClubVO vo) {
		String sql = "UPDATE club SET poster_file_nm=?, poster_save_file_nm=? WHERE club_id=?";
		System.out.println("[setPosterName] vo.vo.getPoster_file_nm(): " + vo.getPoster_file_nm());
		System.out.println("[setPosterName] vo.vo.getPoster_save_file_nm(): " + vo.getPoster_save_file_nm());
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getPoster_file_nm());
			pstmt.setString(2, vo.getPoster_save_file_nm());
			pstmt.setInt(3, club_id);			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return -1;
	}
	
	public int setIntroName(int club_id, ClubVO vo) {
		String sql = "UPDATE club SET intro_file_nm = ?, intro_save_file_nm= ? WHERE club_id=?";
		System.out.println("[setIntroName] vo.getIntro_file_nm()"+vo.getIntro_file_nm());
		System.out.println("[setIntroName] vo.getIntro_save_file_nm()"+vo.getIntro_save_file_nm());
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getIntro_file_nm());
			pstmt.setString(2, vo.getIntro_save_file_nm());
			pstmt.setInt(3, club_id);			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return -1;
	}
	
	
	public int setPosterNameNull(int club_id) {
		String sql = "UPDATE club SET poster_file_nm=null, poster_save_file_nm=null WHERE club_id=?";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, club_id);			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return -1;
	}
	
	public int setIntroNameNull(int club_id) {
		String sql = "UPDATE club SET intro_file_nm=null, intro_save_file_nm=null WHERE club_id=?";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, club_id);			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return -1;
	}
	
	

	public int getTotal(String gb_cd, String search, String at_cd) {
		String sql = "SELECT COUNT(*) FROM CLUB WHERE CLUB_ID <> 1 AND CLUB_GB_CD LIKE ? AND CLUB_NM LIKE ? AND CLUB_AT_CD LIKE ? AND REGISTER_CD='008001'";
		int total = 0;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + gb_cd + "%");
			pstmt.setString(2, "%" + search + "%");
			pstmt.setString(3, "%" + at_cd + "%");
			rs = pstmt.executeQuery();
			if (rs.next()) {
				total = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return total;
	}

	public ArrayList<ClubVO> getClublist(String gb_cd, String search, String at_cd, int pageNumber) {

		ArrayList<ClubVO> list = new ArrayList<ClubVO>();
		String sql = "";

		try {

			// SQL = "SELECT SQL_CALC_FOUND_ROWS * FROM"
			// + "( SELECT A.*, IF(B.STAFF_CD = '004001',B.NM, ''), IF(B.STAFF_CD =
			// '004001',B.PHONE_NO, '') "
			// + "FROM CLUB AS A LEFT JOIN CLUB_MEMBER AS B " + "ON A.CLUB_ID = B.CLUB_ID "
			// + "WHERE A.CLUB_GB_CD LIKE ? AND A.CLUB_NM LIKE ? AND A.CLUB_AT_CD LIKE ? "
			// + "ORDER BY B.STAFF_CD IS NULL ASC, STAFF_CD ASC)X GROUP BY CLUB_ID LIMIT " +
			// (pageNumber - 1) * 4
			// + "," + 4;

			sql = "SELECT * FROM (SELECT ROW_NUMBER() OVER(ORDER BY CLUB_NM) AS RK, A.*, NVL(B.NM, ' ') AS STAFF_NM, NVL(B.PHONE_NO, ' ') AS STAFF_NO "
					+ "FROM CLUB A LEFT OUTER JOIN(SELECT CLUB_ID, NM , PHONE_NO FROM CLUB_MEMBER WHERE STAFF_CD = '004001')B"
					+ " ON A.CLUB_ID = B.CLUB_ID 	WHERE A.CLUB_ID <> 1 AND A.CLUB_GB_CD LIKE ? AND A.CLUB_NM LIKE ? AND A.CLUB_AT_CD LIKE ? AND A.REGISTER_CD='008001' "
					+ "ORDER BY A.CLUB_NM) WHERE RK > ? AND RK <= ?";

			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + gb_cd + "%");
			pstmt.setString(2, "%" + search + "%");
			pstmt.setString(3, "%" + at_cd + "%");
			pstmt.setInt(4, (pageNumber - 1) * 4);
			pstmt.setInt(5, pageNumber * 4);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				ClubVO vo = new ClubVO();
				vo.setClub_id(rs.getInt("CLUB_ID"));
				vo.setClub_nm(rs.getString("CLUB_NM"));
				vo.setClub_gb_cd(rs.getString("CLUB_GB_CD"));
				vo.setClub_at_cd(rs.getString("CLUB_AT_CD"));
				vo.setCnt(rs.getInt("CLUB_CNT"));
				vo.setClub_aim(rs.getString("CLUB_AIM"));
				vo.setClub_active(rs.getString("CLUB_ACTIVE"));
				vo.setClub_room(rs.getString("CLUB_ROOM"));
				vo.setOpen_dt(rs.getString("OPEN_DT"));
				vo.setIntro_file_nm(rs.getString("INTRO_FILE_NM"));
				vo.setIntro_save_file_nm(rs.getString("INTRO_SAVE_FILE_NM"));
				vo.setPoster_file_nm(rs.getString("POSTER_FILE_NM"));
				vo.setPoster_save_file_nm(rs.getString("POSTER_SAVE_FILE_NM"));
				vo.setInput_id(rs.getString("INPUT_ID"));
				vo.setInput_ip(rs.getString("INPUT_IP"));
				vo.setInput_date(rs.getString("INPUT_DATE"));
				vo.setStaff_nm(rs.getString("STAFF_NM"));
				vo.setStaff_phone(rs.getString("STAFF_NO"));
				list.add(vo);
			}
			list.get(0).setRow_count(getTotal(gb_cd, search, at_cd));

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return list;
	}

	// 우수 동아리 선정
	/*
	 * @TODO
	 *  현재 우수동아리 선정기준에 오류가 있다.
	 *   - CODA 클럽이 2개 나오는 오류
	 * Top 클럽을 판단하는 컬럼을 추가
	 * 
	 * 관리자가 Top 클럽을 정한다.
	 *   - 관리자 페이지에 Top 클럽을 정할수 있도록 해주는 페이지 필요
	 */
	
	public String getTopClub_YN(int club_id) {
		String sql = "SELECT topclub_yn FROM club WHERE club_id=?";
		String topClub_yn = null;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, club_id);	
			rs = pstmt.executeQuery();
			while(rs.next())
				topClub_yn = rs.getString(1);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return topClub_yn;
	}
	public int getTopClubRank(int club_id) {
		String sql = "SELECT topclub_rank FROM club WHERE club_id=?";
		int rank= -1;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, club_id);			
			rs = pstmt.executeQuery();
			while(rs.next())
				rank = rs.getInt(1);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return rank;
		
	}
	
	public int setTopClubRank(int club_id, int rank) {
		String sql = "UPDATE club SET topclub_rank=? WHERE club_id=?";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rank);
			pstmt.setInt(2, club_id);			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return -1;
		
	}
	public int setTopClub(int club_id, String topClub_YN) {
		String sql = "UPDATE club SET topclub_yn=? WHERE club_id=?";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, topClub_YN);
			pstmt.setInt(2, club_id);			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return -1;
	}
	public ArrayList<ClubVO> getTopClub2(String gb_cd, String at_cd) {
		ArrayList<ClubVO> list = new ArrayList<ClubVO>();
		String sql  = "";
		if (at_cd.equals("002001")) {
			sql = "SELECT * FROM club WHERE club_gb_cd=? AND club_at_cd ='002001' AND topclub_yn='Y' ORDER BY topclub_rank ASC";
		} else {
			sql = "SELECT * FROM club WHERE club_gb_cd=? AND club_at_cd !='002001' AND topclub_yn='Y' ORDER BY topclub_rank ASC";
		}
		
		try {
			
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, gb_cd);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ClubVO vo = new ClubVO();
				vo.setClub_id(rs.getInt("CLUB_ID"));
				vo.setClub_nm(rs.getString("CLUB_NM"));
				vo.setClub_gb_cd(rs.getString("CLUB_GB_CD"));
				vo.setClub_at_cd(rs.getString("CLUB_AT_CD"));
				vo.setCnt(rs.getInt("CLUB_CNT"));
				vo.setClub_aim(rs.getString("CLUB_AIM"));
				vo.setClub_active(rs.getString("CLUB_ACTIVE"));
				vo.setClub_room(rs.getString("CLUB_ROOM"));
				vo.setOpen_dt(rs.getString("OPEN_DT"));
				vo.setIntro_file_nm(rs.getString("INTRO_FILE_NM"));
				vo.setIntro_save_file_nm(rs.getString("INTRO_SAVE_FILE_NM"));
				vo.setPoster_file_nm(rs.getString("POSTER_FILE_NM"));
				vo.setPoster_save_file_nm(rs.getString("POSTER_SAVE_FILE_NM"));
				vo.setInput_id(rs.getString("INPUT_ID"));
				vo.setInput_ip(rs.getString("INPUT_IP"));
				vo.setInput_date(rs.getString("INPUT_DATE"));
//				vo.setStaff_nm(rs.getString("NM"));
//				vo.setStaff_phone(rs.getString("PHONE_NO"));
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}		
		
		return list;
	}
	public ArrayList<ClubVO> getTopClub(String gb_cd, String at_cd) {

		ArrayList<ClubVO> list = new ArrayList<ClubVO>();
		String sql = "";

		int limit_cnt = 3;

		try {
			if (at_cd.equals(""))
				limit_cnt = 5;

			// SQL = "SELECT * FROM (SELECT A.*, IF(B.STAFF_CD = '004001',B.NM, ''),
			// IF(B.STAFF_CD = '004001',B.PHONE_NO, '') FROM CLUB AS A "
			// + "LEFT JOIN CLUB_MEMBER AS B " + "ON A.CLUB_ID = B.CLUB_ID "
			// + "WHERE A.CLUB_GB_CD LIKE ? AND A.CLUB_AT_CD LIKE ?"
			// + "ORDER BY B.STAFF_CD IS NULL ASC, STAFF_CD ASC)X "
			// + "GROUP BY CLUB_ID ORDER BY CLUB_CNT DESC LIMIT " + limit_cnt;
			sql = "SELECT ROWNUM, T.* FROM(SELECT C.*, NVL(D.NM,' ') AS NM, NVL(D.PHONE_NO,' ') AS PHONE_NO, NVL(D.STAR,0)"
					+ " AS CNT_STAR FROM CLUB C LEFT OUTER JOIN(SELECT A.CLUB_ID, A.NM, A.PHONE_NO, B.STAR FROM CLUB_MEMBER A "
					+ "LEFT OUTER JOIN (SELECT CLUB_ID, NVL(COUNT(*),0) AS STAR FROM CLUB_MEMBER WHERE STAR = 'Y' GROUP BY CLUB_ID)B"
					+ " ON A.CLUB_ID = B.CLUB_ID WHERE A.STAFF_CD = '004001')D ON C.CLUB_ID = D.CLUB_ID "
					+ " WHERE C.CLUB_ID <> 1 AND C.CLUB_GB_CD LIKE ? AND C.CLUB_AT_CD LIKE ? "
					+ " ORDER BY D.STAR DESC NULLS LAST)T WHERE ROWNUM  <= ? ";

			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + gb_cd + "%");
			pstmt.setString(2, "%" + at_cd + "%");
			pstmt.setInt(3, limit_cnt);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ClubVO vo = new ClubVO();
				vo.setClub_id(rs.getInt("CLUB_ID"));
				vo.setClub_nm(rs.getString("CLUB_NM"));
				vo.setClub_gb_cd(rs.getString("CLUB_GB_CD"));
				vo.setClub_at_cd(rs.getString("CLUB_AT_CD"));
				vo.setCnt(rs.getInt("CLUB_CNT"));
				vo.setClub_aim(rs.getString("CLUB_AIM"));
				vo.setClub_active(rs.getString("CLUB_ACTIVE"));
				vo.setClub_room(rs.getString("CLUB_ROOM"));
				vo.setOpen_dt(rs.getString("OPEN_DT"));
				vo.setIntro_file_nm(rs.getString("INTRO_FILE_NM"));
				vo.setIntro_save_file_nm(rs.getString("INTRO_SAVE_FILE_NM"));
				vo.setPoster_file_nm(rs.getString("POSTER_FILE_NM"));
				vo.setPoster_save_file_nm(rs.getString("POSTER_SAVE_FILE_NM"));
				vo.setInput_id(rs.getString("INPUT_ID"));
				vo.setInput_ip(rs.getString("INPUT_IP"));
				vo.setInput_date(rs.getString("INPUT_DATE"));
				vo.setStaff_nm(rs.getString("NM"));
				vo.setStaff_phone(rs.getString("PHONE_NO"));
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return list;
	}

	public String getProfessor(int club_id) {
		String SQL = "";
		String prof_name = "";
		try {
			SQL = "SELECT * FROM CLUB_PROF WHERE CLUB_ID = ? AND PROG_GB_CD = '006001'";
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, club_id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				prof_name = rs.getString(3);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return prof_name;
	}

	public String getIntro_FilePath(int club_id) {
		String SQL = "select POSTER_SAVE_FILE_NM from club where CLUB_ID=? ";
		String Intro_FilePath = "";

		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, club_id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Intro_FilePath = rs.getString(1);
				return Intro_FilePath;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return null;
	}

	public ArrayList<String[]> getItems(int club_id) {
		String sql = "SELECT ITEM_NM,ITEM_CONT,TOT_CNT from item where CLUB_ID=" + club_id + " ORDER BY ITEM_NM";
		ArrayList<String[]> allClubItem = new ArrayList<String[]>();

		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String clubItem[] = new String[3];
				clubItem[0] = rs.getString(1);
				clubItem[1] = rs.getString(2);
				clubItem[2] = rs.getInt(3) + "";
				System.out.println("[ClubDAO] getItems: " + rs.getInt(3));
				System.out.println("[ClubDAO] getItems: " + clubItem[2]);
				allClubItem.add(clubItem);
			}
			return allClubItem;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return null;
	}

	// intro, 동아리 조회
	public ArrayList<ClubVO> getClubIntro(String user_id) {
		ArrayList<ClubVO> clubList = null;
		String sql = "";
		try {
			if (user_id == "") {
				sql = "SELECT * FROM (SELECT C.CLUB_ID, C.CLUB_NM, C.INTRO_SAVE_FILE_NM, C.CLUB_AIM, C.CLUB_ACTIVE, S.SO_NM AS GB_CD, D.SO_NM AS AT_CD, C.CLUB_CNT "
						+ "FROM CLUB C, SO_CD S, SO_CD D WHERE C.CLUB_GB_CD = S.SO_CD AND C.CLUB_AT_CD = D.SO_CD AND C.REGISTER_CD='008001'"
						+ " ORDER BY C.CLUB_CNT DESC) WHERE ROWNUM <= 6";
				conn = JDBCUtil.getConnection();
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				clubList = new ArrayList<ClubVO>();

				while (rs.next()) {
					ClubVO vo = new ClubVO();
					vo.setClub_id(rs.getInt("CLUB_ID"));
					vo.setClub_nm(rs.getString("CLUB_NM"));
					vo.setIntro_save_file_nm(rs.getString("INTRO_SAVE_FILE_NM"));
					vo.setClub_aim(rs.getString("CLUB_AIM"));
					vo.setClub_active(rs.getString("CLUB_ACTIVE"));
					vo.setClub_gb_cd(rs.getString("GB_CD"));
					vo.setClub_at_cd(rs.getString("AT_CD"));
					clubList.add(vo);
				}

			} else {
				sql = "SELECT S.SO_NM AS GB_CD, D.SO_NM AS AT_CD, T.* FROM SO_CD S, SO_CD D, (SELECT C.CLUB_ID, C.CLUB_NM, C.INTRO_SAVE_FILE_NM, C.CLUB_AIM, C.CLUB_ACTIVE, C.CLUB_GB_CD, C.CLUB_AT_CD, ZZ.STAFF "
						+ " FROM CLUB C RIGHT OUTER JOIN (SELECT M.CLUB_ID, M.STAFF_CD, S.SO_NM AS STAFF FROM CLUB_MEMBER M, SO_CD S "
						+ " WHERE M.STAFF_CD = S.SO_CD AND M.STUDENT_ID =? AND M.JOIN_CD = '008001' ORDER BY M.STAFF_CD)ZZ "
						+ " ON C.CLUB_ID = ZZ.CLUB_ID AND C.REGISTER_CD='008001')T WHERE S.SO_CD = T.CLUB_GB_CD AND D.SO_CD = T.CLUB_AT_CD";
				conn = JDBCUtil.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, user_id);
				rs = pstmt.executeQuery();
				clubList = new ArrayList<ClubVO>();
				while (rs.next()) {
					ClubVO vo = new ClubVO();
					vo.setClub_id(rs.getInt("CLUB_ID"));
					vo.setClub_nm(rs.getString("CLUB_NM"));
					vo.setIntro_save_file_nm(rs.getString("INTRO_SAVE_FILE_NM"));
					vo.setStaff_cd(rs.getString("STAFF"));
					vo.setClub_gb_cd(rs.getString("GB_CD"));
					vo.setClub_at_cd(rs.getString("AT_CD"));
					clubList.add(vo);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return clubList;
	}

	// 동아리 개설일 가져오기
	public String getOpen_Dt(int club_id) {
		String sql = "SELECT OPEN_DT from club where CLUB_ID=?";
		String open_dt = "";

		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, club_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				open_dt = rs.getString(1);
			}
			return open_dt;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return null;
	}

	public String getMaster(int club_id) {
		String sql = "SELECT NM FROM CLUB_MEMBER WHERE CLUB_ID = ? AND STAFF_CD = '004001'";
		String name = "";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, club_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				name = rs.getString(1);
			}
			return name;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return null;
	}

	public String getClubNMs(int club_id) {
		String SQL = "SELECT CLUB_NM FROM club where club_id=" + club_id;
		String answer = "";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				answer = rs.getString(1);
			}
			return answer;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return null;
	}

	public String getClubName(String clubName) {

		String club_name = null;
		String SQL = "SELECT CLUB_NM FROM club where club_nm=?";

		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, clubName);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				club_name = rs.getString(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return club_name;
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

	public ArrayList<String> getMyJoinClubList(String user_id) {
		ArrayList<String> allMyClub = new ArrayList<String>();
		// String sql = "SELECT CLUB_ID from club_member where STUDENT_ID = " + user_id
		// + " and JOIN_CD = 008001;";
		String sql = "SELECT C.CLUB_NM FROM CLUB C, CLUB_MEMBER M WHERE C.CLUB_ID = M.CLUB_ID "
				+ " AND M.STUDENT_ID =? AND JOIN_CD = '008001' AND c.register_cd = '008001'";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				allMyClub.add(rs.getString(1));
			}
			return allMyClub;

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return null;
	}

//	public ArrayList<String> getMyWaitClubList(String user_id) {
//		ArrayList<String> allMyClub = new ArrayList<String>();
//		// String sql = "SELECT CLUB_ID from club_member where STUDENT_ID = " + user_id
//		// + " and JOIN_CD = 008003;";
//		String sql = "SELECT C.CLUB_NM FROM CLUB C, CLUB_MEMBER M WHERE C.CLUB_ID = M.CLUB_ID AND STUDENT_ID = ? AND JOIN_CD = '008003'";
//		try {
//			conn = JDBCUtil.getConnection();
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, user_id);
//			rs = pstmt.executeQuery();
//			while (rs.next()) {
//				allMyClub.add(rs.getString(1));
//			}
//			return allMyClub;
//
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally {
//			JDBCUtil.closeResource(rs, pstmt, conn);
//		}
//		return null;
//	}
	
	public ArrayList<ClubVO> getMyWaitClubList(String user_id) {
		ArrayList<ClubVO> allMyClub = new ArrayList<ClubVO>();
		// String sql = "SELECT CLUB_ID from club_member where STUDENT_ID = " + user_id
		// + " and JOIN_CD = 008003;";
		String sql = "SELECT C.CLUB_NM, C.CLUB_ID FROM CLUB C, CLUB_MEMBER M WHERE C.CLUB_ID = M.CLUB_ID AND STUDENT_ID = ? AND JOIN_CD = '008003'";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ClubVO clubVO = new ClubVO();
				clubVO.setClub_nm(rs.getString(1));
				clubVO.setClub_id(rs.getInt(2));
				allMyClub.add(clubVO);
			}
			return allMyClub;

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return null;
	}
	
//	public ArrayList<String> getMyWaitRegisteredClubList(String user_id) {
//		ArrayList<String> allMyClub = new ArrayList<String>();
//		String sql = "SELECT C.CLUB_NM FROM CLUB C, CLUB_MEMBER M WHERE C.CLUB_ID = M.CLUB_ID AND m.staff_cd = '004001' AND STUDENT_ID = ? AND register_cd = '008003'";
//		try {
//			conn = JDBCUtil.getConnection();
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, user_id);
//			rs = pstmt.executeQuery();
//			while (rs.next()) {
//				allMyClub.add(rs.getString(1));
//			}
//			return allMyClub;
//
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally {
//			JDBCUtil.closeResource(rs, pstmt, conn);
//		}
//		return null;
//	}
	
	public ArrayList<ClubVO> getMyWaitRegisteredClubList(String user_id) {
		ArrayList<ClubVO> allMyClub = new ArrayList<ClubVO>();
		String sql = "SELECT C.* FROM CLUB C, CLUB_MEMBER M WHERE C.CLUB_ID = M.CLUB_ID AND m.staff_cd = '004001' AND STUDENT_ID = ? AND register_cd = '008003'";
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ClubVO clubVO = new ClubVO();
				clubVO.setClub_id(rs.getInt("CLUB_ID"));
				clubVO.setClub_nm(rs.getString("CLUB_NM"));
				clubVO.setClub_gb_cd(rs.getString("CLUB_GB_CD"));
				clubVO.setClub_at_cd(rs.getString("CLUB_AT_CD"));
				clubVO.setClub_aim(rs.getString("CLUB_AIM"));
				clubVO.setClub_active(rs.getString("CLUB_ACTIVE"));
				clubVO.setClub_room(rs.getString("CLUB_ROOM"));
				clubVO.setOpen_dt(rs.getString("OPEN_DT"));
				
				allMyClub.add(clubVO);
			}
			return allMyClub;

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return null;
	}

	// public int getJoin_cd(String username, String clubNM) {
	// String sql = "SELECT STAFF_CD FROM club_member where STUDENT_ID=" + username
	// + " AND CLUB_ID=( SELECT CLUB_ID from club where CLUB_NM ='" + clubNM + "')";
	//
	// try {
	// conn = JDBCUtil.getConnection();
	// pstmt = conn.prepareStatement(sql);
	// rs = pstmt.executeQuery();
	// if (rs.next()) {
	// if (rs.getString(1) != null) {
	// if (rs.getString(1).equals("004001") || rs.getString(1).equals("004002"))
	// return 0;
	// }
	// }
	// return 1;
	// } catch (Exception e) {
	// e.printStackTrace();
	// } finally {
	// JDBCUtil.closeResource(rs, pstmt, conn);
	// }
	// return -1;
	// }

	public ArrayList<ClubVO> getClubInfo(int club_id) {
		ArrayList<ClubVO> clubList = null;
		String sql = "";
		try {
			sql = "SELECT CLUB_ID, CLUB_NM, CLUB_GB_CD, CLUB_AT_CD, CLUB_CNT, CLUB_AIM, CLUB_ACTIVE, CLUB_ROOM, OPEN_DT "
					+ "FROM CLUB WHERE CLUB_ID = " + club_id;

			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			clubList = new ArrayList<ClubVO>();
			while (rs.next()) {
				ClubVO vo = new ClubVO();
				vo.setClub_id(rs.getInt(1));
				vo.setClub_nm(rs.getString(2));
				vo.setClub_gb_cd(rs.getString(3));
				vo.setClub_at_cd(rs.getString(4));
				vo.setCnt(rs.getInt(5));
				vo.setClub_aim(rs.getString(6));
				vo.setClub_active(rs.getString(7));
				vo.setClub_room(rs.getString(8));
				vo.setOpen_dt(rs.getString(9));
				clubList.add(vo);
			}
		} catch (Exception e) {
			System.out.println("database fail");
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return clubList;
	}

	public int createClub(ClubVO CV, String user_id) {
		String sql = "INSERT INTO CLUB(CLUB_ID, CLUB_NM, CLUB_GB_CD, CLUB_AT_CD, CLUB_CNT, CLUB_AIM, CLUB_ACTIVE, CLUB_ROOM,"
				+ " OPEN_DT, INTRO_FILE_NM, INTRO_SAVE_FILE_NM, POSTER_FILE_NM, POSTER_SAVE_FILE_NM, REGISTER_CD)"
				+ " VALUES ((SELECT NVL(MAX(CLUB_ID),0)+1 FROM CLUB),?,?,?,?,?,?,?,?,?,?,?,?,?)";

		String sql2 = "INSERT INTO CLUB_MEMBER(CLUB_ID, STUDENT_ID, STAFF_CD, JOIN_DT, JOIN_CD, NM, MAJOR, GRADE, GENDER_CD,PHONE_NO,EMAIL,BIRTH_DT) VALUES "
				+ "((SELECT NVL(MAX(CLUB_ID),0) FROM CLUB),?,'004001',?,'008001',?,?,?,?,?,?,?)";
		try {
			UserDAO userDAO = new UserDAO();
			UserVO userVO = userDAO.getUser(user_id);
			if (CV.getClub_nm().equals(getClubName(CV.getClub_nm()))) {
				throw new ClubExistException("ClubExistException: 이미" + CV.getClub_nm() + " 은(는) 존재 합니다.");

			}

			if(userVO.getId() == null) {
				throw new UserNotExistException("UserNotExistException: "+user_id+"라는 user가 존재 하지 않습니다.");
			}
			
			
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, CV.getClub_nm());
			pstmt.setString(2, CV.getClub_gb_cd());
			pstmt.setString(3, CV.getClub_at_cd());
			pstmt.setInt(4, CV.getCnt());
			pstmt.setString(5, CV.getClub_aim());
			pstmt.setString(6, CV.getClub_active());
			pstmt.setString(7, CV.getClub_room());
			pstmt.setString(8, CV.getOpen_dt());
			pstmt.setString(9, CV.getIntro_file_nm());
			pstmt.setString(10, CV.getIntro_save_file_nm());
			pstmt.setString(11, CV.getPoster_file_nm());
			pstmt.setString(12, CV.getPoster_save_file_nm());
			pstmt.setString(13, CV.getRegister_cd());
			pstmt.executeUpdate();
			pstmt.close();

			pstmt = conn.prepareStatement(sql2);
			pstmt.setString(1, user_id);
			Date dt = new java.util.Date();
			SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMdd");
			String today = sdf.format(dt);
			pstmt.setString(2, today);
			System.out.println("[createClub] today: " + today);

			
			pstmt.setString(3, userVO.getName());
			pstmt.setString(4, userVO.getMajor());
			pstmt.setString(5, userVO.getGender());
			pstmt.setString(6, userVO.getGender());
			pstmt.setString(7, userVO.getPhoneNumber());
			pstmt.setString(8, userVO.getE_mail());
			pstmt.setString(9, userVO.getBirthday());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return -1;
	}
	// 여기까지 수정완료

	public int updateClub(ClubVO CV) {
		String sql = "UPDATE CLUB SET CLUB_GB_CD = ? , CLUB_AT_CD = ?, CLUB_CNT = ?, CLUB_AIM = ?, CLUB_ACTIVE = ?, "
				+ " CLUB_ROOM = ?, OPEN_DT = ? ";
		try {

			if (CV.getIntro_save_file_nm() != null) {
				sql = sql + ", INTRO_SAVE_FILE_NM = '" + CV.getIntro_save_file_nm() + "'";
				System.out.println("[updateClub] INTRO_SAVE_FILE_NM: " + CV.getIntro_save_file_nm());
			}
			if (CV.getPoster_save_file_nm() != null) {
				sql = sql + ", POSTER_SAVE_FILE_NM = '" + CV.getPoster_save_file_nm() + "'";
				System.out.println("[updateClub] POSTER_SAVE_FILE_NM: " + CV.getPoster_save_file_nm());
			}

			sql = sql + " WHERE CLUB_ID = " + CV.getClub_id();
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, CV.getClub_gb_cd());
			pstmt.setString(2, CV.getClub_at_cd());
			pstmt.setInt(3, CV.getCnt());
			pstmt.setString(4, CV.getClub_aim());
			pstmt.setString(5, CV.getClub_active());
			pstmt.setString(6, CV.getClub_room());
			pstmt.setString(7, CV.getOpen_dt());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(pstmt, conn);
		}
		return -1;
	}

	public int deleteClub(String clubNM) {
		String sql = "DELETE FROM club WHERE club_nm = ?";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, clubNM);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(pstmt, conn);
		}
		return -1;
	}
	
	public int deleteClub(int club_id) {
		String sql = "DELETE FROM club WHERE club_id = ?";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, club_id);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(pstmt, conn);
		}
		return -1;
	}
	public int addStar(int club_id, String user_id) {
		String sql = "UPDATE CLUB_MEMBER SET STAR = 'Y' WHERE CLUB_ID = ? AND STUDENT_ID = ? ";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, club_id);
			pstmt.setString(2, user_id);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {
			JDBCUtil.closeResource(pstmt, conn);
		}
	}

	
	
	public int deleteStar(int club_id, String user_id) {
		String sql = "UPDATE CLUB_MEMBER SET STAR = 'N' WHERE CLUB_ID = ? AND STUDENT_ID = ? ";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, club_id);
			pstmt.setString(2, user_id);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(pstmt, conn);
		}
		return -1;
	}

	public String getStar(int club_id, String user_id) {
		String sql = "SELECT STAR FROM CLUB_MEMBER WHERE CLUB_ID = ? AND STUDENT_ID = ? ";
		String str = "N";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, club_id);
			pstmt.setString(2, user_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				str = rs.getString(1);
			} else {
				str = "N";
			}
			return str;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return null;
	}

	public int getStarCnt(int club_id) {
		String sql = "SELECT COUNT(STAR) FROM CLUB_MEMBER WHERE CLUB_ID = ? AND STAR = 'Y' ";
		int cnt = 0;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, club_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				cnt = rs.getInt(1);
			} else {

			}
			return cnt;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return -1;
	}

	public ArrayList<ClubVO> getRegisteredClub() {
		String sql = "SELECT * FROM CLUB WHERE register_cd ='008001'";
		ArrayList<ClubVO> clublist = new ArrayList<>();
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ClubVO vo = new ClubVO();
				vo.setClub_id(rs.getInt("CLUB_ID"));
				vo.setClub_nm(rs.getString("CLUB_NM"));
				vo.setClub_gb_cd(rs.getString("CLUB_GB_CD"));
				vo.setClub_at_cd(rs.getString("CLUB_AT_CD"));
				vo.setCnt(rs.getInt("CLUB_CNT"));
				vo.setClub_aim(rs.getString("CLUB_AIM"));
				vo.setClub_active(rs.getString("CLUB_ACTIVE"));
				vo.setClub_room(rs.getString("CLUB_ROOM"));
				vo.setOpen_dt(rs.getString("OPEN_DT"));
				vo.setIntro_file_nm(rs.getString("INTRO_FILE_NM"));
				vo.setIntro_save_file_nm(rs.getString("INTRO_SAVE_FILE_NM"));
				vo.setPoster_file_nm(rs.getString("POSTER_FILE_NM"));
				vo.setPoster_save_file_nm(rs.getString("POSTER_SAVE_FILE_NM"));
				vo.setInput_id(rs.getString("INPUT_ID"));
				vo.setInput_ip(rs.getString("INPUT_IP"));
				vo.setInput_date(rs.getString("INPUT_DATE"));
				clublist.add(vo);
			} 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return clublist;
	}

	public ArrayList<ClubVO> getNotRegisteredClub() {
		String sql = "SELECT * FROM CLUB WHERE register_cd ='008003'";
		ArrayList<ClubVO> clublist = new ArrayList<>();
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ClubVO vo = new ClubVO();
				vo.setClub_id(rs.getInt("CLUB_ID"));
				vo.setClub_nm(rs.getString("CLUB_NM"));
				vo.setClub_gb_cd(rs.getString("CLUB_GB_CD"));
				vo.setClub_at_cd(rs.getString("CLUB_AT_CD"));
				vo.setCnt(rs.getInt("CLUB_CNT"));
				vo.setClub_aim(rs.getString("CLUB_AIM"));
				vo.setClub_active(rs.getString("CLUB_ACTIVE"));
				vo.setClub_room(rs.getString("CLUB_ROOM"));
				vo.setOpen_dt(rs.getString("OPEN_DT"));
				vo.setIntro_file_nm(rs.getString("INTRO_FILE_NM"));
				vo.setIntro_save_file_nm(rs.getString("INTRO_SAVE_FILE_NM"));
				vo.setPoster_file_nm(rs.getString("POSTER_FILE_NM"));
				vo.setPoster_save_file_nm(rs.getString("POSTER_SAVE_FILE_NM"));
				vo.setInput_id(rs.getString("INPUT_ID"));
				vo.setInput_ip(rs.getString("INPUT_IP"));
				vo.setInput_date(rs.getString("INPUT_DATE"));
				clublist.add(vo);
			} 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return clublist;
	}
	

	public int setRegister_cd(int club_id, String register_cd) {
		String sql = "UPDATE club SET register_cd=? WHERE club_id = ?";
		System.out.println("[setRegister_cd]: club_id: " + club_id);
		
		try {
			conn=JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, register_cd);
			pstmt.setInt(2, club_id);
			pstmt.executeUpdate();
			
			return 1;
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	/*
	 * public ArrayList<ClubVO> getboardwriteClub(String user_id) {
	 * ArrayList<ClubVO> clubList = null; String SQL = ""; try { SQL =
	 * "SELECT * FROM CLUB WHERE CLUB_ID = ANY(SELECT CLUB_ID FROM CLUB_MEMBER WHERE STUDENT_ID = ? AND JOIN_CD = 008001)"
	 * ; conn = JDBCUtil.getConnection(); pstmt = conn.prepareStatement(SQL);
	 * pstmt.setString(1, user_id); rs = pstmt.executeQuery(); clubList = new
	 * ArrayList<ClubVO>(); while (rs.next()) { ClubVO vo = new ClubVO();
	 * vo.setClub_id(rs.getInt(1)); vo.setClub_nm(rs.getString(2));
	 * clubList.add(vo); } } catch (Exception e) { e.printStackTrace(); } finally {
	 * JDBCUtil.closeResource(rs, pstmt, conn); } return clubList; }
	 */
}