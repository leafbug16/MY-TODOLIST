<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이투두리스트 : 메인</title>
<link rel="stylesheet" href="<c:url value='/css/todolist.css'/>">
<link rel="shortcut icon" href="<c:url value='/img/favicon.ico'/>">
<!-- 제이쿼리 -->
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<!-- 폰트어썸 -->
<script src="https://kit.fontawesome.com/77d5171cb8.js" crossorigin="anonymous"></script>
<!--noto sans kr-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Noto+Sans+KR&display=swap" rel="stylesheet">
<!-- asap -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Asap:wght@700&family=Montserrat&family=Noto+Sans+KR&display=swap" rel="stylesheet">
</head>
<body>
	<div id="leftWrap">
	
		<div id="leftTopWrap">
			<div id="leftLogo-div">
				<h1><a href="<c:url value='/'/>" id="leftLogo-title">MY TODOLIST</a></h1>
			    <c:if test="${sessionId eq 'admin' }">
			    	<a href="<c:url value='/board/listAll'/>" id="leftLogo-admin">관리</a><br><br>
			    </c:if>
			</div>
			
			<div id="leftInfo-div">
			    <a href="<c:url value='/board/listMyLike'/>" id="leftInfo-mypage"><i class="fa-regular fa-user" style="color: #a3a3a3;"></i> ${sessionId }</a>
			    <button type="button" id="leftInfo-logout" onclick="location.href='<c:url value='/login/logout'/>'">로그아웃</button>
			    <button type="button" id="leftInfo-board" onclick="location.href='<c:url value='/board/listGuide'/>'">게시판(가이드)</button>
                <button type="button" id="leftInfo-report" onclick="location.href='<c:url value='/board/writeReport'/>'">문의/bug report</button>
			</div>
			<hr id="leftInfo-hr">
		</div>
		
		<div id="leftButtonWrap">
            <button type="button" id="addBtn" title="목록 추가"><i class="fa-solid fa-plus" style="color: #000000;"></i></button>
            <button type="button" id="deleteAllBtn" title="목록 모두 삭제"><i class="fa-regular fa-trash-can" style="color: #ff0000;"></i></button>
        </div>
	    
	    <!-- 목록 가져오기 ajax -->
	    <div id="leftListsWrap">
	    	<div id="lists-div"></div>
	    </div>
	    
    </div>

    <script>
    	const id = "${sessionId}";
    	const showList = function(id) {
    		$.ajax({
    			type : "GET",
    			url : "/todolist/todolist/lists",
    			success : function(res) {
    				$("#lists-div").html(toHtmlLists(res));
    			},
    			error : function(request, status, error){ alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error+"목록 조회 중 에러") }
    		});//ajax
    	}//showList
    	
    	const toHtmlLists = function(lists) {
    		let tmp = "<ul id='list-ul'>";
    		lists.forEach(function(list){
    			tmp += "<li class='list-li'>";
	    			tmp += "<div class='list-div' data-lno="+list.lno+">";
	    				tmp += "<button type='button' class='list-title-button' onclick=\"location.href='<c:url value='/todolist/read?lno="+list.lno+"'/>\'\">"+list.title+"</button>";
            			tmp += "<button type='button' class='listmodBtnb' title='목록 수정'><i class='fa-solid fa-pen fa-lg' style='color: #c7c7c7;'></i></button>";
            			tmp += "<button type='button' class='listdelBtn' title='삭제'><i class='fa-solid fa-xmark fa-lg' style='color: #c7c7c7;'></i></button>";
    			tmp += "</div></li>"
    		})//forEach
    		return tmp + "</ul>";
    	}//toHtml
    	
    	$(document).ready(function(){
    		showList(id);
    		
    		$("#addBtn").click(function(){
    			$.ajax({
    				type : "POST",
    				url : "/todolist/todolist/lists",
    				success : function(res) {
    					showList(id);
    				},
    				error : function(request, status, error){ alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error+"목록 추가 중 에러") }
    			});//ajax
    		});//addBtn click
    		
    		//수정1(목록)
    		$("#lists-div").on("click", ".listmodBtnb", function(){
    			const lno = $(this).parent().attr("data-lno");
    			//부모의 자식중에 button태그를 가져옴
    			const origin = $("button", $(this).parent()).html().trim();
    			
    			$(this).parent().replaceWith("<div class='list-modify-div'><input name='retitle' id='retitle' value='"+origin+"' maxlength='30' spellcheck='false' autofocus><button type='button' id='listmodBtn'>수정완료</button></div>");
    			$("#listmodBtn").attr("data-lno", lno);
    		});//listmodBtnb click
    		
    		//수정2(목록)
    		$("#lists-div").on("click", "#listmodBtn", function(){
    			const title = $("input[name=retitle]").val();
    			const lno = $("#listmodBtn").attr("data-lno");
    			if(title.trim() == ""){
    				alert("내용을 입력하세요");
    				return;
    			}
    			$.ajax({
    				type : "PATCH",
    				url : "/todolist/todolist/lists",
    				headers : {"content-type" : "application/json"},
  					data : JSON.stringify({ lno: lno, title: title}),
  					success : function(res){
  						showList(id);
  					},
  					error: function(request, status, error){ alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error+"목록 수정 완료 중 에러") }
    			});//ajax
    		});//listmodBtn click
    		
    		//할일 목록 삭제
    		$("#lists-div").on("click", ".listdelBtn", (function(){
    			const lno = $(this).parent().attr("data-lno");
    			$.ajax({
    				type : "DELETE",
    				url : "/todolist/todolist/lists?lno="+lno,
    				success : function(res) {
    					showList(id);
    				},
    				error : function(request, status, error){ alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error+"목록 삭제 중 에러") }
    			});//ajax
    		}));//delBtn click
    		
    		
    		//할일 목록 전체 삭제
    		$("#deleteAllBtn").click(function(){
    			if(confirm("정말 목록을 모두 삭제할래요?")) {
	    			$.ajax({
	    				type : "DELETE",
	    				url : "/todolist/todolist/listsAll",
	    				success : function(res) {
	    					showList(id);
	    				},
	    				error : function(request, status, error){ alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error+"목록 삭제 중 에러") }
	    			});//ajax	
    			}
    		});
    		
    		//목록명 수정 엔터키 연결
    		$("#lists-div").on("keyup", "#retitle", function(){
    			if(event.key === "Enter") {
    				event.preventDefault();
    				$(this).siblings("#listmodBtn").click();
    			}
    		});
    		
    	});//ready
    
    
    </script>
     
</body>
</html>

































