<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bMgr" class="packFreeBBS.BoardMgr"/>
<jsp:useBean id="reBean" class="packFreeBBS.BoardBean"/>
<jsp:setProperty property="*" name="reBean" />

<%
	 bMgr.replyUpFreeBoard(reBean.getRef(), reBean.getPos());
	 bMgr.replyFreeBoard(reBean);
	 String nowPage = request.getParameter("nowPage");
	 response.sendRedirect("../jsp/free.jsp?nowPage="+nowPage);
%>
<!DOCTYPE html>
<html lang = "ko">
<head>
	<meta charset="UTF-8">
	<title>답변 프로세스</title>
</head>
<body>

</body>
</html>