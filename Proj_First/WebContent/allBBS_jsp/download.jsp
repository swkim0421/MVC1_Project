<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="bMgr" class="packImgBBS.BoardMgr"/>
<%
	request.setCharacterEncoding("UTF-8");
	bMgr.downLoad(request, response,out,pageContext);
%>
<!DOCTYPE html >
<html lang="ko">
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<script type="text/javascript" src="../script/script.js" ></script>
<link href="../css/style.css" rel="stylesheet" />
<title>title here</title>
<script>


</script>
<style>


</style>
</head>
<body>

</body>
</html>