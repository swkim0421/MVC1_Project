<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, user-scalable=no">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<script type="text/javascript" src="../script/script.js" ></script>
<link href="../css/style.css" rel="stylesheet" />
<title>Second Team Project</title>
<script>
//페이지에 직접 스크립트 작성시 이곳에 입력
</script>
<style>
<!-- 페이지에 직접 css 작성시 이곳에 입력 -->

</style>
</head>

<body>
<div id="wrap">
<div id="header">
<jsp:include page="../template/header.html" />
</div>

<div id="nav">
	<jsp:include page="../template/nav.jsp" />
</div>

<div id="subMenu">
	<jsp:include page="../template/side.jsp" />
</div>

<div id="main">
	<jsp:include page="../allBBS_jsp/list.jsp" />
</div>

<div id="footer">
	<jsp:include page="../template/footer.html" />
</div>
</div>


</body>
</html>