<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My TodoList</title>
    <link rel="stylesheet" href="<c:url value='/css/navi.css'/>">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Noto+Sans+KR&display=swap" rel="stylesheet">
    <!-- asap -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Asap:wght@700&family=Montserrat&family=Noto+Sans+KR&display=swap" rel="stylesheet">
</head>
<body>
    <div id="navi-wrap">
        <div id="navi-wrap-center">
            <div id="header">
                <!-- 로고 -->
                <div id="header-logo">
                    <h1><a href="<c:url value='/'/>" id="title">MY TODOLIST</a></h1>
                </div>

                <!-- 네비게이션 메뉴 -->
                <div id="nav">
                    <ul>
                        <li><a href="<c:url value='/board/listGuide'/>" id="guide-title">가이드</a></li>
                        <li><a href="<c:url value='/board/listNotice'/>" id="notice-title">공지사항</a></li>
                        <li><a href="<c:url value='/board/listFree'/>" id="free-title">자유게시판</a></li>
                    </ul>
                </div>
                
                <!-- 햄버거 메뉴 -->
                <button id="header-hamburger">
                    <div id="header-hamburger-ico"></div>
                    <div id="header-dropmenu" class="header-dropmenu-displaynone">
                        <ul id="ul-dropmenu">
                            <li><a href="<c:url value='/board/listMyLike'/>">${sessionId }</a></li>
                            <li><a href="<c:url value='/board/writeReport'/>">문의/bug report</a></li>
                            <li><a href="<c:url value='/login/logout'/>">로그아웃</a></li>
                        </ul>
                    </div>
                </button>

            </div>

        </div>
    </div>
    
    <script src="<c:url value='/js/navi.js'/>"></script>
</body>
</html>