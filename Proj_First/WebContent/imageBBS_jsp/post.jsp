<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="bMgr" class="packImgBBS.BoardMgr"/>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String) session.getAttribute("idKey");
	String name=bMgr.getNicName(id);
	
%>
<!DOCTYPE html >
<html lang="ko">
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<script type="text/javascript" src="../script/script.js" ></script>
<link href="../css/style.css" rel="stylesheet" />
<title>글쓰기</title>
<script>
function check() {
	if(document.postFrm.pass.value ==""){
		alert("작성을 위해 패스워드를 입력하세요");
		document.postFrm.pass.focus();
		return false;
	}
	document.postFrm.action="postProc.jsp";
	document.postFrm.submit();
}

</script>
<style>


</style>
</head>
<body>

<div id="wrap">

<div id="header">
<jsp:include page="../template/header.html"/><br><br>
 </div>
 
 <div id="nav">
	<jsp:include page="../template/nav.jsp" />
</div>

<div id="subMenu">
	<jsp:include page="../template/side.jsp" />
</div>
 
<div id="main">

<form action="" method="post" enctype="Multipart/form-data" name="postFrm">
<input type="hidden" name="ip" value="<%=request.getRemoteAddr() %>">
<input type="hidden" name="id" value="<%=id %>">
  	<table>
  			<tr>
  			
					<td width="10%">닉네임</td>
					<td width="90%">
					<input type="text" name="name" size="30" maxlength="10" value="<%=name %>" readonly="readonly"></td>
				</tr>
				<tr>
					<td width="10%">제목</td>
					<td width="90%">
					<input type="text" name="subject" size="50" maxlength="15" required="required"></td>
				</tr>
				<tr>
					<td width="10%">내 용</td>
					<td width="90%"><textarea name="content" rows="10" cols="50" required="required"></textarea></td>
				</tr>
				<tr>
					<td width="10%">비밀 번호</td>
					<td width="90%"><input type="password" name="pass" size="15" maxlength="15"></td>
				</tr> 
				<tr>
					<td width="10%">파일찾기</td>
					<td width="90%"><input type="file" name="filename" size="50" maxlength="50"></td>
				</tr>
				
				<tr>
					<td colspan="2"><hr/></td>
				</tr>
				<tr>
					<td colspan="2">
							<input type="submit" value="등록" onclick="check()">
							<input type="reset" value="다시쓰기">
						<input type="button" value="리스트" onclick="location.href='list.jsp'">
						
						<input type="button" value="돌아가기" onclick="history.back()">						
						</td>
				</tr>
  			
  	
  	</table>
  	
	</form>
	</div>
	
	<div id="footer">
	<jsp:include page="../template/footer.html"/>
	</div>
	
</div> 
	
</body>
</html>