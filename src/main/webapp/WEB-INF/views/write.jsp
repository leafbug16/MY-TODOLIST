<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="kr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이투두리스트 : 글쓰기</title>
    <link rel="shortcut icon" href="<c:url value='/img/favicon.ico'/>">
    <link rel="stylesheet" href="<c:url value='/css/write.css'/>">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Noto+Sans+KR&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-latest.min.js"></script>
	<script src="https://cdn.ckeditor.com/4.19.1/standard/ckeditor.js"></script>
</head>
<body>
	<%@include file="navi.jsp" %>
    <div id="writing-wrap">
        <form id="writing-wrap-center" action="<c:url value='/board/write'/>" method="post" onsubmit="return formCheck(this)" enctype="multipart/form-data">
            <!-- 현재 페이지 설명 -->
            <div id="writing-header">
                <h3>글쓰기</h3>
            </div>
            <!-- 게시글 타입 설정(select) -->
            <div id="writing-board-type">
				<c:choose>
				
			    	<c:when test="${sessionId eq 'admin' }">
			    		<select name="boardType" id="select-writing-board-type">
			    			<option value="guide" ${mode eq 'guide' ? 'selected' : ''}>가이드</option>
				            <option value="notice" ${mode eq 'notice' ? 'selected' : ''}>공지사항</option>
				            <option value="free" ${mode eq 'free' ? 'selected' : ''}>자유게시판</option>
			    		</select>
			    	</c:when>
			    	
			    	<c:otherwise>
			    		<select name="boardType" id="select-writing-board-type">
			    			<option value="guide" disabled>가이드</option>
			    			<option value="notice" disabled>공지사항</option>
			    			<option value="free" selected>자유게시판</option>
			    		</select>
			    	</c:otherwise>
			    	
			    </c:choose>
            </div>

            <!-- 게시글 제목 -->
            <div id="writing-title">
                <input type="text" name="title" id="input-writing-title" placeholder="제목을 입력해주세요" maxlength="100">
            </div>

            <!--게시글 내용-->
            <div id="writing-content">
            	<textarea name="content" id="textarea-writing-content" placeholder="내용을 입력해주세요"></textarea>
            </div>

            <!--입력완료 버튼-->
            <div id="writing-button">
                <button id="button-writing-button">등록</button>
            </div>
        </form>
    </div>
    
    <%@include file="footer.jsp" %>
    
    
	<script>
		let msg = "${msg }";
		if (msg=="write_error") alert("게시글 작성에 실패했습니다");
		
	    // Replace the <textarea id="editor1"> with a CKEditor 4
	    // instance, using default configuration.
		CKEDITOR.replace('textarea-writing-content', {
			width: '1280px',
	    	height: '400px',
	    	enterMode: CKEDITOR.ENTER_BR,
			filebrowserUploadUrl : '${pageContext.request.contextPath}/upload'

		});
		    
		CKEDITOR.on('dialogDefinition', function( ev ){
		  var dialogName = ev.data.name;
		  var dialogDefinition = ev.data.definition;
		
		  switch (dialogName) {
		      case 'image': //Image Properties dialog
		      //dialogDefinition.removeContents('info');
		      dialogDefinition.removeContents('Link');
		      dialogDefinition.removeContents('advanced');
		      break;
		  }
		});
		
		function formCheck(form) {
			if (!form.title.value || !CKEDITOR.instances['textarea-writing-content'].getData()) {
				alert('제목과 내용을 모두 입력해주세요.');
				return false;
			}
				return true;
		}
	</script>
</body>

</html>











