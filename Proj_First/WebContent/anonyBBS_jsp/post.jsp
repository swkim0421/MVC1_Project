<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<script type="text/javascript" src="../script/script.js" ></script>
<link href="../css/style.css" rel="stylesheet" />
<title>익명게시판 게시글 작성</title>
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
<form action="postProc.jsp" name ="postFrm" method="post" enctype="multipart/form-data">
<table>
		<tr>
		<th>닉네임</th>
		<td>
		<input type ="text" name="name" maxlength="16" required>
		</td>
		</tr>
		<tr>
			<th>제 목</th>
			<td>
				<input type="text" name="subject" size="50" maxlength="30" required>
			</td>
		</tr>
		<tr>
			<th>내 용</th>
			<td>
				<textarea name="content" rows="10" cols="50" required></textarea>
			</td>
		</tr>
		<tr>
			<th>비밀 번호</th>
			<td>
				<input type="password" name="pass" size="15" maxlength="15" required>
			</td>
		</tr>
		<tr>
			<th>파일찾기</th>
			<td>
				<input type="file" name="filename" size="50" maxlength="50">
			</td>
		</tr>




<!--  html<input type ="radio" name="contentType" value = "HTML" >  -->
<!--  text<input type ="radio" name="contentType" size = "TEXT" checked>  -->




<tr>

<td colspan="2">
<input type = "submit" value = "게시글 작성">
<input type = "reset" value = "다시쓰기">
<input type ="button" value ="글 목록"onclick="location.href='list.jsp' ">
</td>

</tr>

</table>
<input type = "hidden" name = "ip" value ="<%=request.getRemoteAddr()%>">
</form>
</div>

<div id="footer">
	<jsp:include page="../template/footer.html" />
</div>
</div>
</body>
</html>