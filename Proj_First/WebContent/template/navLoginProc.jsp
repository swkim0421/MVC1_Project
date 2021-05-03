<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="nMgr" class="packA.mainMgr" />
<script>
<%
	int navLogout =0;
	if(request.getParameter("navLogout") !=null){
		navLogout = Integer.parseInt(request.getParameter("navLogout"));
	}
	String url =request.getHeader("referer");
	
	
	if(navLogout == 1){
		session.invalidate();
		%>
		alert("로그아웃 되었습니다.");
		location.href = "<%out.print(url); %>";
		<%
		
	}
	String id = "";
	id = request.getParameter("navId");
	String pass = "";
	pass = request.getParameter("navPass");
	
	if(id != "" && id != null){
		int memLevel = nMgr.navLogin(id, pass);
		
		if(memLevel != 0){
			session.setAttribute("idKey", id);
			session.setAttribute("memberLevel", memLevel);
			
			
			if(url.indexOf("/login.jsp") != -1){
				url = "../jsp/index.jsp";
			}
			
			
			%>
			alert("로그인 되었습니다.");
			location.href = "<%out.print(url); %>";
			<%
		}else{
			
			%>
			alert("아이디나 비밀번호를 확인해보세요.");
			history.go(-1);
			<%
			
		}
		
	}else{
		if(navLogout != 1){
		%>
		alert("올바르지 않은 로그인 방법입니다.");
		history.go(-1);
		<%
		}
	}
	
	
%>

</script>