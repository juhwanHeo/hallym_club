package exam.jdbc;
 
import java.net.Inet4Address;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


import Student.StudentVO;
import util.JDBCUtil;
 
public class JDBC_studentDAO {
 
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
   
    public int studentInsert(StudentVO vo){
        int result = 0;
        
        java.util.Date dt = new java.util.Date();

        java.text.SimpleDateFormat sdf = 
             new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        String currentTime = sdf.format(dt);

        
        try{
        	conn = JDBCUtil.getConnection();
            String sql = "INSERT INTO STUDENT (STUDENT_ID, PASSWORD, INPUT_ID,INPUT_IP, INPUT_DATE) VALUES(?,?,?,?,TO_DATE(?,'yyyy-mm-dd hh24:mi:ss'))";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, vo.getUsername());
            pstmt.setString(2, vo.getPassword());
            pstmt.setString(3, vo.getUsername());
            pstmt.setString(4, Inet4Address.getLocalHost().getHostAddress());
            pstmt.setString(5, currentTime);
            
            result = pstmt.executeUpdate();
           
        }catch (Exception e){
           
            System.out.println(e + "=> studentInsert fail");
           
        }finally{
        	JDBCUtil.closeResource(pstmt, conn);
        }
       
        return result;
    }//studentInsert
    
    public boolean check(String id){
       boolean result = false;
       
       try{
    	  conn = JDBCUtil.getConnection();
          String sql = "select student_id from student where student_id=?";
          pstmt = conn.prepareStatement(sql);
          pstmt.setString(1, id);
          rs = pstmt.executeQuery();
          while(rs.next()){
             result = true;
             }
       }catch(Exception e){
          e.printStackTrace();
       }finally{          
    	   JDBCUtil.closeResource(rs, pstmt, conn);
        }  
       return result;
    }
    
}