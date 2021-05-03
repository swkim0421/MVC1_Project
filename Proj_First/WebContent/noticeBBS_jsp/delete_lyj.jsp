<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="packB.BoardBean_lyj" %>
<jsp:useBean id="bMgr" class="packB.BoardMgr_lyj" scope="page" />    
<%
	request.setCharacterEncoding("UTF-8");
	String nowPage = request.getParameter("nowPage");
	int num = Integer.parseInt(request.getParameter("num"));
	
	if(request.getParameter("pass") != null) { // null 아닐경우
		String inPass = request.getParameter("pass");
		BoardBean_lyj bean = (BoardBean_lyj) session.getAttribute("bean");
		String dbPass = bean.getPass();
		
		if(inPass.equals(dbPass)) {
			bMgr.deleteBoard(num);
			String url = "list_lyj.jsp?nowPage=1";
			response.sendRedirect(url);
		} else {
%>
<script>
//페이지에 직접 스크립트 작성시 이곳에 입력
	alert("비밀번호를 확인해주세요");
	history.back();
</script>
<%
		} // 내부 if
	} else {
%>
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="../script/script.js" ></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<link href="../css/style.css" rel="stylesheet" />
<title>삭제스</title>

<style>
<!-- 페이지에 직접 css 작성시 이곳에 입력 -->

</style>
</head>
<body>

	<div id="wrap">
		<form name="chkFrm" method="post" action="delete_lyj.jsp">
			<table>

				<caption>게시물 삭제용 비밀번호 확인</caption>
				<tr>
					<th class="bgColor">비밀 번호</th>
					<td><input type="password" name="pass" size="15"
						maxlength="15"></td>
				</tr>
				<tr>
					<td colspan="2" style="text-align:center">
					<input type="button" value="삭제하기" onclick="chkPass()">
					&nbsp;&nbsp;&nbsp;
					<input type="reset" value="리셋">
					&nbsp;&nbsp;&nbsp;
					<input type="button" value="돌아가기" onclick="history.back();"></td>
				</tr>
			</table>
			<input type="hidden" name="nowPage" value="<%=nowPage%>">
			<input type="hidden" name="num" value="<%=num%>">
		</form>
	
	</div>
</body>
</html>
<%
	}
%>