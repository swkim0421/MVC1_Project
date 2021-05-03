<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import ="packBean.BoardBean" %>
    
<%
	request.setCharacterEncoding("UTF-8");
	int num = Integer.parseInt(request.getParameter("num"));
	String nowpage = request.getParameter("nowpage");
	
	BoardBean bean = (BoardBean)session.getAttribute("bean");
	String subject = bean.getSubject();
	String name = bean.getName();
	String content = bean.getContent();
%>

<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<link href="freeBBS_css/style_post.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../script/script.js" ></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<link href="../css/style.css" rel="stylesheet" />
<title>익명게시판 글수정</title>
<script>
//페이지에 직접 스크립트 작성시 이곳에 입력
function chkPass(){
	
		var frm = document.chkFrm;
		if (frm.pass.value == "") {
			alert("패스워드를 입력하세요.");
			frm.pass.focus();
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
<form name ="chkFrm" method="post" action="updateProc.jsp">
<table>
<tr>
<td>작성자</td>
<td><input type ="text" name = "name" value ="<%=name%>"></td>
</tr>

<tr>
<td>제목</td>
<td><input type ="text" name = "subject" value ="<%=subject%>"></td>
</tr>

<tr>
<td>내용</td>
<td><textarea name = "content" rows = "9" cols="50"> <%=subject%></textarea></td>
</tr>

<tr>
<td>비밀번호</td>
<td><input type ="password" name ="pass" value = ""></td>
</tr>

<tr> 
	 <td colspan="2" >
	<input type="button" value="수정완료" onclick="chkPass()">
			&nbsp;&nbsp;&nbsp;
	<input type="reset" value="리셋">
			&nbsp;&nbsp;&nbsp;
	<input type="button" value="돌아가기" onclick="history.back();">
	 </td>
	 </tr>
	 </table>
	 <input type = "hidden" name="nowpage" value ="<%=nowpage%>">
	 <input type = "hidden" name="num" value ="<%=num%>">
	 </div>
	 </div>
	 <div id="footer"></div>
	<jsp:include page="../template/footer.html"/>
	
</form>
</body>
</html>