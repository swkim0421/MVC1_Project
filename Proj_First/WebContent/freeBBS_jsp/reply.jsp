<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bean" class="packFreeBBS.BoardBean" scope="session"/>
<jsp:useBean id="bMgr" class="packFreeBBS.BoardMgr" />
<%
  String nowPage = request.getParameter("nowPage");
  String subject = bean.getSubject();
  String content = bean.getContent(); 
  
  	//로그인한 계정의 이름이 작성자로 입력이 된다.
  	String id = (String) session.getAttribute("idKey");
	String userName = bMgr.getWriterName(id);
%>
<!DOCTYPE html>
<html lang = "ko">
<head>
	<meta charset="UTF-8">
	<title>답변 : <%=subject%></title>
<link href="freeBBS_css/style_post.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<script type="text/javascript" src="../script/script.js" ></script>
<link href="../css/style.css" rel="stylesheet" />
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
<div>
<br><br>
<h2>답변하기</h2>
<form name="post" method="post" action="replyProc.jsp" >
<table>
 <tr>
  <td>
   <table>
    <tr>
  <td>작성자</td>
					<td>	<input type="text" name="name" size="30" maxlength="20" value="<%=userName %>" readonly="readonly"></td>
    </tr>
    <tr>
     <td width="20%">제 목</td>
     <td width="80%">
<input type="text" name="subject" size="50" value="답변 : <%=subject%>" maxlength="50" required></td> 
    </tr>
<tr>
     <td>답변 내 용</td>
     <td>
      	========원본 게시글 내용=======
      	<br>
      	<pre><span id="originalArea"><%=content%></span></pre>
      		<textarea name="content" rows="12" cols="50"></textarea>
      </td>
    </tr>
    <tr>
     <td>비밀 번호</td> 
     <td>
  <input type="password" name="pass" size="15" maxlength="15" required></td> 
    </tr>
    <tr>
     <td colspan="2" height="5"><hr/></td>
    </tr>
<tr> 
     <td colspan="2">
		<input type="submit" value="답변등록" >
       <input type="reset" value="다시쓰기">
       <input type="button" value="뒤로" onClick="history.back()"></td>
    </tr> 
   </table>
  </td>
 </tr>
</table>
 <input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>" >
 <input type="hidden" name="nowPage" value="<%=nowPage%>">
 <input type="hidden" name="ref" value="<%=bean.getRef()%>">
  <input type="hidden" name="pos" value="<%=bean.getPos()%>">
 <input type="hidden" name="depth" value="<%=bean.getDepth()%>">
</form> 
</div>   
</div>
	<div id="footer">
		<jsp:include page="../template/footer.html" />
	</div>
</div>
</body>
</html>