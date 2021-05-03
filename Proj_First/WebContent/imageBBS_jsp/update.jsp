<%@page import="packImgBBS.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	
	String nowPage=request.getParameter("nowPage");
	
	BoardBean bean= (BoardBean)session.getAttribute("bean");
	int num=bean.getNum();
	String subject=bean.getSubject();
	String content=bean.getContent();
	String Pass=bean.getPass();
	String filename=bean.getFilename();
	String name=bean.getName();
	int filesize=bean.getFilesize();
	
%>
<!DOCTYPE html >
<html lang="ko">
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<script type="text/javascript" src="../script/script.js" ></script>
<link href="../css/style.css" rel="stylesheet" />
<title>수정하기</title>
<script>

function check() {
	if(document.upFrm.pass.value ==""){
		alert("작성을 위해 패스워드를 입력하세요");
		document.upFrm.pass.focus();
		return false;
	}
	document.upFrm.submit();
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
	<form action="updateProc.jsp" method="post" name="upFrm" enctype="Multipart/form-data">
	<dl>
		<dd>
			닉네임 : <%= name %> 
			
		</dd>
		
		<dd>
			제목 : 
			<input type="text" name="subject" size="50" maxlength="15" value="<%=subject %>">
		</dd>
		
		<dd>
			내용 :
			<textarea name="content" rows="10" cols="50"><%=content %></textarea>
		</dd>	
				
				
		<dd>	
		
		이미지찾기 :
			<input type="file" name="filename" size="50" maxlength="50"  accept=".jpg, .jpeg, .png" >
			<input type="hidden" name="filesize" value="filesize">
			원본 파일 :
			<%if(filename != null){ %>
			<%=filename %>
			<%}else{ %> 첨부된 파일없음<%} %>
		</dd>
		
		<dd>		
			<input type="submit" value="수정완료" >
			<input type="reset" value="다시쓰기">
			<input type="button" value="리스트" onclick="location.href='list.jsp'">
		</dd>
		<dd>
			<input type="hidden" name="num" value="<%=num %>">
			<input type="hidden" name="nowPage" value="<%=nowPage %>">
		</dd>	
	</dl>
	
	
	</form>
	</div>
	
 	<div id="footer">
	<jsp:include page="../template/footer.html"/>
	</div>
	
</div> 

</body>
</html>