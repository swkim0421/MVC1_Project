<%@page import="packA.FaqBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<% 
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);

String id ="";
int memberLevel = 0;
if(session.getAttribute("idKey") != null){
id = (String) session.getAttribute("idKey");
memberLevel = (int) session.getAttribute("memberLevel");
}
%>
<jsp:useBean id="fb" class="packA.FaqBean" />
<jsp:useBean id="mgr" class="packA.mainMgr" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자주묻는 질문</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<script type="text/javascript" src="../script/script.js" ></script>
<link href="../css/style.css" rel="stylesheet" />
<style>
talbe[
	border-collapse: collapse;
}
</style>
</head>
<body>
	<div id="faqWrap">
		<%
			if(memberLevel != 0 && memberLevel == 5){
		%>
		<div id="faqWriteWrap" style="float: right; margin-bottom: 20px; ">
			<input type="button" class="button" value="새로운 FAQ 등록하기" onclick="targetAjax('faq_write')">
		</div>
		<%} %>
		
		<table  style="width: 100%;  border: solid 1px;border-color: #a6a6a6 #f6f6f6 #f6f6f6 #a6a6a6;box-shadow: inset 0px 0px 1px #9a9a9a;background: #d7d7d7;text-align: center;padding: 5px;">
			<tr><td class="faqTitle faqTd1" >분류</td><td class="faqTitle faqTd2" style="text-align: center;">내용</td></tr>
			
			<%
				
			Vector<FaqBean> list = mgr.listFaqBoard(0, 5);
			for(int i=0; i < list.size(); i++){
				fb = list.get(i);
				String tab = fb.getTab();
				String subject = fb.getSubject();
				String reg = fb.getRegdate();
				String content = fb.getContent();
				int num = fb.getNum();
			%>
			<tr id="faqRow_<%=i %>" class="faqB"><td class="faqList faqTd1" ><%=tab %></td><td class="faqList faqTd2" > <div><%=subject %>
				
			</div></td></tr>
			<tr id="faqRow_<%=i %>C" class="faqT"><td class="faqList faqTd1" ></td><td class="faqList faqTd2" ><div class="faqListContent"><pre><%=content %></pre>
			<%
					if(memberLevel != 0 && memberLevel == 5){
				%>
			<input type="button" class="button" value="FAQ 수정하기" onclick="targetAjax('faq_write','<%=num%>')" style="float: right; margin-right: 5px;">
				<%} %>
			</div></td></tr>
			<%} %>
			<!--
			<tr id="faqRow_1" class="faqB"><td class="faqList faqTd1" >[게시판 이용]</td><td class="faqList faqTd2" > <div>2019년 패치 일정을 알고 싶어요.</div></td></tr> 
			<tr id="faqRow_1C" class="faqT">
			<td class="faqList faqTd1" >
			</td>
			<td class="faqList faqTd2" ><div class="faqListContent"><pre>
/다시하기 시스템은 게임 시작 직후 팀원의 탈주 및 자리비움으로 인해 불공평한 게임이 진행되지 않도록

도입된 시스템입니다.



/다시하기 시스템은 아래와 같이 적용되고 있습니다.



  • 게임 시작 3분째에 탈주를 하거나 90초 이상 자리를 비운 플레이어가 발생할 경우

      다시하기가 시작될 수 있습니다.
  • 탈주 혹은 자리비움 전 아군을 상대로 한 선취점이 나오면 '/다시하기'를 할 수 없습니다.
  • 해당 팀의 모든 팀원은 채팅창에 ‘/다시하기’를 입력하는 방식으로 1분 동안 투표를 진행할 수 있습니다.
  • 네 팀원 중 최소 두 명(전체 팀원의 30% 이상)이 ‘/다시하기’에 동의하면 게임이 종료됩니다.
  • 게임이 종료되면 해당 게임은 무효가 됩니다. 참여했던 모든 플레이어의 LP와 BE, XP, 승패전적은 
      아무런 변동 없이 그대로 유지됩니다.
  • 탈주를 하거나 자리를 비운 플레이어는 탈주자 단속 대상이 됩니다.

  • 랭크 게임의 경우 탈주자 본인은 LP가 하락하거나 승급, 승격전 기회가 박탈됩니다. 경쟁의 공정성을

      위해 다이아몬드 이상 티어의 플레이어는 사전 구성 팀원이 탈주하여 게임을 다시 할 경우 패배로

      기록됩니다.



추가로 90초 동안 아무런 행동을 하지 않을 경우 자리비움으로 감지될 수 있습니다. 가만히 서서 채팅만

하거나, 은신 상태로 90초동안 추가 움직임이 없을 경우에도 자리비움으로 체크될 수 있으니 유의해 주시길

부탁 드립니다.
</pre> 
</div>
</td></tr>
			-->
			
			
			
			
			
		</table>
		
 		


	
		
	</div>
	
</body>
</html>