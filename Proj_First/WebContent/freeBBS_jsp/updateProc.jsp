<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bMgr" class="packFreeBBS.BoardMgr" />
<jsp:useBean id="bean" class="packFreeBBS.BoardBean" scope="session" />
<jsp:useBean id="upBean" class="packFreeBBS.BoardBean" />
<jsp:setProperty property="*" name="upBean" />

<%

		String nowPage = request.getParameter("nowPage");
		String upPass = upBean.getPass().trim(); 	//사용자 입력 비밀번호
		String inPass = upBean.getPass().trim();   //DB에 저장되어 있는 실제 비밀번호
		
		if(upPass.equals(inPass)){
			bMgr.updateFreeBoard(upBean);
		String url = "read.jsp?nowPage="+nowPage+"&num="+upBean.getNum();
					response.sendRedirect(url);
		}else{
%>
<!DOCTYPE html>
<html lang = "ko">
<head>
	<meta charset="UTF-8">
	<title>Untitled</title>
<script type="text/javascript">
		alert("입력하신 비밀번호가 아닙니다.");
		history.back();
</script>
</head>
<body>
<%}%>
</body>
</html>