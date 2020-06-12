<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<div class="main-content-box main-content-box01">
		<div class="main-mini-wrap">
			<div class="main-mini-box main-mini-box01">
				<h3 class="main-title">공지사항</h3>
				<div class="mini-board-content">
					<!-- 
					<c:import url="/app/board/miniBoard.do" charEncoding="utf-8">
						<c:param name="boardNo" value="1267" />
						<c:param name="count" value="7" />
						<c:param name="url" value="/league/board/notice.do" />
						<c:param name="view" value="/_custom/${clientId}/_common/miniboard/miniboard" />
						<c:param name="skin" value="common" />
					</c:import>
				-->
					<ul>
						<li><a class="articleTitle"
							href="/league/board/notice.do?mode=view&amp;articleNo=30582">
								<p>
									<span class="mini-title"> 농구게시판 테스트 </span>
								</p>
						</a> <span class="mini-date">2020.03.03</span></li>
						<li><a class="articleTitle"
							href="/league/board/notice.do?mode=view&amp;articleNo=30575">
								<p>
									<span class="mini-title"> 참가신청서 </span>
								</p>
						</a> <span class="mini-date">2020.03.03</span></li>
						<li><a class="articleTitle"
							href="/league/board/notice.do?mode=view&amp;articleNo=29586">
								<p>
									<span class="mini-title"> 공지사항 </span>
								</p>
						</a> <span class="mini-date">2020.01.29</span></li>
					</ul>
				</div>
				<a href="/BoardListForm.do" title="공지사항 더보기" class="viewmore">더보기</a>
			</div>
			<div class="main-mini-box main-mini-box02">
				<h3 class="main-title">PHOTO GALLERY</h3>
				<div>
					<!-- 
					<c:import url="/app/board/miniBoard.do" charEncoding="utf-8">
						<c:param name="boardNo" value="1268" />
						<c:param name="count" value="2" />
						<c:param name="url" value="/league/board/photos.do" />
						<c:param name="view" value="/_custom/${clientId}/_common/miniboard/miniboard" />
						<c:param name="skin" value="gallery" />
					</c:import>
				-->
					<ul>
						<li><a
							href="/league/board/photos.do?mode=view&amp;articleNo=30674"
							title="2019-2 Intramural League  자세히 보기">
								<div class="mini-img-box">
									<img
										src="${pageContext.request.contextPath}/images/attach/thumb_mRasDKPhqphyvoAavPZS.jpg"
										alt="키커 단체사진">
								</div>
								<div class="mini-txt-box">
									<p>2019-2 Intramural League</p>
								</div>
						</a></li>
						<li><a
							href="/league/board/photos.do?mode=view&amp;articleNo=30580"
							title="사진 테스트 333 자세히 보기">
								<div class="mini-img-box">
									<img
										src="${pageContext.request.contextPath}/images/attach/thumb_JhrYrgXGwZxTiCWavjXu.jpg"
										alt="리그 사진 테스트">
								</div>
								<div class="mini-txt-box">
									<p>사진 테스트 333</p>
								</div>
						</a></li>
					</ul>
				</div>
				<a href="/league/board/photos.do" title="PHOTO GALLERY 더보기" class="viewmore">더보기</a>
			</div>
		</div>
	</div>
</body>
</html>