<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%@ page import="bbs.BbsDAO"%>

<!-- bbsdao의 클래스 가져옴 -->

<%@ page import="java.io.PrintWriter"%>

<!-- 자바 클래스 사용 -->

<%

   request.setCharacterEncoding("UTF-8");

   response.setContentType("text/html; charset=UTF-8"); //set으로쓰는습관들이세오.

%>


   <jsp:useBean id="bbs" class="bbs.Bbs" />
   <jsp:setProperty property="*" name="bbs" />
   <jsp:useBean id="bbs_dao" class="bbs.BbsDAO" />
   

<!DOCTYPE html>

<html>

<head>



<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>jsp 게시판 웹사이트</title>

</head>

<body>
   <jsp:useBean id="itemDAO" class="item.itemDAO" />
   <%
   
   String userID = null;
   
      if (session.getAttribute("username") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 

         userID = (String) session.getAttribute("username");//유저아이디에 해당 세션값을 넣어준다.

      }
 {



         if (bbs.getTITLE() == null || bbs.getCONTENTS() == null) {

            PrintWriter script = response.getWriter();

            script.println("<script>");

            script.println("alert('입력이 안된 사항이 있습니다')");

            script.println("history.back()");

            script.println("</script>");

         } else {

            BbsDAO BbsDAO = new BbsDAO();

            int result = BbsDAO.write(bbs, userID);
            
             if (result == -1) {

               PrintWriter script = response.getWriter();
               script.println("<script>");
               script.println("alert('글쓰기에 실패했습니다')");
               script.println("history.back()");
               script.println("</script>");

            }
            else { 

               PrintWriter script = response.getWriter();
               script.println("<script>");
               script.println("alert('글을 작성하였습니다.')");
               if(bbs.getBoard_cd().equals("007004")){
                  script.println("location.href='club_calendar.jsp?club_id="+bbs.getClub_id()+"&board_cd="+bbs.getBoard_cd()+"'");
               }else{
                  script.println("location.href='myClub_Board.jsp?club_id="+bbs.getClub_id()+"&board_cd="+bbs.getBoard_cd()+"'");
               }
               script.println("</script>");

            }

         }
      }


      

   %>

</body>

</html>


