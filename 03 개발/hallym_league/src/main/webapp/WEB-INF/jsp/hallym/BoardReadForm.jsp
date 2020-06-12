<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@page import="hallym.league.user.vo.UserVO"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>게시판 &gt; Notice 게시판읽기&#40;농구게시판 테스트&#41; | 부서_인트라뮤럴</title>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    
    <!--css-->
    <link rel="canonical" href="http://league.hallym.ac.kr/league/board/notice.do" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/cms.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/league/css/layout.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/league/css/m-mn.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/css/toastr.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/css/ui.datepicker.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/css/jquery.ui-selectBox.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/board/css/board.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/board/css/type01.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/custom/css/board.common.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/league/css/user.css" />
    <link type="text/css" rel="stylesheet" charset="UTF-8" href="https://translate.googleapis.com/translate_static/css/translateelement.css">
    
    <!--js-->
    <script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery/jquery-ui-1.11.4.min.js"></script>
    <script defer="" type="text/javascript" src="https://translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
    <script type="text/javascript" charset="UTF-8" src="https://translate.googleapis.com/translate_static/js/element/main_ko.js"></script>
    <script type="text/javascript" charset="UTF-8" src="https://translate.googleapis.com/element/TE_20181015_01/e/js/element/element_main.js"></script>
    <script type="text/javascript">
    //<![CDATA[
        var _thisHost = location.protocol+'//'+location.host, _thisUrl = document.location.href
        ,_so_ = false,_cur_menu_cd = '4157',_edit_content = false,front_page_edit = true,zooInOutMode = 'font'
        ,_reouscePath = '/res/league/',editorVendor = 'froala',sslYN = 'N',sslPort = '8443',servicePort = ''
        ,developMode = false,device='pc',isMobile=false,_cfgUseDevMode = false,_siteId = 'league',printSelector = '#jwxe_main_content',ctx = ''
        ,rootPath = '',locale= 'ko',localeScriptPath='${pageContext.request.contextPath}/custom/js/';
    //]]>
    </script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/plugin/ckeditor/ckeditor.js"></script>

    <script type="text/javascript" src="${pageContext.request.contextPath}/common/cms.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/common/js/menu/menu.js"></script>	
    <script type="text/javascript" src="${pageContext.request.contextPath}/res/league/js/m-mn.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/common/js/toastr.js" ></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery-plugin/selectBox.min.js" ></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/custom/js/board.common.js" ></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/res/board/js/board.js" ></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/res/league/js/user.js"></script>

 	<script type="text/javascript">
 
	     function ListForm(){
	     	location.href="/BoardSearch.do";
	     }
     
	     function getSingleBoard(data1) {
	     	location.href="/BoardReadForm.do?&num=" + data1;
	     }
	     
	     function getDownLink(data1) {
	    	 var url = "/FileDownload.do?&num=";
	    	 var num = data1;
	    	 location.href = url + num;
	     }
	     
	     function getPage(data1, data2, data3, data4) {
	    	var urlpaging = "/BoardSearch.do?";
        	var page = data1; /* 페이지 번호 */
        	var opt = data2; /* 제목 및 작성자 검색 */
        	var opt2 = data3; /* 기간 검색 */
        	var condition = data4;
        	var link = urlpaging + "&page=" + page;
        	
        	if(opt == 1 || opt == 2) {
        		link += "&o1=" + opt + "&condition=" + (data4 == null)?"":condition;
        	} 
        	if(opt2 == 1) {
        		link += "&o2=" + opt2;
        	}
        	
        	location.href = link; 
         }
	     
	     
	     $(document).ready(function() {
        	var board_cd = "<%=session.getAttribute("board_cd") %>"
        	var sidemenu = document.querySelector("#item_body > div > div.sub-container > div.lnb-wrap > div > ul").getElementsByTagName('li');
        	var activeNum = 0;
        	for(var i=0; i<sidemenu.length; i++) {
        		if(sidemenu[i].className == "active") {
        			activeNum = i;
        			break;
        		}
        	}
        	var msg = "";
        	var msg2 = "";
        	var code = 0;
        	
    		sidemenu[activeNum].classList.remove('active');
    		sidemenu[activeNum].getElementsByTagName("a")[0].classList.remove("active");
        	switch(board_cd) {
        	case "007101":
        		msg = "공지사항";
        		msg2 = "게시판";
        		code = 1;
        		sidemenu[0].classList.add('active');
        		sidemenu[0].getElementsByTagName("a")[0].classList.add("active");
        		break;
        	case "007102":
        		msg = "Photos";
        		msg2 = "게시판";
        		code = 1;
        		sidemenu[1].classList.add('active');
        		sidemenu[1].getElementsByTagName("a")[0].classList.add("active");
        		break;
        	case "007103":
        		msg = "경기영상";
        		msg2 = "게시판";
        		code = 1;
        		sidemenu[2].classList.add('active');
        		sidemenu[2].getElementsByTagName("a")[0].classList.add("active");
        		break;
        	case "007104":
        		msg = "News";
        		msg2 = "게시판";
        		code = 1;
        		sidemenu[3].classList.add('active');
        		sidemenu[3].getElementsByTagName("a")[0].classList.add("active");
        		break;
        	case "007001":
        		msg = "축구";
        		msg2 = "참가 신청";
        		code = 2;
        		sidemenu[0].classList.add('active');
        		sidemenu[0].getElementsByTagName("a")[0].classList.add("active");
        		break;
        	case "007002":
        		msg = "농구";
        		msg2 = "참가 신청";
        		code = 2;
        		sidemenu[1].classList.add('active');
        		sidemenu[1].getElementsByTagName("a")[0].classList.add("active");
        		break;
        	case "007003":
        		msg = "야구";
        		msg2 = "참가 신청";
        		code = 2;
        		sidemenu[2].classList.add('active');
        		sidemenu[2].getElementsByTagName("a")[0].classList.add("active");
        		break;
        	case "007006":
        		msg = "족구";
        		msg2 = "참가 신청";
        		code = 2;
        		sidemenu[3].classList.add('active');
        		sidemenu[3].getElementsByTagName("a")[0].classList.add("active");
        		break;
        	case "007004":
        		msg = "배드민턴";
        		msg2 = "참가 신청";
        		code = 2;
        		sidemenu[4].classList.add('active');
        		sidemenu[4].getElementsByTagName("a")[0].classList.add("active");
        		break;
        	case "007010":
        		msg = "테니스";
        		msg2 = "참가 신청";
        		code = 2;
        		sidemenu[5].classList.add('active');
        		sidemenu[5].getElementsByTagName("a")[0].classList.add("active");
        		break;
        	case "007009":
        		msg = "피구";
        		msg2 = "참가 신청";
        		code = 2;
        		sidemenu[6].classList.add('active');
        		sidemenu[6].getElementsByTagName("a")[0].classList.add("active");
        		break;
        	case "007007":
        		msg = "풋살";
        		msg2 = "참가 신청";
        		code = 2;
        		sidemenu[7].classList.add('active');
        		sidemenu[7].getElementsByTagName("a")[0].classList.add("active");
        		break;
        	case "007008":
        		msg = "탁구";
        		msg2 = "참가 신청";
        		code = 2;
        		sidemenu[8].classList.add('active');
        		sidemenu[8].getElementsByTagName("a")[0].classList.add("active");
        		break;
        	/* 이벤트 리그 */
        	case "007207":
        		msg = "풋살";
        		msg2 = "이벤트 리그";
        		code = 2;
        		sidemenu[0].classList.add('active');
        		sidemenu[0].getElementsByTagName("a")[0].classList.add("active");
        		break;
        	case "007202":
        		msg = "길거리 농구";
        		msg2 = "이벤트 리그";
        		code = 2;
        		sidemenu[1].classList.add('active');
        		sidemenu[1].getElementsByTagName("a")[0].classList.add("active");
        		break;
        	default:
        		msg = "Null";
   				msg2 = "Null";
        		break;
        	}
        	document.querySelector("#item_body > div > div.sub-container > div.lnb-wrap > div > div > div > h2").innerText = msg2;
        	document.querySelector("#item_body > div > div.path-wrap > div > div > ul > li:nth-child(2)").innerText = msg2;
        	document.querySelector("#item_body > div > div.path-wrap > div > div > ul > li:nth-child(3)").innerText = msg;
        	document.querySelector("#item_body > div > div.sub-container > div.content-wrap > div.title > div > h3").innerText = msg;
        	
        });
 	</script>
 	<style>
 		/* 바깥 테두리 제거 */
		#cke_articleText {
			border: none;
		}
		
		/* 툴바 제거 */
	   .cke_inner .cke_top {
		    display: none;
		}
		
		/* 하단 태그 삭제 */
		#cke_1_bottom {
			display: none;
		}
		
	</style>
