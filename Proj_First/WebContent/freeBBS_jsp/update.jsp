<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="packFreeBBS.BoardBean" %>
<jsp:useBean id="bMgr" class="packFreeBBS.BoardMgr" />
<%
		request.setCharacterEncoding("utf-8");

		int num = Integer.parseInt(request.getParameter("num"));
		String nowPage = request.getParameter("nowPage");
		BoardBean bean = (BoardBean)session.getAttribute("bean");
		String subject = bean.getSubject();
		String name = bean.getName();
		String content = bean.getContent();
		
		String filename = bean.getFilename();
		int filesize = bean.getFilesize();
		
		//로그인한 계정의 이름이 작성자로 입력이 된다.
		String id = (String) session.getAttribute("idKey");
		String userName = bMgr.getWriterName(id);
%>
<!DOCTYPE html>
<html lang = "ko">
<head>
	<meta charset="UTF-8">
	<title>수정 : <%=subject%></title>
<link href="freeBBS_css/style_post.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="freeBBS_script/script.js" ></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<script type="text/javascript" src="../script/script.js" ></script>
<link href="../css/style.css" rel="stylesheet" />
<script>
	function check(){
		if(document.updateFrm.pass.value== ""){
			alert("비밀번호를 입력해주셔야 합니다.");
			document.updateFrm.pass.focus();
			return false;
		}
		document.updateFrm.submit();
	}
</script>
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
<br/><br/>
<h2>수정하기</h2>
	<form name="updateFrm" method="post" action="updateProc.jsp">
	<table>
		<tr>
			<td>
				<table>
					<tr>
						<td>작성자</td>
					<td>	<input type="text" name="name" size="30" maxlength="20" value="<%=userName %>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>제 목</td>
				<td>
					<input type="text" name="subject" size="48" value="<%=subject%>" maxlength="50">
				</td>
					<tr>
						<td>내 용</td>
				<td>
					<textarea name="content" rows="10" cols="50"><%=content%></textarea>
				</td>
					</tr>
					  <tr>
						<td>첨부 파일</td>
						<td>
							<input type="file" name="filename" size="50" maxlength="50"  accept="All types (*,*)" >
							<!-- <input type="hidden" name="filesize" value="filesize">-->
						<% if( filename !=null && !filename.equals("")) {%>
   				  	<a href="#('<%=filename%>')" id="downloadFile"><%=filename%></a>
   				  	<font color="blue">(<%=filesize%>KBytes)</font>
   				  	<%} else{%>등록된 파일이 없습니다.<%}%>
   				  	</td>
				    </tr>
			    <tr>
					<td>비밀 번호</td>
				<td><input type="password" name="pass" size="15" maxlength="15">
					입력하신 비밀번호를 입력해주세요</td>
				</tr>
		 <tr>
		 		<td colspan="2" height="5"><hr/></td>
		 		</tr>
		 <tr>
		 		<td colspan="2">
			<input type="hidden" name="num" value="<%=num%>">
		 	<input type="button" value="수정완료"  onClick="check()">
		 	<input type="reset" value="다시수정"> 
		 	<input type="button" value="뒤로가기" onClick="history.go(-1)">
		</td>
			</tr>
			</table>
		</td>
	</tr>
		</table>
		<input type="hidden" name="nowPage" value="<%=nowPage %>">	
		<input type="hidden" name="num" value="<%=num%>">	
</form>
	</div>
</div>
	<div id="footer">
	<jsp:include page="../template/footer.html" />
</div>
</div>
</body>
</html>