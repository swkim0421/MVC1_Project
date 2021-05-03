<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <jsp:useBean id="bean" class="packA.memberBean" scope="page"/>
 <jsp:useBean id="mMgr" class="packA.MemberMgr" scope="page"/>
 <jsp:setProperty property="*" name="bean"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

</head>
<body>
<% 
	request.setCharacterEncoding("UTF-8"); 
	boolean result = mMgr.inserttotblmember(bean);
	String alertMsg = "";
	String sendUrl = "";
	
	if(result){
		alertMsg = "회원가입을 축하합니다";
		sendUrl = "http://localhost:8680/Proj_First/jsp/index.jsp";
	}else{
		sendUrl = "member.jsp";
		alertMsg = "회원가입에 실패하였습니다 축하합니다. 다시 가입하십시오";
	}	
%>
<script type="text/javascript">

alert("<%=alertMsg%>");
location.href="<%=sendUrl%>";

</script>
</body>
</html>
