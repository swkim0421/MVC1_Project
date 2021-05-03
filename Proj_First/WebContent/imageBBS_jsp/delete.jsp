<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="packImgBBS.BoardBean" %>
<jsp:useBean id="bMgr" class="packImgBBS.BoardMgr"/>
<jsp:useBean id="bean" class="packImgBBS.BoardBean" scope="session"/>


<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">	
	<%
	request.setCharacterEncoding("UTF-8");
	String nowPage=request.getParameter("nowPage");
	int num=bean.getNum();
	
	if(request.getParameter("pass") != null){
		//비번을 입력해서 세션에 있는 pass 비교 요청
		String inPass=request.getParameter("pass");
		
		String dbPass=bean.getPass();
		
		if(inPass.equals(dbPass)){
			bMgr.deleteBoard(num);
			String url="list.jsp?nowPage=" + nowPage;
			response.sendRedirect(url);
		}else{
			
%>
<script type="text/javascript">
alert("입력하신 비밀번호가 아닙니다.")
history.back();
</script>
<%}
		}else {
%>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<script type="text/javascript" src="../script/script.js" ></script>
<link href="../css/style.css" rel="stylesheet" />
<title>title here</title>
<script>

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

	<div>
  	<br><br>
  	<table>
  			<tr>
  				<td>정말 지우시려면 사용자의 비밀번호를 입력해주세요.</td>
  			</tr>
  			
  	</table>
  	<form action="delete.jsp" name="delFrm" method="post">
  		<table>
  			<tr>
  				<td>
  					<table>
  					<tr>
  						<td>
  						<%out.print(bean.getPass()); %>
  						<input type="password" name="pass" size="17" maxlength="15" required>
  						</td>
  					</tr>
  					<tr>
  						<td><hr></td>
  					</tr>  	
  					<tr>				
  						<td>
  						<input type="submit" value="삭제완료" >
  						<input type="reset" value="다시쓰기">
  						<input type="button" value="뒤로" onclick="history.go(-1)">
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
  <%} %>
  
  </div>
 	 <div id="footer">
	<jsp:include page="../template/footer.html"/>
	</div>
</div>
 
</body>
</html>