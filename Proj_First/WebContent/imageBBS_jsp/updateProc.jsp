<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="bMgr" class="packImgBBS.BoardMgr"/>

<%
	request.setCharacterEncoding("UTF-8");
	String url=null;
	

	url = bMgr.updateImgBoard(request);	
	
	
	
	
	if(url.equals("1")){
		//오류처리해라
		
	}

	response.sendRedirect(url);
%>
<script>

alert("<%=url%>");
</script>