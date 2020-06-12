<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="hallym.league.board.vo.BoardVO"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script src="/js/jquery.min.js"></script>

    <title>게시판 - 글보기</title>
    
    <style type="text/css">
        #title{
            height : 16;
            font-family :'돋움';
            font-size : 12;
            text-align :center;
        }
    </style>
    
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/ckeditor5.css">

    <script type="text/javascript">
	    $(document).ready(function () {
	        $("#FileDown").click(function () { 
	        	var data = $("searchBoard.BOARD_FILE").val();
	        	//alert(data);
	            location.href = "/fileDown.do?" + "&fileName=123.txt";
	          });
	    });
    
        function ListForm(){
            location.href="/BoardListForm.do";
        }
    </script>
    
</head>
<body>
 
    <br>
    <b><font size="6" color="gray">글읽기</font></b>
    <br>
    
    <form method="post" action="/BoardUpdateAction.do" name="boardForm" enctype="multipart/form-data">
    <table width="700" border="3" bordercolor="lightgray" align="center">
        <tr>
            <td id="title">
          		      작성자
            </td>
            <td>
                <input name="board_id" type="text" size="70" maxlength="100" value="${searchBoard.BOARD_ID}"/>
            </td>
            <td>
            	<label>
            		<input type="checkbox" name="board_fix" value="Y"
            	<%
            		BoardVO board = (BoardVO) request.getAttribute("searchBoard");
            		if(board.getBOARD_FIX().equalsIgnoreCase("Y")) {
            	%>
            		checked
            	<%
            		}
            	%>
            		>
            		고정글
            	</label>
            </td>
        </tr>
            <tr>
            <td id="title">
                	제 목
            </td>
            <td>
                <input name="board_subject" type="text" size="70" maxlength="100" value="${searchBoard.BOARD_SUBJECT}"/>
            </td>        
        </tr>
        <tr>
            <td id="contents">
               	        내 용
            </td>
            <td>
                <textarea class="editor" name="board_content" cols="72" rows="20">${searchBoard.BOARD_CONTENT}</textarea>   
            </td>        
        </tr>
        <tr>
            <td id="file">
               	     파일 다운로드
            </td>
            <td>
            	<a href="javascript:getPage(${searchBoard.BOARD_FILE});">${searchBoard.BOARD_FILE}</a>
                <input id="FileDown" type="button" value="${searchBoard.BOARD_FILE}"/> 
            </td>        
        </tr>
        <tr align="center" valign="middle">
            <td colspan="5">
                <input type="submit" value="수정" >
                <input type="button" value="목록" onclick="ListForm()">            
            </td>
        </tr>
    </table>    
    </form>
    <script src="${pageContext.request.contextPath}/plugin/ckeditor5/build/ckeditor.js"></script>
	<script>ClassicEditor.create( document.querySelector( '.editor' ), {
				toolbar: {
					items: [
						'heading',
						'|',
						'bold',
						'italic',
						'underline',
						'strikethrough',
						'link',
						'removeFormat',
						'|',
						'fontFamily',
						'fontSize',
						'fontColor',
						'fontBackgroundColor',
						'highlight',
						'|',
						'bulletedList',
						'numberedList',
						'indent',
						'outdent',
						'|',
						/*'imageUpload',*/
						'blockQuote',
						'insertTable',
						'mediaEmbed',
						'undo',
						'redo',
						'|'
					]
				},
				language: 'ko',
				image: {
					toolbar: [
						'imageTextAlternative',
						'imageStyle:full',
						'imageStyle:side'
					]
				},
				table: {
					contentToolbar: [
						'tableColumn',
						'tableRow',
						'mergeTableCells',
						'tableCellProperties',
						'tableProperties'
					]
				},
				licenseKey: '',
			} )
			.then( editor => {
				window.editor = editor;
			} )
			.catch( error => {
				console.error( 'Oops, something gone wrong!' );
				console.error( 'Please, report the following error in the https://github.com/ckeditor/ckeditor5 with the build id and the error stack trace:' );
				console.warn( 'Build id: if8eqbsgmsuf-i2f2tjhnq9v9' );
				console.error( error );
			} );
	</script>
</body>

</html>