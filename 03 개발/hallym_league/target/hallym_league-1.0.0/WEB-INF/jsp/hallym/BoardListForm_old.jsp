<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script src="/js/jquery.min.js"></script>
 
    <title>전체 게시글</title>
    
    <style type="text/css">
        #wrap {
            width: 800px;
            margin: 0 auto 0 auto;
        }
        #topForm{
            text-align :right;
        }
        #board, #pageForm, #searchForm{
            text-align :center;
        }
        
        #bList{
            text-align :center;
        }
        
        .fixItem {
       		background-color: yellow;
        }
    </style>
    
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
    
</head>
<body>    
 
<div id="wrap">
    <br>
    <div id="topForm">
            <input type="button" value="글쓰기" onclick="writeForm()">
    </div>
    <br>
    <div id="board">
        <table id="bList" width="800" border="3" bordercolor="lightgray">
            <tr heigh="30">
                <td>글번호</td>
                <td>제목</td>
                <td>작성자</td>
                <td>작성일</td>
                <td>조회수</td>
                <td>삭제</td>
            </tr>
			<c:forEach items='${boardList}' var="item" varStatus="status">
					<!-- 상단 고정 여부가 Y면 fixItem클래스를 추가하여 스타일을 적용시킴 -->
			        <tr class="<c:if test='${item.BOARD_FIX eq "Y"}'>fixItem</c:if>">
			            <td id="id_${status.count}">${item.BOARD_NUM}</td>
			            <td>
				            <a href="/BoardReadForm.do?num=${item.BOARD_NUM}">
				            	${item.BOARD_SUBJECT}
				            </a>
			            </td>
			            <td>${item.BOARD_ID}</td>
			            <td>${item.BOARD_DATE}</td>
			            <td>${item.BOARD_COUNT}</td>
			            <td>
			           		<a href="/BoardDeleteForm.do?num=${item.BOARD_NUM}">
			            		<input type="button" value="삭제">
			            	</a>
			            </td>
			        </tr>  
		    </c:forEach> 
        </table>
    </div>
    <br>
                  <div>
                        <c:forEach var="i" begin="1" end="${boardListCount}">

                          <c:choose>
                            <c:when test="${boardListCount eq i}">
                              <a class="current" href="javascript:getPage(${i});">${i}</a>
                            </c:when>
                            <c:otherwise>
                              <a href="javascript:getPage(${i});">${i}</a>
                            </c:otherwise>
                          </c:choose>

                        </c:forEach>
                  </div>
    <br>
    <div id="searchForm">
        <form method="post" action="/BoardSearch.do" name="boardForm" enctype="multipart/form-data">
            <select name="opt">
                <option value="0">제목</option>
                <option value="1">작성자</option>
            </select>
            <input type="text" size="20" name="condition"/>&nbsp;
            <input type="submit" value="검색"/>
        </form>    
    </div>
</div>    
 
</body>

</html>