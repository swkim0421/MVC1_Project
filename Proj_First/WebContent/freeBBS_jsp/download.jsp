<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="bMgr" class="packFreeBBS.BoardMgr" />
<%
		request.setCharacterEncoding("UTF-8");
		bMgr.downLoad(request, response, out, pageContext);
%>
<!DOCTYPE html>
<html lang = "ko">
<head>
	<meta charset="UTF-8">
	<title>다운로드</title>
</head>
<body>
</body>
</html>