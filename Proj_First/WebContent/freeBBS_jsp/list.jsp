<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8"); //데이터가 수신되는 것
%>
<%@page import="packFreeBBS.BoardBean"%>
<%@ page import="packFreeBBS.BoardMgr" %>
<jsp:useBean id="bMgr" class="packFreeBBS.BoardMgr" />
<%
	//페이징(=페이지나누기, paging) part1 시작 //
	int totalRecord = 0;   //전체 레코드 수
	int totalPage = 0;   //전체 페이지 수
	int totalBlock = 0; //전체 블럭 수
	
	int numPerPage = 10;   //페이지당 레코드 수
	int pagePerBlock = 10; //블럭당 페이지 수
	
	int nowPage=1;   //현재페이지
	int nowBlock=1;  //현재블럭
	
	int start = 0;   //디비의 select 시작번호
	int end = 10;    //시작번호로 부터 가져올 select 갯수
	
	int listSize=0;  //현재 읽어온 게시물의 수
	// 페이징(=페이지 나누기, paging) part1 끝 //
	
               // 검색 시작 //	
	String keyWord = "", keyField = "";
	List<BoardBean> list = null;
	if (request.getParameter("keyWord") != null){
		keyWord = request.getParameter("keyWord");
		keyField = request.getParameter("keyField");
}
	
	if (request.getParameter("reload") != null){
			if(request.getParameter("reload").equals("true")){
				keyWord = "";
				keyField = "";
			}
	}      // 검색 끝 //

	                 
	    // 페이징(=페이지나누기, paging) part2 시작 //
			if (request.getParameter("nowPage") != null){
					nowPage = Integer.parseInt(request.getParameter("nowPage"));
			} //매개변수 nowPage 가 null 값
			
			start = (nowPage * numPerPage) - numPerPage; //시작할 때는 10 - 10 => 0
			end = start + numPerPage; //시작할 때는 0 + 10 => 10
			
			totalRecord = bMgr.getTotalCount(keyField, keyWord);
			totalPage = (int)Math.ceil((double)totalRecord / numPerPage); //전체 페이지 수
			nowBlock = (int)Math.ceil((double)nowPage / pagePerBlock); //현재 블럭 계산
			
			totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock); //전체 블럭 계산
			// 페이징(=페이지나누기, paging) part2 끝 // 
			
			//로그인을 세션으로 걸어두면 로그인 한 계정만 가능하다.
			String id = (String)session.getAttribute("idKey");
%>
<%@ page import="java.util.*,java.text.*" %>
<%
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd / a HH : mm : ss");
		String today = formatter.format(new java.util.Date());
%>
<!DOCTYPE html>
<html lang = "ko">
<head>
	<meta charset="UTF-8">
	<title>전체게시판</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<script type="text/javascript" src="../script/script.js" ></script>
<link href="../css/style.css" rel="stylesheet" />
<script type="text/javascript">
	function block(value){
		document.readFrm.nowPage.value<%=pagePerBlock%>*(value-1)+1;
		document.readFrm.submit();
	}
	
	function pageing(page){
		document.readFrm.nowPage.value = page;
		document.readFrm.submit();
	}

	function read(num){
		document.readFrm.num.value=num;
		document.readFrm.action="../freeBBS_jsp/read.jsp";
		document.readFrm.submit();
	}

	function check() {
		if(document.searchFrm.keyWord.value == "") {
			alert("검색어를 입력하세요.");
			document.searchFrm.keyWord.focus();
			return 0;
		}
		document.searchFrm.submit();
	}

	function down(filename){
		document.downFrm.filename.value=filename;
		document.downFrm.submit();
	}

	function postCheck(id){
		if (id != null){
				document.postFrm.action = "post.jsp";
				document.postFrm.submit();
		}else{
				alert("로그인을 하신후에 게시글을 작성하실수 있습니다.")
			}
		}
