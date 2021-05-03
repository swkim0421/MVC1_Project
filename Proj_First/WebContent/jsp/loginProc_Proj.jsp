<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="packA.MemberMgr_Proj" />
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	String url = "index.jsp";
	String msg = "로그인 정보가 일치하지 않습니다.";


	int result = mMgr.loginMember(id, pass); // 1, 5 넘어옴
	
	if(result == 5) {
		session.setAttribute("idKey", id);	// 로그인 확인 시 아래 내용 출력
		session.setAttribute("memberLevel", result);
		msg = "관리자로 로그인에 성공 하였습니다.";
		
	} else if(result == 1){
		session.setAttribute("idKey", id);	// 로그인 확인 시 아래 내용 출력
		session.setAttribute("memberLevel", result);
		msg = "로그인에 성공 하였습니다.";
	}
%>
<script>
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>
