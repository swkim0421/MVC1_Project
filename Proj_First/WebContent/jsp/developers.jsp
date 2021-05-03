<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<% 
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, user-scalable=no">
<link href="../css/style.css" rel="stylesheet" />
<title>Team Second Project</title>
<style type="text/css">
	img{
		width: 150px;
	}
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
<div>

<h3>더 조은, Java curriculum Second Team Members ^^</h3>

	<div id="moon" style="margin-bottom: 10px; margin-top: 20px;; width: 65px; border-bottom: 2px solid #ddd;">
	1. 문승환 
	</div>
	<div style="width:90%; padding: 10px; border: 1px solid #ddd; display: none;">
		Pm, 템플릿 밑 CSS, 마이페이지, 팀원 서포트, 전체 게시판
		<br><br>
		<img alt="teemo" src="../image/teemo.png">
	</div>
	
	<div id="bae" style="margin-bottom: 10px; width: 65px; border-bottom: 2px solid #ddd;">
	2. 배효진
	</div>
	<div style="width:90% padding: 10px; border: 1px solid #ddd; display: none;">
		갤러리 게시판 / 댓글 기능
		<br><br>
		<img alt="teemo" src="../image/tree.jpeg">
	</div>
	
	<div id="hong" style="margin-bottom: 10px; width: 65px; border-bottom: 2px solid #ddd;">
	3. 홍석빈
	</div>
	<div style="width:90% padding: 10px; border: 1px solid #ddd; display: none;">
		회원가입, 익명게시판(못한것들=검색,페이징)
		<br><br>
		<img alt="teemo" src="../image/rumble.jpg">
	</div>
	
	<div id="kim" style="margin-bottom: 10px; width: 65px; border-bottom: 2px solid #ddd;">
	4. 김성원
	</div>
	<div style="width:90% padding: 10px; border: 1px solid #ddd; display: none;">
		자유게시판
		<br><br>
		<img alt="teemo" src="../image/bbobi.jpg">
	</div>
	
	<div id="lee" style="margin-bottom: 10px; width: 65px; border-bottom: 2px solid #ddd;">
	5. 이용진
	</div>
	<div style="width:90% padding: 10px; border: 1px solid #ddd; display: none;">
		공지사항 / 로그인,로그아웃 
		<br><br>
		<img alt="teemo" src="../image/kenen.jpg">
	</div>

</div>
</div>

<div id="footer">
	<jsp:include page="../template/footer.html" />
</div>
</div>


</body>
</html>


