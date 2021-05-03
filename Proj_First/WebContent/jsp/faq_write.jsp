<%@page import="packA.FaqBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String id ="";
	int memberLevel = 0;
	if(session.getAttribute("idKey") != null){
	id = (String) session.getAttribute("idKey");
	memberLevel = (int) session.getAttribute("memberLevel");
	}
	
	
	
	String num = "";
	if(request.getParameter("num") != null){
		num = request.getParameter("num");
	}
	
	
%>
<jsp:useBean id="mgr" class="packA.mainMgr"/>
<%
	FaqBean fb = new FaqBean();
	fb.setTab("");
	fb.setSubject("");
	fb.setContent("");
	
	if(!num.equals("")){
	fb = mgr.modifyData(Integer.parseInt(num));
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<script type="text/javascript" src="../script/script.js" ></script>
<link href="../css/style.css" rel="stylesheet" />
<link href="../css/main.css" rel="stylesheet" media="all">
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
	<div id="faqWrite">
	<span><h2>새로운 자주묻는 질문 등록.</h2></span>
	<div style="width: 100%; padding: 10px; margin-top: 10px;">
	<form action="faq_writeProc.jsp" method="post">
	
	<div class="input-group">
	<input class="input--style-1" type="text" placeholder="Tab" name="tab" style="width: 50%" value="<%=fb.getTab()%>">
	</div>
	
	<div class="input-group">
	<input class="input--style-1" type="text" placeholder="Subject" name="subject" style="width: 50%" value="<%=fb.getSubject() %>">
	</div>
	
	<div class="input-group">
	<textarea name="content" placeholder="Content" style="width: 100%; min-height: 300px; resize: none;"><%=fb.getContent() %></textarea>
	</div>
	
	
	<input type="hidden" name="id" value="<%=id %>">
	<%
		if(!num.equals("")){
			%>
		<input type="hidden" name="modifyMode" value="1">
		<input type="hidden" name="num" value="<%=num %>">
			<%
		}
	%>
	
	
	<div style="text-align: center;margin-bottom: 20px;">
  	<button onclick="inputCheck()" class="button" style="width: 80px;height: 30px">확인</button>
  	<input type="reset" value="다시쓰기" class="button"  style="width: 80px;height: 30px">
	</div>
			
			
	</form>
	</div>
</div>
</div>

<div id="footer">
	<jsp:include page="../template/footer.html" />
</div>
</div>





</body>
</html>