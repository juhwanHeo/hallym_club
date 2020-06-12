<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="hallym.league.user.vo.UserVO"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>게시판 - 글쓰기</title>
    
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
        function ListForm(){
            location.href="/BoardListForm.do";
        }
    </script>
    
</head>
<body>
 
    <br>
    <b><font size="6" color="gray">글쓰기</font></b>
    <br>
    
    <form method="post" action="/BoardWriteAction.do" name="boardForm" enctype="multipart/form-data">
    <table width="700" border="3" bordercolor="lightgray" align="center">
        <tr>
            <td id="title">작성자</td>
            <td>
                <%
	                UserVO userVO = null;
	        		String userId = "";
	                if (session.getAttribute("userVO") != null) {
	                	userVO = (UserVO)session.getAttribute("userVO");
	                	userId = userVO.getId();
	        		}
            	%>
                <input name="board_id" type="text" size="70" maxlength="100" value="<%=userId%>"/>
            </td>
            <td>
            	<label><input type="checkbox" name="board_fix" value="Y">고정글</label>
            </td>
        </tr>
            <tr>
            <td id="title">
                	제 목
            </td>
            <td>
                <input name="board_subject" type="text" size="70" maxlength="100" value=""/>
            </td>        
        </tr>
        <tr>
            <td id="title">
               	        내 용
            </td>
            <td>
                <textarea class="editor" name="board_content" cols="72" rows="20"></textarea>
            </td>        
        </tr>
        <tr>
            <td id="title">
                	파일첨부
            </td>
            <td>
                <input type="file" name="board_file" />
            </td>    
        </tr>
 
        <tr align="center" valign="middle">
            <td colspan="5">
                <input type="reset" value="작성취소" >
                <input type="submit" value="등록" >
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