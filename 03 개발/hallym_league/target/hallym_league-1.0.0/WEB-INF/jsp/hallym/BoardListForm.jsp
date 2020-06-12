<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>게시판</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	    
	<!--link-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/cms.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/league/css/m-mn.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/css/toastr.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/css/ui.datepicker.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/css/jquery.ui-selectBox.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/board/css/board.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/board/css/type01.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/custom/css/board.common.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/league/css/user.css">
	<link rel="stylesheet" type="text/css" charset="UTF-8" href="https://translate.googleapis.com/translate_static/css/translateelement.css">
	<link rel="stylesheet" type="text/css" charset="UTF-8" href="https://translate.googleapis.com/translate_static/css/translateelement.css">
	 
	<!--script-->
	<script type="text/javascript" href="${pageContext.request.contextPath}/common/js/jquery/jquery-1.9.1.js"></script>
	<script type="text/javascript" href="${pageContext.request.contextPath}/common/js/jquery/jquery-ui-1.11.4.min.js"></script>
	<script defer type="text/javascript" src="//translate.google.com/translate_a/element.js?cd=googleTranslateElementInit"></script>
	<script type="text/javascript" charset="UTF-8" src="https://translate.googleapis.com/translate_static/js/element/main_ko.js"></script>
	<script type="text/javascript" charset="UTF-8" src="https://translate.googleapis.com/element/TE_20181015_01/e/js/element/element_main.js"></script>
	<script type="text/javascript">
	   //<![CDATA[
	       var _thisHost = location.protocol+'//'+location.host, 
	       _thisUrl = document.location.href,_so_ = false,_cur_menu_cd = '4157',
	       _edit_content = false,front_page_edit = true,zooInOutMode = 'font',_reouscePath = '${pageContext.request.contextPath}/res/league/',
	       editorVendor = 'froala',sslYN = 'N',sslPort = '8443',
	       servicePort = '',developMode = false,device='pc',isMobile=false,_cfgUseDevMode = false,
	       _siteId = 'league',printSelector = '#jwxe_main_content',ctx = '',rootPath = '',locale= 'ko',
	       localeScriptPath='${pageContext.request.contextPath}/custom/js/';
	   //]]>
	</script>
	<script type = "text/javascript" src="${pageContext.request.contextPath}/common/cms.js"></script>
	<script type = "text/javascript" src="${pageContext.request.contextPath}/common/js/control.js"></script>
	<script type = "text/javascript" src="${pageContext.request.contextPath}/common/js/menu/menu.js"></script>
	<script type = "text/javascript" src="${pageContext.request.contextPath}/res/league/js/m-mn.js"></script>
	<script type = "text/javascript" src="${pageContext.request.contextPath}/common/js/toastr.js"></script>
	<script type = "text/javascript" src="${pageContext.request.contextPath}/common/js/jquery-plugin/selectBox.min.js"></script>
	<script type = "text/javascript" src="${pageContext.request.contextPath}/custom/js/board.common.js"></script>
	<script type = "text/javascript" src="${pageContext.request.contextPath}/res/board/js/board.js"></script>
	<script type = "text/javascript" src="${pageContext.request.contextPath}/res/league/js/user.js"></script>
	<script type = "text/javascript" charset="UTF-8" src="https://translate.googleapis.com/translate_static/js/element/main_ko.js"></script>
	<script type = "text/javascript" charset="UTF-8" src="https://translate.googleapis.com/element/TE_20200210_00/e/js/element/element_main.js"></script>
	
	<script type="text/javascript">	        
	    function writeForm(){
	            location.href="/BoardWriteForm.do";   
	    }
        
        function getPage(data) {
            var urlpaging = "/BoardListForm.do?";
        	var page = data;
        	
        	location.href = urlpaging + "&page=" + page; 
        }
    </script>
	<!--style-->
	<style type='text/css'></style>

