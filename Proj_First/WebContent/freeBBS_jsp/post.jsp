<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*" %>
<%@page import="packFreeBBS.BoardBean" %>
<jsp:useBean id="bMgr" class="packFreeBBS.BoardMgr" />
<%
		request.setCharacterEncoding("UTF-8");

		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd aHH:mm");
		String today = formatter.format(new java.util.Date());
		
		//로그인한 계정의 이름이 작성자로 입력이 된다.
		String id = (String) session.getAttribute("idKey");
		String userName = bMgr.getWriterName(id);
%>
<!DOCTYPE html>
<html lang = "ko">
<head>
	<meta charset="UTF-8">
	<title>게시판 글쓰기</title>
<link href="freeBBS_css/style_post.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="freeBBS_script/script.js" ></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<script type="text/javascript" src="../script/script.js" ></script>
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
<br/><br/>
<h2>게시판 글쓰기</h2>
<br/>
	<form name="postFrm" method="post" action="postProc.jsp" enctype="multipart/form-data">
	<table>
	<tr>
		<td>
			<table>
				<tr>
					<td>작성자</td>
					<td>	<input type="text" name="name" size="30" maxlength="20" value="<%=userName %>" readonly="readonly"></td>
				</tr>
				<tr>
						<td>제 목</td>
						<td>
						<input type="text" name="subject" size="50" maxlength="30" required></td>
						</tr>
         						<tr>
         							<td>내 용</td>
         							<td><textarea name="content" rows="10" cols="50" ></textarea></td>
						</tr>
					<tr>
								<td>비밀 번호</td>
								<td><input type="password" name="pass" size="15" maxlength="15" required></td>
						</tr>
						<tr>
						  <tr>
						  		<td>첨부 파일</td>
						  		<td><input type="file" name="filename" size="50" maxlength="50"></td>
						 </tr>
						 		<tr>
						 				<td>내용타입</td>
						 <td> HTML<input type=radio name="contentType" value="HTTP" >
						 &nbsp;&nbsp;&nbsp;
						 						TEXT<input type=radio name="contentType" value="TEXT" checked>
						 										</tr>
						 			<tr>
						 						<td colspan="2">작성일 : <%=today%><hr/></td>
						 			</tr>
						 			<tr>
						 					<td colspan="2">
						 									<input type="submit" value="등록">
						 									<input type="reset" value="다시쓰기">
						 		<input type="button" value="리스트" onClick="javascript:location.href='../jsp/free.jsp'">
						 					</td>
						 				</tr>
						 	</table>
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