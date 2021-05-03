<%@page import="packImgBBS.BoardBean"%>
<%@page import="java.util.Vector"%>
<%@	page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
	<jsp:useBean id="mgr" class="packA.mainMgr"/>
	<jsp:useBean id="bb" class="packImgBBS.BoardBean"/>
<%
	Vector<BoardBean> vls = mgr.mainPageView("all");
	Vector<BoardBean> vls2 = mgr.mainPageView("notice");
%>
<div id="mainWrap">
	<div id="main_top_left" style="width: 45%;float: left; margin-left: 3%;">
		<div style="border-bottom: 1px solid #ddd; padding: 5px 0px;display: inline-block;font-size:12px;width: 100%;">
			<span style="padding-left: 10px">최신글 목록(<%=vls.size() %>)</span><span style="float: right;"><a href="all.jsp">more</a></span>
		</div>
			
		<div style="margin-top: 10px; padding-bottom: 10px; border-bottom: 1px solid #ddd;">
				<%
						for(int i=0; i < vls.size(); i++){
							bb = vls.get(i);
							%>
								<div id="allLIst_<%=bb.getNum()%>" style="width: 265px;">
								<div style="float: left;padding-right: 5px;">
								<a href="javascript:read('<%=bb.getNum() %>')" id="aImg">
								<% String filename = bb.getFilename();%>
							  			<%if(filename != null){ %>
							  			<img id="sumnail" src="http://192.168.0.79:8180/Proj_First/uploadFolder/<%=filename %>"  style="width: 60px; height: 60px;">
							  			<%}else{ %><img id="nonImg" src="http://192.168.0.79:8180/Proj_First/uploadFolder/thm_nonimage.jpg"  style="width: 60px; height: 60px;">
							  			<%} %></a>
								</div>
								<div><%= bb.getSubject() %></div>
								<div style="font-size: 11px;margin-top: 18px;">
									<%
										switch(bb.getTblcode()){
											case 1: out.print("자유게시판"); break;
											case 2: out.print("갤러리"); break;
											case 4: out.print("익명");break;
										}
									%>
								</div>
								<div style="font-size: 11px;">
									<%= bb.getRegdate() %>
									<%
										if(bb.getId() != null && !bb.getId().equals("")){
											out.print(bb.getId());
										}else{
											out.print(bb.getName());
										}
									%>
								</div>
								<div style="clear: both;"></div>
								</div>
							<%
						}
				%>			
		</div>
	</div>
	
	
	
		<div id="main_top_right" style="width: 45%; float: left; margin-left: 5%;">
		<div style="border-bottom: 1px solid #ddd; padding: 5px 0px;display: inline-block;font-size:12px;width: 100%;">
			<span style="padding-left: 10px">공지사항(<%=vls.size() %>)</span><span style="float: right;"><a href="notice.jsp">more</a></span>
		</div>
			
		<div style="margin-top: 10px;padding-bottom: 10px; border-bottom: 1px solid #ddd;">
				<%
						for(int i=0; i < vls2.size(); i++){
							bb = vls2.get(i);
							%>
								<div id="allLIst_<%=bb.getNum()%>" style="width: 265px;">
								<div style="float: left;padding-right: 5px;">
								<a href="javascript:read('<%=bb.getNum() %>')" id="aImg">
								<% String filename = bb.getFilename();%>
							  			<%if(filename != null){ %>
							  			<img id="sumnail" src="http://192.168.0.79:8180/Proj_First/uploadFolder/<%=filename %>"  style="width: 60px; height: 60px;">
							  			<%}else{ %><img id="nonImg" src="http://192.168.0.79:8180/Proj_First/uploadFolder/thm_nonimage.jpg"  style="width: 60px; height: 60px;">
							  			<%} %></a>
								</div>
								<div><%= bb.getSubject() %></div>
								<div style="font-size: 11px;margin-top: 18px;"> 공지사항 </div>
								<div style="font-size: 11px;">
									<%= bb.getRegdate() %>
									<%
										if(bb.getId() != null && !bb.getId().equals("")){
											out.print(bb.getId());
										}else{
											out.print(bb.getName());
										}
									%>
								</div>
								<div style="clear: both;"></div>
								</div>
							<%
						}
				%>			
		</div>
	</div>
</div>
<script>
function read(num){
	document.readFrm.num.value=num;
	document.readFrm.action="../allBBS_jsp/read.jsp";
	document.readFrm.submit();
}
</script>

	<form name="readFrm" method="get">
	 <input type="hidden" name="num"> 
	 <input type="hidden" name="nowPage" > 
	 <input type="hidden" name="keyField"> 
	 <input type="hidden" name="keyWord" >
	</form>