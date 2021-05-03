<%@page import="packA.memberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="nMgr" class="packA.mainMgr" />
<%
	String id = (String) session.getAttribute("idKey");
	memberBean mb = nMgr.infoData(id);
%>
<%
	String[] str;
	str = mb.getHobby();
	String result = "";
	   for (int i = 0; i < str.length; i++) {
	     result += str[i];
	   }
	   str = result.split("");
	for(int i=0;i<str.length;i++) { 
	    if(str[i].equals("1")){
	    	str[i]="checked='checked'";
	    }else{
	    	str[i]="";
	    }
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>title here</title>

 <link href="../vendor/mdi-font/css/material-design-iconic-font.min.css" rel="stylesheet" media="all">
 <link href="../vendor/font-awesome-4.7/css/font-awesome.min.css" rel="stylesheet" media="all">
 <link href="https://fonts.googleapis.com/css?family=Roboto:100,100i,300,300i,400,400i,500,500i,700,700i,900,900i" rel="stylesheet">
 <link href="../css/main.css" rel="stylesheet" media="all">

</head>
<body>

		<form action="my_infoUpdate.jsp" name="multiForm" id="multiForm" method="post">
			<div class="input-group">
                 <input class="input--style-1" type="text" placeholder="name" name="name"  value="<%=mb.getName() %>">
            </div>
			
			<div class="input-group" style="height: 30px;margin-bottom: 20px;">
				<span style="float: left;margin-right: 20px; color:#555555;">성별</span>  
                
			    <%
			    	if(mb.getSex().equals("1")){
			    %>
			    <span style="float: left; color:#555555;">남</span><input type="radio" name="sex" value="1" style="width: 20px;float: left;margin-top: 2px; margin-right: 15px;" checked >
                <span style="float: left; color:#555555;">여</span><input type="radio" name="sex" value="2" style="width: 20px;float: left;margin-top: 2px;">
			    <%		
			    	}else{
			    %>
			    <span style="float: left; color:#555555;">남</span><input type="radio" name="sex" value="1" style="width: 20px;float: left;margin-top: 2px; margin-right: 15px;">
                <span style="float: left; color:#555555;">여</span><input type="radio" name="sex" value="2" style="width: 20px;float: left;margin-top: 2px;"  checked >
			    <%} %>
            </div>
			
			
            <div class="input-group">
	             <input class="input--style-1" type="text" placeholder="birthday" name="birthday"  value="<%=mb.getBirthday() %>">
         	</div>
         	
           	<div class="input-group">
	             <input class="input--style-1" type="text" placeholder="email" name="email"  value="<%=mb.getEmail() %>">
         	</div>

			<div class="input-group">
                 <input class="input--style-1" type="text" placeholder="zipcode" name="zipcode" style="width: 50%" value="<%=mb.getZipcode() %>"> 
                 <button class="btn btn--radius btn--green" type="button" onclick="zipCheck()" style="float: right;height: 36px;;">우편번호찾기</button>
            </div>
            
           	<div class="input-group">
	             <input class="input--style-1" type="text" placeholder="address" name="address"  value="<%=mb.getAddress() %>">
         	</div>
         	
         	
 			<div class="input-group">
				<div style="height: 25px">
				<span style="float: left;margin-right: 20px; color:#555555;">취미</span>  
                <span style="float: left; color:#555555;">음악</span><input type="checkbox" name="hobby" value="음악" style="width: 20px;float: left;margin-top: 2px; margin-right: 5px;" <%=str[0] %>>
                <span style="float: left; color:#555555;">미술</span><input type="checkbox" name="hobby" value="미술" style="width: 20px;float: left;margin-top: 2px; margin-right: 5px;" <%=str[1] %>>
                <span style="float: left; color:#555555;">체육</span><input type="checkbox" name="hobby" value="체육" style="width: 20px;float: left;margin-top: 2px; margin-right: 5px;" <%=str[2] %>>
                <span style="float: left; color:#555555;">문학</span><input type="checkbox" name="hobby" value="문학" style="width: 20px;float: left;margin-top: 2px; margin-right: 5px;" <%=str[3] %>>
                <span style="float: left; color:#555555;">정치</span><input type="checkbox" name="hobby" value="정치" style="width: 20px;float: left;margin-top: 2px; margin-right: 5px;" <%=str[4] %>>
                </div>
            </div>
            
           	<div class="input-group">
	             <input class="input--style-1" type="text" placeholder="job" name="job"  value="<%=mb.getJob() %>">
         	</div>
         	
			<div style="text-align: center;margin-bottom: 20px;">
		  	<button onclick="myInfosUpadate()" class="button" style="width: 80px;height: 30px">확인</button>
		  	<input type="reset" value="다시쓰기" class="button"  style="width: 80px;height: 30px">
			</div>

  	</form>
  			
</body>
</html>