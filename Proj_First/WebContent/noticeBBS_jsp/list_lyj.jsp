<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="packB.BoardBean_lyj" %>
<%@ page import="java.util.Vector"%>
<jsp:useBean id="bMgr" class="packB.BoardMgr_lyj" scope="page" />
<jsp:useBean id="mMgr" class="packA.MemberMgr_Proj" />

<%
	request.setCharacterEncoding("UTF-8");
	String id = "";
	if(session.getAttribute("idKey") != null){
		id = (String) session.getAttribute("idKey");
	}
	int result = mMgr.loginMember(id, ""); // 1, 5 넘어옴

	int totalRecord = 0;				// 전체 레코드 수
	int numPerPage = 15; 			// 페이지 당 레코드 수(기본=10)
	int pagePerBlock = 15;			// 블록 당 페이지 수
	int totalPage = 0;				// 전체 페이지 수
	int totalBlock = 0;				// 전체 블록 수
	int nowPage = 1;					// 현재 페이지(기본값=1)
	int nowBlock = 1;				// 현재 블록(기본값=1)
	int start = 0;						// DB의 select 시작번호
	int end = 10;						// 시작번호로 부터 가져올 select 개수
	int listSize = 0;					// 현재 읽어온 게시물의 수
	
	String keyWord = "", keyField = "";
	Vector<BoardBean_lyj> vlist = null;
	if(request.getParameter("keyWord") != null) {
		keyWord = request.getParameter("keyWord");
		keyField = request.getParameter("keyField");
	}
	if(request.getParameter("reload") != null) {
		if(request.getParameter("reload").equals("true")) {
			keyWord = "";
			keyField = "";
		}
	}
	if(request.getParameter("nowPage") != null) {
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	start=(nowPage * numPerPage)-numPerPage;
	end=numPerPage;
	
	totalRecord = bMgr.getTotalCount(keyField, keyWord);
	totalPage = (int)Math.ceil((double)totalRecord / numPerPage);
	nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
	totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
%>
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<script type="text/javascript" src="../script/script.js" ></script>
<link href="../css/style.css" rel="stylesheet" />
<title>공지사항</title>
<script>
function list() {
	document.listFrm.action = "../noticeBBS_jsp/list_lyj.jsp";
	document.listFrm.submit();
}

function pageing(page) {
	document.readFrm.action = "../noticeBBS_jsp/read_lyj.jsp";
	document.readFrm.submit();
}
function read(num) {
	document.readFrm.num.value=num;
	document.readFrm.action="../noticeBBS_jsp/read_lyj.jsp";
	document.readFrm.submit();
}
function check() {
	if (document.searchFrm.keyWord.value == "") {
		alert("검색어를 입력하세요.");
		document.searchFrm.keyWord.focus();
		return;
	}
	document.searchFrm.submit();
}
function down(filename) {
	document.downFrm.filename.value=filename;
	document.downFrm.submit();
}

function chkPass(){
	
	var frm = document.chkFrm;
	if (frm.pass.value == "") {
		alert("패스워드를 입력하세요.");
		frm.pass.focus();
		return false;
	}
	
	frm.submit();
}	
function block(value){
	 document.readFrm.nowPage.value=<%=pagePerBlock%>*(value-1)+1;
	 document.readFrm.submit();
}

</script>
</head>
<body>
	<%
		vlist = bMgr.getBoardList(keyField, keyWord, start, end);
	%>
	
		<div style="padding: 7px 0px;background-color: #ededed;font-size: 13px;padding-left: 3px;text-align: center;">
		<span style="width: 5%;display: inline-block;">번호</span>
		<span style="width: 65%;display: inline-block;">제목</span>
		<span style="width: 15%;display: inline-block;">날짜</span>
		<span  style="width: 10%;display: inline-block;">조회수</span>
		</div>
		
		<div style="text-align: center; margin: 20px 0px;	font-size: 13px;">
		
				<%
				listSize = vlist.size();	//브라우저 화면에 보여질 공지사항 개수
				if(vlist.isEmpty()) {
					out.println("등록된 게시물이 없습니다.");
				} else {
					for(int i=0; i<numPerPage; i++) {
						if(i==listSize) break; 	// 마지막 페이지에서 데이터 개수가 부족할 때
						BoardBean_lyj bean = vlist.get(i);
						int num = bean.getNum();
						String subject = bean.getSubject();
						String regdate = bean.getRegdate();
						int count = bean.getCount();				
				%>
		<div style="margin-bottom: 10px;">		
		<span style="width: 5%;display: inline-block;"><%=num %></span>
		<span style="width: 65%;display: inline-block;"><a href="javascript:read('<%=num %>')"><%=subject%>	</a></span>
		<span style="width: 15%;display: inline-block;"><%=regdate %></span>
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
<!-- 페이징 및 블럭 처리 시작 -->
		<% if(result == 5) { %>
		<div style="float: right;margin: -7px 25px 5px 0px;">
			<a href="../noticeBBS_jsp/post_lyj.jsp"><input type="button" class="button" value="글쓰기"></a>
		</div>
		<% } %>
				
		<div style="text-align: center; margin: 20px 0px;	font-size: 13px;">
		<form name="searchFrm" method="get">
		<input type="text" name="keyWord" size="16" value="<%=keyWord%>" placeholder="검색어 입력">

		&nbsp;&nbsp;
		<input type="button" value="검색" onclick="check()" class="button" >
		<input type="hidden" name="nowPage" value="1">
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