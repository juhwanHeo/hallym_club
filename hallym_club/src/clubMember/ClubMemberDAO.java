package clubMember;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.JDBCUtil;

public class ClubMemberDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	// 동아리 가입
	public int writeMember(ClubMemberVo CM) {
		String sql = "INSERT INTO club_member(CLUB_ID,STUDENT_ID,NM,MAJOR,GRADE,GENDER_CD,PHONE_NO,ADDRESS,EMAIL,JOIN_CD,BIRTH_DT,plan,hope) VALUES(?,?,?,?,?,?,?,?,?,'008003',?,?,?)";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, CM.getCLUB_ID());
			pstmt.setString(2, CM.getSTUDENT_ID());
			pstmt.setString(3, CM.getNM());
			pstmt.setString(4, CM.getMAJOR());
			pstmt.setString(5, CM.getGRADE());
			pstmt.setString(6, CM.getGENDER_CD());
			pstmt.setString(7, CM.getPHONE_NO());
			pstmt.setString(8, CM.getADDRESS());
			pstmt.setString(9, CM.getEMAIL());
			pstmt.setString(10, CM.getBIRTH_DT());
			pstmt.setString(11, CM.getPlan());
			pstmt.setString(12, CM.getHope());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(pstmt, conn);
		}
		return -1;
	}

	public String getStaff_CD(int club_id, String student_id) {
		String staff_cd = null;
		String sql = "";

		try {
			sql = "SELECT staff_cd FROM club_member WHERE club_id = ? AND student_id = ?";
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, club_id);
			pstmt.setString(2, student_id);
			rs = pstmt.executeQuery();
			rs.next();
			staff_cd = rs.getString(1);
			// System.out.println("[getStaff_CD]: " + staff_cd);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return staff_cd;
	}

	public ArrayList<ClubMemberVo> club_getMember(int CLUB_ID, String join_cd) {
		ArrayList<ClubMemberVo> clubList = null;
		String sql = "";
		try {
			sql = "SELECT * FROM CLUB_MEMBER WHERE CLUB_ID = ? AND JOIN_CD = ? ";
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, CLUB_ID);
			pstmt.setString(2, join_cd);
			rs = pstmt.executeQuery();
			clubList = new ArrayList<ClubMemberVo>();
			while (rs.next()) {
				ClubMemberVo vo = new ClubMemberVo();
				vo.setCLUB_ID(rs.getInt(1));
				vo.setSTUDENT_ID(rs.getString(2));
				vo.setNM(rs.getString(3));
				vo.setMAJOR(rs.getString(4));
				vo.setGRADE(rs.getString(5));
				vo.setGENDER_CD(rs.getString(6));
				vo.setSTAFF_CD(rs.getString(7));
				vo.setPHONE_NO(rs.getString(8));
				vo.setADDRESS(rs.getString(10));
				vo.setEMAIL(rs.getString(12));
				vo.setJoin_dt(rs.getString(13));
				vo.setBIRTH_DT(rs.getString(14));
				vo.setJOIN_CD(rs.getString(16));
				vo.setPlan(rs.getString(23));
				vo.setHope(rs.getString(24));
				clubList.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return clubList;
	}

	public int getTotal(int club_id, String category, String search) {
		String sql = "SELECT COUNT(*) FROM CLUB_MEMBER WHERE CLUB_ID = ? AND JOIN_CD = '008001' AND ? LIKE ? ";
		int total = 0;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, club_id);
			pstmt.setString(2, category);
			pstmt.setString(3, "%" + search + "%");
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

	public ArrayList<ClubMemberVo> getMember(int club_id, String category, String search, int pageNumber) {

		ArrayList<ClubMemberVo> clubList = null;
		String sql = "";

		try {
			sql = "SELECT * FROM (SELECT ROWNUM AS RNUM, MAJOR, GRADE, STUDENT_ID, NM, PHONE_NO, S.SO_NM AS STAFF_CD, JOIN_DT"
					+ " FROM CLUB_MEMBER M , SO_CD S WHERE M.STAFF_CD = S.SO_CD AND CLUB_ID = ? AND JOIN_CD = '008001' AND ? LIKE ?) WHERE RNUM >? AND RNUM<=?";
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, club_id);
			pstmt.setString(2, category);
			pstmt.setString(3, "%" + search + "%");
			pstmt.setInt(4, (pageNumber - 1) * 10);
			pstmt.setInt(5, pageNumber * 10);
			rs = pstmt.executeQuery();
			clubList = new ArrayList<ClubMemberVo>();
			while (rs.next()) {
				ClubMemberVo vo = new ClubMemberVo();
				vo.setMAJOR(rs.getString("MAJOR"));
				vo.setGRADE(rs.getString("GRADE"));
				vo.setSTUDENT_ID(rs.getString("STUDENT_ID"));
				vo.setNM(rs.getString("NM"));
				vo.setPHONE_NO(rs.getString("PHONE_NO"));
				vo.setSTAFF_CD(rs.getString("STAFF_CD"));
				vo.setJoin_dt(rs.getString("JOIN_DT"));
				clubList.add(vo);
			}
			if (!clubList.isEmpty()) {
				clubList.get(0).setRow_count(getTotal(club_id, category, search));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return clubList;
	}

	public ArrayList<ClubMemberVo> getMember(int CLUB_ID, String join_cd, String category, String search) {

		ArrayList<ClubMemberVo> clubList = null;
		String sql = "";

		try {

			sql = "SELECT * FROM CLUB_MEMBER WHERE CLUB_ID = ? AND JOIN_CD = ? AND " + category + " LIKE ? ORDER BY "
					+ "ISNULL(STAFF_CD) ASC, STAFF_CD ASC";
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, CLUB_ID);
			pstmt.setString(2, join_cd);
			pstmt.setString(3, "%" + search + "%");
			rs = pstmt.executeQuery();

			clubList = new ArrayList<ClubMemberVo>();

			while (rs.next()) {
				ClubMemberVo vo = new ClubMemberVo();
				vo.setCLUB_ID(rs.getInt(1));
				vo.setSTUDENT_ID(rs.getString(2));
				vo.setNM(rs.getString(3));
				vo.setMAJOR(rs.getString(4));
				vo.setGRADE(rs.getString(5));
				vo.setGENDER_CD(rs.getString(6));
				vo.setSTAFF_CD(rs.getString(7));
				vo.setPHONE_NO(rs.getString(8));
				vo.setADDRESS(rs.getString(10));
				vo.setEMAIL(rs.getString(12));
				vo.setJoin_dt(rs.getString(13));
				vo.setBIRTH_DT(rs.getString(14));
				vo.setJOIN_CD(rs.getString(16));
				vo.setPlan(rs.getString(23));
				vo.setHope(rs.getString(24));
				clubList.add(vo);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return clubList;
	}

	// 회원 관리 수정할 때
	public ArrayList<ClubMemberVo> getMemberInfo(int CLUB_ID, String student_id) {
		ArrayList<ClubMemberVo> clubList = null;
		String sql = "";
		try {
			sql = "SELECT * FROM CLUB_MEMBER WHERE CLUB_ID = ? AND STUDENT_ID = ?";
			sql = "SELECT M.CLUB_ID, M.STUDENT_ID, M.NM, M.MAJOR, M.GRADE, M.GENDER_CD, S.SO_NM AS STAFF_CD, M.PHONE_NO, M.ADDRESS, M.EMAIL,"
					+ " M.JOIN_DT, M.BIRTH_DT, M.JOIN_CD, M.PLAN, M.HOPE FROM CLUB_MEMBER M, SO_CD S WHERE M.CLUB_ID = ? "
					+ " AND STUDENT_ID = ? AND M.JOIN_CD = '008001' AND M.STAFF_CD = S.SO_CD ";
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, CLUB_ID);
			pstmt.setString(2, student_id);
			rs = pstmt.executeQuery();
			clubList = new ArrayList<ClubMemberVo>();

			while (rs.next()) {
				ClubMemberVo vo = new ClubMemberVo();
				vo.setCLUB_ID(rs.getInt("CLUB_ID"));
				vo.setSTUDENT_ID(rs.getString("STUDENT_ID"));
				vo.setNM(rs.getString("NM"));
				vo.setMAJOR(rs.getString("MAJOR"));
				vo.setGRADE(rs.getString("GRADE"));
				vo.setGENDER_CD(rs.getString("GENDER_CD"));
				vo.setSTAFF_CD(rs.getString("STAFF_CD"));
				vo.setPHONE_NO(rs.getString("PHONE_NO"));
				vo.setADDRESS(rs.getString("ADDRESS"));
				vo.setEMAIL(rs.getString("EMAIL"));
				vo.setJoin_dt(rs.getString("JOIN_DT"));
				vo.setBIRTH_DT(rs.getString("BIRTH_DT"));
				vo.setJOIN_CD(rs.getString("JOIN_CD"));
				vo.setPlan(rs.getString("PLAN"));
				vo.setHope(rs.getString("HOPE"));
				clubList.add(vo);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return clubList;
	}

	public ArrayList<ClubMemberVo> allMember(int CLUB_ID) {
		ArrayList<ClubMemberVo> clubList = null;
		String sql = "";
		try {
			sql = "SELECT M.NM, M.GENDER_CD, S.SO_NM AS STAFF_CD, M.MAJOR, M.PHONE_NO FROM CLUB_MEMBER M, SO_CD S "
					+ "WHERE M.CLUB_ID = ? AND M.JOIN_CD = '008001' AND M.STAFF_CD = S.SO_CD";
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, CLUB_ID);
			rs = pstmt.executeQuery();

			clubList = new ArrayList<ClubMemberVo>();
			while (rs.next()) {
				ClubMemberVo vo = new ClubMemberVo();
				vo.setNM(rs.getString("NM"));
				vo.setGENDER_CD(rs.getString("GENDER_CD"));
				vo.setSTAFF_CD(rs.getString("STAFF_CD"));
				vo.setMAJOR(rs.getString("MAJOR"));
				vo.setPHONE_NO(rs.getString("PHONE_NO"));
				clubList.add(vo);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return clubList;
	}

	public int update(int club_id, String student_id) {
		String sql = "UPDATE club_member SET JOIN_DT = ? , JOIN_CD = '008001', STAFF_CD = '004004' WHERE CLUB_ID = ? AND STUDENT_ID = ?";
		java.util.Date dt = new java.util.Date();
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMdd");
		String join_dt = sdf.format(dt);
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, join_dt);
			pstmt.setInt(2, club_id);
			pstmt.setString(3, student_id);
			pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		sql = "UPDATE club SET club_cnt = club_cnt+1 where  CLUB_ID = ?";
		try {
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

	// 회원 가입 거부(삭제)
	public int delete(int club_id, String student_id, String distinction) {
		String sql = "DELETE FROM CLUB_MEMBER WHERE CLUB_ID = ? AND STUDENT_ID = ?";
		int answer = 0;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, club_id);
			pstmt.setString(2, student_id);
			answer = pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		if (distinction.equals("2")) {
			sql = "UPDATE club SET club_cnt = club_cnt-1 where  CLUB_ID = ?";
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, club_id);
				return pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				JDBCUtil.closeResource(pstmt, conn);
			}
		} else {
			return answer;
		}
		return -1; // 데이터베이스 오류
	}

	public int update(int club_id, String student_id, String staff_cd) {
		String sql = "UPDATE CLUB_MEMBER SET STAFF_CD = ?  WHERE CLUB_ID = ? AND STUDENT_ID = ?";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, staff_cd);
			pstmt.setInt(2, club_id);
			pstmt.setString(3, student_id);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(pstmt, conn);
		}
		return -1;
	}

	public List<String> get_MyApplyList(String username, int check) {
		String sql = "";
		if (check == 0)
			sql = "SELECT CLUB_NM from club WHERE CLUB_ID = ANY(SELECT CLUB_ID from club_member where Student_ID= "
					+ username + " AND JOIN_CD='008003')";
		else if (check == 1)
			sql = "SELECT CLUB_NM from club WHERE CLUB_ID = ANY(SELECT CLUB_ID from club_member where Student_ID= "
					+ username + " AND JOIN_CD='008001')";

		List<String> apply = new ArrayList<String>();

		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				apply.add(rs.getString(1));
			}
			return apply;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return null;
	}

	public int removeApply(String username, int club_id) {
		String sql = "DELETE from club_member where STUDENT_ID= ? AND CLUB_ID = ?";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, username);
			pstmt.setInt(2, club_id);
			pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		sql = "UPDATE club SET club_cnt = club_cnt-1 where CLUB_ID = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, club_id);
			pstmt.executeUpdate();
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(pstmt, conn);
		}
		return -1;
	}

	public String[] getUserForm(String username, int club_id) {
		String sql = "SELECT NM,MAJOR,GRADE,GENDER_CD,PHONE_NO,ADDRESS,EMAIL,BIRTH_DT,plan,hope from club_member where STUDENT_ID= ? AND CLUB_ID= ?";
		String myInfo[] = new String[10];
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, username);
			pstmt.setInt(2, club_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				myInfo[0] = rs.getString(1); // 성명
				myInfo[1] = rs.getString(2); // 전공
				myInfo[2] = rs.getString(3); // 학년
				myInfo[3] = rs.getString(4); // 성별 코드
				myInfo[4] = rs.getString(5); // 폰번호
				myInfo[5] = rs.getString(6); // 주소
				myInfo[6] = rs.getString(7); // 이메일
				myInfo[7] = rs.getString(8); // 생년 월일
				myInfo[8] = rs.getString(9); // 계획
				myInfo[9] = rs.getString(10); // 바라는점
			}
			return myInfo;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return null;
	}

	public int modMember(ClubMemberVo CM, String username, String clubNM) {
		String sql = "UPDATE club_member SET NM=?,MAJOR=?,GRADE=?,GENDER_CD=?,PHONE_NO=?,ADDRESS=?,EMAIL=?,BIRTH_DT=?,plan=?,hope=? where STUDENT_ID= ? "
				+ " AND CLUB_ID=( SELECT CLUB_ID from club where CLUB_NM = ? )";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, CM.getNM());
			pstmt.setString(2, CM.getMAJOR());
			pstmt.setString(3, CM.getGRADE());
			pstmt.setString(4, CM.getGENDER_CD());
			pstmt.setString(5, CM.getPHONE_NO());
			pstmt.setString(6, CM.getADDRESS());
			pstmt.setString(7, CM.getEMAIL());
			pstmt.setString(8, CM.getBIRTH_DT());
			pstmt.setString(9, CM.getPlan());
			pstmt.setString(10, CM.getHope());
			pstmt.setString(11, username);
			pstmt.setString(12, clubNM);
			pstmt.executeUpdate();
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(pstmt, conn);
		}
		return -1;
	}

	public int overlapCheck(String username, int club_id) {
		String sql = "SELECT JOIN_CD FROM club_member where STUDENT_ID= ? AND CLUB_ID= ?";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, username);
			pstmt.setInt(2, club_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getString(1).equals("008003"))
					return 0;
				else if (rs.getString(1).equals("008001"))
					return 1;
			}
			return 2;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return -1;
	}

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
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return null;// 디비 오류

	}

	
	public int getStaff_CD(String username, int club_id) {
		String sql = "SELECT STAFF_CD FROM club_member where STUDENT_ID= ? AND CLUB_ID= ?";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, username);
			pstmt.setInt(2, club_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getString(1) != null) {
					if (rs.getString(1).equals("004001") || rs.getString(1).equals("004002"))
						return 0;
				}
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return -1;

	}
	public String getJoin_cd(String username, int club_id) {
		String sql = "SELECT join_cd FROM club_member where STUDENT_ID= ? AND CLUB_ID= ?";
		String join_cd = null;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, username);
			pstmt.setInt(2, club_id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				join_cd=rs.getString(1);
			}
			System.out.print("[ClubMemberDAO.getJoin_cd] club_id:" + club_id);
			System.out.println(", join_cd:" + join_cd);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return join_cd;
	}
}