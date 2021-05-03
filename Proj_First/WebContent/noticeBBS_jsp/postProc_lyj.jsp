<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="bMgr" class="packB.BoardMgr_lyj" />
<%
	request.setCharacterEncoding("UTF-8");

	int resCut = bMgr.insertBoard(request);
	if(resCut > 0) {
		response.sendRedirect("../jsp/notice.jsp");
	} else {
%>
<script>
	history.back();
</script>
<%
	}
%>