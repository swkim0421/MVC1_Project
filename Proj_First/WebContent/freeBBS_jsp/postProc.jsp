<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="bMgr" class="packFreeBBS.BoardMgr"/>
<%
		bMgr.insertFreeBoard(request); // request 내장객체
		response.sendRedirect("../jsp/free.jsp");
%>
<!DOCTYPE html>
<html lang = "ko">
<head>
	<meta charset="UTF-8">
	<title>포스트 프로세스</title>
</head>
<body>
</body>
</html>