<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
session.invalidate();
%>
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="../script/script.js" ></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<link href="../css/style.css" rel="stylesheet" />
<title>로그인</title>
<script>
//페이지에 직접 스크립트 작성시 이곳에 입력
alert("로그아웃 되었습니다.");
location.href="member_jsp/login.jsp";
</script>
<style>
<!-- 페이지에 직접 css 작성시 이곳에 입력 -->


</style>
</head>
<body>

</body>
</html>