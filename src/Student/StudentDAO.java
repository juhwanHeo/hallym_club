package Student;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.JDBCUtil;

public class StudentDAO {
	private Connection conn = null;
	private PreparedStatement pstmt= null;;
	private ResultSet rs= null;

	public int login(String userID, String userPassword) {
		String SQL = "select PASSWORD from student where STUDENT_ID= ?";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getString(1).equals(userPassword)) {
					return 1;// 로그인성공
				} else
					return 0;// 비밀번호 불 일치
			}
			return -1;// 아이디 없음
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.closeResource(rs,pstmt, conn);
		}
		return -2;// 데이터베이스의 오류
	}

}