</head>
<body id="item_body" class="pc">
	<%
		UserVO cuserVO = null;
		String cuserId = null;
		if (session.getAttribute("userVO") != null) {
			cuserVO = (UserVO) session.getAttribute("userVO");
			cuserId = cuserVO.getId();
		}
	%>
    <ul id="go_main">
        <li><a href="#jwxe_main_content" >본문 바로가기</a></li>
        <li><a href="#jwxe_main_menu" >주메뉴 바로가기</a></li>
        <li><a href="#jwxe_sub_menu" >서브메뉴 바로가기</a></li>
    </ul>

    <div class="sub-wrap">
        <!--메뉴바-->
        <header>
			<div class="top-header-wrap"><jsp:include page="/WEB-INF/jsp/item/top-util.jsp"/></div>
			<div class="bottom-header-wrap"><jsp:include page="/WEB-INF/jsp/item/header.jsp"/></div>
		</header>
        <!--작은 바-->
        <div class="sub-visual-wrap"></div>
        <div class="path-wrap">
        	<div class="path-box">
          		<div class="jwxe_navigator jw-relative">
                	<ul>
                    	<li><a href="/index.do"><img src="images/common/ico-home.png" alt="home"></a></li>
	                    <li>게시판</li>
	                    <li>공지사항</li>
                 	</ul>
             	</div>
         	</div>
     	</div>
        <!--공지사항 보기-->
        <div class="sub-container">

            <!--왼쪽 게시판 메뉴-->
            <div class="lnb-wrap">
                <div class="lnb">
                    <div class="lnb-title-box">
                        <div>			
                            <h2>게시판</h2>
                        </div>
                    </div>
                    <ul class="lnb-menu jwxe-menu-ul">
                    <c:choose>
                    	<c:when test="${board_cd eq '007001' or board_cd eq '007002' or bard_cd eq '007003' or board_cd eq '07004'}">
                        <li class="active">
                            <a href="/BoardSearch.do?&bdc=007001" class="active">공지사항</a>
                        </li>
                        <li>
                            <a href="/BoardSearch.do?&bdc=007002">Photos</a>
                        </li>
                        <li>
                            <a href="/BoardSearch.do?&bdc=007003">경기영상</a>
                        </li>
                        <li>
                            <a href="/BoardSearch.do?&bdc=007004">News</a>
                        </li>
                        </c:when>
                        <c:otherwise>
                        	<li class="active"><a href="/BoardSearch.do?&bdc=007005001" class="active">축구</a></li>
							<li><a href="/BoardSearch.do?&bdc=007005002">농구</a></li>
							<li><a href="/BoardSearch.do?&bdc=007005003">야구</a></li>
							<li><a href="/BoardSearch.do?&bdc=007005006">족구</a></li>
							<li><a href="/BoardSearch.do?&bdc=007005004">배드민턴</a></li>
							<li><a href="/BoardSearch.do?&bdc=007005010">테니스</a></li>
							<li><a href="/BoardSearch.do?&bdc=007005009">피구</a></li>
							<li><a href="/BoardSearch.do?&bdc=007005007">풋살</a></li>
							<li><a href="/BoardSearch.do?&bdc=007005008">탁구</a></li>
                        
                        </c:otherwise>
                    </c:choose>
                    </ul>
                </div>
            </div>

        <!--본문-->
        <div class="content-wrap">
            <div class="title">
                <div class="jwxe_mnu_template jw-relative page-title" >
                    <h3>공지사항</h3>
                </div>
            </div>
            <div class="tab"></div>
            <div class="content" id="jwxe_main_content">
                <script type="text/javascript">
                //<![CDATA[
                    var resPath = '/_custom/hallym/resource/', isEditorImageUpload = 'true' == 'false'? false: true, 
                    clientId = 'hallym', boardTy = 'common', boardNo = '1267', siteId = 'league';
                //]]>
                </script>
                <div class="ko board view co-board type01">
                    <div class="bn-view-common01-box">
                        <div class="bn-view-common01 type01">
                            <input type="hidden" name="articleNo" value="30582" />
                            <div class="b-main-box">
                                <div class="b-top-box">
                                    <p class="b-title-box"><span>${searchBoard.TITLE}</span></p>
                                    <div class="b-etc-box">
                                        <ul>
                                            <li class="b-hit-box">
                                                <span>조회수</span>
                                                <span>${searchBoard.OPEN_CNT}</span>
                                            </li>
                                            <li class="b-writer-box">
                                                <span>작성자</span>
                                                <span>
	                                                <c:choose>
	                                              		<c:when test='${empty searchBoard.UPDATE_ID}'>
	                                              			${searchBoard.INPUT_ID}
	                                              		</c:when>
	                                              		<c:otherwise>
	                                              			${searchBoard.UPDATE_ID}
	                                              		</c:otherwise>
	                                              	</c:choose>
                                                </span>
                                            </li>
                                            <li class="b-date-box">
                                                <span>작성일</span>
                                                <span>
	                                                <c:choose>
	                                             		<c:when test='${empty searchBoard.UPDATE_DATE}'>
	                                             			<fmt:parseDate value="${searchBoard.INPUT_DATE}" var="tmp" pattern="yy-MM-dd" scope="page" />
	                                             			<fmt:formatDate value="${tmp}" pattern="yy.MM.dd" />
	                                             		</c:when>
	                                             		<c:otherwise>
	                                             			<fmt:parseDate value="${searchBoard.UPDATE_DATE}" var="tmp" pattern="yy-MM-dd" scope="page" />
	                                             			<fmt:formatDate value="${tmp}" pattern="yy.MM.dd" />
	                                             		</c:otherwise>
	                                             	</c:choose>
                                             	</span>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="b-content-box">
                                    <!--
                            	        <p><div class="fr-view"><p>${searchBoard.CONTENTS}</p></div></p>
                                   	-->
	                               	<p><div class="fr-view">
	                               		<textarea id="articleText" name="contents" class="b-input b-textarea jwvalid-must-contents ceditor" rows="10" cols="30" data-editor-height="500" style="height: 0px; border: none; position: absolute; left: -99999px;">${searchBoard.CONTENTS}</textarea>
	                               	</div></p>
                                </div>
                                
							<c:if test="${fileListCnt gt 0}">
                               	<div class="b-file-box">
									<ul>
										<c:forEach items='${fileList}' var="item">
										<li>
											<a class="file-down-btn pptx" href="javascript:getDownLink(${item.FILE_NO});">
												${item.FILE_NM}
											</a>
										</li>
										</c:forEach>
									</ul>
								</div>
                                <div class="b-etc-txt-box">
									<p class="b-etc-txt type01">"파일 명이 길 경우 브라우저 특성상 파일명이 잘릴 수 있습니다."</p>
								</div>
                            </c:if>
                            </div>
                            <div class="b-btn-wrap">
                       		<% if (cuserId != null) { %>
								<a class="b-btn-type01 b-btn-c-white" id="deleteArticle" href="/BoardDeleteForm.do?&num=${searchBoard.SEQ_NO}" data-confirm="viewBtn.delete.msg">삭제</a>
								<a class="b-btn-type01 b-btn-c-white" href="/BoardUpdateForm.do?&num=${searchBoard.SEQ_NO}">수정</a>
								<a class="b-btn-type01 b-btn-c-white" href="/BoardWriteForm.do">등록</a>
							<% } %>
								<a class="b-btn-type01 b-btn-c-blue" href="/BoardSearch.do">목록</a>
							</div>
                            <div class="b-pager-box">
                                <div>
                                    <p>이전글</p>
                                    <p>
                                    <c:choose>
                                    	<c:when test="${not empty prevBoard}">
                                        	<a href="javascript:getSingleBoard(${prevBoard.SEQ_NO});">
                                            	${prevBoard.TITLE}
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                        	<a href="#" title="이전글이 없습니다.">이전글이 없습니다.</a>
                                       	</c:otherwise>
                                    </c:choose>
                                    </p>
                                </div>
                                <div>
                                    <p>다음글</p>
                                    <p>
                                    <c:choose>
                                    	<c:when test="${not empty nextBoard}">
                                        	<a href="javascript:getSingleBoard(${nextBoard.SEQ_NO});">
                                            	${nextBoard.TITLE}
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                        	<a href="#" title="다음글이 없습니다.">다음글이 없습니다.</a>
                                        </c:otherwise>
                                    </c:choose>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <footer>
		<div class="top-footer-wrap"><jsp:include page="/WEB-INF/jsp/item/footer-top.jsp"/></div>
		<div class="bottom-footer-wrap"><jsp:include page="/WEB-INF/jsp/item/footer.jsp"/></div>
	</footer>
</div>
    <script type="text/javascript">
		CKEDITOR.replace( 'articleText', {
			removePlugins: 'toolbar',
			enterMode: '2',
		    shiftEnterMode: '3',
			readOnly: true
		} );
	</script>
	<noscript><p>이 사이트는 자바스크립트를 지원하지 않으면 정상적으로 보이지 않을수 있습니다.</p></noscript>
</body>
</html>
