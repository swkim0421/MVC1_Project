<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<script type="text/javascript" src="../script/script.js" ></script>
<link href="../css/style.css" rel="stylesheet" />
<title>title here</title>
<script>
//페이지에 직접 스크립트 작성시 이곳에 입력

</script>
<style>
<!-- 페이지에 직접 css 작성시 이곳에 입력 -->

</style>
</head>
<body>
	<div>
	<ul id="sideMenuMember">
	<%
		String id ="";
		int memberLevel = 0;
		if(session.getAttribute("idKey") != null){
		id = (String) session.getAttribute("idKey");
		memberLevel = (int) session.getAttribute("memberLevel");
		}
		if(id == ""){
	%>
		<li id="login" onclick="mainPageChange(this.id)">
			로그인
		</li>
		<li id="member" onclick="mainPageChange(this.id)">
			회원 가입
		</li>
	<%
	}else{
	%>
		<li id="logout_Proj" onclick="javascript:location.href='http://localhost:8680/Proj_First/jsp/logout_Proj.jsp'">
		로그아웃
		</li>
	<%} %>
	</ul>
	<div style="width: 80%; margin-top: 15px;">
		<hr>
	</div>
	<ul id="sideMenu">
		<li><a href="http://localhost:8680/Proj_First/jsp/all.jsp">전체게시판</a></li>
		<li><a href="http://localhost:8680/Proj_First/jsp/notice.jsp">공지사항</a></li>
		<li><a href="http://localhost:8680/Proj_First/jsp/free.jsp">자유게시판</a></li>
		<li><a href="http://localhost:8680/Proj_First/imageBBS_jsp/list.jsp">이미지게시판</a></li>
		<li><a href="http://localhost:8680/Proj_First/jsp/anony.jsp">익명게시판</a></li>
		<li><a href="http://localhost:8680/Proj_First/jsp/faq.jsp">FAQ</a></li>
	</ul>
	</div>
</body>
</html>