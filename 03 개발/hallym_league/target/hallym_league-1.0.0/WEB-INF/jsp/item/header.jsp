<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<div class="bottom-header-box">
		<a class="btn-menu" href="#a"><span class="hide">모바일 메뉴 열기</span></a>
		<h1>
			<a href="/${siteId}" title="한림대학교 일반대학원 바로가기">
				<img src="${pageContext.request.contextPath}/images/common/img-logo.png" alt="한림대학교">
				<span>Intramural League</span>
			</a>
		</h1>
		<!--
		<div class="gnb">
			<c:import url="/cms/menu/siteMap.do" charEncoding="utf-8">  
				<c:param name="view" value="/_custom/${clientId}/_common/menu/gnb/pc/gnb_type04" />
				<c:param name="depth" value="2" />
			</c:import>            
		</div>
		-->
		<div class="gnb">
			<ul class="gnb-ul jwxe-menu-ul">
				<li>
				 	<a title="소개" href="/league/newFolder/graduate/dean.do" class="">
				 		<span>소개</span>
				 	</a>
					<ul class="sub-mn" style="display: none;">
						<li>
							<a href="/league/newFolder/graduate/dean.do">Intramural League 소개</a>
						</li>
					</ul>
				</li>
				<li>
				 	<a title="참가 신청" href="/league/apply/soccer.do">
				 		<span>참가 신청</span>
				 	</a>
					<ul class="sub-mn" style="display: none;">
						<li>
							<a href="/league/apply/soccer.do">축구</a>
						</li>
						<li>
							<a href="/league/apply/basketball.do">농구</a>
						</li>
						<li>
							<a href="/league/apply/baseball.do">야구</a>
						</li>
						<li>
							<a href="/league/apply/jokgu.do">족구</a>
						</li>
						<li>
							<a href="/league/apply/badminton.do">배드민턴</a>
						</li>
						<li>
							<a href="/league/apply/Tennis.do">테니스</a>
						</li>
						<li>
							<a href="/league/apply/Dodgeball.do">피구</a>
						</li>
						<li>
							<a href="/league/apply/Futsal.do">풋살</a>
						</li>
						<li>
							<a href="/league/apply/Tabletennis.do">탁구</a>
						</li>
					</ul>
				</li>
				<li>
				 	<a title="경기 종목" href="/league/sports/Soccer/specialized.do">
				 		<span>경기 종목</span>
				 	</a>
					<ul class="sub-mn" style="display: none;">
						<li>
							<a href="/league/sports/Soccer/specialized.do">축구</a>
						</li>
						<li>
							<a href="/league/sports/Basketball/specialized.do">농구</a>
						</li>
						<li>
							<a href="/league/sports/Baseball/list.do">야구</a>
						</li>
						<li>
							<a href="/league/sports/Jokgu/list.do">족구</a>
						</li>
						<li>
							<a href="/league/sports/Badminton/list.do">배드민턴</a>
						</li>
						<li>
							<a href="/league/sports/Tennis/list.do">테니스</a>
						</li>
						<li>
							<a href="/league/sports/Dodgeball/list.do">피구</a>
						</li>
						<li>
							<a href="/league/sports/Futsal/list.do">풋살</a>
						</li>
						<li>
							<a href="/league/sports/Tabletennis/list.do">탁구</a>
						</li>
					</ul>
				</li>
				<li>
				 	<a title="참석현황" href="/league/attendance/attendance.do" class="">
				 		<span>참석현황</span>
				 	</a>
					<ul class="sub-mn" style="display: none;">
						<li>
							<a href="/league/attendance/attendance.do">출석 확인</a>
						</li>
					</ul>
				</li>
				<li>
				 	<a title="게시판" href="/league/board/notice.do" class="">
				 		<span>게시판</span>
				 			<span>notice</span>
				 	</a>
					<ul class="sub-mn" style="display: none;">
						<li>
							<a href="/league/board/notice.do">공지사항</a>
						</li>
						<li>
							<a href="/league/board/photos.do">Photos</a>
						</li>
						<li>
							<a href="/league/board/video.do">경기영상</a>
						</li>
						<li>
							<a href="/league/board/program.do">News</a>
						</li>
					</ul>
				</li>
			</ul>			
		</div>
	</div>
	<nav class="slideMenu">
	<div class="m-util">
		<ul>
			<li><a href="/${siteId}" title="home 바로가기">Home</a></li>
			<li><a href="#a" title="사이트맵 보기" class="sitemap-btn">Sitemap</a></li>
			<!-- 로그아웃 표시 추가 예정 -->
			<li class="login"><a href="login.do" class="login"
				title="Login">Login</a></li>
		</ul>
	</div>
	<!--
		<div class="m-gnb">
			<c:import url="/cms/menu/siteMap.do" charEncoding="utf-8">  
				<c:param name="view" value="/_custom/${clientId}/_common/menu/gnb/mobile/gnb_type01" />
				<c:param name="depth" value="3" />
			</c:import>
		</div>
		-->
	<div class="m-gnb">
		<ul class="dep1 jwxe-menu-ul">
			<li><a href="/league/newFolder/graduate/dean.do">소개</a>
				<ul class="dep2">
					<li><a href="/league/newFolder/graduate/dean.do">Intramural
							League 소개</a></li>
				</ul></li>
			<li><a href="/league/apply/soccer.do">참가 신청</a>
				<ul class="dep2">
					<li><a href="/league/apply/soccer.do">축구</a></li>
					<li><a href="/league/apply/basketball.do">농구</a></li>
					<li><a href="/league/apply/baseball.do">야구</a></li>
					<li><a href="/league/apply/jokgu.do">족구</a></li>
					<li><a href="/league/apply/badminton.do">배드민턴</a></li>
					<li><a href="/league/apply/Tennis.do">테니스</a></li>
					<li><a href="/league/apply/Dodgeball.do">피구</a></li>
					<li><a href="/league/apply/Futsal.do">풋살</a></li>
					<li><a href="/league/apply/Tabletennis.do">탁구</a></li>
				</ul></li>
			<li><a href="/league/sports/Soccer/specialized.do">경기 종목</a>
				<ul class="dep2">
					<li><a href="#nomenu" class="has-dep03-open">축구</a>
						<ul class="dep3">
							<li><a href="/league/sports/Soccer/specialized.do">참가자명단</a>
							</li>
							<li><a href="/league/sports/Soccer/groups.do">조별 현황</a></li>
							<li><a href="/league/schedule/Soccer/soccer_schedule.do">경기
									일정 및 결과</a></li>
							<li><a href="/league/sports/Soccer/notice.do">축구 게시판</a></li>
						</ul></li>
					<li><a href="#nomenu" class="has-dep03-open">농구</a>
						<ul class="dep3">
							<li><a href="/league/sports/Basketball/specialized.do">참가자명단</a>
							</li>
							<li><a href="/league/sports/Basketball/groups.do">조별현황</a></li>
							<li><a href="/league/schedule/Basketball/schedule.do">경기
									일정 및 결과</a></li>
							<li><a href="/league/sports/Basketball/notice.do">농구 게시판</a>
							</li>
						</ul></li>
					<li><a href="#nomenu" class="has-dep03-open">야구</a>
						<ul class="dep3">
							<li><a href="/league/sports/Baseball/list.do">참가자명단</a></li>
							<li><a href="/league/sports/Baseball/groups.do">조별현황</a></li>
							<li><a href="/league/schedule/Baseball/schedule.do">경기
									일정 및 결과</a></li>
							<li><a href="/league/sports/Baseball/notice.do">야구 게시판</a></li>
						</ul></li>
					<li><a href="#nomenu" class="has-dep03-open">족구</a>
						<ul class="dep3">
							<li><a href="/league/sports/Jokgu/list.do">참가자명단</a></li>
							<li><a href="/league/sports/Jokgu/groups.do">조별현황</a></li>
							<li><a href="/league/schedule/Jokgu/schedule.do">경기 일정 및
									결과</a></li>
							<li><a href="/league/sports/Jokgu/notice.do">족구 게시판</a></li>
						</ul></li>
					<li><a href="#nomenu" class="has-dep03-open">배드민턴</a>
						<ul class="dep3">
							<li><a href="/league/sports/Badminton/list.do">참가자명단</a></li>
							<li><a href="/league/sports/Badminton/groups.do">조별현황</a></li>
							<li><a href="/league/schedule/Badminton/schedule.do">경기
									일정 및 결과</a></li>
							<li><a href="/league/sports/Badminton/notice.do">배드민턴
									게시판</a></li>
						</ul></li>
					<li><a href="#nomenu" class="has-dep03-open">테니스</a>
						<ul class="dep3">
							<li><a href="/league/sports/Tennis/list.do">참가자명단</a></li>
							<li><a href="/league/sports/Tennis/groups.do">조별현황</a></li>
							<li><a href="/league/schedule/Tennis/schedule.do">경기 일정
									및 결과</a></li>
							<li><a href="/league/sports/Tennis/notice.do">테니스 게시판</a></li>
						</ul></li>
					<li><a href="#nomenu" class="has-dep03-open">피구</a>
						<ul class="dep3">
							<li><a href="/league/sports/Dodgeball/list.do">참가자명단</a></li>
							<li><a href="/league/sports/Dodgeball/groups.do">조별현황</a></li>
							<li><a href="/league/schedule/Dodgeball/schedule.do">경기
									일정 및 결과</a></li>
							<li><a href="/league/sports/Dodgeball/notice.do">피구 게시판</a>
							</li>
						</ul></li>
					<li><a href="#nomenu" class="has-dep03-open">풋살</a>
						<ul class="dep3">
							<li><a href="/league/sports/Futsal/list.do">참가자명단</a></li>
							<li><a href="/league/sports/Futsal/groups.do">조별현황</a></li>
							<li><a href="/league/schedule/Futsal/schedule.do">경기 일정
									및 결과</a></li>
							<li><a href="/league/sports/Futsal/notice.do">풋살 게시판</a></li>
						</ul></li>
					<li><a href="#nomenu" class="has-dep03-open">탁구</a>
						<ul class="dep3">
							<li><a href="/league/sports/Tabletennis/list.do">참가자명단</a></li>
							<li><a href="/league/sports/Tabletennis/groups.do">조별현황</a>
							</li>
							<li><a href="/league/schedule/Tabletennis/schedule.do">경기
									일정 및 결과</a></li>
							<li><a href="/league/sports/Tabletennis/notice.do">탁구
									게시판</a></li>
						</ul></li>
				</ul></li>
			<li><a href="/league/attendance/attendance.do">참석현황</a>
				<ul class="dep2">
					<li><a href="/league/attendance/attendance.do">출석 확인</a></li>
				</ul></li>
			<li><a href="/league/board/notice.do">게시판</a>
				<ul class="dep2">
					<li><a href="/league/board/notice.do">공지사항</a></li>
					<li><a href="/league/board/photos.do">Photos</a></li>
					<li><a href="/league/board/video.do">경기영상</a></li>
					<li><a href="/league/board/program.do">News</a></li>
				</ul></li>
		</ul>
	</div>
	</nav>
	<a href="#a" class="slide-close"><span class="hide">모바일 메뉴
			닫기</span></a>
	<div class="m-gnb-bg">&nbsp;</div>
	<!-- 사이트 맵 -->
	<div class="sitemap-wrap">
		<div class="sitemap-box">
			<!--
			<c:import url="/cms/menu/siteMap.do" charEncoding="utf-8">  
				<c:param name="view" value="/_custom/${clientId}/_common/site-map/site_map" />
			</c:import>
		-->
			<ul>
				<li id="menu_4137" class="depth_1 first"><a
					href="/league/newFolder/graduate/dean.do" class="depth_1 ">소개</a>
					<ul class="depth_2">
						<li id="menu_4142" class="depth_2 first"><a
							href="/league/newFolder/graduate/dean.do" class="depth_2 ">Intramural
								League 소개</a></li>
					</ul></li>
				<li id="menu_4138" class="depth_1"><a
					href="/league/apply/soccer.do" class="depth_1 ">참가 신청</a>
					<ul class="depth_2">
						<li id="menu_4146" class="depth_2 first"><a
							href="/league/apply/soccer.do" class="depth_2 ">축구</a></li>
						<li id="menu_4435" class="depth_2"><a
							href="/league/apply/basketball.do" class="depth_2 ">농구</a></li>
						<li id="menu_4436" class="depth_2"><a
							href="/league/apply/baseball.do" class="depth_2 ">야구</a></li>
						<li id="menu_4437" class="depth_2"><a
							href="/league/apply/jokgu.do" class="depth_2 ">족구</a></li>
						<li id="menu_4438" class="depth_2"><a
							href="/league/apply/badminton.do" class="depth_2 ">배드민턴</a></li>
						<li id="menu_4439" class="depth_2"><a
							href="/league/apply/Tennis.do" class="depth_2 ">테니스</a></li>
						<li id="menu_4440" class="depth_2"><a
							href="/league/apply/Dodgeball.do" class="depth_2 ">피구</a></li>
						<li id="menu_4441" class="depth_2"><a
							href="/league/apply/Futsal.do" class="depth_2 ">풋살</a></li>
						<li id="menu_4442" class="depth_2"><a
							href="/league/apply/Tabletennis.do" class="depth_2 ">탁구</a></li>
					</ul></li>
				<li id="menu_4134" class="depth_1"><a
					href="/league/sports/Soccer/specialized.do" class="depth_1 ">경기
						종목</a>
					<ul class="depth_2">
						<li id="menu_4443" class="depth_2 first"><a
							href="/league/sports/Soccer/specialized.do" class="depth_2 ">축구</a>
							<ul class="depth_3">
								<li id="menu_4448" class="depth_3 first"><a
									href="/league/sports/Soccer/specialized.do" class="depth_3 ">참가자명단</a></li>
								<li id="menu_4449" class="depth_3"><a
									href="/league/sports/Soccer/groups.do" class="depth_3 ">조별
										현황</a></li>
								<li id="menu_4150" class="depth_3"><a
									href="/league/schedule/Soccer/soccer_schedule.do"
									class="depth_3 ">경기 일정 및 결과</a></li>
								<li id="menu_4451" class="depth_3"><a
									href="/league/sports/Soccer/notice.do" class="depth_3 ">축구
										게시판</a></li>
							</ul></li>
						<li id="menu_4444" class="depth_2"><a
							href="/league/sports/Basketball/specialized.do" class="depth_2 ">농구</a>
							<ul class="depth_3">
								<li id="menu_4456" class="depth_3 first"><a
									href="/league/sports/Basketball/specialized.do"
									class="depth_3 ">참가자명단</a></li>
								<li id="menu_4457" class="depth_3"><a
									href="/league/sports/Basketball/groups.do" class="depth_3 ">조별현황</a></li>
								<li id="menu_4458" class="depth_3"><a
									href="/league/schedule/Basketball/schedule.do" class="depth_3 ">경기
										일정 및 결과</a></li>
								<li id="menu_4459" class="depth_3"><a
									href="/league/sports/Basketball/notice.do" class="depth_3 ">농구
										게시판</a></li>
							</ul></li>
						<li id="menu_4445" class="depth_2"><a
							href="/league/sports/Baseball/list.do" class="depth_2 ">야구</a>
							<ul class="depth_3">
								<li id="menu_4460" class="depth_3 first"><a
									href="/league/sports/Baseball/list.do" class="depth_3 ">참가자명단</a></li>
								<li id="menu_4461" class="depth_3"><a
									href="/league/sports/Baseball/groups.do" class="depth_3 ">조별현황</a></li>
								<li id="menu_4462" class="depth_3"><a
									href="/league/schedule/Baseball/schedule.do" class="depth_3 ">경기
										일정 및 결과</a></li>
								<li id="menu_4463" class="depth_3"><a
									href="/league/sports/Baseball/notice.do" class="depth_3 ">야구
										게시판</a></li>
							</ul></li>
						<li id="menu_4446" class="depth_2"><a
							href="/league/sports/Jokgu/list.do" class="depth_2 ">족구</a>
							<ul class="depth_3">
								<li id="menu_4465" class="depth_3 first"><a
									href="/league/sports/Jokgu/list.do" class="depth_3 ">참가자명단</a></li>
								<li id="menu_4466" class="depth_3"><a
									href="/league/sports/Jokgu/groups.do" class="depth_3 ">조별현황</a></li>
								<li id="menu_4467" class="depth_3"><a
									href="/league/schedule/Jokgu/schedule.do" class="depth_3 ">경기
										일정 및 결과</a></li>
								<li id="menu_4468" class="depth_3"><a
									href="/league/sports/Jokgu/notice.do" class="depth_3 ">족구
										게시판</a></li>
							</ul></li>
						<li id="menu_4447" class="depth_2"><a
							href="/league/sports/Badminton/list.do" class="depth_2 ">배드민턴</a>
							<ul class="depth_3">
								<li id="menu_4469" class="depth_3 first"><a
									href="/league/sports/Badminton/list.do" class="depth_3 ">참가자명단</a></li>
								<li id="menu_4470" class="depth_3"><a
									href="/league/sports/Badminton/groups.do" class="depth_3 ">조별현황</a></li>
								<li id="menu_4471" class="depth_3"><a
									href="/league/schedule/Badminton/schedule.do" class="depth_3 ">경기
										일정 및 결과</a></li>
								<li id="menu_4472" class="depth_3"><a
									href="/league/sports/Badminton/notice.do" class="depth_3 ">배드민턴
										게시판</a></li>
							</ul></li>
						<li id="menu_4452" class="depth_2"><a
							href="/league/sports/Tennis/list.do" class="depth_2 ">테니스</a>
							<ul class="depth_3">
								<li id="menu_4473" class="depth_3 first"><a
									href="/league/sports/Tennis/list.do" class="depth_3 ">참가자명단</a></li>
								<li id="menu_4474" class="depth_3"><a
									href="/league/sports/Tennis/groups.do" class="depth_3 ">조별현황</a></li>
								<li id="menu_4475" class="depth_3"><a
									href="/league/schedule/Tennis/schedule.do" class="depth_3 ">경기
										일정 및 결과</a></li>
								<li id="menu_4476" class="depth_3"><a
									href="/league/sports/Tennis/notice.do" class="depth_3 ">테니스
										게시판</a></li>
							</ul></li>
						<li id="menu_4453" class="depth_2"><a
							href="/league/sports/Dodgeball/list.do" class="depth_2 ">피구</a>
							<ul class="depth_3">
								<li id="menu_4477" class="depth_3 first"><a
									href="/league/sports/Dodgeball/list.do" class="depth_3 ">참가자명단</a></li>
								<li id="menu_4478" class="depth_3"><a
									href="/league/sports/Dodgeball/groups.do" class="depth_3 ">조별현황</a></li>
								<li id="menu_4479" class="depth_3"><a
									href="/league/schedule/Dodgeball/schedule.do" class="depth_3 ">경기
										일정 및 결과</a></li>
								<li id="menu_4480" class="depth_3"><a
									href="/league/sports/Dodgeball/notice.do" class="depth_3 ">피구
										게시판</a></li>
							</ul></li>
						<li id="menu_4454" class="depth_2"><a
							href="/league/sports/Futsal/list.do" class="depth_2 ">풋살</a>
							<ul class="depth_3">
								<li id="menu_4481" class="depth_3 first"><a
									href="/league/sports/Futsal/list.do" class="depth_3 ">참가자명단</a></li>
								<li id="menu_4482" class="depth_3"><a
									href="/league/sports/Futsal/groups.do" class="depth_3 ">조별현황</a></li>
								<li id="menu_4483" class="depth_3"><a
									href="/league/schedule/Futsal/schedule.do" class="depth_3 ">경기
										일정 및 결과</a></li>
								<li id="menu_4484" class="depth_3"><a
									href="/league/sports/Futsal/notice.do" class="depth_3 ">풋살
										게시판</a></li>
							</ul></li>
						<li id="menu_4455" class="depth_2"><a
							href="/league/sports/Tabletennis/list.do" class="depth_2 ">탁구</a>
							<ul class="depth_3">
								<li id="menu_4485" class="depth_3 first"><a
									href="/league/sports/Tabletennis/list.do" class="depth_3 ">참가자명단</a></li>
								<li id="menu_4486" class="depth_3"><a
									href="/league/sports/Tabletennis/groups.do" class="depth_3 ">조별현황</a></li>
								<li id="menu_4487" class="depth_3"><a
									href="/league/schedule/Tabletennis/schedule.do"
									class="depth_3 ">경기 일정 및 결과</a></li>
								<li id="menu_4488" class="depth_3"><a
									href="/league/sports/Tabletennis/notice.do" class="depth_3 ">탁구
										게시판</a></li>
							</ul></li>
					</ul></li>
				<li id="menu_4139" class="depth_1"><a
					href="/league/attendance/attendance.do" class="depth_1 ">참석현황</a>
					<ul class="depth_2">
						<li id="menu_4491" class="depth_2 first"><a
							href="/league/attendance/attendance.do" class="depth_2 ">출석
								확인</a></li>
					</ul></li>
				<li id="menu_4141" class="depth_1"><a
					href="/league/board/notice.do" class="depth_1 ">게시판</a>
					<ul class="depth_2">
						<li id="menu_4157" class="depth_2 first"><a
							href="/league/board/notice.do" class="depth_2 ">공지사항</a></li>
						<li id="menu_4131" class="depth_2"><a
							href="/league/board/photos.do" class="depth_2 ">Photos</a></li>
						<li id="menu_4133" class="depth_2"><a
							href="/league/board/video.do" class="depth_2 ">경기영상</a></li>
						<li id="menu_4130" class="depth_2"><a
							href="/league/board/program.do" class="depth_2 ">News</a></li>
					</ul></li>
			</ul>
			<a href="#" title="닫기" class="sitemap-close"> <img
				src="${pageContext.request.contextPath}/images/board/btn-sitemap-close.png"
				alt="닫기">
			</a>
		</div>
	</div>
	<!-- //사이트 맵 -->
</body>
</html>