<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My TodoList</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Noto+Sans+KR&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/77d5171cb8.js" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="<c:url value='/css/comment.css'/>">
	<script src="https://code.jquery.com/jquery-latest.min.js"></script>
</head>


<body>
	<div id="comment-wrap">
        <div id="comment-wrap-center">

            <div id="comment-header">
                <h2 id=comment-header-text>댓글</h2>
                <hr/>
            </div>

            <div id="commentList">
            </div>

            <div id="comment-input">
                <textarea name="comment" id="comment" placeholder="댓글을 작성해보세요" spellcheck="false"></textarea>
                <button type="button" id="sendBtn">등록</button>
            </div>

        </div>
    </div>
	
	<script>
		let bno = ${board.bno };
		let mode = false;
		let showList = function(bno){
			$('textarea[name=comment]').val("");
			$.ajax({
				type : "GET",
				url : "/todolist/comments?bno="+bno,
				success : function(result) {
					$("#commentList").html(toHtml(result));
				},
				error: function(request, status, error){ alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error+"조회중에러") }
			});
		}
		
		let toHtml = function(comments) {
			let tmp = "<ul id='comment-ul'>";
			comments.forEach(function (comment) {
				var currentDate = new Date(); // 현재 날짜와 시간 정보를 가져옵니다.
				var commentDate = new Date(comment.regDate); // 댓글 작성 일자를 Date 객체로 변환합니다.

				var formattedDate = ""; // 포맷팅된 날짜를 저장할 변수입니다.

				// 댓글 작성 일자와 현재 날짜를 비교하여 포맷팅합니다.
				if (commentDate.toDateString() === currentDate.toDateString()) {
				    // 오늘 작성된 댓글이면 시:분 형식으로 표시합니다.
				    var hours = commentDate.getHours().toString().padStart(2, "0");
				    var minutes = commentDate.getMinutes().toString().padStart(2, "0");
				    formattedDate = hours + ":" + minutes;
				} else {
				    // 오늘이 아닌 다른 날에 작성된 댓글이면 년/월/시:분 형식으로 표시합니다.
				    var year = commentDate.getFullYear();
				    var month = (commentDate.getMonth() + 1).toString().padStart(2, "0");
				    var day = commentDate.getDate().toString().padStart(2, "0");
				    var hours = commentDate.getHours().toString().padStart(2, "0");
				    var minutes = commentDate.getMinutes().toString().padStart(2, "0");
				    formattedDate = year + "/" + month + "/" + day + " " + hours + ":" + minutes;
				}
				tmp += "<li id='comment-li' data-cno="+comment.cno + " data-bno="+comment.bno + ">";
				tmp += "<div id='comment-div' data-cno="+comment.cno + " data-bno="+comment.bno + ">";
				tmp +='<span id="commentlist-commenter"><b>'+comment.commenter+'</b></span><br>';
				tmp +='<span id="commentlist-comment"> '+comment.comment.replace(/\n/g, '<br>')+'</span>';
				tmp += "<span id='commentlist-regDate'>"+formattedDate+"</span>";
				if (comment.commenter === "${sessionScope.id}" || "admin" === "${sessionScope.id}") {
					tmp += "<button type='button' class='modBtnb'><i class='fa-solid fa-pen'></i></button>";
					tmp += "<button type='button' class='delBtn'><i class='fa-solid fa-x'></i></button>";
				}
				tmp +="</div>";
				tmp += "</li>";
				tmp += "<hr id='comment-hr'>";
			})
			return tmp + "</ul>";
		}
		
		$(document).ready(function() {
			showList(bno);
			//등록 버튼
			$("#sendBtn").click(function() {
				let comment = $("textarea[name=comment]").val();
				if (comment.trim() == "") {
					alert("내용을 입력하세요");
					return;
				}
				$.ajax({
					type : "POST",
					url : "/todolist/comments?bno="+bno,
					headers : {"content-type" : "application/json"},
					data : JSON.stringify({ bno: bno, comment: comment}),
					success : function(result) {
						showList(bno);
					},
					error: function(request, status, error){ alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error) }
				}); //ajax
			}); //sendBtn
			
			//댓글 옆 수정버튼 클릭 시
			$("#commentList").on("click", ".modBtnb", function() {
				//부모는 comment-li
			    let cno = $(this).parent().attr("data-cno");
			    let bno = $(this).parent().attr("data-bno");                
			    let originalComment = $("span#commentlist-comment", $(this).parent()).html().replace('<br>', '\r\n').trim();
			    
			    $(this).parent().replaceWith("<div id='comment-modify'><textarea name='recomment' id='recomment" + cno + "' spellcheck='false'>"+originalComment+"</textarea><button type='button' id='modBtn'>수정</button></div>");
			    	    
			    $("#modBtn").attr("data-cno", cno);
			}); 
			
			//수정완료 클릭 시
			$("#commentList").on("click", "#modBtn", function() {
				let comment = $("textarea[name=recomment]").val();
				if (comment.trim() == "") {
					alert("내용을 입력하세요");
					return;
				}
				let cno = $("#modBtn").attr("data-cno");

				$.ajax({
					type : "PATCH",
					url : "/todolist/comments/"+cno,
					headers : {"content-type" : "application/json" },
					data : JSON.stringify({ cno: cno, comment: comment }),
					success : function(result){
						showList(bno);
			        },
			        error: function(request, status, error){ alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error) }
			     }); //ajax

			     // 복구
			     $("textarea[name=recomment]", $(this).parent()).replaceWith('<span class="comment"> '+ comment +'</span>');
			     $(this).replaceWith("<button type='button' class='modBtnb'>수정</button>");
			});
			
			//삭제 버튼
			$("#commentList").on("click", ".delBtn", (function() {
				let cno = $(this).parent().attr("data-cno");
				let bno = $(this).parent().attr("data-bno");
				$.ajax({
					type : "DELETE",
					url : "/todolist/comments/"+cno+"?bno="+bno,
					success : function(result) {
						showList(bno);
					},
					error: function(request, status, error){ alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error) }
				}); //ajax
			})); //delBtn	
			
		}); //ready
	</script>
</body>
</html>











