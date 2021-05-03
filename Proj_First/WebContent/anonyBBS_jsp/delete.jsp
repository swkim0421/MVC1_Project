<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="packBean.BoardBean"%>

<jsp:useBean id="bMgr" class="packBean.BoardMgr" scope="page" />
<%


	request.setCharacterEncoding("UTF-8");
	String nowpage = request.getParameter("nowpage");
	int num = Integer.parseInt(request.getParameter("num"));

	if (request.getParameter("pass") != null) {
		String inPass = request.getParameter("pass");
		BoardBean bean = (BoardBean) session.getAttribute("bean");
		String dbPass = bean.getPass();

		if (inPass.equals(dbPass)) {
			bMgr.deleteBoard(num);
			String url = "../jsp/anony.jsp?nowpage="+nowpage;
			response.sendRedirect(url);
		} else {
%>
<!-- 	deletesubmit해줘야함 -->
 <script> 
 alert("비밀번호를 확인해주세요");
 history.back();
 </script> 
<%
	} // 내부 if

	} else {
%>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>익명게시판 글삭제</title>
<script type="text/javascript" src="../script/script.js" ></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<link href="../css/style.css" rel="stylesheet" />
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


		<form name="chkFrm" method="post" action="delete.jsp">
			<table>

				
				<tr>
					<th >비밀 번호</th>
					<td><input type="password" name="pass" size="15"
						maxlength="15"></td>
				</tr>
				<tr>
					<td colspan="2" style="text-align:center">
					<input type="button" value="삭제하기" onclick="chkPass()" class="button">
					&nbsp;&nbsp;&nbsp; 
					<input type="reset" value="리셋" class="button">
					&nbsp;&nbsp;&nbsp;
					<input type="button" value="돌아가기" onclick="history.back();" class="button"></td>
				</tr>
			</table>
			<input type="hidden" name="nowpage" value="<%=nowpage%>">
			<input type="hidden" name="num" value="<%=num%>">

		</form>

</div>
</div>

	<div id="footer">
	<jsp:include page="../template/footer.html"/>
	</div>
	</div>

	<script type="text/javascript">
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

</body>
</html>

<%
	}
%>

