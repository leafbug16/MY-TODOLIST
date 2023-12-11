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
    <link rel="stylesheet" href="<c:url value='/css/view.css'/>">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Noto+Sans+KR&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-latest.min.js"></script>
</head>

<body>
	<%@include file="navi.jsp" %>
	<div id="view-wrap">
        <div id="view-wrap-center">
            <!-- 게시판 종류와 수정, 삭제, 목록 버튼 -->
            <div id="view-nav">
                <h3 onclick="location.href='<c:url value='/board/listMyReport?${searchCondition.queryString }'/>'">문의/bug report</h3>
                <div id="view-nav-button">
                    <button type="button" onclick="location.href='<c:url value='/board/listMyReport?${searchCondition.queryString }'/>'">목록</button>
                </div>
            </div>

            <!-- 글 제목 -->
            <div id="post-title">
                <h1>${board.title }</h1>
            </div>

            <!-- 글 정보 -->
            <fmt:formatDate value="${board.regDate }" type="date" pattern="yyyy-MM-dd HH:mm" var="regDate" />
            <div id="post-info">
                <span>${board.writer }&nbsp;&nbsp;|&nbsp;&nbsp;${regDate } &nbsp;&nbsp;조회&nbsp;${board.views }</span>
            </div>

            <!-- 본문 -->
            <div id="post-content">
                <span>
                	${board.content }
                </span>
            </div>

        </div>
    </div> 
    <!-- footer include -->
    <%@include file="footer.jsp" %>
</body>

</html>