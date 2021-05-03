
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="bMgr" class="packImgBBS.BoardMgr"/>
<%@ page import="packImgBBS.BoardBean" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<script type="text/javascript" src="../script/script.js" ></script>
<link href="../css/style.css" rel="stylesheet" />
<title>Second Team Project</title>

<style>


</style>
</head>
<body>
<%
int totalRecord=0;			//전체 레코드 수

int numPerPage=10;		// 페이지 당 레코드 수
int pagePerBlock=5;		// 블럭 당 페이지 수

int totalPage=0;				//전체 페이지 수
int totalBlock=0;				//전체 블록 수

int nowPage=1;				//현재 페이지
int nowBlock=1;				//현재 블럭

int start=0;					//DB의 selet 시작번호
int end=10;					//시작번호로 부터 가져올 select 개수

int listSize=0;

///////////////////////////////////////////////////////
if(request.getParameter("nowPage") !=null){
	nowPage=Integer.parseInt(request.getParameter("nowPage"));
}

start=(nowPage * numPerPage) - numPerPage;
end=numPerPage;

totalRecord=bMgr.getTotalImgCount();

totalPage=(int)Math.ceil((double)totalRecord/numPerPage);
nowBlock=(int)Math.ceil((double)nowPage/pagePerBlock);

totalBlock=(int) Math.ceil((double)totalPage/pagePerBlock);
%>
<div id="wrap">

<div id="header">
<jsp:include page="../template/header.html"/><br><br>
 </div>
 
 <div id="nav">
	<jsp:include page="../template/nav.jsp" />
</div>

<div id="subMenu">
	<jsp:include page="../template/side.jsp" />
</div>
 
<div id="main">
  	<dl id="imgList_dl">
  		
  			<%
  			List<BoardBean> vlist=bMgr.getBoardImgList(start,end);
  			  			
				for(int i=0; i<vlist.size() ; i++){
					BoardBean bean=vlist.get(i);	
					int num=bean.getNum();
					String name=bean.getName();
					String subject=bean.getSubject();
					String regdate = bean.getRegdate();					
					int count=bean.getCount();
					String filename=bean.getFilename();
					int repCnt = 0;
					if(bMgr.replyCnt(num) > 0){
					repCnt=bMgr.replyCnt(num);
					}
			%>										  	
  			
  			<dd id="imgList_dd">
  			<div id="img_Subject" style="font-size: 12px;">
  				<div><a href="javascript:read('<%=num %>')" id="aImg">
  					<%if(filename != null){ %>
  					<img id="sumnail" src="http://192.168.0.79:8180/Proj_First/uploadFolder/thm_<%=filename %>" >
  					<%}else{ %><img id="nonImg" src="http://192.168.0.79:8180/Proj_First/uploadFolder/thm_nonimage.jpg" >
  					<%} %></a>
					</div>
  				<div style="width:130px; padding:0 5px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap">
  				<a href="javascript:read('<%=num %>')" ><%= subject %></a>
  				</div>
  				<div style="width:130px; padding:0 5px; color: red;">[<%=repCnt %>]</div>
  				<div style="width:130px; padding:0 5px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;margin-top: 5px;"><%=name %></div>
  				<div style="width:130px; padding:0 5px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap">조회수:<%=count %></div>
  			</div>
  			</dd>
  			  					  			  		
  	<%} %>
  	
  	</dl>
  	
  	<!-- 페이지 블럭 처리 -->
  	<hr>
  	<p id="img_page">
  	<%
		int pageStart=(nowBlock-1)*pagePerBlock + 1 ;//하단페이지 시작번호
		int pageEnd=((pageStart + pagePerBlock) < totalPage) ? 
				(pageStart +pagePerBlock) : totalPage+1;
			//하단 페이지 끝 번호
			
			if(totalPage !=0){
				if(nowBlock > 1) {%>
		<a href="javascript:block('<%=nowBlock-1%>')">이전</a>
		<%} %>&nbsp;
		
		<%for(;pageStart<pageEnd;pageStart++){ %>
		
		<a href="javascript:pageing('<%=pageStart%>')">
		 <%if(pageStart == nowPage) { %><font color="blue">
		 <%} %>
		 
		[<%=pageStart %>]
		
		<%if(pageStart==nowPage) {%></font><%} %> </a>
		
		<%} //for%> &nbsp;
		<%if(totalBlock> nowBlock) {%>
		<a href="javascript:block('<%=nowBlock+1%>')">다음</a>
		<%} %>&nbsp;
		<%} %>
	</p>
		<!--  페이징 및 블럭처리  -->
		
  	<form action="list.jsp" name="img_serchFrm" method="post">
	<table>
		<tr>
		<td>
		<% String id=(String)session.getAttribute("idKey");
				if(id != null || id == ""){ %>		
			<a href="post.jsp"><input type="button" class="button" value="글쓰기"></a>
		<% }%>
		
			<a href="javascript:list()"><input type="button" class="button" value="처음으로"></a>
		</td>
			
		</tr>
	</table>
	
</form>

</div>
	
<form name="listFrm" method="post">
	<input type="hidden" name="reload" value="true">
	<input type="hidden" name="nowPage" value="1">
</form>

<form name="readFrm" method="get">
	<input type="hidden" name="num"> 
	<input type="hidden" name="nowPage" value="<%= nowPage%>">	
</form>
  	
  	
 	<div id="footer">
	<jsp:include page="../template/footer.html"/>
	</div>
	
</div> 
	
	
<script>
function list() {
	document.listFrm.action="list.jsp";
	document.listFrm.submit();
}
function read(num) {
	document.readFrm.num.value=num;
	document.readFrm.action="read.jsp";
	document.readFrm.submit();
}
function pageing(page) {
	document.readFrm.nowPage.value=page;
	document.readFrm.submit();
}

function block(value) {
	document.readFrm.nowPage.value=<%=pagePerBlock %>*(value-1)+1;
	document.readFrm.submit();
}
</script>

</body>
</html>