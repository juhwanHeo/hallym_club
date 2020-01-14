<%@ page import="bbs.BbsDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/club_main.css">
<link href='js/packages/core/main.css' rel='stylesheet' />
<link href='js/packages/daygrid/main.css' rel='stylesheet' />
<script src='js/packages/core/main.js'></script>
<script src='js/packages/interaction/main.js'></script>
<script src='js/packages/daygrid/main.js'></script>

<jsp:useBean id="clubMem_DAO" class="clubMember.clubMemberDAO" />
<%
   request.setCharacterEncoding("UTF-8");

   int club_id = 1;
   String board_cd = "";
   
   String username = null;
   if (session.getAttribute("username") != null) {
      username = (String) session.getAttribute("username");
   }
   
   if (request.getParameter("club_id") != null) {

      club_id = Integer.parseInt(request.getParameter("club_id"));

   }

   if (request.getParameter("board_cd") != null) {
      board_cd = request.getParameter("board_cd");
   }

   BbsDAO bbsDAO = new BbsDAO();

   String list = bbsDAO.getCalendar(club_id);
   
   int join_cd = clubMem_DAO.getJoin_cd(username, club_id);
%>


<script>
   /* var arr = new Array();

    var arrInfo = new Object();

    arrInfo.title = 'zzz22';
    arrInfo.start = '2019-10-03';
    arrInfo.end= '2019-10-07';
    arr.push(arrInfo);

    arrInfo = new Object();
    arrInfo.title = 'zzz';
    arrInfo.start = '2019-10-01';
    arrInfo.end= '2019-10-07';
    arr.push(arrInfo); */

   /* var jsonInfo = JSON.stringify([{"title":"김as","start":"2019-10-18","end":"2019-10-18"}]); */
   var jsonInfo = JSON.stringify(
<%=list%>
   );
</script>
<script>
   document.addEventListener('DOMContentLoaded', function() {
      var calendarEl = document.getElementById('calendar');

      var today = new Date();
      var yyyy = today.getFullYear();
      var mm = today.getMonth() + 1;
      var dd = today.getDate();

      if (dd < 10) {
         dd = '0' + dd
      }

      if (mm < 10) {
         mm = '0' + mm
      }

      today = yyyy + '-' + mm + '-' + dd;

      var calendar = new FullCalendar.Calendar(calendarEl, {
         plugins : [ 'interaction', 'dayGrid' ],
         defaultDate : today,
         locale : 'ko',
         displayEventTime : false, //시간 제거
         eventLimit : 4, // allow "more" link when too many events
         events : eval(jsonInfo)

      });

      calendar.render();
   });
</script>
<style>

#calendar {
   max-width: 900px;
   margin: 0 auto;
}
</style>
</head>
<body>
   <jsp:include page="club_platform.jsp?club_id=<%=club_id%>"></jsp:include>
   
   <div class="main">
      <div style="max-width: 880px; margin: 0 auto; height: 30px">
         <div style="float: right">
         <%if(join_cd==0){ %>
            <button class="cal-btn"
               onclick="location.href='mywrite.jsp?club_id=<%=club_id%>&board_cd=<%=board_cd%>'">일정
               등록</button>
               <%} %>
         </div>
      </div>
      <div id='calendar' style="max-width: 880px; margin: 0 auto;"></div>
   </div>
</body>
</html>