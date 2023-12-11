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
    <link rel="stylesheet" href="<c:url value='/css/adminBoard.css'/>">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Noto+Sans+KR&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<%@include file="navi.jsp" %>
    <div id="adminboard-wrap">
        <div id="adminboard-wrap-center">

            <div id="adminboard-info">
                <h3>관리자페이지 - 게시판 글 관리</h3>
            </div>

            <div id="adminboard-userinfo">
                <h1>admin</h1>
            </div>

            <div id="adminboard-nav">
                <ul>
                    <li><a href="<c:url value='/board/listAll'/>">전체글</a></li>
                    <li><a href="<c:url value='/user/listAll'/>">회원목록</a></li>
                    <li><a href="<c:url value='/board/listReported'/>">문의/bug report</a></li>
                </ul>
                <hr>
            </div>

            <div id="adminboard-board">
                <table id="adminboard-board-table">
                    <thead>
                        <tr id="adminboard-first-tr">
                            <th>카테고리</th>
                            <th>제목</th>
                            <th>글쓴이</th>
                            <th>등록일</th>
                            <th>조회</th>
                            <th>좋아요</th>
                            <th>삭제</th>
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
				                <td><a href="<c:url value='/board/remove?bno=${board.bno }&page=${page }&pageSize=${pageSize }&mode=adminBoard'/>" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a></td>
				            </tr>
				        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- 페이지네이션 -->
            <div id="adminboard-pagenation">
                <ul>
				  	<c:if test="${ph.showPrev }">
					    <li>
					      <a href="<c:url value='/board/listAll${ph.sc.getQueryString(ph.beginPage-1) }'/>" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
					      </a>
					    </li>
				    </c:if>
				    <c:forEach var="i" begin="${ph.beginPage }" end="${ph.endPage }">
				    	<li><a class="${ph.sc.page==i? 'active':'' }" href="<c:url value='/board/listAll${ph.sc.getQueryString(i) }' />">${i }</a></li>
				    </c:forEach>
				    <c:if test="${ph.showNext }">
					    <li>
					      <a href="<c:url value='/board/listAll${ph.sc.getQueryString(ph.endPage+1) }'/>" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					      </a>
					    </li>
				    </c:if>
				</ul>
            </div>

            <!-- 검색폼 -->
            <div id="myboard-search-area">
                <form action="<c:url value='/board/listAll'/>" method="get">
                    <div id="myboard-search-area-flex">
                        
                        <!-- 셀렉트 -->
                        <div id="myboard-select">
                            <select name="option">
                                <option value="A" ${ph.sc.option=='A' || ph.sc.option=='' ? "selected" : "" }>제목+내용</option>
                                <option value="T" ${ph.sc.option=='T' ? "selected" : "" }>제목</option>
                                <option value="W" ${ph.sc.option=='W' ? "selected" : "" }>글쓴이</option>
                            </select>
                        </div>

                        <div id="myboard-search">
                            <input type="text" name="keyword" value="${ph.sc.keyword }" placeholder="검색어를 입력하세요">
                            <button>검색</button>
                        </div>
                    </div>
                </form>
            </div>

        </div>
    </div>
    
    <%@include file="footer.jsp" %>

	<script>
		let msg="${msg}";
		if(msg=="del") alert("성공적으로 삭제되었습니다");
		if(msg=="error") alert("삭제를 실패했습니다");
		
		$(document).ready(function() {
			$('.title').on('click', function() {
				window.location = $(this).data('url');
			});
		});
	</script>
</body>

</html>