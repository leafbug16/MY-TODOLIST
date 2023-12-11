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
    <link rel="stylesheet" href="<c:url value='/css/adminUser.css'/>">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Noto+Sans+KR&display=swap" rel="stylesheet">
</head>
<body>
	<%@include file="navi.jsp" %>
    <div id="adminuser-wrap">
        <div id="adminuser-wrap-center">

            <div id="adminuser-info">
                <h3>관리자페이지 - 회원 관리</h3>
            </div>

            <div id="adminuser-userinfo">
                <h1>admin</h1>
            </div>

            <div id="adminuser-nav">
                <ul>
                    <li><a href="<c:url value='/board/listAll'/>">전체글</a></li>
                    <li><a href="<c:url value='/user/listAll'/>">회원목록</a></li>
                    <li><a href="<c:url value='/board/listReported'/>">문의/bug report</a></li>
                </ul>
                <hr>
            </div>

            <div id="adminuser-board">
                <table id="adminuser-board-table">
                    <thead>
                        <tr id="adminuser-first-tr">
                            <th>아이디</th>
                            <th>비밀번호</th>
                            <th>이메일</th>
                            <th>가입일</th>
                            <th>삭제</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach var="user" items="${list }">
			            <tr>
			                <td>${user.id }</td>
			                <td>${user.pwd }</td>
			                <td>${user.email }</td>
			                <fmt:formatDate value="${user.regDate }" type="date" pattern="yyyy-MM-dd HH:mm" var="regDate" />
			                <td>${regDate }</td>
			                <td><a href="<c:url value='/user/remove?id=${user.id }&page=${page }&pageSize=${pageSize }'/>" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a></td>
			            </tr>
			            </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- 페이지네이션 -->
            <div id="adminuser-pagenation">
                <ul>
				  	<c:if test="${ph.showPrev }">
					    <li>
					      <a href="<c:url value='/user/listAll?${ph.sc.getQueryString(ph.beginPage-1) }'/>" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
					      </a>
					    </li>
				    </c:if>
				    <c:forEach var="i" begin="${ph.beginPage }" end="${ph.endPage }">
				    	<li><a class="${ph.sc.page==i? 'active':'' }" href="<c:url value='/user/listAll?${ph.sc.getQueryString(i) }' />">${i }</a></li>
				    </c:forEach>
				    <c:if test="${ph.showNext }">
					    <li>
					      <a href="<c:url value='/user/listAll?${ph.sc.getQueryString(ph.endPage+1) }'/>" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					      </a>
					    </li>
				    </c:if>
				</ul>
            </div>
            
            <!-- 검색폼 -->
            <div id="adminuser-search-area">
                <form action="<c:url value='/user/listAll'/>" method="get">
                    <div id="adminuser-search-area-flex">
                        
                        <!-- 셀렉트 -->
                        <div id="adminuser-select">
                            <select name="option">
                                <option value="W" selected>아이디</option>
                            </select>
                        </div>

                        <div id="adminuser-search">
                            <input type="text" placeholder="검색어를 입력하세요" name="keyword" value="${ph.sc.keyword }">
                            <button>검색</button>
                        </div>
                    </div>
                </form>
            </div>

        </div>
    </div>

	<script>
		let msg="${msg}";
		if(msg=="del") alert("성공");
		if(msg=="error") alert("실패");
	</script>
</body>

</html>