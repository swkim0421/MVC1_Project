<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="packB.BoardBean_lyj" %>    
<%
	request.setCharacterEncoding("UTF-8");
	int num = Integer.parseInt(request.getParameter("num"));
	
	String nowPage = request.getParameter("nowPage");
	
	BoardBean_lyj bean = (BoardBean_lyj)session.getAttribute("bean");
	
	String subject = bean.getSubject();
	String name = bean.getName();
	String content = bean.getContent();
%>    
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="../script/script.js" ></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<link href="../css/style.css" rel="stylesheet" />
<title>수정스</title>
<script>
//페이지에 직접 스크립트 작성시 이곳에 입력
/* 	function chkPass() {
		if(confirm("수정 하시겠습니까?")) {
			submit();
		}
		
	} */
</script>
<style>
<!-- 페이지에 직접 css 작성시 이곳에 입력 -->

</style>
</head>
<body>
	<div id="wrap">
		<form name="chkFrm" method="post" action="updateProc_lyj.jsp">
			<table>
				<caption>수정하기</caption>
				<tr>
					<td class="bgColor"> 이 름 </td>
					<td><input type="text" name="name" value="<%=name%>" size="30" maxlength="20"></td>
				</tr>
				<tr>
					<td class="bgColor"> 제 목 </td>
					<td><input type="text" name="subject" value="<%=subject%>" size="50" maxlength="50"></td>
				</tr>
				<tr> 
				 	<td class="bgColor"> 내 용 </td>
				 	<td>
				  	<textarea name="content" rows="10" cols="50"><%=content %></textarea>
				  	</td>
	    		 </tr>
     			 <tr> 
     			 	<td class="bgColor"> 비밀 번호 </td>
				 	<td>
				   		<input type="password" name="pass" value="" size="15" maxlength="15">
				   </td>
				 </tr>
				 <tr> 
					<td colspan="2" style="text-align:center">
						<input type="button" value="수정완료" onclick="chkPass()">
						&nbsp;&nbsp;&nbsp;
						<input type="reset" value="리셋">
						&nbsp;&nbsp;&nbsp;
						<input type="button" value="돌아가기" onclick="history.back()">
					</td>
				</tr>	 
			</table>
						<input type="hidden" name="nowPage" value="<%=nowPage%>">
						<input type="hidden" name="num" value="<%=num%>">
		</form>
	</div>
</body>
</html>