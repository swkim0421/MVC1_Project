<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:useBean id="bMgr" class="packBean.BoardMgr" scope="page" />
<jsp:useBean id="bean" class="packBean.BoardBean" scope="session" />
<jsp:useBean id="upBean" class="packBean.BoardBean" scope="page" />

<% request.setCharacterEncoding("UTF-8"); %>    
<jsp:setProperty property="*" name="upBean" />
    
<%
String nowpage = request.getParameter("nowpage");

String upPass = upBean.getPass().trim();  // 사용자 입력 비밀번호
String inPass = bean.getPass().trim();       // DB에 저장되어 있는 실제 비밀번호

if (upPass.equals(inPass)) {
	bMgr.updateBoard(upBean);
	String url = "read.jsp?nowPage="+ nowpage + "&num="+ upBean.getNum();
	response.sendRedirect(url);
} else {
	out.println("<script type='text/javascript'>");
	out.println("alert('비밀번호를 확인해주세요.');");
	out.println("history.back()");
	out.println("</script>");
}
%>    