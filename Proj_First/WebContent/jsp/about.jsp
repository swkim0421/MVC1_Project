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
	<pre>
Java, Jsp, MySql, Connector J, DBCP, Cos 등을 사용한

첫번째 프로젝트.

게시판, 5가지와 회원인증 개발
	
각 게시판별도의 권환부여하여 게시판형 커뮤니티 사이트 구축.

기간 19.03.18 ~ 19.04.05
	</pre>
</div>

<div id="footer">
	<jsp:include page="../template/footer.html" />
</div>
</div>


</body>
</html>




