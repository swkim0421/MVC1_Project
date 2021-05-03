<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="../script/script.js" ></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<link href="../css/style.css" rel="stylesheet" />
<title>title here</title>
</head>
<body>
	
	<div style="width: 450px; padding: 20px 10px; margin: 20px auto; text-align: center; border:1px solid black;" id="myInfosWrap">
	<p style="margin-bottom: 10px;">내정보를 수정하기 위해서는 비밀번호를 입력하셔야합니다</p>
	<p style="margin-bottom: 10px;"><input type="password" id="passModyfiy" name="passModyfiy" size="16" placeholder="비밀번호"></p>
	<input type="button" value="확인" class="button" onclick="myinfos_2();">
	</div>
</body>
</html>