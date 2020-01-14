<%@page import="budget.BudgetVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>한림대학교 동아리</title>
<jsp:useBean id="clubMem_DAO" class="clubMember.clubMemberDAO" />

<link rel="stylesheet" type="text/css" href="css/club_main.css">
<link rel="stylesheet" type="text/css" href="css/budget.css?">
<style>

</style>
</head>
<body>

   <%
      request.setCharacterEncoding("UTF-8");

      String io_gb_cd = "009001";
      
      String username = null;
      if (session.getAttribute("username") != null) {
         username = (String) session.getAttribute("username");
      }
      
      if (request.getParameter("io_gb_cd") != null) {
         io_gb_cd = request.getParameter("io_gb_cd");
      }
      
      int club_id =1;
      
      if (request.getParameter("club_id") != null) {
         club_id = Integer.parseInt(request.getParameter("club_id"));
      }
      
      int join_cd = clubMem_DAO.getJoin_cd(username, club_id);
   %>

   <jsp:useBean id="budget_dao" class="budget.BudgetDAO" />

   <%
      
      ArrayList<BudgetVO> budget_list = budget_dao.getBudget(club_id, io_gb_cd);

      if (budget_list != null) {
   %>

   <script>
   function move_url(x){
      var io_gb_cd = x.value;
      var url = "club_budget.jsp?club_id=" + <%=club_id%> + "&io_gb_cd=" + io_gb_cd;
      location.href =  url ;
   }
   
   </script>

   <jsp:include page="club_platform.jsp?club_id=<%=club_id%>"></jsp:include>

   <div class="main">
      <div style="text-align: justify;">
         <div id="up-btn">
         <button class="io-btn" name="io_gb_cd" value="009001" onclick="move_url(this);">수입</button>
         <button class="io-btn" name="io_gb_cd" value="009002" onclick="move_url(this);">지출</button>
         <button class="io-btn"
            onclick="location.href = 'club_budgetTotal.jsp?club_id=<%=club_id %>';">월별
            보고서</button>
         </div>
         
    
   <script>
   if(<%=io_gb_cd%> == ("009001")){
      document.getElementsByName('io_gb_cd')[0].className = "io-btn-select";
   }
    else if(<%=io_gb_cd%> == ("009002")){
       document.getElementsByName('io_gb_cd')[1].className = "io-btn-select";
    }else{
       document.getElementsByName('io_gb_cd')[2].className = "io-btn-select";
    }
   </script> 
   
         <form method="post" action="budget_Action.jsp"
            onsubmit="return checkSave();">
            <input type="hidden" name="club_id" value=<%=club_id%> > <input
               type="hidden" name="hidden_io_gb_cd" value='<%= io_gb_cd %>'>

            <div>

               <div>

                  <table id="bg_table">

                     <thead>
                        <tr>
                           <th><input type='checkbox' id='ck' onclick='allChk(this);'></th>
                           <th>&nbsp;날짜</th>
                           <th>&nbsp;사용내역</th>
                           <th>&nbsp;금액</th>
                        </tr>
                     </thead>

                     <tbody>
                        <%
            String total_price = budget_dao.getTotal(club_id, io_gb_cd);
               int i = 1;

               for (BudgetVO vo : budget_list) {
         %>
                        <tr onclick='javascript:trClick(this);'>
                           <td><input type='checkbox' name='check_idx' value='0' /></td>
                           <td><input type="text" name="use_dt" id="dt<%=i%>"
                              onfocus="this.select();" value="<%=vo.getUse_dt()%>"></td>
                           <td><input type="text" name="contents"
                              value="<%=vo.getContents()%>"></td>
                           <td><input type="text" name="price" id='in_price<%=i%>'
                              value='<%=vo.getPrice()%>'
                              onKeyup="this.value=this.value.replace(/[^0-9]/g,''); numberWithCommas(this);"
                              onfocus="this.select();"></td>
                        </tr>

                        <script>
            var x_id = in_price<%=i%>.getAttribute('id');
            var tmp = Number(document.getElementById(x_id).value);
            document.getElementById(x_id).value = tmp.toLocaleString();

         </script>


                        <%
            i++;
         %>

                        <%
            }
         %><!--  for문 끝 -->

                        <%
         if(budget_list.size() <4 ){
            while (i < 5) { %>
                        <tr onclick='javascript:trClick(this);'>
                           <td><input type='checkbox' name='check_idx' value='0' /></td>
                           <td><input type="text" name="use_dt" id="dt<%=i%>"
                              onfocus="this.select();" value=''></td>
                           <td><input type="text" name="contents"></td>
                           <td><input type="text" name="price" id='in_price<%=i%>'
                              onKeyup="this.value=this.value.replace(/[^0-9]/g,''); numberWithCommas(this);"
                              onfocus="this.select();"></td>
                        </tr>

                        <%
                  i++;
               %>
                        <%
                  }
         }else{
            while (i < budget_list.size()+2) {
               
               %>

                        <tr onclick='javascript:trClick(this);'>
                           <td><input type='checkbox' name='check_idx' value='0' /></td>
                           <td><input type="text" name="use_dt" id="dt<%=i%>"
                              onfocus="this.select();" value=''></td>
                           <td><input type="text" name="contents"></td>
                           <td><input type="text" name="price" id='in_price<%=i%>'
                              onKeyup="this.value=this.value.replace(/[^0-9]/g,''); numberWithCommas(this);"
                              onfocus="this.select();"></td>
                        </tr>

                        <%
                  i++;
               %>
                        <%
                  }
               
         }%>


                        <tr style="text-align: center;">
                           <td colspan="2" class="bg">&nbsp;&nbsp;<input type="button"
                              value="선택삭제" id="del_btn" class="del-btn">&nbsp;&nbsp;<input
                              type="button" value="전체삭제" onclick='allDel();' class="del-btn"></td>
                           <td style="text-align: right" class="bg">
                              <%
                  if (io_gb_cd.equals("009001")) {
                        out.println("<h4 style='margin-right:10px;'>수입합계</h4>");
                     } else if (io_gb_cd.equals("009002")) {
                        out.println("<h4 style='margin-right:10px;'>지출합계</h4>");
                     } 
               %>
                           </td>
                           <td><input type="text" id="total" readonly="readonly" value= '<%=total_price%>' ></td>
                        </tr>
                     </tbody>
                  </table>
               </div>


            </div>
            <div id="below">
            <%if(join_cd==0){ %>
            <input type="submit" value="저장하기" class="save-btn" >
            <%}%> 
            <input type="button" class="save-btn"
               value="초기화" onclick="location.reload();">
            </div>
         </form>
      </div>
   </div>


   <%
      } else {
         out.println("<script>alert('가입 동아리를 선택해주세요.');</script>");
      }
   %>

   <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
   <script>
      function numberWithCommas(x) {
         var y = x.value;
         y = y.replace(/[^0-9]/g, ''); // 입력값이 숫자가 아니면 공백
         y = y.replace(/,/g, ''); // ,값 공백처리
         var x_id = x.getAttribute('id');
         $('#' + x_id).val(y.replace(/\B(?=(\d{3})+(?!\d))/g, ",")); // 정규식을 이용해서 3자리 마다 , 추가 
      }

      function trClick(tr) {
         var idx = $('#bg_table tr').length ;   //행 위치
         var idx_id = "in_price" + idx;   //price id
         var dt_id = "dt" + idx;
         
         var exp = 'this.value=this.value.replace(/[^0-9]/g,"")';
               
         var data = "<tr onclick='javascript:trClick(this);'> <td><input type='checkbox' name='check_idx' value='0' /></td>" 
            + "<td><input type='text' name='use_dt' id='"+ dt_id +"' onfocus='this.select();'></td> <td><input type='text' name='contents'></td> <td><input type='text' name='price' id='" + idx_id +"'  onKeyup='" + exp +  "; numberWithCommas(this); '"+
            "onfocus='this.select();'></td> </tr>";
         
          if (tr.rowIndex == $('#bg_table tr').length-2) {
             $('#bg_table tr:last').before(data);
          }

         $('#' + idx_id).bind("blur", function() {

            var sum1 = Number("0");
            var sum2 = Number("0");

            if ($(this).val() == "") {
               $(this).val(Number("0"));
            }

            $('[id*=in_price]').each(function() {
               var price = $(this);
               sum2 = price.val();
               sum2 = sum2.replace(/,/g, '');

               if (sum2 == "") {
                  sum2 = Number("0");
               }
               sum1 += Number(sum2);
            });

            $('#total').val(addComma(sum1));

         });

         $('#' + dt_id).focusin(function() {

            var today = getToday();
            
            if ($(this).val() == "") {
               $(this).val(getToday());
               $(this).select();
            } else {
               $(this).val($(this).val().replace(/\-/g, ''));
               $(this).select();
            }
         });

          $('#'+dt_id).bind("blur", function(){
          
            var pattern = /^(19|20)\d{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[0-1])$/; 
            var tmp = $(this).val().replace(/\-/g, '');
            
            if(!pattern.test(tmp)) {
               
               alert("날짜형식이 올바르지않습니다.\n 오늘 날짜로 입력합니다.");
               $(this).val(formatDate(getToday()));
               
               var a = $(this).attr('id');
               $('#'+a).focus();
            }else{
               $(this).val(formatDate($(this).val()));
            }
            
         });
          
         var objDiv = document.getElementById("bg_table"); 
         objDiv.scrollTop = objDiv.scrollHeight;
      }// end tr_click

      function addComma(num) {
         var regexp = /\B(?=(\d{3})+(?!\d))/g;
         return num.toString().replace(regexp, ',');
      }

      // 오늘 날짜 구하기
      function getToday() {
         var date = new Date();
         var year = date.getFullYear();
         var month = date.getMonth() + 1
         var day = date.getDate();
         if (month < 10) {
            month = "0" + month;
         }
         if (day < 10) {
            day = "0" + day;
         }

         var today = ""+year + month + day;
         
         return today;

      }

      $('input[id*=in_price]').blur(function(e) {

         var sum1 = Number("0");
         var sum2 = Number("0");

         if ($(this).val() == "") {
            $(this).val(Number("0"));
         }

         $('[id*=in_price]').each(function() {
            var price = $(this);
            sum2 = price.val();
            sum2 = sum2.replace(/,/g, '');

            if (sum2 == "") {
               sum2 = Number("0");
            }
            sum1 += Number(sum2);
         });

         $('#total').val(addComma(sum1));

      });

      function formatDate(date) { //20121212
         if (date.length == 8) {
            var year = date.substr(0, 4);
            var month = date.substr(4, 2);
            var day = date.substr(6, 2);
            var format_dt = year + "-" + month + "-" + day;
            return format_dt;
         }

      }

      $('input[id*=dt]').focusin(function() {

         var today = getToday();

         if ($(this).val() == "") {
            $(this).val(getToday());
            $(this).select();
         } else {
            $(this).val($(this).val().replace(/\-/g, ''));
            $(this).select();
         }

      });
      
      
      $('input[id*=dt]').focusout(function(){
         
         var pattern = /^(19|20)\d{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[0-1])$/; 
         var tmp = $(this).val().replace(/\-/g, '');
         if(!pattern.test(tmp)) {
            
            alert("날짜형식이 올바르지않습니다.\n 오늘 날짜로 입력합니다.");
            $(this).val(formatDate(getToday()));
            var a = $(this).attr('id');
            $('#'+a).focus();
         }else{
            $(this).val(formatDate(tmp));
         }
         
         });
      

      $("#del_btn").click(function(){ 
         var total = Number("0");
         
         var result = confirm('정말 삭제하시겠습니까?');
         if(result){
            $("#bg_table input[name='check_idx']:checked").parent().parent().remove();
            
            while($('#bg_table tr').length < 6){
               var exp = 'this.value=this.value.replace(/[^0-9]/g,"")';
                              
                  
               var data = "<tr onclick='javascript:trClick(this);'> <td><input type='checkbox' name='check_idx' /></td>" 
                  + "<td><input type='text' name='use_dt' id='dt' onfocus='this.select();'></td> <td><input type='text' name='contents'></td> <td><input type='text' name='price' id='in_price'  onKeyup='" + exp +  "; numberWithCommas(this);'"+
                  "onfocus='this.select();'></td> </tr>";
               
               $('#bg_table tr:last').before(data);
               
               $('[id*=in_price]').bind("blur", function(){
                   
                   var sum1 = Number("0");
                  var sum2 = Number("0");
                  
                  if ($(this).val() =="" ){
                     $(this).val(Number("0"));
                  }
                  
                  $('[id*=in_price]').each(function() {
                       var price = $(this);
                       sum2 = price.val();
                       sum2 = sum2.replace(/,/g, '');
                       
                     if (sum2==""){
                        sum2 = Number("0");
                     }
                       sum1 += Number(sum2);
                   });
                  
                  $('#total').val(addComma(sum1));
                   
                });
            
            }
            
            
            //삭제후 아이디 재설정
            for(var x=1; x<= $('#bg_table tr').length-2; x++){
               var new_id = "dt" + x;
               var new_id2 = "in_price" + x;
               
               
               $('#bg_table  tr:eq('+x+')>td:eq(1)').find('input[type="text"]').attr("id",new_id);
               $('#bg_table  tr:eq('+x+')>td:eq(3)').find('input[type="text"]').attr("id",new_id2);
            
               var sum1 = $('#' + new_id2).val().replace(/,/g, '');
               if (sum1 == ""){
                  sum1 = "0"
               }
               
               total +=  Number(sum1);
               
               $('#' + new_id).focusin(function() {

                  var today = getToday();

                  if ($(this).val() == "") {
                     $(this).val(getToday());
                     //$(this).val("123");
                     $(this).select();
                  } else {
                     $(this).val($(this).val().replace(/\-/g, ''));
                     $(this).select();
                  }
               });
            
               $('#' + new_id).focusout(function(){
                  
                  var pattern = /^(19|20)\d{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[0-1])$/; 
                  var tmp = $(this).val().replace(/\-/g, '');
                  
                  if(!pattern.test(tmp)) {
                     
                     alert("날짜형식이 올바르지않습니다.\n 오늘 날짜로 입력합니다.");
                     $(this).val(formatDate(getToday()));
                     var a = $(this).attr('id');
                     $('#'+a).focus();
                  }else{
                     $(this).val(formatDate(tmp));
                     
                  }
                  
                  });

            
            }//end for
            $('#total').val(addComma(total));
            document.getElementById('ck').checked = false;
         }else{
            if(document.getElementById('ck').checked){
               
            }else{
               document.getElementById('ck').checked = false;
            }
            
         }
             
         
      });

      function allChk(obj) {

         var chkObj = document.getElementsByName("check_idx");
         var rowCnt = chkObj.length - 1;
         var check = obj.checked;
         if (check) {
            for (var i = 0; i <= rowCnt; i++) {
               if (chkObj[i].type == "checkbox")
                  chkObj[i].checked = true;
            }
         } else {
            for (var i = 0; i <= rowCnt; i++) {
               if (chkObj[i].type == "checkbox") {
                  chkObj[i].checked = false;
               }
            }
         }
      }

      function allDel() {
         var timer;
         $("#ck").trigger("click");
         timer = setTimeout(function() {
            $("#del_btn").trigger("click");
         }, 100);

      }

      function checkSave() {
         $('#total').focus();
         for (var x = 1; x <= $('#bg_table tr').length - 2; x++) {
            var tmp_val1 = $('#bg_table  tr:eq(' + x + ')>td:eq(1)').find(
                  'input[type="text"]').val();
            var tmp_val2 = $('#bg_table  tr:eq(' + x + ')>td:eq(2)').find(
                  'input[type="text"]').val();
            var tmp_val3 = $('#bg_table  tr:eq(' + x + ')>td:eq(3)').find(
                  'input[type="text"]').val();

            if (tmp_val1 == "" || tmp_val2 == "" || tmp_val3 == "") {
               tmp_val1 = "";
               tmp_val2 = "";
               tmp_val3 = "";
            }

         }
      }

      /*값 저장*/

      
   </script>
</body>

</html>