</head>
<body id="item_body" class="pc" style="position: relative; min-height: 100%; top: 0px;">
	<ul id="go_main">
		<li><a href="#jwxe_main_content">본문 바로가기</a></li>
	</ul>
	<div class="sub-wrap">
		<header>
			<div class="top-header-wrap"><jsp:include page="/WEB-INF/jsp/item/top-util.jsp"/></div>
			<div class="bottom-header-wrap"><jsp:include page="/WEB-INF/jsp/item/header.jsp"/></div>
		</header>
		<div class="sub-visual-wrap"></div>
        <div class="path-wrap">
            <div class="path-box">
                <div class="jwxe_navigator jw-relative">
                    <ul>
                        <li><a href="/leauge"><img src="images/common/ico-home.png" alt="home"></a></li>
                        <li>게시판</li>
                        <li>공지사항</li>
                    </ul>
                </div>
            </div>
        </div>
		<div class="sub-container">
			<!--메뉴바-->
            <div class="lnb-wrap">
                <div class="lnb">
                    <div class="lnb-title-box">
                        <div>
                            <h2>게시판</h2>
                        </div>
                    </div>
                    <ul class="lnb-menu jwxe-menu-ul">
                        <li class="active">
                            <a href="/league/board/notice.do" class="active">공지사항</a>
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
                </div>
            </div>
            <!--메뉴바-->
			<!--공지사항 본문-->
            <div class="content-wrap">
                <div class="title">
                    <div class="jwxe_mnu_template jw-relative page-title">
                        <h3>공지사항</h3>
                    </div>
                </div>
                
                <div class="tab"></div>
                <!--공지사항-->
                <div class="content" id="jwxe_main_content">
                    <script type="text/javascript">
                        //<![CDATA[
                          var resPath = '/_custom/hallym/resource/', isEditorImageUpload = 'true' == 'false'? false: true, 
                          clientId = 'hallym', boardTy = 'common', boardNo = '1267', siteId = 'league';
                        //]]>
                    </script>
                    <div class="ko board list co-board type01">
                        <div class="common">
                            <!--검색창-->
                            <div class="bn-search01 type01">
                                <form method="post" action="/BoardSearch.do" name="boardForm" enctype="multipart/form-data">
                                    <fieldset class="b-search-wrap">
                                        <legend class="hide">게시글 검색</legend>
                                        <input type="hidden" name="mode" value="list">
                                        <div class="b-sel-box b-cate-basic" style="z-index: 0;">
                                            <label for="search_key" class="hide">검색분류선택</label>
                                            <a href=#search class="b-sel-title">전체</a>
                                            <input type=hidden name=srSearchKey id=search_key value>
                                            <ul>
                                                <li class="selected">
                                                    <a href=#search class=searchOption title="전체" data-value>
                                                        전체
                                                    </a>
                                                </li>
                                                <li>
                                                    <a href=#search class=searchOption title=제목 data-value="article_title">
                                                        제목
                                                    </a>
                                                </li>
                                                <li>
                                                    <a href=#search class=searchOption title=내용 data-value="article_text">
                                                        내용
                                                    </a>
                                                </li>
                                                <li>
                                                    <a href=#search class=searchOption title=작성자 data-value="writer_nm">
                                                        작성자
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>
                                        <label for="search_val" class="b-sel-label"><span>검색어</span></label>
                                        <input type="text" id="search_val" name="condition" value placeholder="검색어를 입력해 주세요">
                                        <button type="submit" class="b-sel-btn">검색</button>
                                    </fieldset>
                                </form>
                            </div>
                            <!--검색창-->

                            <!--공지사항1-->
                            <div class="bn-list-common01 type01 bn-common bn-common">
                                <div class="b-top-info-wrap">
                                </div>
                                <table summary="게시판 > Notice" class=board-table>
                                    <caption class="hide">게시판 > Notice</caption>
                                    <colgroup>
                                        <col class="b-col01">
                                        <col class="b-col02">
                                        <col class="b-col03">
                                        <col class="b-col04">
                                        <col class="b-col05">
                                        <col class="b-col06">
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th scope="col">번호</th>
                                            <th scope="col">제목</th>
                                            <th scope="col">작성자</th>
                                            <th scope="col">작성일</th>
                                            <th scope="col" class="b-no-right">조회</th>
                                            <th scope="col">파일</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items='${boardList}' var="item" varStatus="status">
									        <tr class>
									            <td class="b-num-box" id="id_${status.count}">
									            	<c:choose>
									            		<c:when test='${item.BOARD_FIX eq "Y"}'>
									            			<img src="images/board/ico-notice01.png" border="0" valign="middle" alt="고정글">
									            		</c:when>
									            		<c:otherwise>
									            			${item.BOARD_NUM}
									            		</c:otherwise>
									            	</c:choose>
									            </td>
									            <td class="b-td-left">
	                                                <div class="b-title-box">
	                                                    <a href="/BoardReadForm.do?num=${item.BOARD_NUM}" title="${item.BOARD_SUBJECT} 자세히 보기">
	                                                    	${item.BOARD_SUBJECT}
	                                                    </a>
	                                                    <div class="b-etc-box"></div>
	                                                    <div class="b-m-con">
	                                                        <span class="b-writer">${item.BOARD_ID}</span>
	                                                        <span class="b-date">${item.BOARD_DATE}</span>
	                                                        <span class="hit">조회수 ${item.BOARD_COUNT}</span>
	                                                    	<span class="b-file">첨부파일</span>
	                                                    </div>
	                                                </div>
	                                            </td>
	                                            <td>${item.BOARD_ID}</td>
	                                            <td>${item.BOARD_DATE}</td>
	                                            <td>${item.BOARD_COUNT}</td>
	                                            <td class="b-no-right">
	                                            	<c:choose>
									            		<c:when test='${item.BOARD_FIX eq "Y"}'>
									            			<div class="b-file-box">
		                                                    	<span class="hide">첨부파일</span>
		                                                	</div>	
									            		</c:when>
									            		<c:otherwise>
									            			<span>-</span>
									            		</c:otherwise>
									            	</c:choose>
	                                            </td>
									        </tr>  
								    	</c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <!--공자사항1-->

                            <!--공지사항2-->
                            <div class="b-paging01 type03">
                                <div class="b-paging01 type01">
                                    <div class="b-paging-wrap">
										<ul>
											<c:if test="${totalPage > 1 and currPage ne prevPage}">
												<li class="first pager">
													<a href="javascript:getPage(1);" title="첫 페이지로 이동하기">
														<span class="hide">첫 페이지로 이동하기</span>
													</a>
												</li>
												<li class="prev pager">
													<a href="javascript:getPage(${prevPage});" title="이전 페이지로 이동하기">
														<span class="hide">이전 페이지로 이동하기</span>
													</a>
												</li>
											</c:if>
											<c:forEach var="i" begin="1" end="${totalPage}">
												<li>
													<c:choose>
							                        	<c:when test="${i eq currPage}">
							                        		<a class="active" href="javascript:getPage(${i});">${i}</a>
							                        	</c:when>
							                        	<c:otherwise>
							                        		<a class href="javascript:getPage(${i});">${i}</a>
							                        	</c:otherwise>
							                        </c:choose>
						                        </li>
											</c:forEach>
											<c:if test="${totalPage > 1 and currPage ne nextPage}">
												<li class="next pager">
													<a href="javascript:getPage(${nextPage});" title="다음 페이지로 이동하기">
														<span class="hide">다음 페이지로 이동하기</span>
													</a>
												</li>
												<li class="last pager">
													<a href="javascript:getPage(${totalPage});" title="마지막 페이지로 이동하기">
														<span class="hide">마지막 페이지로 이동하기</span>
													</a>
												</li>
											</c:if>
										</ul>
									</div>
                                </div>
                            </div>
                            <!--공지사항2-->
                            <div class="b-btn-wrap"></div>
                            <form name=admin-form method=post action="?article.offset=0&articleLimit=10">
                                <input type="hidden" name="method">
                                <input type="hidden" name="articles">
                                <input type="hidden" name="confirMode">
                            </form>
                        </div>
                    </div>
                </div>
                <!--공지사항-->

            </div>
            <!--공지사항 본문-->
		</div>
		<footer>
			<div class="top-footer-wrap"><jsp:include page="/WEB-INF/jsp/item/footer-top.jsp"/></div>
			<div class="bottom-footer-wrap"><jsp:include page="/WEB-INF/jsp/item/footer.jsp"/></div>
		</footer>
	</div>
</body>
</html>