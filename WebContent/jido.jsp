<%@page import="util.JDBCUtil"%>
<%@page import="sun.security.krb5.internal.PAEncTSEnc"%>
<%@page import="java.net.URLEncoder"%>
<%-- <%@page import="exam.jdbc.ClubVO"%> --%>
<%@page import="java.util.ArrayList"%>
<%-- <%@page import="exam.jdbc.JDBC_clubDAO"%> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.DriverManager,
                   java.sql.Connection,
                   java.sql.Statement,
                   java.sql.ResultSet,
                   java.sql.SQLException,
                   java.util.ArrayList,
                java.util.List"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=1200">
<title>한림대학교 동아리</title>
<link rel="stylesheet" type="text/css" href="css/common.css">
<link rel="stylesheet" type="text/css" href="css/jido.css">
</head>
<body>

	<%
		String username = null;
		if (session.getAttribute("username") != null) {
			username = (String) session.getAttribute("username");
		}
	%>

	<div id="wrap">
		<div id="header">
			<jsp:include page="header.jsp"></jsp:include>
		</div>

		<div id="map"></div>

		<hr>
		<hr>

		<div id="info">
			<table class="restaurant">
				<thead>
					<tr>
						<th style="width: 350px;">음식점</th>
						<th style="width: 650px;">주소</th>
						<th style="width: 200px;">연락처</th>
					</tr>
				</thead>
				<tbody>
					<%
						response.setContentType("text/html;charset=utf-8;");
						request.setCharacterEncoding("utf-8"); //charset, Encoding 설정
						
						Connection conn = null;
						Statement stmt = null;
						ResultSet rs = null;

						List<String> club_name = new ArrayList<String>();
						List<String> club_x = new ArrayList<String>();
						List<String> club_y = new ArrayList<String>();
						List<String> club_phone = new ArrayList<String>();
						List<String> club_address = new ArrayList<String>();
						List<String> club_post = new ArrayList<String>();
						List<String> club_internet = new ArrayList<String>();

						int i = 0;

						try {
							conn = JDBCUtil.getConnection();
							stmt = conn.createStatement();
							String Query = "select rest_nm,latitute,longitude,rest_phone_no,address,post,input_id from restaurant";

							rs = stmt.executeQuery(Query);

							while (rs.next()) {
								club_name.add(rs.getString(1));
								club_x.add(rs.getString(2));
								club_y.add(rs.getString(3));
								club_phone.add(rs.getString(4));
								club_address.add(rs.getString(5));
								club_post.add(rs.getString(6));
								club_internet.add(rs.getString(7));
								i++;
							}

						} catch (Exception e) {
							e.printStackTrace();
						} finally {
							JDBCUtil.closeResource(rs, stmt, conn);
						}
					%>

					<tr>
						<%
							for (int k = 0; k < club_name.size(); k++) {
						%>
						<td><a href=<%=club_internet.get(k)%> target=_blank><%=club_name.get(k)%></a></td>
						<td><%=club_address.get(k)%></td>
						<td><%=club_phone.get(k)%></td>
					</tr>
					<%
						}
					%>

				</tbody>
			</table>
		</div>
		<hr>
		<div id="footer">
			<jsp:include page="footer.jsp"></jsp:include>
		</div>
		<hr>
	</div>

	<script>
var tmpArr = new Array();
<%for (int q = 0; q < club_name.size(); q++) {%>
tmpArr[<%=q%>]='<%=club_name.get(q)%>';
<%}%>
var tmpArr2 = new Array();
<%for (int w = 0; w < club_x.size(); w++) {%>
tmpArr2[<%=w%>]='<%=club_x.get(w)%>';
<%}%>
var tmpArr3 = new Array();
<%for (int e = 0; e < club_y.size(); e++) {%>
tmpArr3[<%=e%>]='<%=club_y.get(e)%>';
<%}%>
</script>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8341261c4a8673a524c441e2ea3f9b04"></script>
	<script>
 var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
    mapOption = { 
        center: new daum.maps.LatLng(37.886297, 127.738137), // 지도의 중심좌표
        level: 5 // 지도의 확대 레벨
    };
var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
 
 var tmpArr4 = new Array();
 <%for (int r = 0; r < club_internet.size(); r++) {%>
 tmpArr4[<%=r%>]='<%=club_internet.get(r)%>';
	<%}%>
		var ad;
		var hi;
		hi = tmpArr4[0];
		//alert(hi);
		for ( var i in tmpArr4) {
			// 마커를 생성합니다

			var marker = new daum.maps.Marker({
				map : map, // 마커를 표시할 지도
				position : new daum.maps.LatLng(tmpArr2[i], tmpArr3[i]), // 마커의 위치

			});
			// 마커에 표시할 인포윈도우를 생성합니다 
			var infowindow = new daum.maps.InfoWindow({
				content : '<div>' + tmpArr[i] + '</div>' // 인포윈도우에 표시할 내용
			});
			// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
			// 이벤트 리스너로는 클로저를 만들어 등록합니다 
			// for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
			daum.maps.event.addListener(marker, 'mouseover', makeOverListener(
					map, marker, infowindow));
			daum.maps.event.addListener(marker, 'mouseout',
					makeOutListener(infowindow));
			daum.maps.event.addListener(marker, 'click', function(mouseEvent) {
				window.open('https://map.kakao.com/');

			});
		}
		// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
		function makeOverListener(map, marker, infowindow) {
			return function() {
				infowindow.open(map, marker);
			};
		}
		// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
		function makeOutListener(infowindow) {
			return function() {
				infowindow.close();
			};
		}
	</script>

</body>
</html>