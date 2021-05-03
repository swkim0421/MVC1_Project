<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <jsp:useBean id="mMgr" class = "packA.MemberMgr" scope="page"/>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	boolean result = mMgr.checkId(id);
%>
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="../script/script.js" ></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<link href="../css/style.css" rel="stylesheet" />
<title>ID중복체크</title>
<script>
//페이지에 직접 스크립트 작성시 이곳에 입력
</script>
<style>
<!-- 페이지에 직접 css 작성시 이곳에 입력 -->
p{
	border: 1 solid black;
	text-align: center;
	padding: 10px;
}
</style>
</head>
<body>
<div>
<p><b><%=id %></b>
<%
	if(result){
		out.print(" 는 이미 존재하는 ID입니다.");
	}else{
		out.print(" 는 사용 가능합니다.");
	}
%>
<br>
<span onclick = "self.close()">[닫 기]</span></p>
</div>
</body>
</html>