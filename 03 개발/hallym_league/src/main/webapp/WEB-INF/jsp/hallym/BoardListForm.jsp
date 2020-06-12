<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@page import="hallym.league.user.vo.UserVO"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>게시판</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	    
	<!--link-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/cms.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/league/css/layout.css" /><!--  -->
	
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/league/css/m-mn.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/css/toastr.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/css/ui.datepicker.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/css/jquery.ui-selectBox.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/board/css/board.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/board/css/type01.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/custom/css/board.common.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/league/css/user.css">
	
	<!--script-->
	<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery/jquery-1.9.1.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery/jquery-ui-1.11.4.min.js"></script>
	<script defer type="text/javascript" src="//translate.google.com/translate_a/element.js?cd=googleTranslateElementInit"></script>
	<script type="text/javascript">
	   //<![CDATA[
	       var _thisHost = location.protocol+'//'+location.host, _thisUrl = document.location.href,_so_ = false
	       ,_cur_menu_cd = '4157',_edit_content = false,front_page_edit = true,zooInOutMode = 'font',_reouscePath = '/res/league/'
	       ,editorVendor = 'froala',sslYN = 'N',sslPort = '8443', servicePort = '',developMode = false,device='pc',isMobile=false
	       ,_cfgUseDevMode = false, _siteId = 'league',printSelector = '#jwxe_main_content',ctx = '',rootPath = ''
	       ,locale= 'ko', localeScriptPath='${pageContext.request.contextPath}/custom/js/';
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
	
	<script type="text/javascript">	        
	    function writeForm(){
	            location.href="/BoardWriteForm.do";   
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
	<!--style-->
	<style type='text/css'></style>

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
                        <li><a href="/index.do"><img src="images/common/ico-home.png" alt="home"></a></li>
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
                    
                    <c:choose>
                    	<c:when test="${(board_cd eq '007101') or (board_cd eq '007102') or (board_cd eq '007103') or (board_cd eq '007104')}">
	                        <li class="active"><a href="/BoardSearch.do?&bdc=007101" class="active">공지사항</a></li>
	                        <li><a href="/BoardSearch.do?&bdc=007102">Photos</a></li>
	                        <li><a href="/BoardSearch.do?&bdc=007103">경기영상</a></li>
	                        <li><a href="/BoardSearch.do?&bdc=007104">News</a></li>
                        </c:when>
                        <c:when test="${(board_cd eq '007202') or (board_cd eq '007207')}">
	                 		<li class="active"><a href="/BoardSearch.do?&bdc=007207" class="active">풋살</a></li>
							<li><a href="/BoardSearch.do?&bdc=007202">길거리 농구</a></li>
                        </c:when>
                        <c:otherwise>
                        	<li class="active"><a href="/BoardSearch.do?&bdc=007001" class="active">축구</a></li>
							<li><a href="/BoardSearch.do?&bdc=007002">농구</a></li>
							<li><a href="/BoardSearch.do?&bdc=007003">야구</a></li>
							<li><a href="/BoardSearch.do?&bdc=007006">족구</a></li>
							<li><a href="/BoardSearch.do?&bdc=007004">배드민턴</a></li>
							<li><a href="/BoardSearch.do?&bdc=007010">테니스</a></li>
							<li><a href="/BoardSearch.do?&bdc=007009">피구</a></li>
							<li><a href="/BoardSearch.do?&bdc=007007">풋살</a></li>
							<li><a href="/BoardSearch.do?&bdc=007008">탁구</a></li>
                        </c:otherwise>
                    </c:choose>
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
                                        	<select class="b-sel-title" name="o1">
                                        		<option class=searchOption value="0">전체</option>
								                <option class=searchOption value="1">제목</option>
								                <option class=searchOption value="2">작성자</option>
								            </select>
								        </div>
                                        <label for="search_val" class="b-sel-label"><span>검색어</span></label>
                                        <input type="text" id="search_val" name="cdn" value placeholder="검색어를 입력해 주세요">
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
									            		<c:when test='${item.FIX_YN eq "Y"}'>
									            			<img src="images/board/ico-notice01.png" border="0" valign="middle" alt="고정글">
									            		</c:when>
									            		<c:otherwise>
									            			${item.SEQ_NO}
									            		</c:otherwise>
									            	</c:choose>
									            </td>
									            <td class="b-td-left">
	                                                <div class="b-title-box">
	                                                    <a href="/BoardReadForm.do?num=${item.SEQ_NO}" title="${item.TITLE} 자세히 보기">
	                                                    	${item.TITLE}
	                                                    </a>
	                                                    <div class="b-etc-box"></div>
	                                                    <div class="b-m-con">
	                                                        <span class="b-writer">
	                                                        	<c:choose>
	                                                        		<c:when test='${empty item.UPDATE_ID}'>
	                                                        			${item.INPUT_ID}
	                                                        		</c:when>
	                                                        		<c:otherwise>
	                                                        			${item.UPDATE_ID}
	                                                        		</c:otherwise>
	                                                        	</c:choose>
	                                                        </span>
	                                                        <span class="b-date">
	                                                        	<c:choose>
	                                                        		<c:when test='${empty item.UPDATE_DATE}'>
	                                                        			<fmt:formatDate value="${item.INPUT_DATE}" pattern="yy.MM.dd" />
	                                                        		</c:when>
	                                                        		<c:otherwise>
	                                                        			<fmt:formatDate value="${item.UPDATE_DATE}" pattern="yy.MM.dd" />
	                                                        		</c:otherwise>
	                                                        	</c:choose>
	                                                        </span>
	                                                        <span class="hit">조회수 ${item.OPEN_CNT}</span>
	                                                    	<span class="b-file">첨부파일</span>
	                                                    </div>
	                                                </div>
	                                            </td>
	                                            <td>
	                                            	<c:choose>
                                                   		<c:when test='${empty item.UPDATE_ID}'>
                                                   			${item.INPUT_ID}
                                                   		</c:when>
                                                   		<c:otherwise>
                                                   			${item.UPDATE_ID}
                                                   		</c:otherwise>
                                                   	</c:choose>
	                                            </td>
	                                            <td>
													<c:choose>
                                                   		<c:when test='${empty item.UPDATE_DATE}'>
                                                   			<fmt:formatDate value="${item.INPUT_DATE}" pattern="yy.MM.dd" />
                                                   		</c:when>
                                                   		<c:otherwise>
                                                   			<fmt:formatDate value="${item.UPDATE_DATE}" pattern="yy.MM.dd" />
	                                                    </c:otherwise>
                                                   	</c:choose>
												</td>
	                                            <td>${item.OPEN_CNT}</td>
	                                            <td class="b-no-right">
	                                            	<c:choose>
									            		<c:when test='${item.ATTACH_YN eq "Y"}'>
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
								    	<c:if test="${boardListCount lt 1}">
									    	<tr>
												<td class="b-no-post" colspan="6">등록된 글이 없습니다.</td>
											</tr>
										</c:if>
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
													<a href="javascript:getPage(1,${opt},${opt2},${condition});" title="첫 페이지로 이동하기">
														<span class="hide">첫 페이지로 이동하기</span>
													</a>
												</li>
												<li class="prev pager">
													<a href="javascript:getPage(${prevPage},${opt},${opt2},${condition});" title="이전 페이지로 이동하기">
														<span class="hide">이전 페이지로 이동하기</span>
													</a>
												</li>
											</c:if>
											<c:forEach var="i" begin="1" end="${totalPage}">
												<li>
													<c:choose>
							                        	<c:when test="${i eq currPage}">
							                        		<a class="active" href="javascript:getPage(${i},${opt},${opt2},${condition});">${i}</a>
							                        	</c:when>
							                        	<c:otherwise>
							                        		<a class href="javascript:getPage(${i},${opt},${opt2},${condition});">${i}</a>
							                        	</c:otherwise>
							                        </c:choose>
						                        </li>
											</c:forEach>
											<c:if test="${totalPage > 1 and currPage ne nextPage}">
												<li class="next pager">
													<a href="javascript:getPage(${nextPage},${opt},${opt2},${condition});" title="다음 페이지로 이동하기">
														<span class="hide">다음 페이지로 이동하기</span>
													</a>
												</li>
												<li class="last pager">
													<a href="javascript:getPage(${totalPage},${opt},${opt2},${condition});" title="마지막 페이지로 이동하기">
														<span class="hide">마지막 페이지로 이동하기</span>
													</a>
												</li>
											</c:if>
										</ul>
									</div>
                                </div>
                            </div>
                            <!--공지사항2-->
                            <div class="b-btn-wrap">
                           	<% if (cuserId != null) { %>
                            	<a class="b-btn-type01 b-btn-c-blue" href="javascript:writeForm();">등록</a>
                            <% } %>
                            </div>
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