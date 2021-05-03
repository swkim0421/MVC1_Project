<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<script type="text/javascript" src="../script/script.js" ></script>
</head>
<body>
	<div id="navWrap">
	<ul style="display: inline-block; list-style: none;" id="boardLIst">
	<li><a href="http://localhost:8680//Proj_First/jsp/developers.jsp">Developer</a></li>
	<li><a href="http://localhost:8680/Proj_First/jsp/about.jsp">About</a></li>
	</ul>
	<%
		String id ="";
		int memberLevel = 0;
		if(session.getAttribute("idKey") != null){
		id = (String) session.getAttribute("idKey");
		memberLevel = (int) session.getAttribute("memberLevel");
		}
		if(id == ""){
	%>
	<form action="../template/navLoginProc.jsp" method="post" style="display: inline;" name="navFrm" id="navFrm">
	<ul id="navMenu" style="display: inline-block;float: right;">
		<li><input type="text" name="navId" required="required" size="16" placeholder="ID" id="navId"></li>
		<li><input type="password" name="navPass" required="required" size="16" placeholder="Password" id="navPass"></li>
		<li><input type="button" value="로그인" class="button" onclick="loginCheck2()"></li>
		<li><input type="button" value="회원가입" class="button" onclick="mainPageChange('member')"></li>
	</ul>
	</form>
	<%
	}else{
	%>
	<form action="../template/navLoginProc.jsp" method="post" style="display: inline;" name="navFrm" id="navFrm">
	<ul id="navMenu" style="display: inline-block;float: right;font-size: 13px;">
	<li><span id="myInfos">내정보</span> | 내 글
	<%
		if(memberLevel == 5){
			out.print("(관리자)");
		}
	%>
	</li>
	<li><input type="button" value="로그아웃" class="button" onclick="logOut()"></li>
	</ul>
	<input type="hidden" name="navLogout"  value="1">
	</form>
	<%
	}
	%>
	
	</div>
</body>
</html>