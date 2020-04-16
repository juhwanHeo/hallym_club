package util;

import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

public class JDBCUtil {
	public static Connection getConnection() {
		Connection conn = null;
		try {
			String driver = "oracle.jdbc.driver.OracleDriver";
			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			String oraId = "hr";
			String oraPw = "hr";
			// String url = "jdbc:oracle:thin:@14.56.34.174:1521:xe";
			// String oraId = "hallym";
			// String oraPw = "hallym123!";

			try {
				Class.forName(driver);
				conn = DriverManager.getConnection(url, oraId, oraPw);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}

	public static void closeResource(Statement stmt, Connection conn) {
		try {
			if (stmt != null)
				stmt.close();
		} catch (Exception e) {
			stmt = null;
		}
		try {
			if (conn != null)
				conn.close();
		} catch (Exception e) {
			conn = null;
		}
	}

	public static void closeResource(ResultSet rs, Statement stmt, Connection conn) {
		try {
			if (rs != null)
				rs.close();
		} catch (Exception e) {
			rs = null;
		}
		try {
			if (stmt != null)
				stmt.close();
		} catch (Exception e) {
			stmt = null;
		}
		try {
			if (conn != null)
				conn.close();
		} catch (Exception e) {
			conn = null;
		}
	}
}
