<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="kr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이투두리스트 : 관리</title>
    <link rel="shortcut icon" href="<c:url value='/img/favicon.ico'/>">
    <link rel="stylesheet" href="<c:url value='/css/adminReported.css'/>">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Noto+Sans+KR&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<%@include file="navi.jsp" %>
    <div id="adminreported-wrap">
        <div id="adminreported-wrap-center">

            <div id="adminreported-info">
                <h3>관리자페이지 - 문의/bug report 관리</h3>
            </div>

            <div id="adminreported-userinfo">
                <h1>admin</h1>
            </div>

            <div id="adminreported-nav">
                <ul>
                    <li><a href="<c:url value='/board/listAll'/>">전체글</a></li>
                    <li><a href="<c:url value='/user/listAll'/>">회원목록</a></li>
                    <li><a href="<c:url value='/board/listReported'/>">문의/bug report</a></li>
                </ul>
                <hr>
            </div>

            <div id="adminreported-board">
                <table id="adminreported-board-table">
                    <thead>
                        <tr id="adminreported-first-tr">
                            <th>제목</th>
                            <th>보낸이</th>
                            <th>날짜</th>
                            <th>삭제</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach var="board" items="${list }">
				            <tr>
				            	<td class="title" data-url="<c:url value='/board/read?bno=${board.bno }&${ph.sc.queryString }&mode=${board.boardType }'/>">
					                ${board.title }
					            </td>
				                
				                <td>${board.writer }</td>
				                <fmt:formatDate value="${board.regDate }" type="date" pattern="yyyy-MM-dd HH:mm" var="reg_date" />
				                <td>${reg_date }</td>
				                <td><a href="<c:url value='/board/remove?bno=${board.bno }&page=${page }&pageSize=${pageSize }&mode=adminReported'/>" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a></td>
				            </tr>
			            </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- 페이지네이션 -->
            <div id="adminreported-pagenation">
                <ul>
				  	<c:if test="${ph.showPrev }">
					    <li>
					      <a href="<c:url value='/board/listReport${ph.sc.getQueryString(ph.beginPage-1) }'/>" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
					      </a>
					    </li>
				    </c:if>
				    <c:forEach var="i" begin="${ph.beginPage }" end="${ph.endPage }">
				    	<li><a class="${ph.sc.page==i? 'active':'' } href="<c:url value='/board/listReport${ph.sc.getQueryString(i) }' />">${i }</a></li>
				    </c:forEach>
				    <c:if test="${ph.showNext }">
					    <li>
					      <a href="<c:url value='/board/listReport${ph.sc.getQueryString(ph.endPage+1) }'/>" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					      </a>
					    </li>
				    </c:if>
				</ul>
            </div>

        </div>
    </div>

	<script>
		let msg="${msg}";
		if(msg=="del") alert("성공적으로 삭제되었습니다");
		if(msg=="error") alert("삭제를 실패했습니다");
		if(msg=="write_ok") alert("성공적으로 등록되었습니다");
		if(msg=="modify_error") alert("작성자만 수정할 수 있습니다");
		if(msg=="modify_ok") alert("수정 성공");
		
		$(document).ready(function() {
			$('.title').on('click', function() {
				window.location = $(this).data('url');
			});
		});
	</script>
</body>

</html>