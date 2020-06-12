<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<div class="main-visual-box">
		<div>
			<div class="main-visual-carousel-box carousel-wrap">
				<div class="main-visual-carousel owl-carousel owl-theme">
				<!-- 
					<c:import url="/app/board/miniBoard.do" charEncoding="utf-8">
						<c:param name="boardNo" value="1269" />
						<c:param name="count" value="3" />
						<c:param name="url" value="/grad/index.do" />
						<c:param name="view" value="/_custom/${clientId}/_common/miniboard/miniboard" />
						<c:param name="skin" value="main_visual" />
					</c:import>
				-->
					<div class="owl-stage-outer">
						<div class="owl-stage"
							style="transform: translate3d(-2062px, 0px, 0px); transition: all 0s ease 0s; width: 7217px;">
							<div class="owl-item cloned" style="width: 1031px;">
								<div class="item">
									<div class="main-visual-img-box">
										<img src="${pageContext.request.contextPath}/images/attach/iFetefBarIzWQYMkQxxW.jpg"
											alt="스포츠리그">
									</div>
								</div>
							</div>
							<div class="owl-item cloned" style="width: 1031px;">
								<div class="item">
									<div class="main-visual-img-box">
										<img src="${pageContext.request.contextPath}/images/attach/vxdNznaRZMPPdPcFRygu.jpg"
											alt="스포츠리그">
									</div>
								</div>
							</div>
							<div class="owl-item active" style="width: 1031px;">
								<div class="item">
									<div class="main-visual-img-box">
										<img src="${pageContext.request.contextPath}/images/attach/sItnBVShRLiwaeuPOgUf.jpg"
											alt="총장님 시상식">
									</div>
								</div>
							</div>
							<div class="owl-item" style="width: 1031px;">
								<div class="item">
									<div class="main-visual-img-box">
										<img src="${pageContext.request.contextPath}/images/attach/iFetefBarIzWQYMkQxxW.jpg"
											alt="스포츠리그">
									</div>
								</div>
							</div>
							<div class="owl-item" style="width: 1031px;">
								<div class="item">
									<div class="main-visual-img-box">
										<img src="${pageContext.request.contextPath}/images/attach/vxdNznaRZMPPdPcFRygu.jpg"
											alt="스포츠리그">
									</div>
								</div>
							</div>
							<div class="owl-item cloned" style="width: 1031px;">
								<div class="item">
									<div class="main-visual-img-box">
										<img src="${pageContext.request.contextPath}/images/attach/sItnBVShRLiwaeuPOgUf.jpg"
											alt="총장님 시상식">
									</div>
								</div>
							</div>
							<div class="owl-item cloned" style="width: 1031px;">
								<div class="item">
									<div class="main-visual-img-box">
										<img src="${pageContext.request.contextPath}/images/attach/iFetefBarIzWQYMkQxxW.jpg"
											alt="스포츠리그">
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="owl-nav disabled">
						<div class="owl-prev">prev</div>
						<div class="owl-next">next</div>
					</div>
					<div class="owl-dots">
						<div class="owl-dot active">
							<span></span>
						</div>
						<div class="owl-dot">
							<span></span>
						</div>
						<div class="owl-dot">
							<span></span>
						</div>
					</div>
				</div>
				<div class="control-wrap">
					<a class="prev" href="#"><span class="hide">prev</span></a>
					<a class="next" href="#"><span class="hide">next</span></a>
				</div>
				<!--
	   			<a href="#a" title="정지" class="mini-board-ctrl carousel-stop">
	 				<img src="/_res/template01/img/main/btn-banner-stop.png" alt="정지">
	 				<img src="/_res/template01/img/main/btn-banner-play.png" alt="재생">
	   			</a>
	   			-->
			</div>
			<div class="main-visual-lnk-box">
				<div>
					<ul>
						<li>
							<a href="/league/board/attendance.do" title="출석현황 바로가기">
								<p>
									출석현황
									<span>Guide to Course Registration</span>
								</p>
							</a>
						</li>
						<li>
							<a href="/league/board/program.do" title="MVP 바로가기">
								<p>
									MVP
								</p>
							</a>
						</li>
						<li>
							<a href="/league/board/video.do" title="경기영상 바로가기">
								<p>
									경기영상
									<span>Notice of Good Research</span>
								</p>
							</a>
						</li>
						<li>
							<a href="/league/board/notice.do" target="_blank" title="공지사항 바로가기">
								<p>
									공지사항
									<span>Course</span>
								</p>
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</body>
</html>