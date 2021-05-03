<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="ub" class="packA.FaqBean" />
<jsp:useBean id="mgr" class="packA.mainMgr" />
<jsp:setProperty property="*" name="ub"/>
<script>
<%

	if(request.getParameter("modifyMode") != null){
		int result = mgr.updateFaq(ub);
		if(result == 1){
			%>
			alert("수정이 정상적으로 완료 되었습니다.");
			location.href="faq.jsp";
			<%
		}
	}else{
	int result = mgr.insertFaqBoard(ub);
	if(result == 1){
%>
	alert("정상적으로 등록되었습니다.");
	location.href="faq.jsp";
<%}else{%>
	alert("비정상적으로 등록되었습니다.");
	history.go(-1);
<%}}%>

</script>