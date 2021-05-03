<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<link href="../css/style.css" rel="stylesheet" />
<title>로그인</title>
<script>
//페이지에 직접 스크립트 작성시 이곳에 입력
	window.onload = function() {
		
		if(getCookie("id")	) { // getCookie함수로 id라는 이름의 쿠키를 불러옴
			document.loginFrm.id.value = getCookie("id");	// input 이름이 id인곳에 getCookie
			document.loginFrm.idsave.checked = true; // 체크는 체크됨
		}
	}
	
	function setCookie(name, value, expiredays) {//쿠키 저장함수
		var todayDate = new Date();
		todayDate.setDate(todayDate.getDate() + expiredays);
		document.cookie = name + "=" + escape(value) + ";path=/; expires="
			+ todayDate.toGMTString() + ";"
	}
	
	function getCookie(Name) {	// 쿠키 불러오는 함수
		var search = Name + "=";
		if(document.cookie.length > 0) { // if there are any cookies
			offset = document.cookie.indexOf(search);
			if(offset != -1) { // if cookie exists
				offset += search.length;	// set index of beginning of value
				end = document.cookie.indexOf(";", offset); // set index of end of cookie value
				if(end == -1)
					end = document.cookie.length;
				return unescape(document.cookie.substring(offset, end));
			}
		}
	}

	function loginCheck() {
		if(document.loginFrm.id.value == "") {
			alert("아이디를 입력해 주세요.");
			document.loginFrm.id.focus();
			return;
		}
		if(document.loginFrm.pass.value == "") {
			alert("비밀번호를 입력해 주세요.");
			document.loginFrm.pass.focus();
			return;
		}
		
		if(document.loginFrm.idsave.checked == true) { // 아이디 저장을 체크 하였을때
			setCookie("id", document.loginFrm.id.value, 7);	// 쿠키이름을 id로 아이디입력필드값을 7일동안 저장
		} else { // 아이디 저장을 체크 하지 않았을때
			setCookie("id", document.loginFrm.id.value, 0); // 날짜를 0으로 저장하여 쿠키삭제
		}
		
		document.loginFrm.submit();
	}
	
	function goJoin() {
		location.href="member.jsp";	// 석빈이 회원가입으로 넘어감
	}
</script>
<style>
<!-- 페이지에 직접 css 작성시 이곳에 입력 -->

</style>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("idKey");
%>
<body>


	<div id="loginWrap">
		<form name="loginFrm" action="loginProc_Proj.jsp" method="get">
			<div style="margin-top: 5px; text-align: center;">
			<input type="text" name="id" required placeholder="아이디">
			</div>
			<div style="margin-top: 5px; text-align: center;">
	    	<input type="password" name="pass" required placeholder="비밀번호" id="loginPass">
	  		</div>
	  		
	  		<div style="margin-top: 5px; text-align: center;">
	  		<input type="checkbox" name="idsave" value="saveOk" style="width:20px;height:15px;"><span style="font-size:15px;">아이디 저장</span>
	    	</div>
	    	
	  		<div style="margin-top: 10px; text-align: center;">
	    	<input type="button" class="button"  value="로그인" onclick="loginCheck()">
	    	<input type="button"  class="button" value="회원가입" onclick="goJoin()">
	    	</div>
	    	
	    	
		</form>
	</div>
	
</body>
</html>