</script>
</head>
<body>
	<%
		 list = bMgr.getFreeBoardList(keyField, keyWord, start, end);
	%>

		<div style="padding: 7px 0px;background-color: #ededed;font-size: 13px;padding-left: 3px;text-align: center;">
			<span style="width: 5%;display: inline-block;">번호</span>
			<span style="width: 65%;display: inline-block;">제목</span>
			<span style="width: 15%;display: inline-block;">날짜</span>
			<span  style="width: 10%;display: inline-block;">조회수</span>
		</div>

		<div style="text-align: center; margin: 20px 0px;	font-size: 13px;">
		
				<%
				listSize = list.size();	//브라우저 화면에 보여질 공지사항 개수
				if(list.isEmpty()) {
					out.println("등록된 게시물이 없습니다.");
				} else {
					for(int i=0; i<numPerPage; i++) {
						if(i==listSize) break; 	// 마지막 페이지에서 데이터 개수가 부족할 때
						
						BoardBean bean = list.get(i);
						int num = bean.getNum();
						String subject = bean.getSubject();
						String regdate = bean.getRegdate();
						int depth = bean.getDepth();
						int count = bean.getCount();
				%>
				
		<div style="margin-bottom: 10px;">
		<span style="width: 5%;display: inline-block;">
		<% if (depth==0) out.print(num); %></span>
		<span style="width: 65%; display: inline-block; text-align:auto;">
		<% if(depth>0){
				for(int j=0;j<depth;j++){
					out.println("&nbsp;&nbsp;");										
					}
					  out.println("<img src='../images/replyImg.png' alt=''>");
				 //답변의 글이 등록되었을시 원본 게시글 밑에 표시되고, 답변글 제목 옆에는 아이콘이 표시됨
					  }
		%>
		<a href="javascript:read('<%=num%>')"><%=subject%></a></span>
		<span style="width: 15%;display: inline-block;"><%=regdate %></span>
		<!-- 작성된 글은 날짜가 출력됨 -->
		<span  style="width: 10%;display: inline-block;"><%=count %></span>
		</div>
						<%
					}//for
				}//if
				%>
		</div>

		<div style="text-align: center; margin: 20px 0px;	font-size: 13px;">
			<%
		int pageStart = (nowBlock - 1) * pagePerBlock + 1;
		// 블럭당 시작페이지번호, 아래 삼항연산자
		int pageEnd = ((pageStart + pagePerBlock) < totalPage) ? (pageStart + pagePerBlock) : totalPage + 1;
		// 블럭당 끝 페이지 번호
		if(totalPage != 0) { // 데이터가 1개라도 존재한다면
			if(nowBlock > 1) { %>
				<a href="javascript:block('<%=nowBlock - 1 %>')">◀</a>
			<% } 
			for( ; pageStart < pageEnd; pageStart++) {
			%>
				<a href="javascript:pageing('<%=pageStart%>')">
					<% if(pageStart == nowPage) { %>
						<span style="color:red;"><b>[
					<% } %>
							&nbsp;<%=pageStart%>&nbsp;
					<% if(pageStart == nowPage) { %>
							]</b></span>
						<% } %>
				</a>
			<% } %>
				<!-- 페이지 번호 입력 구간 끝 -->
			<% if(totalBlock > nowBlock) { %>
				<a href="javascript:block('<%=nowBlock + 1%>')">▶</a>
			<% } %>
		<% } %>
			</div>
				
	<div style="float: right;margin: -7px 25px 5px 0px;">
			<!-- 세션으로 로그인 접속시 글쓰기 버튼이 생기는 현상, 비 로그인시 글쓰기 버튼이 사라짐 -->
	 		<%if(id != null){%>
			<a href="../freeBBS_jsp/post.jsp"><input type="button" class="button" value="글쓰기"  class="button" ></a>
			 <%} %>
			<input type ="submit" onclick="location.href = 'free.jsp'" value = "처음으로" class="button" >
	</div>

	<div>
	<form  name="searchFrm"  method="post" action="all.jsp">
		<div style="text-align: center;">
		    <select name="keyField" size="1" >
		    <option value="subject"> 제 목</option>
		    <option value="content"> 내 용</option>
		    </select>
		    <input type="text"  name="keyWord" placeholder="검색어를 입력하세요." style="width: 200px;">
		    <input type="button"  value="찾기" onClick="javascript:check()" class="button" >
		    <input type="hidden" name="nowPage" value="1">
	    </div>
	</form>
	
	<form name="listFrm" method="post">
	 <input type="hidden" name="reload" value="true"> 
	 <input type="hidden" name="nowPage" value="1">
	</form>
	
	<form name="readFrm" method="get">
	 <input type="hidden" name="num"> 
	 <input type="hidden" name="nowPage" value="<%=nowPage%>"> 
	 <input type="hidden" name="keyField" value="<%=keyField%>"> 
	 <input type="hidden" name="keyWord" value="<%=keyWord%>">
	</form>
	</div>

</body>
</html>