<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="packB.BoardBean_lyj" %>
<jsp:useBean id="bMgr" class="packB.BoardMgr_lyj" scope="page" />    
<jsp:useBean id="mMgr" class="packA.MemberMgr_Proj" />
<%
	request.setCharacterEncoding("UTF-8");
	int num = Integer.parseInt(request.getParameter("num"));
	String nowPage = request.getParameter("nowPage");
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");
	
	
	Vector<Integer> list = new Vector();
	int checkNum = 0;
	for(int i=0; i < list.size(); i++){
		if(list.get(i)!=num){
			checkNum = 1;
		};
	}
	if(checkNum != 1){
		list.add(num);
		bMgr.upCount(num);	// 조회수 증가
	}
	
	
	
	
	BoardBean_lyj bean = bMgr.getBoard(num); // 게시물 가져오기
	String name = bean.getName();
	String subject = bean.getSubject();
	String regdate = bean.getRegdate();
	String content = bean.getContent();
	String filename = bean.getFilename();
	int filesize = bean.getFilesize();
	String ip = bean.getIp();
	int count = bean.getCount();
	session.setAttribute("bean", bean);	// 게시물을 세션에 저장
	
	
	String id = "";
	if(session.getAttribute("idKey") != null){
		id = (String) session.getAttribute("idKey");
	}
	int result = mMgr.loginMember(id, ""); // 1, 5 넘어옴
	
	
%>
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<script type="text/javascript" src="../script/script.js" ></script>
<link href="../css/style.css" rel="stylesheet" />
<title>Team Second Project - Notice Read</title>
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

		<div style="padding: 7px 0px;background-color: #ededed;font-size: 13px;padding-left: 3px;text-align: center;">
		<span style="width: 15%;display: inline-block;"><%=name%></span>
		<span style="width: 65%;display: inline-block;"><%=regdate%></span>
		<span style="width: 15%;display: inline-block;">조회 : <%=count%></span>
		</div>
		<div style="float: right;font-size: 12px;">
			<span>첨부파일 :</span>
			<% if( filename != null && !filename.equals("")) { %>
					<a href="#" title="" onclick="down('<%=filename%>')">
					<%=filename%>
					</a>
						&nbsp;&nbsp;
						<span style="color:blue">
						(<%=filesize%>Bytes)
						</span>
				<% } else { %>		
					등록된 파일이 없습니다.
				<% } %>
		</div>
		<div style="margin-top: 80px; margin-left: 30px;">
			<h1 style="font-size: 14pt;font-weight: bold;color: brown;"><%=subject%></h1>
		</div>
		
		<div style="margin: 20px;font-size: 12px;">
			<pre style="width:100%;white-space:normal;"><%=content%></pre>
		</div>
		
		
		<div style="float: right;font-size: 11px; color: gray;">
				<%=ip%>
		</div>
		<div style="clear: both;"></div>
		
		<div style="margin-top: 25px; border: 1px solid #ddd; margin-bottom: 10px;"></div>
		
		<a href="../jsp/notice.jsp" ><input type="button" value="리스트"  class="button"></a> 
		
		<% if(result == 5){ %>
		<a href="../noticeBBS_jsp/update_lyj.jsp?nowPage=<%=nowPage%>&num=<%=num%>" ><input type="button" value="수정"  class="button"></a>
		<a href="../noticeBBS_jsp/delete_lyj.jsp?nowPage=<%=nowPage%>&num=<%=num%>"><input type="button" value="삭제"  class="button"></a>
		<% } %>
		 
		<form name="downFrm" action="../noticeBBS_jsp/download_lyj.jsp" method="post">
			<input type="hidden" name="filename">
		</form>
		
		<form name="listFrm" method="post">
			<input type="hidden" name="num" value="<%=num%>">
			<input type="hidden" name="nowPage" value="<%=nowPage%>">
			<%if(!(keyWord==null || keyWord.equals("null"))){ %>
			<input type="hidden" name="keyField" value="<%=keyField%>">
			<input type="hidden" name="keyWord" value="<%=keyWord%>">
			<%}%>
		</form>
	
	</div>

<div id="footer">
	<jsp:include page="../template/footer.html" />
</div>
</div>
</body>
</html>