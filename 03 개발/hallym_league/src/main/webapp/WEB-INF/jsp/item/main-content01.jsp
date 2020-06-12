<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
					<ul>
						<c:forEach items='${boardList}' var="item" varStatus="status">
							<li>
								<a class="articleTitle" href="/BoardReadForm.do?num=${item.SEQ_NO}">
								<p><span class="mini-title">
									<c:if test='${item.FIX_YN eq "Y"}'>
										[공지]
									</c:if>
									${item.TITLE}
								</span></p></a>
								<span class="mini-date">
									<c:choose>
                                 		<c:when test='${empty item.UPDATE_DATE}'>
                                 			<fmt:formatDate value="${item.INPUT_DATE}" pattern="yyyy.MM.dd" />
                                 		</c:when>
                                 		<c:otherwise>
                                 			<fmt:formatDate value="${item.UPDATE_DATE}" pattern="yyyy.MM.dd" />
                                 		</c:otherwise>
                                 	</c:choose>
								</span>
							</li>
						</c:forEach>
					</ul>
				</div>
				<a href="/BoardSearch.do?&bdc=007101" title="공지사항 더보기" class="viewmore">더보기</a>
			</div>
			<div class="main-mini-box main-mini-box02">
				<h3 class="main-title">PHOTO GALLERY</h3>
				<div>
					<ul>
						<li><a
							href="/BoardSearch.do?&bdc=007102"
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
							href="/BoardSearch.do?&bdc=007102"
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
				<a href="/BoardSearch.do?&bdc=007102" title="PHOTO GALLERY 더보기" class="viewmore">더보기</a>
			</div>
		</div>
	</div>
</body>
</html>