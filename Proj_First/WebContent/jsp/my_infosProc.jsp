<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
	<jsp:useBean id="nMgr" class="packA.mainMgr" />
<%
	String id = (String) session.getAttribute("idKey");
	String pass = request.getParameter("passModyfiy");
	boolean result = nMgr.infoAuth(id, pass);
	out.print(result);
%>