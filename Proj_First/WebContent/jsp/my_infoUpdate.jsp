<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="memberBean" class="packA.memberBean" />
<jsp:setProperty property="*" name="memberBean" />
<jsp:useBean id="nMgr" class="packA.mainMgr" />
<script>
<%
	memberBean.setId((String) session.getAttribute("idKey"));
	int a = nMgr.myInfoUpdate(memberBean);
	if(a == 1){
		%>
		alert("정보 업데이트 완료되었습니다.");
		location.href="http://192.168.0.79:8180/Proj_First/jsp/index.jsp";
		<%
	}else{	
		%>
		alert("올바르지 않은 방법입니다.");
		location.href="http://192.168.0.79:8180/Proj_First/jsp/index.jsp";
		<%
			}
		%>
</script>




