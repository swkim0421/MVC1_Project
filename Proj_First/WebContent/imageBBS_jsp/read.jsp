<%@page import="java.util.List"%>
<%@page import="javax.security.auth.Subject"%>
<%@page import="packImgBBS.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = (String)session.getAttribute("idKey");
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="packImgBBS.BoardBean" scope="session"/>

<jsp:useBean id="bMgr" class="packImgBBS.BoardMgr"/>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<script type="text/javascript" src="../script/script.js" ></script>
<link href="../css/style.css" rel="stylesheet" />
<title>글읽기</title>
<script>


</script>
<style>


</style>
  </head>
  <body>
  
	<%
	int num=Integer.parseInt(request.getParameter("num"));
	
	
	String nowPage=request.getParameter("nowPage");
	bMgr.upCount(num); // 조회수
	
	
	//////
	BoardBean bean=bMgr.getImgBoard(num);
	String filename=bean.getFilename();
	String regdate=bean.getRegdate();
	String name=bean.getName();
	String subject=bean.getSubject();
	int count=bean.getCount();
	String content=bean.getContent();
	String bbsId=bean.getId();
	int filesize=bean.getFilesize();
	session.setAttribute("bean", bean);
	///////
	
// 	String user=user.getName();
	
	//
	
	%>
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
		<div style="margin: 20px;font-size: 14px;">
			<%if( filename != null && !filename.equals("")) {%>
				<div style="margin-bottom: 20px;">
				<img src="http://192.168.0.79:8180/Proj_First/uploadFolder/<%= filename%>">
				</div>
			<%}	%>
			<pre style="width:100%;white-space:normal;"><%=content%></pre>  

		</div>
	
		<div style="margin: 20px;font-size: 12px; border-bottom: 2px solid #ddd; padding-bottom: 5px;">
		<%
			List<BoardBean> vlist=bMgr.getReplyBoard(num);
		%>
			<div style="margin-top: 20px;">
			<div style="margin-top: -2px;float: left;margin-right: 4px;"><img src="../image/icon_arrow_red1.gif"></div>
			<b>코멘트(<font style="color: red;"><%=vlist.size() %></font>)</b>
			</div>
		</div>

		<div style="margin: 20px;font-size: 12px; border-bottom: 2px solid #ddd; padding-bottom: 5px;">
		<%
		for(int i=0;i<vlist.size();i++){
			BoardBean bean1=vlist.get(i);
			
			%>
			<div>
			<span style="font-size: 14px;"><%=bean1.getName() %></span>
			<span style="color: gray;">(<%=bean1.getRegdate()%>)</span>
			</div>
				
			<div style="margin: 20px 20px 20px 0px;">
			
			
<pre style="width:100%;white-space:normal;word-break:break-all;"><%=bean1.getContent() %></pre>
			</div>
		<%
		}
		%>
		</div>

	
	
	
	
	<div style="width: 100%; text-align: center;clear: both; margin-left: 20px;">
	<form  name="repFrm" method="get">
		<textarea id="contentsText" name="content"  onFocus="clearText(content)" style="color:#696969; resize: none; width: 466px; height: 66px; padding: 3px;float: left;" >댓글을 작성해주세요</textarea>
  		<input type="button" value="등록"  onclick="javascript:check('<%= id %>')" style="width: 75px;height: 75px;background-color: white;border-radius: 2px;border: 1px solid #a5a4a4;float: left; margin-left: 5px;">
  		<input type="hidden" name="nowPage" value="<%=nowPage %>"> 
  		<input type="hidden" name="num" value="<%=num %>">
	</form>
	</div>
		
		
		
	<div style="clear: both; margin: 20px 0px 10px 20px; padding-top: 20px;">
	<a href="javascript:list()"><input type="button" value="목록"  class="button"></a>
	<%
	if(id != null && id != ""){
	if(id.equals(bbsId)){
		%>
	
	<a href="update.jsp?nowPage=<%=nowPage%>"><input type="button" value="수정"  class="button"></a>
	<a href="delete.jsp?nowPage=<%=nowPage%>"><input type="button" value="삭제"  class="button"></a>
	
	<%}
	}%>	
	</div>

	
	</div>
	
	<div id="footer">
	<jsp:include page="../template/footer.html" />
	</div>
	
	</div>
	
			
	<form action="download.jsp" name="downFrm" method="post">
	<input type="hidden" name="filename">
	</form>
	
	<form name="listFrm" method="post">
		<input type="hidden" name="num" value="<%=num %>">
		<input type="hidden" name="nowPage" value="<%=nowPage %>">		
	</form>
	
	
  	
	<script type="text/javascript">
	function list() {
		document.listFrm.action="list.jsp";
		document.listFrm.submit();
	}
	
	function down(filename) {
		document.downFrm.filename.value=filename;
		document.downFrm.submit();
	}
	
	function check(id) {
		if(id != "null"){		
		document.repFrm.action="replyProc.jsp";
		document.repFrm.submit();
		}else{
			alert("로그인하세요");
			document.repFrm.action="../jsp/login.jsp";
			document.repFrm.submit();
			
		}
	}
	
	function clearText(txt) {
	    if (txt.defaultValue==txt.value){
	        txt.value = "";	        
	    }
	    
	    $("#contentsText").css("color","#000000");
	    
	}
	</script>
	
	</body>
</html>
  	
  