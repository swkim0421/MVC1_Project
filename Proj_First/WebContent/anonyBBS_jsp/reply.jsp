<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="bean" class="packBean.BoardBean" scope="session"/>
<%
	request.setCharacterEncoding("UTF-8");
	String nowpage = request.getParameter("nowpage");


%>
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="../script/script.js" ></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<link href="../css/style.css" rel="stylesheet" />
<title>익명게시판 답글 작성</title>
<script>
//페이지에 직접 스크립트 작성시 이곳에 입력
function replychk(){
	var frm = document.repFrm;
	
	if(frm.name.value==""){
		alert("닉네임을 지정해주세요");
		frm.name.focus();
		return false;
	}
	
	if(frm.subject.value==""){
		alert("제목을 지정해주세요");
		frm.name.focus();
		return false;
	}
	if(frm.content.value==""){
		alert("내용을 작성해 주세요");
		frm.name.focus();
		return false;
	}
	frm.submit();
	
}
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
<div>
<form action="replyProc.jsp" name ="repFrm" method="get">

<table>
<tr>
<td>닉네임<input type = "text" name="name"></td>
<td>비밀번호<input type = "password" name="pass"></td>
</tr>

<tr>
<td>제목<input type = "text" name="subject" size="20"></td>
</tr>

<tr>

<td>내용<textarea rows="12" cols="50" name="content"></textarea></td>
</tr>


<tr>
<td colspan="2">
<input type = "submit" value = "답변 작성" onclick ="replychk()">
<input type = "reset" value = "다시쓰기">
<input type ="button" value ="글 목록"onclick="location.href='list.jsp' ">
</td>
</tr>
</table>

<input type = "hidden" name = "ip" value = "<%=request.getRemoteAddr()%>">
<input type = "hidden" name="nowpage" value = "<%=nowpage%>">
</form>
</div>
</div>
<div id="footer">

<jsp:include page="../template/footer.html"></jsp:include>
</div></div>
</body>
</html>