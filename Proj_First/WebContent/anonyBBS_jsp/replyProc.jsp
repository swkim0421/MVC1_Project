<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="bMgr" class="packBean.BoardMgr" />
<jsp:useBean id="bean" class="packBean.BoardBean" />
<jsp:setProperty property="*" name="bean"/>

<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="../script/script.js" ></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<link href="../css/style.css" rel="stylesheet" />
<title>익명게시판 답변글 등록확인</title>
<%

	bMgr.replyupboard(bean.getRef(), bean.getPos());
	bMgr.reply(bean);
	String nowpage = request.getParameter("nowpage");
	out.print(nowpage);
 	response.sendRedirect("list.jsp?nowpage="+nowpage);
	
%>
<script>
//페이지에 직접 스크립트 작성시 이곳에 입력

</script>

<style>
<!-- 페이지에 직접 css 작성시 이곳에 입력 -->


</style>
</head>
<body>

</body>
</html>