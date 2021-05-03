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
<title>글쓰기</title>
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

		<form name="postFrm" method="post" action="../noticeBBS_jsp/postProc_lyj.jsp" enctype="multipart/form-data">
			<table>
				<caption>글쓰기</caption>
				<tr>
					<th>성 명</th>
					<td>
						<input type="text" name="name" size="10" value="관리자" maxlength="8" required>
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
				<tr>
					<th>내용타입</th>
					<td>
						HTML <input type="radio" name="contentType" value="HTTP">
						TEXT <input type="radio" name="contentType" value="TEXT" checked>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align:center">
						<input type="submit" value="등록">
						<input type="reset" value="다시쓰기">
						<input type="button" value="뒤로가기" onclick="location.href='list_lyj.jsp'">
					</td>	 	
				</tr>	
			</table>
			<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
		</form>


</div>
<div id="footer">
	<jsp:include page="../template/footer.html" />
</div>
</div>
</body>
</html>