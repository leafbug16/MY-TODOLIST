<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>마이투두리스트 : 로그인</title>
<link rel="shortcut icon" href="<c:url value='/img/favicon.ico'/>">
<link rel="stylesheet" href="<c:url value='/css/index.css'/>">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Noto+Sans+KR&display=swap" rel="stylesheet">
<!-- asap -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Asap:wght@700&family=Montserrat&family=Noto+Sans+KR&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<div id="wrap">
	
		<!-- 타이틀 -->
		<div id="header-title">
	            <h1 id="title">MY TODOLIST</h1>
	    </div>
	    
        <div id="wrap-center">
        	<!-- 제목 -->
	        <div id="header">
	            <h2>ID 로그인</h2>
	        </div>

            <!-- 로그인 폼 -->
            <div id="main">
                <form action="<c:url value='/login/action'/>" method="post">
                
                	<!-- 로그인 실패 메시지 -->
                    <div id="login-failed-msg-div">
                        <span class="" id="login-failed-msg"></span>
                    </div>
                
                    <!-- 아이디 입력 -->
                    <div id="input-id">
                        <input type="text" name="id" id="id" placeholder="아이디" required autofocus>
                    </div>

                    <!-- 비밀번호 입력 -->
                    <div id="input-pwd">
                        <input type="password" name="pwd" id="pwd" placeholder="비밀번호" required>
                    </div>

                    <!-- 로그인 상태 유지 -->
                    <div id="auto-div">
                        <input type="checkbox" name="auto" id="auto">
                        <label for="auto" class="auto-label">로그인 상태 유지</label>
                    </div>

                    <!-- 버튼 -->
                    <div id="input-button">
                        <button>로그인</button>
                    </div>

                </form>
            </div>
        </div>
        
        <!-- 아이디/비밀번호 찾기, 회원가입 링크 -->
		<div id="links">
		    <a href="#" id="findUserInfo-link">아이디/비밀번호 찾기</a>
		    <a href="<c:url value='/register/form'/>">회원가입</a>
		</div>
		
		<!-- 이메일 입력 -->
        <div id="findUserInfo-div" class="hidden">
        	<span id="email-msg"></span>
        	<span id="email-msg-fail"></span>
            <input type="email" name="email" id="email" placeholder="가입할때 입력한 이메일">
            <button type="button" id="emailBtn">전송</button>
        </div>
        
    </div>
    
    <script>
    	let msg="${msg}";
    	if(msg=="login-failed") $("#login-failed-msg").html("아이디 또는 비밀번호를 잘못 입력했습니다");
    	
    	//유저 정보 찾기에서 엔터 키 연결
    	document.getElementById("email").addEventListener("keyup", function(event) {
    	    if (event.key === 'Enter') {
    	        event.preventDefault();
    	        document.getElementById("emailBtn").click();
    	    }
    	});
    	
    	//아이디/비밀번호찾기 클릭시 히든 제거
    	$("#findUserInfo-link").click(function(){
    		$("#findUserInfo-div").toggleClass("hidden");
    	});
    	
    	$(document).ready(function(){
    		$("#emailBtn").click(function(){
    			//전송버튼 비활성화
    			$(this).prop("disabled", true);
    			
    			const email = $("#email").val().trim();
    			$.ajax({
    				type : "GET",
    				url : "/todolist/findUserInfo?email="+email,
    				success : function(res) {
    					if(res == "success") {
	    					$("#email-msg").html("이메일을 전송했어요");   
	    					$("#email-msg-fail").html("");
    					} else {
    						$("#email-msg-fail").html("그런 이메일은 없어요");
    						$("#email-msg").html("");
    					}
    				},
    				error : function(request, status, error){ alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error+"이메일 전송 중 에러") },
    				complete: function() {
						setTimeout(function() {
			            	$("#emailBtn").prop("disabled", false);
			            }, 1000);
			        }
    			});//ajax
    		})
    		
    	}); //ready
    </script>
</body>
</html>