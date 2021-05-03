<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="bMgr" class = "packBean.BoardMgr" scope="page"/>

<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<script type="text/javascript" src="../script/script.js" ></script>
<link href="../css/style.css" rel="stylesheet" />
<title>익명게시판 게시글 등록확인</title>
<%
	
	int resCnt= bMgr.insertBoard(request);
	if(resCnt > 0){
		response.sendRedirect("../jsp/anony.jsp");
		
	}else{
%>
<script>
//페이지에 직접 스크립트 작성시 이곳에 입력
alert("글 작성에 실패하였습니다. 다시 게시글을 작성해 주세요");
history.back();
</script>
<%} %>
<style>
<!-- 페이지에 직접 css 작성시 이곳에 입력 -->


</style>
</head>
<body>

</body>
</html>