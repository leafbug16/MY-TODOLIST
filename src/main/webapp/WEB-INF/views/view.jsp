<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html data-bs-theme="dark">

<head>
    <meta charset="UTF-8">
    <title>view</title>
</head>

<body>
	<form name="writeFrm">
	<h2>글 상세보기</h2>
	<table class="table text-center border">
	    <thead>
	    	<tr>
	            <th>${board.writer }</th>
	            <fmt:formatDate value="${boardDto.regDate }" type="date" pattern="yyyy-MM-dd HH:mm" var="regDate" />
	            <th>${regDate }</th>
	            <th>조회 ${board.views }</th>
	            <th>추천 5</th>
	       	</tr>
	    </thead>
	    <tbody>
	        <tr>
	            <td colspan="4"><input type="text" name="title" value="${board.title }" readonly></td>
	        </tr>
	        <tr>
	            <td colspan="4"><textarea class="form-control" name="title" style="height:350px" readonly>${board.content }</textarea></td>
	        </tr>
	    </tbody>
	</table>
	</form>
	<c:choose>
		<c:when test="${sessionId eq board.writer }">
			<a href="<c:url value='/board/listFree?${searchCondition.queryString }'/>">목록</a>
			<a onclick="deletePost()">삭제</a>
			<a href="<c:url value='/board/modify?bno=${boardDto.bno }&page=${page }&pageSize=${pageSize }'/>">수정</a>
		</c:when>
		<c:otherwise>
			<a href="<c:url value='/board/listFree?page=${page }&pageSize=${pageSize }'/>">목록</a>
		</c:otherwise>
	</c:choose>
	
	<script>
		function deletePost(){
			var confirmed = confirm("정말 삭제하시겠습니까?");
			if(confirmed){
				var form = document.writeFrm;
				form.method = "post";
				form.action = "<c:url value='/board/remove'/>?bno=${boardDto.bno }&page=${page }&pageSize=${pageSize }";
				form.submit();
			}
		}
	</script>
</body>

</html>