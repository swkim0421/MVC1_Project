<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="packBean.BoardBean" %>
<%@ page import ="java.util.Vector" %>
<%
	request.setCharacterEncoding("UTF-8");

	
%>
<jsp:useBean id="bMgr" class="packBean.BoardMgr" scope="page"/>
<%
	int totalrec = 0;
	int totalpage =0;
	int totalblock =0;
	
	int perpage = 10;
	int perblock = 10;
	int nowpage=1;
	int nowblock=1;
	
	int start = 0;
	int end =10;
	
	int listSize =0;
	
	//페이징 이해안되ㅜㅜ
	
	//검색
	String keyWord = "";
	String keyField = "";
	
	Vector<BoardBean> vlist =null;
	if(request.getParameter("keyWord")!=null){
		keyWord = request.getParameter("keyWord");
		keyField = request.getParameter("keyField");
	}
	
	if(request.getParameter("reload")!=null){
		if(request.getParameter("reload").equals("true")){
			keyWord="";
			keyField="";
		}
	}
	
	//페이징 증말(이해못함)
	if(request.getParameter("nowpage")!= null){
		nowpage = Integer.parseInt(request.getParameter("nowpage"));
	}
	start =(nowpage * perpage)-perpage;//시작할때는 0
	end = start+perpage;
	
	totalrec = bMgr.getTotalCount(keyField, keyWord);
	totalpage = (int)Math.ceil((double)totalrec/perpage);
	nowblock = (int)Math.ceil((double)nowpage/perblock);
	
	totalblock =(int)Math.ceil((double)totalpage/perblock);
	
%>
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<script type="text/javascript" src="../script/script.js" ></script>
<link href="../css/style.css" rel="stylesheet" />
<title>익명게시판 글목록</title>
<script>
//페이지에 직접 스크립트 작성시 이곳에 입력
function list(){
	document.listFrm.action = "list.jsp";
	document.listFrm.submit();
}

/*
function pageing(page){
	document.readFrm.nowpage.value=page;
	document.readFrm.submit();
}
*/

function read(num){
	document.readFrm.num.value=num;
	document.readFrm.action="../anonyBBS_jsp/read.jsp";
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


</script>
<style>
<!-- 페이지에 직접 css 작성시 이곳에 입력 -->


</style>
</head>
<body>

	<% vlist = bMgr.getBoardList(keyField, keyWord, start, end); %>
		<div style="padding: 7px 0px;background-color: #ededed;font-size: 13px;padding-left: 3px;text-align: center;">
		<span style="width: 5%;display: inline-block;">번호</span>
		<span style="width: 65%;display: inline-block;">제목</span>
		<span style="width: 15%;display: inline-block;">날짜</span>
		<span  style="width: 10%;display: inline-block;">조회수</span>
		</div>

	<div style="text-align: center; margin: 20px 0px;	font-size: 13px;">
		
				<%
				listSize = vlist.size();	
				if(vlist.isEmpty()) {
					out.println("등록된 게시물이 없습니다.");
				} else {
					for(int i=0; i<listSize; i++) {
						BoardBean bean = vlist.get(i);
						int num = bean.getNum();
						String name = bean.getName();
						String subject = bean.getSubject();
						String regdate = bean.getRegdate();
						int depth = bean.getDepth();
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


	</div>
	
	<div style="float: right;margin: -7px 25px 5px 0px;">
			<input type ="submit" onclick="location.href = '../anonyBBS_jsp/post.jsp'" value = "글쓰기" class="button" >
			<input type ="submit" onclick="location.href = 'anony.jsp'" value = "처음으로" class="button" >
	</div>



 <form name="readFrm" method="get"> 
<input type="hidden" name="num">  
<input type="hidden" name="nowpage" value="<%=nowpage%>">  
<input type="hidden" name="keyField" value="<%=keyField%>">  
<input type="hidden" name="keyWord" value="<%=keyWord%>"> 
</form> 



<!-- 

<p>현재 글 갯수 = <%=totalrec %></p>
<table id="listtable">
<tr>
<td>번호</td> <td>제목</td> <td>작성자</td> <td>날짜</td> <td>조회수</td>

</tr>



<%

	vlist = bMgr.getBoardList(keyField, keyWord, start, end);
	listSize = vlist.size();
	if(vlist.isEmpty()){
		out.print("등록된 게시물이 없습니다.");
	}
	
	else{
	//페이징 넘모빡세ㅜㅜ
	for(int i=0;i<perpage;i++){
		if(i==listSize)break;
		
		BoardBean bean = vlist.get(i);
		int num = bean.getNum();
		String name = bean.getName();
		String subject = bean.getSubject();
		String regdate = bean.getRegdate();
		int depth = bean.getDepth();
		int count = bean.getCount();
		
%>
<tr>
<td>
<%if (depth==0) out.print(num); %>
</td>
<td>
<%
//댓글 표시
		if(depth>0){
			for(int j=0;j<depth;j++){
				out.print("&ngsp;&ngsp;");
			}
			out.print("ㄴ");
		}
%>

<a href ="javascript:read('<%=num%>')">
<%=subject //제목 출력
%>
</a>

<td><%= name //작성자 출력
%>
</td>

<td><%= regdate //날짜 출력
%>
</td>
<td><%= count //조회수 출력
%>
</td>
<%
	}
	}
%>




<tr>
<td colspan ="6">
<input type ="submit" onclick="location.href = 'post.jsp'" value = "글쓰기">
<input type ="submit" onclick="location.href = 'index.jsp'" value = "처음으로">


</td>
</tr>
<tr>

</tr>
</table>
 -->
 
 </body>
 </html>