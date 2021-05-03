<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="bMgr" class="packB.BoardMgr_lyj" scope="page" />
<jsp:useBean id="bean" class="packB.BoardBean_lyj" scope="session" />
<jsp:useBean id="upBean" class="packB.BoardBean_lyj" scope="page" />

<% request.setCharacterEncoding("UTF-8"); %>    
<jsp:setProperty property="*" name="upBean" />
    
<%
String nowPage = request.getParameter("nowPage");

String upPass = upBean.getPass().trim();  // 사용자 입력 비밀번호
String inPass = bean.getPass().trim();       // DB에 저장되어 있는 실제 비밀번호

if (upPass.equals(inPass)) {
	bMgr.updateBoard(upBean);
	String url = "read_lyj.jsp?nowPage="+ nowPage + "&num="+ upBean.getNum();
	response.sendRedirect(url);
} else {
	out.println("<script type='text/javascript'>");
	out.println("alert('비밀번호를 확인해주세요.');");
	out.println("history.back()");
	out.println("</script>");
}
%>   