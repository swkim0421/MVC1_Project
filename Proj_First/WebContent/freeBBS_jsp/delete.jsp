<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="packFreeBBS.BoardBean"%>
<jsp:useBean id="bMgr" class="packFreeBBS.BoardMgr"/>
<%
  		request.setCharacterEncoding("utf-8");
		String nowPage = request.getParameter("nowPage");
		int num = Integer.parseInt(request.getParameter("num"));
		if(request.getParameter("pass") != null){

			String inPass = request.getParameter("pass");
			BoardBean bean = (BoardBean) session.getAttribute("bean");
			String dbPass = bean.getPass();
			if(inPass.equals(dbPass)){
				bMgr.deleteFreeBoard(num);
				String url = "../jsp/free.jsp?nowPage=" + nowPage;
				response.sendRedirect(url);
			}else{
%>
<!DOCTYPE html>
<html lang = "ko">
<head>
	<meta charset="UTF-8">
	<title>작성글 삭제</title>
<script type="text/javascript">
	alert("입력하신 비밀번호가 아닙니다. 다시 입력해주시기 바랍니다.");
	history.back();
</script>
</head>
<body>
<%}
		} else{
%>
<script type="text/javascript">
function confirmcheck(){
	var confirmming = confirm("작성하신 글을 삭제하시겠습니까?");
	if(confirmming){
		true;
	}else{
		return false;
	}
	if(document.delFrm.pass.value ==""){
			alert("비밀번호를 입력하세요");
			document.delFrm.pass.focus();
			return false;
		}
		document.delFrm.submit();
	}
</script>
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
<br><br>
 <table>
 		<tr>
 				<td>
 					작성자의 비밀번호를 입력해주세요!
 				</td>
 		</tr>
</table>
<form name="delFrm" method="post" action="delete.jsp" >
 	<table>
	<tr>
			<td>
					<table>
					<tr>
						<td>
	<input type="password" name="pass" size="17" maxlength="15">
						</td>
						</tr>
						<tr>
							<td><hr size="1" color="#eeeeee"></td>					
 						</tr>
 						<tr>
 								<td>
 	<input type="button" value="삭제완료" onClick="confirmcheck()">
 	<input type="reset" value="다시쓰기">
 	<input type="button" value="뒤로가기" onClick="history.go(-1)"></td>
 						</tr>
 				</table>
 			</td>
 		</tr>
 	</table>
 		<input type="hidden" name="nowPage" value="<%=nowPage%>">
 			<input type="hidden" name="num" value="<%=num%>">
 		</form>
 </div>
 <%}%> 
 </div>
 	<div id="footer">
				<jsp:include page="../template/footer.html" />
    </div>
</div>
</body>
</html>