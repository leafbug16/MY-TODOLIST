<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="kr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이투두리스트 : 마이페이지</title>
    <link rel="shortcut icon" href="<c:url value='/img/favicon.ico'/>">
    <link rel="stylesheet" href="<c:url value='/css/myPost.css'/>">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Noto+Sans+KR&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<%@include file="navi.jsp" %>
    <div id="mypost-wrap">
        <div id="mypost-wrap-center">

            <div id="mypost-info">
                <h3>마이페이지 - 작성글</h3>
            </div>

            <div id="mypost-userinfo">
                <h1>${sessionId }</h1>
            </div>

            <div id="mypost-nav">
                <ul>
                    <li><a href="<c:url value='/board/listMyLike'/>">좋아요한 글</a></li>
                    <li><a href="<c:url value='/board/listMyPost'/>">작성글</a></li>
                    <li><a href="<c:url value='/board/listMyComment'/>">작성댓글</a></li>
                    <li><a href="<c:url value='/board/listMyReport'/>">문의/bug report 내역</a></li>
                </ul>
                <a href="<c:url value='/user/remove?id=${sessionId }&mode=selfRemove'/>" onclick="return confirm('정말 탈퇴하시겠습니까?')" id="mypost-delete-user">회원탈퇴</a>
                <hr>
            </div>

            <div id="mypost-board">
                <table id="mypost-board-table">
                    <thead>
                        <tr id="mypost-first-tr">
                            <th>카테고리</th>
                            <th>제목</th>
                            <th>글쓴이</th>
                            <th>등록일</th>
                            <th>조회</th>
                            <th>좋아요</th>
                        </tr>
                    </thead>

                    <tbody>
                    	<c:forEach var="board" items="${list }">
				            <tr>
				                <td>${board.boardType }</td>
				                <td class="title" data-url="<c:url value='/board/read?bno=${board.bno }&mode=${board.boardType }'/>">
					                ${board.title }
					                <c:if test="${board.comments != 0 }">
					                    <span id="comments" style="color: gray;">[ ${board.comments } ]</span>
					                </c:if>
					            </td>
				                <td>${board.writer }</td>
				                <fmt:formatDate value="${board.regDate }" type="date" pattern="yy/MM/dd HH:mm" var="regDate" />
                                <fmt:formatDate value="${board.regDate }" type="time" pattern="HH:mm" var="regTime" />
            					<fmt:formatDate value="<%=new java.util.Date()%>" type="date" pattern="yy/MM/dd" var="today" />
            					<c:choose>
					              <c:when test="${regDate eq today }">
					                <td>${regDate }</td>
					              </c:when>
					              <c:otherwise>
					                <td>${regDate }</td>
					              </c:otherwise>
					            </c:choose>
				                <td>${board.views }</td>
				                <td>${board.likes }</td>
				            </tr>
			            </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- 페이지네이션 -->
            <div id="mypost-pagenation">
                <ul>
				  	<c:if test="${ph.showPrev }">
						<li>
							<a href="<c:url value='/board/listMyPost?page=${ph.beginPage-1 }&pageSize=${ph.pageSize }'/>" aria-label="Previous">
					        	<span aria-hidden="true">&laquo;</span>
					      	</a>
					    </li>
				    </c:if>
				    <c:forEach var="i" begin="${ph.beginPage }" end="${ph.endPage }">
				    	<li><a class="${ph.page==i? 'active':'' }" href="<c:url value='/board/listMyPost?page=${i }&pageSize=${ph.pageSize }' />">${i }</a></li>
				    </c:forEach>
				    <c:if test="${ph.showNext }">
						<li>
					    	<a href="<c:url value='/board/listMyPost?page=${ph.endPage+1 }&pageSize=${ph.pageSize }'/>" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					      	</a>
					    </li>
				    </c:if>
			  	</ul>
			  
            </div>
        </div>
    </div>
    
    <%@include file="footer.jsp" %>

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