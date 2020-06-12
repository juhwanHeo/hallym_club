<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="hallym.league.user.vo.UserVO"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>게시판 - 글쓰기</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">

    <!--css-->
    <link rel="canonical" href="http://league.hallym.ac.kr/league/apply/soccer.do">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/cms.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/league/css/layout.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/league/css/m-mn.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/css/toastr.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/css/ui.datepicker.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/css/jquery.ui-selectBox.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/test/common/js/jquery-plugin/tag/css/jquery.tagit.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/test/common/js/jquery-plugin/tag/css/tagit.ui-zendesk.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/board/css/board.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/board/css/type01.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/custom/css/board.common.css">
    <link type="text/css" rel="stylesheet" charset="UTF-8" href="https://translate.googleapis.com/translate_static/css/translateelement.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/league/css/user.css">
	<link type="text/css" rel="stylesheet" charset="UTF-8" href="https://translate.googleapis.com/translate_static/css/translateelement.css">
       
    <!--js-->
    <script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery/jquery-ui-1.11.4.min.js"></script>
    
    <script defer="" type="text/javascript" src="https://translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
    <script type="text/javascript" charset="UTF-8" src="https://translate.googleapis.com/translate_static/js/element/main_ko.js"></script>
    <script type="text/javascript" charset="UTF-8" src="https://translate.googleapis.com/element/TE_20181015_01/e/js/element/element_main.js"></script>
    <script type="text/javascript">
       //<![CDATA[
		var _thisHost = location.protocol+'//'+location.host, _thisUrl = document.location.href,_so_ = false
		,_cur_menu_cd = '4146',_edit_content = false,front_page_edit = true,zooInOutMode = 'font',_reouscePath = '/_res/league/'
		,editorVendor = '',sslYN = 'N',sslPort = '8443',servicePort = '',developMode = false,device='pc',isMobile=false
		,_cfgUseDevMode = false,_siteId = 'league',printSelector = '#jwxe_main_content',ctx = '',rootPath = '',locale= 'ko'
		,localeScriptPath='${pageContext.request.contextPath}/custom/js/';
       //]]>
  	</script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/plugin/ckeditor/ckeditor.js"></script>
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/common/cms.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/control.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/common/js/menu/menu.js"></script>	
    <script type="text/javascript" src="${pageContext.request.contextPath}/res/league/js/m-mn.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/common/js/toastr.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery-plugin/selectBox.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/custom/js/board.common.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/test/common/js/jquery-plugin/tag/tag-it.min.2.0.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/test/common/js/jquery-plugin/tag/jquery.autosize.input.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/test/custom/js/board.write.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/test/common/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/res/board/js/board.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/res/league/js/user.js"></script>
	<script type="text/javascript" charset="UTF-8" src="https://translate.googleapis.com/translate_static/js/element/main_ko.js"></script>
	<script type="text/javascript" charset="UTF-8" src="https://translate.googleapis.com/element/TE_20200506_00/e/js/element/element_main.js"></script>
	
	
    <script type="text/javascript">
        function ListForm(){
            location.href="/BoardSearch.do";
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
    /*
		.ck-editor__editable {
			min-height: 400px;
			max-height: 500px;
		}
		
		.ck.ck-editor__editable:not(.ck-editor__nested-editable).ck-focused {
	    	width: auto;
		}
		
		.ck.ck-editor__main>.ck-editor__editable:not(.ck-focused) {
	    	width: auto;
		}
		*/
	</style>
</head>
<body id="item_body" class="pc" style="position: relative; min-height: 100%; top: 0px;">
	<%
		UserVO userVO = null;
		String userId = null;
		String board_cd = null;
		if (session.getAttribute("userVO") != null) {
			userVO = ((UserVO) session.getAttribute("userVO"));
			userId = userVO.getId();
			board_cd = (String) session.getAttribute("board_cd");
		}
		if (userId == null) {
			out.println("<script>");
			out.println("alert('로그인이 필요한 서비스입니다.')");
			out.println("location.href='login.do'");
			out.println("window.close();");
			out.println("</script>");
		} else {
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
                    <div class="ko board write co-board type01">
	                    <div class="bn-write-common01 type01">
	                        <!-- 사용여부를  게시판 수정시 기타 설정에서 선택할수 있는 필드  -->
	                        <form method="post" action="/BoardWriteAction.do" name="boardForm" enctype="multipart/form-data">
	                            <fieldset>
	                                <legend class="hide">공지사항 게시판 작성</legend>
	                                <input type="hidden" name="csrfToken" value="cryjsjscbszhtaostgll">
	                                <input type="hidden" name="articleNo" value="">
	                                <input type="hidden" name="parentNo" value="0">
	                                <input type="hidden" name="htmlYn" value="Y">
	                                <div class="b-table-wrap">
	                                    <!--제목-->
	                                    <div class="b-table-box type01 b-subject-box">
	                                        <div class="b-row-box">
	                                            <div class="b-title-box b-required">
	                                                <label for="articleTitle">제목</label>
	                                            </div>
	                                            <div class="b-con-box">
	                                                <input class="jwvalid-must-title b-input type01" type="text" id="articleTitle" name="title" value="" maxlength="120">
	                                            </div>
	                                        </div>
	                                    </div>
	        
	                                    <!--비밀번호-->
	                                    <!-- 
	                                    <div class="b-table-box type01">
	                                        <div class="b-row-box">
	                                            <div class="b-title-box b-required">
	                                                <label for="writerPw">비밀번호</label>
	                                            </div>  
	                                            <div class="b-con-box">
	                                                <div class="b-password-box">
	                                                    <input type="password" id="writerPw" name="writerPw" maxlength="4" class="jwvalid-must-pwd b-input type01">
	                                                    <span>비밀번호 4자리를 숫자로 입력해주세요</span>
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
										-->
										<div class="b-table-box type01">
	                                        <div class="b-row-box">
	                                            <div class="b-title-box b-required">
	                                                <label for="fix_yn">고정 게시글</label>
	                                            </div>  
	                                            <div class="b-con-box">
                                                    <input type="checkbox" id="fix_yn" name="fix_yn" value="Y">
                                                    <span>상단 고정 게시글로 등록합니다.</span>
	                                            </div>
	                                        </div>
	                                    </div>
	                                    <!--작성자-->
	                                    <div class="b-table-box type01">
	                                        <div class="b-row-box">
	                                            <div class="b-title-box b-required">
	                                               	 작성자
	                                            </div>
	                                            <div class="b-con-box">
	                                                <label for="writerNm" class="hide">작성자</label>
	                                                <input data-valid-title="작성자" class="jwvalid-must b-input type02" type="text" id="writerNm" name="writer" value="<%=userId%>">
	                                            </div>    
	                                        </div>
	                                    </div>
	
	                                    <!--내용-->
	                                    <div class="b-table-box type01">
	                                        <div class="b-row-box">
	                                            <div class="b-title-box b-required">
	                                                <label for="articleText">내용</label>
	                                            </div>  
	                                            <div class="b-con-box">
	                                                <textarea id="articleText" name="contents" class="b-input b-textarea jwvalid-must-contents ceditor" rows="10" cols="30" data-editor-height="500" style="height: 0px; border: none; position: absolute; left: -99999px;"></textarea>
	                                            	
	                                            </div>                                  
	                                        </div>
	                                    </div>
	
	                                    <!--첨부파일-->
	                                    <div class="b-table-box type01">
	                                        <div class="b-row-box">
	                                            <div class="b-title-box">첨부파일</div>
	                                            <div class="b-con-box02">
	                                                <div class="b-file-box type01">
	                                                    <div>
	                                                        <select id="attachCnt" class="attach-select b-select">
	                                                            <option value="1">1</option>
	                                                            <option value="2">2</option>
	                                                            <option value="3">3</option>
	                                                            <option value="4">4</option>
	                                                            <option value="5">5</option>
	                                                            <option value="6">6</option>
	                                                            <option value="7">7</option>
	                                                            <option value="8">8</option>
	                                                            <option value="9">9</option>
	                                                            <option value="10">10</option>
	                                                        </select>
	                                                        <p class="b-guide-txt">
	                                                            <label for="attachCnt">파일 갯수를 지정해 주십시오. </label> 
	                                                            <br class="pc-hide">[파일1개 당 00MB 이하 업로드]
	                                                            <span class="privacy">※ 개인정보 업로드 금지</span>
	                                                        </p>
	                                                    </div>
	                                                </div>
	                                                
	                                                <c:forEach var="fnum" begin="1" end="10">
	                                                <div class="b-file-box type03 file-list" 
		                                                <c:choose>
		                                                	<c:when test="${fnum eq 1}">
		                                                		style="display: block;"
		                                                	</c:when>
		                                                	<c:otherwise>
		                                                		style="display: none;"
		                                                	</c:otherwise>
		                                                </c:choose>
	                                                >
	                                                    <div>
	                                                        <div>
	                                                            <input type="text" id="file_view${fnum}" name="wr-file-name" class="b-input" placeholder="첨부파일을 등록하세요" readonly="">  <!--  name="wr-file-name" -->
	                                                            <input class="outTable thumb hide  " type="file" id="file_nm${fnum}" name="attachFile" onchange="javascript:document.getElementById('file_view${fnum}').value = this.value;">
	                                                            <label for="file_nm${fnum}" class="b-file-btn">찾아보기</label>
	                                                        </div>
	                                                        <div class="b-guide-box">
	                                                            <label class="b-guide-txt hide" for="fileAlt${fnum}">대체 텍스트 </label>
	                                                            <input data-valid-title="대체텍스트" class="b-input file-alt" type="text" id="fileAlt${fnum}" name="attachImageAlt" placeholder="대체텍스트를 입력해주세요.">
	                                                        </div>
	                                                    </div>
	                                                </div>
	                                                </c:forEach>
	                                                
	                                            </div>
	                                        </div>
	                                    </div>
	
	                                    <!-- 보안 문자 -->
	
	                                    <!--개인정보 보호 동의-->
	                                    <div class="b-table-box type01">
	                                        <div class="b-row-box">
	                                            <div class="b-title-box b-required">
	                                                <label>개인정보 보호 동의</label>
	                                            </div>
	                                            <div class="personal_info b-con-box">
	                                                <ul>
	                                                    <li>개인정보보호법 제 15조에 의한 <span>개인정보 수집·이용 동의</span></li>
	                                                    <li>고객님의 개인정보를 아래와 같이 처리함을 알려드립니다.</li>
	                                                    <li>
	                                                        <ul>
	                                                            <li>1. 개인정보의 수집·이용 목적 : 축구참가신청 서비스 제고를 위해 수집</li>
	                                                            <li>2. 수집 항목 : 필수 항목(성명,휴대전화,이메일)</li>
	                                                            <li>3. 보유 및 이용기간 : 개인정보취급방침에 따름</li>
	                                                            <li>4. 동의를 거부할 권리가 있으며, 동의거부 시 글쓰기가 불가하오니 양지하시기 바랍니다.</li>
	                                                        </ul>
	                                                    </li>
	                                                    <li>개인정보보호법 제 15조에 따라 위 각호사항을 고지받고 개인정보 처리에 동의 합니다.</li>
	                                                </ul>
	                                                <div class="b-agree-box">
	                                                    <input type="radio" class="b-radio" name="infoProtectYn" id="agree01" value="Y"><label for="agree01">동의함</label>
	                                                    <input type="radio" class="b-radio" name="infoProtectYn" id="agree02" value="N"><label for="agree02">동의안함</label>
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                            </fieldset>  
	                            <div class="b-btn-wrap">
	                                <a class="b-btn-type01 b-btn-c-white" title="취소" href="javascript:ListForm();">취소</a>
	                                <!-- 삭제버튼 -->
	                                <button type="submit" class="b-btn-type01 b-btn-c-blue submit">저장</button>
	                            </div>	     
	                        </form>
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
			enterMode: '2',
		    shiftEnterMode: '3',
			filebrowserUploadUrl: '/ImageUpload.do'
		} );
	</script>
	<%} %>
</body>

</html>