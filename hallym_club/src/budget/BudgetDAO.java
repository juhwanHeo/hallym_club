package budget;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.util.ArrayList;

import util.JDBCUtil;

public class BudgetDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	public String getTotal(int club_id, String io_gb_cd) {

		String sql = "";
		String total = "";
		sql = "SELECT NVL(SUM(PRICE),0) FROM BUDGET WHERE CLUB_ID =? AND IO_GB_CD LIKE ?";

		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, club_id);
			pstmt.setString(2, io_gb_cd);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				DecimalFormat formatter = new DecimalFormat("###,###");
				total = formatter.format(rs.getInt(1));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs,pstmt, conn);
		}
		return total;
	}

	public int getTotal(int club_id, String io_gb_cd, int year, int month) {

		String sql = "";
		int total = 0;
		String tmp = "";

		sql = "select SUM(PRICE) FROM BUDGET WHERE CLUB_ID =? AND IO_GB_CD LIKE ? AND USE_DT LIKE ? ";

		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, club_id);
			pstmt.setString(2, io_gb_cd);

			if (year == 0)
				tmp = tmp + "____";
			else
				tmp = tmp + year;

			if (month == 0)
				tmp = tmp + "%";
			else {
				if (month < 10)
					tmp = tmp + "0" + month + '%';
				else
					tmp = tmp + month + "%";
			}
			pstmt.setString(3, tmp);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				total = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return total;
	}

	public ArrayList<BudgetVO> getBudget(int club_id, String io_gb_cd) {
		ArrayList<BudgetVO> list = new ArrayList<BudgetVO>();
		String sql = "";

		sql = "select USE_DT, CONTENTS, PRICE  FROM BUDGET WHERE CLUB_ID = ? AND IO_GB_CD LIKE ? ";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, club_id);
			pstmt.setString(2, io_gb_cd);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				BudgetVO vo = new BudgetVO();
				vo.setUse_dt(rs.getString(1));
				vo.setContents(rs.getString(2));
				vo.setPrice(rs.getInt(3));
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return list;
	}

	public ArrayList<BudgetVO> getBudget(int club_id, String io_gb_cd, int year, int month) {
		ArrayList<BudgetVO> list = new ArrayList<BudgetVO>();
		String sql = "";
		String tmp = "";

		sql = "select USE_DT, CONTENTS, PRICE  FROM BUDGET WHERE CLUB_ID = ? AND IO_GB_CD LIKE ? AND USE_DT LIKE ? ";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, club_id);
			pstmt.setString(2, io_gb_cd);

			if (year == 0)
				tmp = tmp + "____";
			else
				tmp = tmp + year;

			if (month == 0)
				tmp = tmp + "%";
			else {
				if (month < 10)
					tmp = tmp + "0" + month + '%';
				else
					tmp = tmp + month + "%";
			}

			pstmt.setString(3, tmp);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BudgetVO vo = new BudgetVO();
				vo.setUse_dt(rs.getString(1));
				vo.setContents(rs.getString(2));
				vo.setPrice(rs.getInt(3));
				list.add(vo);

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, pstmt, conn);
		}
		return list;
	}

	public int writeBudget(ArrayList<BudgetVO> bv, int club_id, String io_gb_cd) {
		String sql = "";
		String insert_sql = "";

		sql = "DELETE FROM BUDGET WHERE CLUB_ID = ? AND IO_GB_CD LIKE ? ";

		insert_sql = "insert into budget (CLUB_ID, SEQ_NO, IO_GB_CD, USE_DT, CONTENTS, PRICE) "
				+ " values(?, (SELECT NVL(MAX(seq_no) + 1, 1) FROM budget), ?, ?, ?, ?)";

		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, club_id);
			pstmt.setString(2, io_gb_cd);
			pstmt.executeUpdate();
			pstmt.close();
			pstmt = conn.prepareStatement(insert_sql);
			for (int i = 0; i < bv.size(); i++) {
				pstmt.setInt(1, club_id);
				pstmt.setString(2, io_gb_cd);
				pstmt.setString(3, bv.get(i).getUse_dt().replaceAll("-", ""));
				pstmt.setString(4, bv.get(i).getContents());
				pstmt.setInt(5, bv.get(i).getPrice());
				pstmt.executeUpdate();
				pstmt.clearParameters();
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(pstmt, conn);
		}
		return -1;
	}
}
