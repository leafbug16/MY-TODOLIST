<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이투두리스트 : 메인</title>
<link rel="stylesheet" href="<c:url value='/css/todolist2.css'/>">
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
	<div id="wrap">
		<div id="leftWrap">
			<div id="leftTopWrap">
			
				<div id="leftLogo-div">
                    <h1><a href="<c:url value='/'/>" id="leftLogo-title">MY TODOLIST</a></h1>
                    <c:if test="${sessionId eq 'admin' }">
                    	<a href="<c:url value='/board/listAll'/>" id="leftLogo-admin">관리</a>
                    </c:if>
                </div><!-- leftLogo-div -->
                
                <div id="leftInfo-div">
				    <a href="<c:url value='/board/listMyLike'/>" id="leftInfo-mypage"><i class="fa-regular fa-user" style="color: #a3a3a3;"></i> ${sessionId }</a>
				    <button type="button" id="leftInfo-logout" onclick="location.href='<c:url value='/login/logout'/>'">로그아웃</button>
				    <button type="button" id="leftInfo-board" onclick="location.href='<c:url value='/board/listGuide'/>'">게시판(가이드)</button>
	                <button type="button" id="leftInfo-report" onclick="location.href='<c:url value='/board/writeReport'/>'">문의/bug report</button>
				</div>
				<hr id="leftInfo-hr">
                
			</div><!-- leftTopWrap -->
			
			<div id="leftButtonWrap">
            	<button type="button" id="addBtn" title="목록 추가"><i class="fa-solid fa-plus" style="color: #000000;"></i></button>
            	<button type="button" id="deleteAllBtn" title="목록 모두 삭제"><i class="fa-regular fa-trash-can" style="color: #ff0000;"></i></button>
        	</div>
        	
        	<!-- 목록 가져오기 ajax -->
		    <div id="leftListsWrap">
		    	<div id="lists-div"></div>
		    </div>
			
		</div><!-- leftWrap -->
		
		<div id="center-wrap">
			<div id="center-top-wrap">
				<h2>오늘의 할 일</h2>
			</div>
			
			<div id="center-center-wrap">
				<div id="todoList"></div>
			</div><!-- center-center-wrap -->
			
		</div><!-- center-wrap -->
		
		<div id="right-wrap">
			<!-- 메모장 -->
            <div id="todo-memo-div">
                <textarea name="memo" id="memo" spellcheck="false" placeholder="메모장 - 입력 완료 2초 후 자동으로 저장됩니다"></textarea>
            </div>
		</div><!-- right-wrap -->
	
    </div><!-- wrap -->
	    
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
    	
    	const showTodo = function(id) {
    		$.ajax({
    			type : "GET",
    			url : "/todolist/todolist/mainTodos",
		        success : function(res) {
		        	$("#todoList").html(toHtmlTodo(res));
		        	//processTodoInformation();
		        },
		        error : function(request, status, error){ alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error+"조회중에러") }
    		});//ajax
    	}//showTodo
    	
    	//메모 불러오기
    	const showMemo = function(id) {
    		$("#memo").val("");
    		$.ajax({
    			type : "GET",
    			url : "/todolist/todolist/todosMainMemo",
    			success : function(res) {
    				const memo = res.memo; // Todolist 객체의 memo 필드
            		$("#memo").val(memo);
    			},
    			error : function(request, status, error){ alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error+"메모 조회 중 에러") }
    		});//ajax
    	}
    	
    	const toHtmlTodo = function(todoLists) {
    		let tmp = "<ul id='todo-ul'>";
    		todoLists.forEach(function(todo){
    			tmp += "<li class='todo-li'>";
	    			tmp += "<div class='todo-div' data-tno="+todo.tno+" data-lno="+todo.lno+" data-regDate="+todo.regDate+" data-completeDate="+todo.completeDate+" data-dday="+todo.dday+" data-dplusday="+todo.dplusday+" data-startDate="+todo.startDate+" data-endDate="+todo.endDate+" data-repeatCycle="+todo.repeatCycle+" data-repeatStart="+todo.repeatStart+">";
	    			tmp += "<input type='checkbox' id='todo"+todo.tno+"' class='todo-checkbox' "+(todo.complete == 'true' ? "checked" : "")+">";
	    			tmp += "<label for='todo"+todo.tno+"' class='todo-label'>"+todo.content+"</label>";
	    			tmp += "<button type='button' class='setting-button' title='설정'><i class='fa-solid fa-gear fa-lg' style='color: #878787;'></i></button>";
	    			tmp += "<button type='button' class='modBtnb' title='수정'><i class='fa-solid fa-pen fa-lg' style='color: #c7c7c7;'></i></button>";
	    			tmp += "<button type='button' class='delBtn' title='삭제'><i class='fa-solid fa-xmark fa-lg' style='color: #c7c7c7;'></i></button>";
	    			//상세메모1
	    			tmp += "<button type='button' class='additionalMemo-button' title='상세 내용 메모'><i class='fa-solid fa-caret-down fa-lg' style='color: #878787;'></i></button><br>";
	    			//중복 코드
	    			//요일
	    			const dayNames = ["일", "월", "화", "수", "목", "금", "토"];	
	    			//오늘날짜
	    			const now = new Date();
    				now.setHours(0, 0, 0, 0);
    				const nowYear = now.getFullYear();
	    			
	    			//조건에 따라 세팅값을 출력한다 (dday, d+day, 구간, 반복)
	    			//d-day
	    			if (todo.dday) {
	    				const ddayStr = todo.dday;
	    				let dday = new Date(parseInt(ddayStr));
	    				dday.setHours(0, 0, 0, 0);
	    				const ddayDay = dday.getDay();
	    				
	    				let diff = Math.round((dday - now) / (1000 * 60 * 60 * 24));
	    				
	    				let year = dday.getFullYear();
	  				    let month = ("0" + (dday.getMonth() + 1)).slice(-2);
	  				    let day = ("0" + dday.getDate()).slice(-2);
	  				    dday = year+"/"+month+"/"+day;
	  				    ddayNowYear = month+"/"+day;
	  				    
	    				//d-day
	    				if(diff == 0) {
    				    	tmp += "<span class='setting-info' style='color: red'>D-Day ("+ddayNowYear+", "+dayNames[ddayDay]+"요일)</span>";
	    				//d-day 전
	    				} else if(diff > 0) {
	    				    //올해라면 월/일만 올해가 아니라면 년/월/일 표시
	    				    if (nowYear - year == 0){
	    				    	tmp += "<span class='setting-info'>D-"+diff+" ("+ddayNowYear+", "+dayNames[ddayDay]+"요일)</span>";
	    				    } else {
		    					tmp += "<span class='setting-info'>D-"+diff+" ("+dday+", "+dayNames[ddayDay]+"요일)</span>";
	    				    }
	    				//d-day 이후
	    				} else {
	    					diff = diff * -1;
	    				  	//올해라면 월/일만 올해가 아니라면 년/월/일 표시
	    				    if (nowYear - year == 0){
	    				    	tmp += "<span class='setting-info'>D-Day 종료 후 "+diff+"일 지났습니다 ("+ddayNowYear+", "+dayNames[ddayDay]+"요일)</span>";
	    				    } else {
	    				    	tmp += "<span class='setting-info'>D-Day 종료 후 "+diff+"일 지났습니다 ("+dday+", "+dayNames[ddayDay]+"요일)</span>";
	    				    }
	    				}
	    			}
	    			//d+day
	    			if (todo.dplusday) {
	    				const dplusdayStr = todo.dplusday;
	    				let dplusday = new Date(parseInt(dplusdayStr));
	    				dplusday.setHours(0, 0, 0, 0);
	    				const dplusdayDay = dplusday.getDay();
	    				
	    				let diff = Math.round((now - dplusday) / (1000 * 60 * 60 * 24));
    				    let year = dplusday.getFullYear();
    				    let month = ("0" + (dplusday.getMonth() + 1)).slice(-2);
    				    let day = ("0" + dplusday.getDate()).slice(-2);
    				    dplusday = year+"/"+month+"/"+day;
    				    dplusdayNowYear = month+"/"+day;
    				  	//올해라면 월/일만, 올해가 아니라면 년/월/일 표시
    				  	if (diff < 0) {
    				  		diff = diff * -1;
    				  		diff1 = diff - 1;
    				  		if (nowYear - year == 0){
    				  			//날짜 계산 국룰에 따라 오늘을 제외한 날짜로 표기해야함
	    				    	tmp += "<span class='setting-info'>D+Day 시작까지 "+diff1+"일 남았습니다 ("+dplusdayNowYear+", "+dayNames[dplusdayDay]+"요일)</span>";
	    				    } else {
	    				    	tmp += "<span class='setting-info'>D+Day 시작까지 "+diff1+"일 남았습니다 ("+dplusday+", "+dayNames[dplusdayDay]+"요일)</span>";
	    				    }
    				  	} else {
	    				    if (nowYear - year == 0){
	    				    	tmp += "<span class='setting-info'>D+"+diff+" ("+dplusdayNowYear+", "+dayNames[dplusdayDay]+"요일)</span>";
	    				    } else {
	    				    	tmp += "<span class='setting-info'>D+"+diff+" ("+dplusday+", "+dayNames[dplusdayDay]+"요일)</span>";
	    				    }
    				  	}
	    			}
	    			
	    			//startend 정보 표시
	    			if (todo.endDate) {	
	    				const startDateStr = todo.startDate;
	    				let startDate = new Date(parseInt(startDateStr));
	    				startDate.setHours(0, 0, 0, 0);
	    				
	    				const endDateStr = todo.endDate;
	    				let endDate = new Date(parseInt(endDateStr));
	    				endDate.setHours(0, 0, 0, 0);
	    				
	    				const startDay = startDate.getDay();
	    		    	const endDay = endDate.getDay();
	    		    	const startDate1 = startDate;
	    		    	const endDate1 = endDate;
    				
	    				const diff = Math.round((endDate - startDate) / (1000 * 60 * 60 * 24)) + 1;
    				    let year = startDate.getFullYear();
    				    let month = ("0" + (startDate.getMonth() + 1)).slice(-2);
    				    let day = ("0" + startDate.getDate()).slice(-2);
    				    startDate = year+"/"+month+"/"+day;
    				    startDateNowYear = month+"/"+day;
    				    
    				    let year1 = endDate.getFullYear();
    				    let month1 = ("0" + (endDate.getMonth() + 1)).slice(-2);
    				    let day1 = ("0" + endDate.getDate()).slice(-2);
    				    endDate = year1+"/"+month1+"/"+day1;
    				    endDateNowYear = month1+"/"+day1;
    				    
    				    if (nowYear - year1 == 0){
    				    	//시작일과 종료일이 같다면 그날 할 일로 표시
    				    	if(endDate1 - startDate1 == 0) {
    				    		//진행중이라면
    				    		if(now - startDate1 >= 0 && endDate1 - now >= 0) {
        				    		tmp += "<span class='setting-info' style='color: red'>("+startDateNowYear+", "+dayNames[startDay]+"요일)</span>";
        				    	} else {
    	    				    	tmp += "<span class='setting-info'>("+startDateNowYear+", "+dayNames[startDay]+"요일)</span>";
        				    	}
    				    	} else {
	    				    	if(now - startDate1 >= 0 && endDate1 - now >= 0) {
	    				    		tmp += "<span class='setting-info' style='color: red'>시작 ("+startDateNowYear+", "+dayNames[startDay]+"요일) ~ 종료 ("+endDateNowYear+", "+dayNames[endDay]+"요일)</span>";
	    				    	} else {
		    				    	tmp += "<span class='setting-info'>시작 ("+startDateNowYear+", "+dayNames[startDay]+"요일) ~ 종료 ("+endDateNowYear+", "+dayNames[endDay]+"요일)</span>";
	    				    	}
    				    	}	
    				    } else {
    				    	//시작일 = 종료일인 경우
    				    	if(endDate1 - startDate1 == 0) {
    				    		//진행중인경우
    				    		if(now - startDate1 >= 0 && endDate1 - now >= 0) {
    				    			tmp += "<span class='setting-info' style='color: red'>("+startDate+", "+dayNames[startDay]+"요일)/span>";
    				    		} else {
    				    			tmp += "<span class='setting-info'>("+startDate+", "+dayNames[startDay]+"요일)</span>";
    				    		}
    				    	} else {
								if(now - startDate1 >= 0 && endDate1 - now >= 0) {
									tmp += "<span class='setting-info' style='color: red'>시작 ("+startDate+", "+dayNames[startDay]+"요일) ~ 종료 ("+endDate+", "+dayNames[endDay]+"요일)</span>";
    				    		} else {
    				    			tmp += "<span class='setting-info'>시작 ("+startDate+", "+dayNames[startDay]+"요일) ~ 종료 ("+endDate+", "+dayNames[endDay]+"요일)</span>";
    				    		}
    				    	}
    				    }
	    			}
	    			
	    			//repeat 정보 표시
	    			if (todo.repeatCycle) {
	    				//반복 시작일 관리
    					const repeatStartStr = todo.repeatStart;
    					let repeatStart = new Date(parseInt(repeatStartStr));
    					repeatStart.setHours(0, 0, 0, 0);
    					let repeatStartDay = repeatStart.getDay();

    					let startYear = repeatStart.getFullYear();
    					let startMonth = ("0" + (repeatStart.getMonth() + 1)).slice(-2);
    					let startDate = ("0" + repeatStart.getDate()).slice(-2);
    					let repeatStartOtherYear = startYear+"/"+startMonth+"/"+startDate;
    					let repeatStartNowYear = startMonth+"/"+startDate;
    					
    					//등록일 관리
    					let regDateStr = todo.regDate;
    					let regDate = new Date(parseInt(regDateStr));
    					regDate.setHours(0, 0, 0, 0);
    					let regDateDay = regDate.getDay();
    					
    					let regYear = regDate.getFullYear();
    					let regMonth = ("0" + (regDate.getMonth() + 1)).slice(-2);
    					let regDateDate = ("0" + regDate.getDate()).slice(-2);
    					let regDateOtherYear = regYear+"/"+regMonth+"/"+regDateDate;
    					let regDateNowYear = regMonth+"/"+regDateDate;

    					//repeatCycle
	    				let repeatCycle = todo.repeatCycle;
    					
	    				//매일반복
	    				if(repeatCycle == "everyday") {
	    					repeatCycle = "매일";
	    					if (nowYear - regYear == 0) {
	    						tmp += "<span class='setting-info'><i class='fa-solid fa-rotate-right fa-spin fa-lg' style='color: #7aabff;''></i>&nbsp&nbsp"+repeatCycle+" - ("+regDateNowYear+", "+dayNames[regDateDay]+"요일)부터 "+todo.completes+"회 완료됨</span>";
	    					} else {
	    						tmp += "<span class='setting-info'><i class='fa-solid fa-rotate-right fa-spin fa-lg' style='color: #7aabff;''></i>&nbsp&nbsp"+repeatCycle+" - ("+regDateOtherYear+", "+dayNames[regDateDay]+"요일)부터 "+todo.completes+"회 완료됨</span>";
	    					}
	    					
	    				//매주반복
	    				} else if(repeatCycle == "week") {
	    					repeatCycle = "매주";
	    					let yoil = repeatStart.getDay();
	    					yoil = dayNames[yoil];
	    					
	    					if (nowYear - regYear == 0) {
	    						tmp += "<span class='setting-info'><i class='fa-solid fa-rotate-right fa-spin fa-lg' style='color: #7aabff;''></i>&nbsp&nbsp"+repeatCycle+" ("+yoil+")요일 - ("+regDateNowYear+", "+dayNames[repeatStartDay]+"요일)부터 "+todo.completes+"회 완료됨</span>";
	    					} else {
	    						tmp += "<span class='setting-info'><i class='fa-solid fa-rotate-right fa-spin fa-lg' style='color: #7aabff;''></i>&nbsp&nbsp"+repeatCycle+" ("+yoil+")요일 - ("+regDateOtherYear+", "+dayNames[repeatStartDay]+"요일)부터 "+todo.completes+"회 완료됨</span>";
	    					}
	    					
	    				//매월반복
	    				} else if(repeatCycle == "month") {
	    					repeatCycle = "매월";
	    					let day = ("0" + repeatStart.getDate()).slice(-2);
	    					//diff 구하기
	    					let diff = repeatStart.getDate() - now.getDate();
	    					if (diff < 0) {
				                const lastDayOfMonth = new Date(now.getFullYear(), now.getMonth() + 1, 0).getDate();
				                diff = lastDayOfMonth - now.getDate() + repeatStart.getDate();
				            }
	    					
	    					//매월 반복에 적용할 코드
	    					if (nowYear - regYear == 0) {
	    						tmp += "<span class='setting-info'><i class='fa-solid fa-rotate-right fa-spin fa-lg' style='color: #7aabff;''></i>&nbsp&nbsp"+repeatCycle+" ("+day+")일 - ("+regDateNowYear+", "+dayNames[repeatStartDay]+"요일)부터 "+todo.completes+"회 완료됨</span>";
	    					} else {
	    						tmp += "<span class='setting-info'><i class='fa-solid fa-rotate-right fa-spin fa-lg' style='color: #7aabff;''></i>&nbsp&nbsp"+repeatCycle+" ("+day+")일 - ("+regDateOtherYear+", "+dayNames[repeatStartDay]+"요일)부터 "+todo.completes+"회 완료됨</span>";
	    					}
	    				//n간격 반복
	    				} else {    
		    				repeatCycle1 = parseInt(repeatCycle);
	    					repeatCycle = ""+repeatCycle+"일";
	    					
	    					//다음 초기화 날짜 구하기
	    					//resetDiff = 초기화 간격
	    					//resetDate = 다음 초기화 날짜
	    					//diff = 다음 초기화 날짜까지 남은 일 수
	    					let resetDiff = (Math.floor((now - repeatStart) / (1000 * 60 * 60 * 24 * repeatCycle1) + 1)) * repeatCycle1;
							let resetDate = new Date(repeatStart.getTime() + resetDiff * 24 * 60 * 60 * 1000);
							let diff = Math.round((resetDate - now) / (1000 * 60 * 60 * 24)) - 1;
							
							const resetDateDay = resetDate.getDay();
	    					let year = resetDate.getFullYear();
	    				    let month = ("0" + (resetDate.getMonth() + 1)).slice(-2);
	    				    let day = ("0" + resetDate.getDate()).slice(-2);
	    				    resetDate = year+"/"+month+"/"+day;
	    				    resetDateNowYear = month+"/"+day;
	    				    
	    				  	//n간격 반복에 적용할 코드
	    				    if (nowYear - year == 0) {
	    				    	tmp += "<span class='setting-info'><i class='fa-solid fa-rotate-right fa-spin fa-lg' style='color: #7aabff;''></i>&nbsp&nbsp"+repeatCycle+"마다 반복 : 다음 초기화("+resetDateNowYear+", "+dayNames[resetDateDay]+"요일) 까지 "+diff+"일 남았습니다 - ("+regDateNowYear+", "+dayNames[repeatStartDay]+"요일)부터 "+todo.completes+"회 완료됨</span>";
	    				    } else {
	    				    	tmp += "<span class='setting-info'><i class='fa-solid fa-rotate-right fa-spin fa-lg' style='color: #7aabff;''></i>&nbsp&nbsp"+repeatCycle+"마다 반복 : 다음 초기화("+resetDate+", "+dayNames[resetDateDay]+"요일) 까지 "+diff+"일 남았습니다 - ("+regDateOtherYear+", "+dayNames[repeatStartDay]+"요일)부터 "+todo.completes+"회 완료됨</span>";
	    				    }
	    				}
    					
	    			}

		    			tmp += "<div class='setting-wrap hidden'>";
		    				tmp +="<span class='setting-wrap-span'>기본은 오늘 할 일 입니다. 특별한 로직을 설정하려면 다음 4가지 중 하나를 선택하세요</span><br>";
		    				//dday 세팅창
		    				tmp += "<span class='d-minus-day-span'>d-day를 설정합니다. d-day에는 빨간색으로 강조 표시됩니다</span>";
			    			tmp += "<div class='d-minus-day-div'>";
			    				let ddayStr = todo.dday;
			    				if (ddayStr) {  // ddayStr 값이 유효한지 확인합니다.
			    				    let dday = new Date(ddayStr);
			    				    let year = dday.getFullYear();
			    				    let month = ("0" + (dday.getMonth() + 1)).slice(-2);
			    				    let day = ("0" + dday.getDate()).slice(-2);
			    				    dday = year+"-"+month+"-"+day;
			    				    tmp += "<button type='button' class='d-minus-day-button setting-active'>D-Day</button>";
			    				    tmp += "<div class='d-minus-day-input-div'>D-Day : <input type='date' value='"+dday+"' class='d-minus-day-input'><br><button type='button' class='d-minus-day-input-button'>적용</button></div>";
			    				} else {
			    					tmp += "<button type='button' class='d-minus-day-button'>D-Day</button>";
			    				    tmp += "<div class='hidden d-minus-day-input-div'>D-Day : <input type='date' class='d-minus-day-input'><br><button type='button' class='d-minus-day-input-button'>적용</button></div>";
			    				}
			    			tmp += "</div>"
			    			//d+day 세팅창
			    			tmp += "<span class='d-plus-day-span'>d+day를 설정합니다.</span>";
			    			tmp += "<div class='d-plus-day-div'>";
			    				let dplusdayStr = todo.dplusday;
			    				if (dplusdayStr) {  // endDate 값이 유효한지 확인합니다.
			    				    let dplusday = new Date(dplusdayStr);
			    				    let year = dplusday.getFullYear();
			    				    let month = ("0" + (dplusday.getMonth() + 1)).slice(-2);
			    				    let day = ("0" + dplusday.getDate()).slice(-2);
			    				    dplusday = year+"-"+month+"-"+day;
			    				    tmp += "<button type='button' class='d-plus-day-button setting-active'>D+Day</button>";
			    				    tmp += "<div class='d-plus-day-input-div'>D+Day : <input type='date' value='"+dplusday+"' class='d-plus-day-input'><br><button type='button' class='d-plus-day-input-button'>적용</button></div>";
			    				} else {
			    					tmp += "<button type='button' class='d-plus-day-button'>D+Day</button>";
			    				    tmp += "<div class='hidden d-plus-day-input-div'>D+Day : <input type='date' class='d-plus-day-input'><br><button type='button' class='d-plus-day-input-button'>적용</button></div>";
			    				}
			    			tmp += "</div>"
			    			//startend 세팅창
			    			tmp += "<span class='startend-span'>할일의 시작일과 종료일을 설정합니다. 오늘이 설정된 구간이라면 빨간색으로 강조 표시됩니다. 시작일과 종료일을 같은 날짜로 설정하면 그 날 할 일이 됩니다</span>";
			    			tmp += "<div class='startend-div'>";
			    				let endDateStr = todo.endDate;
			    				if(endDateStr) {
			    					let startDate = new Date(todo.startDate);
			    					let endDate = new Date(todo.endDate);
			    					let startYear = startDate.getFullYear();
			    					let startMonth = ("0" + (startDate.getMonth() + 1)).slice(-2);
			    					let startDay = ("0" + startDate.getDate()).slice(-2);
			    					startDate = startYear+"-"+startMonth+"-"+startDay;
			    					let endYear = endDate.getFullYear();
			    					let endMonth = ("0" + (endDate.getMonth() + 1)).slice(-2);
			    					let endDay = ("0" + endDate.getDate()).slice(-2);
			    					endDate = endYear+"-"+endMonth+"-"+endDay;
			    					tmp += "<button type='button' class='startend-button setting-active'>시작~종료</button>"
			    					tmp += "<div class='startend-input-div'>";
				    					tmp += "시작일 : <input type='date' class='startend-start-input' value='"+startDate+"'><br>";
				    					tmp += "종료일 : <input type='date' class='startend-end-input' value='"+endDate+"'><br>";
				    					tmp += "<button type='button' class='startend-input-button'>적용</button>"
			    					tmp += "</div>";
			    				} else {
			    					tmp += "<button type='button' class='startend-button'>시작~종료</button>"
				    				tmp += "<div class='hidden startend-input-div'>";
				    					tmp += "시작일 : <input type='date' class='startend-start-input'><br>";
				    					tmp += "종료일 : <input type='date' class='startend-end-input'><br>";
				    					tmp += "<button type='button' class='startend-input-button'>적용</button>"
				    				tmp += "</div>";
			    				}
			    			tmp += "</div>";//startend
			    			//repeat 세팅창
			    			tmp += "<span class='repeat-span'>반복을 설정합니다. 매일, 주간, 월간, n일 간격 반복을 설정할 수 있습니다.<br>시작 기준일에 자동으로 체크가 해제됩니다.</span>"
			    			tmp += "<div class='repeat-div'>";
			    				
			    				const repeatCycle = todo.repeatCycle;
			    				if(repeatCycle) {
			    					tmp += "<button type='button' class='repeat-button setting-active'>반복</button>"
			    					tmp += "<div class='repeat-input-div'>";
			    				} else {
			    					tmp += "<button type='button' class='repeat-button'>반복</button>"
				    				tmp += "<div class='hidden repeat-input-div'>";
			    				}
			    					tmp += "<span id='repeat-help'>반복 주기 : </span>";	
			    					if(repeatCycle === "everyday") {
				    					tmp += "<input type='radio' name='repeatCycle"+todo.tno+"' value='everyday' checked>매일";
			    					} else {
			    						tmp += "<input type='radio' name='repeatCycle"+todo.tno+"' value='everyday'>매일";
			    					}
			    					if(repeatCycle === "week") {
			    						tmp += "<input type='radio' name='repeatCycle"+todo.tno+"' value='week' checked>매주";
			    					} else {
			    						tmp += "<input type='radio' name='repeatCycle"+todo.tno+"' value='week'>매주";
			    					}
			    					if(repeatCycle === "month") {
			    						tmp += "<input type='radio' name='repeatCycle"+todo.tno+"' value='month' checked>매월";
			    					} else {
			    						tmp += "<input type='radio' name='repeatCycle"+todo.tno+"' value='month'>매월";
			    					}
			    					//숫자로 변환할 수 있으면 true
			    					if(!isNaN(parseInt(repeatCycle))) {
			    						tmp += "<input type='radio' name='repeatCycle"+todo.tno+"' value='0' checked>n일";
			    						tmp += "<input type='number' name='repeatCycle"+todo.tno+"' class='repeat-cycle-input' placeholder='자연수' value='"+todo.repeatCycle+"'><br>";
			    					} else {
			    						tmp += "<input type='radio' name='repeatCycle"+todo.tno+"' value='0'>n일";
				    					tmp += "<input type='number' name='repeatCycle"+todo.tno+"' class='repeat-cycle-input' placeholder='자연수' disabled><br>";
			    					}
			    					tmp += "<span id='repeat-help2'>반복 기준일 : </span>";
			    					if( todo.repeatStart != null) {
			    						let repeatStartStr = todo.repeatStart;
				    					let repeatStart = new Date(repeatStartStr);
				    					let year = repeatStart.getFullYear();
				    				    let month = ("0" + (repeatStart.getMonth() + 1)).slice(-2);
				    				    let day = ("0" + repeatStart.getDate()).slice(-2);
				    				    repeatStart = year+"-"+month+"-"+day;
				    					tmp += "<input type='date' class='repeat-start-input' value='"+repeatStart+"'><br>";
			    					} else {
			    						tmp += "<input type='date' class='repeat-start-input' disabled><br>";
			    					}
			    					tmp += "<button type='button' class='repeat-input-button btn_"+todo.tno+"'>적용</button>";
			    				tmp += "</div>"; //repeat-input-div
			    			tmp += "</div>"; //repeat-div
		    			tmp += "</div>" //setting-wrap
		    			
		    			
		    			//additionalMemo-wrap
		    			//상세메모2
		    			let aMemo = todo.additionalMemo;
		    			if (aMemo == null) {
		    				aMemo = "";
		    			}
		    			tmp += "<div class='additionalMemo-wrap hidden'>";
							tmp += "<textarea name='additionalMemo' class='additionalMemo' spellcheck='false' placeholder='상세 내용 메모 - 입력 완료 2초 후 자동 저장됩니다'>"+aMemo+"</textarea>";
						tmp += "</div>"; //additionalMemo-wrap
		    			
    			tmp += "</div></li>" //.todo-div
    		})//forEach
    		return tmp + "</ul>";
    	}//toHtml

    	
    	$(document).ready(function(){
    		showList(id);
    		showTodo(id);
    		showMemo(id);
    		
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
    		
    		const homeUrl = "<c:url value='/todolist/main'/>";
    		//할일 목록 하나 삭제
    		$("#lists-div").on("click", ".listdelBtn", (function(){
    			const lno = $(this).parent().attr("data-lno");
    			$.ajax({
    				type : "DELETE",
    				url : "/todolist/todolist/lists?lno="+lno,
    				success : function(res) {
    					window.location.href = homeUrl;
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
	    					window.location.href = homeUrl;
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
    		
    		//할일 삭제
    		$("#todoList").on("click", ".delBtn", (function(){
    			const tno = $(this).parent().attr("data-tno");
    			const lno = $(this).parent().attr("data-lno");
    			$.ajax({
    				type : "DELETE",
    				url : "/todolist/todolist/todos?tno="+tno,
    				success : function(res) {
    					showTodo(id);
    				},
    				error : function(request, status, error){ alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error+"삭제 중 에러") }
    			});//ajax
    		}));//delBtn click
    		
    		//할일 내용 수정1
    		$("#todoList").on("click", ".modBtnb", function(){
    			const tno = $(this).parent().attr("data-tno");
    			const lno = $(this).parent().attr("data-lno");
    			const origin = $("label", $(this).parent()).html().replace('<br/>', '\r\n').trim();
    			
    			$(this).parent().replaceWith("<div id='todo-modify-div'><input name='recontent' class='recontent' value='"+origin+"' spellcheck='false' autofocus><button type='button' class='modBtn'>수정</button></div>");
    			$(".modBtn").attr("data-tno", tno);
    		});//modeBtnb click
    		
    		//할일 내용 수정2
    		$("#todoList").on("click", ".modBtn", function(){
    			const content = $("input[name=recontent]").val();
    			const tno = $(this).attr("data-tno");
    			if(content.trim() == "") {
    				alert("내용을 입력하세요");
    				return;
    			}
    			$.ajax({
    				type : "PATCH",
    				url : "/todolist/todolist/todos",
    				headers : {"content-type" : "application/json"},
  					data : JSON.stringify({ tno: tno, content: content}),
  					success : function(res){
  						showTodo(id);
  					},
  					error: function(request, status, error){ alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error+"수정 완료 중 에러") }
    			});//ajax
    		});//modBtn click
    		
    		
    		//할일 setting 시작 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    		//checkbox 사운드 경로
    		let soundUrl = "<c:url value='/audio/Coin 1.mp3'/>";		
    		//complete
    		//checked인 상태면 null이 들어가고 아니면 오늘날짜가 들어감
    		$("#todoList").on("change", ".todo-checkbox", function(){
    			const tno = $(this).closest('.todo-div').attr("data-tno");
    			const complete = $(this).prop("checked");
    			let completeDate = null;
	    	    if(complete) {
	    	        completeDate = new Date();
	    	        completeDate.setHours(0, 0, 0, 0);
	    	        var checkSound = new Audio(soundUrl);  // Audio 객체 생성
	    	        checkSound.volume = 0.3;  // 볼륨 조절
	    	        checkSound.play();  // 소리 재생
	    	    }
    			$.ajax({
    				type : "PATCH",
    				url : "/todolist/todolist/complete",
    				headers : {"content-type" : "application/json"},
 					data : JSON.stringify({ tno: tno, complete: complete, completeDate: completeDate }),
 					success : function(todo){	
 						showTodo(id);
 					},
 					error: function(request, status, error){ alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error+"complete 수정 중 에러") }
      			});//ajax
    		});
    		
	      	//dday세팅
	      	$("#todoList").on("click", ".d-minus-day-input-button", function(){
	  	        const dday = $(this).siblings('.d-minus-day-input').val();
	  	        const tno = $(this).closest('.todo-div').attr("data-tno");
	  	        $.ajax({
      				type : "PATCH",
      				url : "/todolist/todolist/dday",
      				headers : {"content-type" : "application/json"},
   					data : JSON.stringify({ tno: tno, dday: dday}),
   					success : function(todo){	
   						showTodo(id);
   					},
   					error: function(request, status, error){ alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error+"dday 수정 중 에러") }
	      		});//ajax
	  		});
	      	
	      	//dplusday
	      	$("#todoList").on("click", ".d-plus-day-input-button", function(){
	  	        const dplusday = $(this).siblings('.d-plus-day-input').val();
	  	        const tno = $(this).closest('.todo-div').attr("data-tno");
	  	        $.ajax({
      				type : "PATCH",
      				url : "/todolist/todolist/dplusday",
      				headers : {"content-type" : "application/json"},
   					data : JSON.stringify({ tno: tno, dplusday: dplusday}),
   					success : function(todo){
   						showTodo(id);
   					},
   					error: function(request, status, error){ alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error+"dplusday 수정 중 에러") }
	      		});//ajax
	  		});
	      	
	      	//startend
	      	$("#todoList").on("click", ".startend-input-button", function(){
	  	        const startDate = $(this).siblings('.startend-start-input').val();
	  	        const endDate = $(this).siblings('.startend-end-input').val();
	  	        const tno = $(this).closest('.todo-div').attr("data-tno");
	  	        $.ajax({
      				type : "PATCH",
      				url : "/todolist/todolist/startend",
      				headers : {"content-type" : "application/json"},
   					data : JSON.stringify({ tno: tno, startDate: startDate, endDate: endDate }),
   					success : function(todo){
   						showTodo(id);
   					},
   					error: function(request, status, error){ alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error+"startend 수정 중 에러") }
	      		});//ajax
	  		});
	      	
	      	//인풋 활성화 조절
	      	$("#todoList").on("change", "input:radio[name^=repeatCycle]", function(){
	      		if($(this).val() == "0"){
	            $("input[type=number][name^=repeatCycle]").prop("disabled", false);
	          } else {
	            $("input[type=number][name^=repeatCycle]").prop("disabled", true);
	            $("input[type=number][name^=repeatCycle]").val("");
	          }
	      		if($(this).val() != "everyday") {
	      			$(this).siblings(".repeat-start-input").prop("disabled", false);
	      		} else {
	      			$(this).siblings(".repeat-start-input").prop("disabled", true);
	      			$(this).siblings(".repeat-start-input").val("");
	      		}
	      	});
	      	
	      	//repeat에 데이터 초기값 입력용 ajax
	      	$("#todoList").on("click", ".repeat-input-button", function(){
	      		let todoTno = $(this).attr('class').split("_")[1];
	      		let repeatCycle = $(this).siblings("input:checked").val();
	      		if(repeatCycle == "0") {
	      			repeatCycle = $(this).siblings('.repeat-cycle-input').val();
	      		}
	  	        const repeatStart = $(this).siblings('.repeat-start-input').val();
	  	        const tno = $(this).closest('.todo-div').attr("data-tno");
	  	        $.ajax({
      				type : "PATCH",
      				url : "/todolist/todolist/repeat",
      				headers : {"content-type" : "application/json"},
   					data : JSON.stringify({ tno: tno, repeatCycle: repeatCycle, repeatStart: repeatStart }),
   					success : function(todo){
   						showTodo(id);
   					},
   					error: function(request, status, error){ alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error+"startend 수정 중 에러") }
	      		});//ajax
	  		});
    		
    		//버튼 관련
	      	//세팅 버튼
	      	$("#todoList").on("click", ".setting-button", function(){
	          	// 클릭된 버튼의 '.setting-wrap'이 닫혀 있으면, 모든 '.setting-wrap' 닫고 해당 '.setting-wrap' 열기
	          	// li태그로 구분되어있기 때문에 this.siblings라고 하면 현재 세팅창만 선택됨
	          	// 그냥 setting-wrap이라고 하면 존재하는 모든 setting-wrap이 선택됨
	      		if ($(this).siblings('.setting-wrap').hasClass('hidden')) {
	            	$('.setting-wrap').addClass('hidden');
	            	$(this).siblings('.setting-wrap').removeClass('hidden');
	        	} else {
	            	// 클릭된 버튼의 '.setting-wrap'이 이미 열려 있으면, 해당 '.setting-wrap' 닫기
	            	$(this).siblings('.setting-wrap').addClass('hidden');
	        	}
	      	});
	      	
	      	//d-day버튼
	      	$("#todoList").on("click", ".d-minus-day-button", function(){
	      		let parentDiv = $(this).closest('.d-minus-day-div');	
	      		$(this).siblings('.d-minus-day-input-div').toggleClass('hidden');
	      		parentDiv.siblings(".d-plus-day-div").find(".d-plus-day-input-div").addClass('hidden');
	      		parentDiv.siblings(".startend-div").find('.startend-input-div').addClass('hidden');
	      		parentDiv.siblings(".repeat-div").find('.repeat-input-div').addClass('hidden');
	      		
	      		//버튼 활성화
	      		$(".d-plus-day-button").removeClass("setting-active");
	      		$(".startend-button").removeClass("setting-active");
	      		$(".repeat-button").removeClass("setting-active");
	      		$(this).toggleClass('setting-active');
	      	});
	      	
	      	//d+day버튼
	      	$("#todoList").on("click", ".d-plus-day-button", function(){
	      		let parentDiv = $(this).closest(".d-plus-day-div");
	      		$(this).siblings(".d-plus-day-input-div").toggleClass("hidden");
	      		parentDiv.siblings(".d-minus-day-div").find(".d-minus-day-input-div").addClass('hidden');
	      		parentDiv.siblings(".startend-div").find('.startend-input-div').addClass('hidden');
	      		parentDiv.siblings(".repeat-div").find('.repeat-input-div').addClass('hidden');
	      		
	      		$(".d-minus-day-button").removeClass("setting-active");
	      		$(".startend-button").removeClass("setting-active");
	      		$(".repeat-button").removeClass("setting-active");
	      		$(this).toggleClass('setting-active');
	      	});
	      	
	      	//startend버튼
	      	$("#todoList").on("click", ".startend-button", function(){
	      		let parentDiv = $(this).closest(".startend-div");
	      		$(this).siblings(".startend-input-div").toggleClass("hidden");
	      		parentDiv.siblings(".d-minus-day-div").find(".d-minus-day-input-div").addClass('hidden');
	      		parentDiv.siblings(".d-plus-day-div").find('.d-plus-day-input-div').addClass('hidden');
	      		parentDiv.siblings(".repeat-div").find('.repeat-input-div').addClass('hidden');
	      		
	      		//버튼 활성화
	      		$(".d-minus-day-button").removeClass("setting-active");
	      		$(".d-plus-day-button").removeClass("setting-active");
	      		$(".repeat-button").removeClass("setting-active");
	      		$(this).toggleClass('setting-active');
	      	});
	      	
	      	//repeat버튼
	      	$("#todoList").on("click", ".repeat-button", function(){
	      		let parentDiv = $(this).closest(".repeat-div");
	      		$(this).siblings(".repeat-input-div").toggleClass("hidden");
	      		parentDiv.siblings(".d-minus-day-div").find(".d-minus-day-input-div").addClass('hidden');
	      		parentDiv.siblings(".d-plus-day-div").find('.d-plus-day-input-div').addClass('hidden');
	      		parentDiv.siblings(".startend-div").find('.startend-input-div').addClass('hidden');
	      		
	      		//버튼 활성화
	      		$(".d-minus-day-button").removeClass("setting-active");
	      		$(".d-plus-day-button").removeClass("setting-active");
	      		$(".startend-button").removeClass("setting-active");
	      		$(this).toggleClass('setting-active');
	      	});
	    		
	      	//할일내용수정 - 수정버튼 엔터키 연결
	      	$("#todoList").on("keyup", ".recontent", function(){
	      		if(event.key === "Enter") {
    				event.preventDefault();
    				$(this).siblings(".modBtn").click();
    			}
	      	});
      	
    		//메모 입력 & 저장
    		function saveMemo() {
    			const memo = $("#memo").val();
    			$.ajax({
    				type : "POST",
    				url : "/todolist/todolist/todosMainMemo",
    				headers : {"content-type" : "application/json"},
  					data : JSON.stringify({ id: id, memo: memo}),
  					success : function(res) {
  						showMemo(id);
  					},
    				error : function(request, status, error){ alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error+"메모 작성 중 에러") }
    			});//ajax
    		}
    		
    		//메모 저장 딜레이 타이머
    		let memoTimer = null;
    		$("#memo").keyup(function() {
    		    clearTimeout(memoTimer); //이전 타이머 취소
    		    
    		    memoTimer = setTimeout(function() {
    		        saveMemo();
    		    }, 2000); // 1000ms(2초) 딜레이 후에 저장 함수 호출
    		});
    		
	      	//상세메모3
	      	//상세내용 버튼
	      	$("#todoList").on("click", ".additionalMemo-button", function(){
	      	  	// 클릭된 버튼의 '.setting-wrap'이 닫혀 있으면, 모든 '.setting-wrap' 닫고 해당 '.setting-wrap' 열기
	      	  	// li태그로 구분되어있기 때문에 this.siblings라고 하면 현재 세팅창만 선택됨
	      	  	// 그냥 setting-wrap이라고 하면 존재하는 모든 setting-wrap이 선택됨
	      		if ($(this).siblings('.additionalMemo-wrap').hasClass('hidden')) {
	      	    	$('.additionalMemo-wrap').addClass('hidden');
	      	    	$(this).siblings('.additionalMemo-wrap').removeClass('hidden');
	      			$(this).siblings('.additionalMemo-wrap').addClass('memo-active');
	      		} else {
	      	    	// 클릭된 버튼의 '.setting-wrap'이 이미 열려 있으면, 해당 '.setting-wrap' 닫기
	      	    	$(this).siblings('.additionalMemo-wrap').addClass('hidden');
	      			$(this).siblings('.additionalMemo-wrap').removeClass('memo-active');
	      		}
	      	});
	      	
	      	//상세메모4
	      	//상세내용 입력 & 저장
	      	let additionalMemoTimer = null;
	      	$("#todoList").on("keyup", ".additionalMemo", function(){
	      		const $this = $(this);
	      	    clearTimeout(additionalMemoTimer); //이전 타이머 취소
	      	    
	      	    additionalMemoTimer = setTimeout(function() {
	      	    	const additionalMemo = $this.val();
	  	      		const tno = $this.closest(".todo-div").attr("data-tno");
	  	      		$.ajax({
	  	      			type : "POST",
	  	      			url : "/todolist/todolist/todosAdditionalMemo",
	  	      			headers : {"content-type" : "application/json"},
	  	      			data : JSON.stringify({ tno: tno, additionalMemo: additionalMemo}),
	  	      			success : function(res) {
	  	      			},
	  	      			error : function(request, status, error){ alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error+"상세 메모 작성 중 에러") }
	  	      		});//ajax
	      	    }, 2000); // 2000ms(2초) 딜레이
	      	});
	      	
	      	//목록 활성탭 설정
	      	$("#lists-div").on("click", ".list-title-button", function(){
	      	    $(".list-title-button").removeClass('active');
	      	  	localStorage.setItem('activeTab', $(this).parent().data('lno'));
	      	});

    	});//ready
    	
    	//12시에 강제 새로고침		
  		function refreshAt(hours, minutes, seconds) {
  		    var now = new Date();
  		    var then = new Date();
  	
  		    if(now.getHours() > hours ||
  		       (now.getHours() == hours && now.getMinutes() > minutes) ||
  		        now.getHours() == hours && now.getMinutes() == minutes && now.getSeconds() >= seconds) {
  		        then.setDate(now.getDate() + 1);
  		    }
  		    then.setHours(hours);
  		    then.setMinutes(minutes);
  		    then.setSeconds(seconds);
  	
  		    var timeout = (then.getTime() - now.getTime());
  		    setTimeout(function() { window.location.reload(true); }, timeout);
  		}
  		refreshAt(00,00,00); // 매일 자정에 새로고침
    
		//활성탭 함수
		function activeTabFunction() {
			const activeTab = localStorage.getItem('activeTab');
	        if (activeTab) {
	            $('.list-div[data-lno="' + activeTab + '"]').find(".list-title-button").addClass('active');
	        }
		}
  		
    </script>
     
</body>
</html>
































