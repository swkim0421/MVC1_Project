<%@page import="packA.memberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
%>    
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <title>회원가입</title>

    <link href="../vendor/mdi-font/css/material-design-iconic-font.min.css" rel="stylesheet" media="all">
    <link href="../vendor/font-awesome-4.7/css/font-awesome.min.css" rel="stylesheet" media="all">
    <link href="https://fonts.googleapis.com/css?family=Roboto:100,100i,300,300i,400,400i,500,500i,700,700i,900,900i" rel="stylesheet">
    <link href="../css/main.css" rel="stylesheet" media="all">
    <script src="../script/script.js"></script>
  	<script>
  		
  		function idCheck(id) {
  			var frm = document.regFrm;
  			if (id == "") {
				alert("아이디를 입력해 주세요.");
				frm.id.focus();
				return false;
			}
  			
  			var w = screen.width;
  			var left = (w - 300)/2;
  			var h = screen.height;
  			var top = (h - 150)/2;
  			var url = "../jsp/member_jsp/idCheck.jsp?id=" + id;

  			window.open(url, "IDCheck", 
  		"width=300,height=150,left="+left+",top="+top+"");
  		}
  		
  		function zipCheck() {
  			var url = "../jsp/member_jsp/zipCheck.jsp?check=y";
  			var w = screen.width;
  			var left = (w - 500)/2;
  			var h = screen.height;
  			var top = (h - 350)/2;
  			window.open(url, "ZipCodeSearch",
  					"width=500,height=350,scrollbars=no,left="+left+",top="+top+"");
  		}
  		
  		
  	</script>
  </head>
  
  <body>  
  	<div id="memberWrap">
  	
  		<h2 style="color:#555555;margin-bottom: 15px;">회원가입</h2>
  		<form action="../jsp/member_jsp/memberProc.jsp" name="regFrm" method="get">

 
			<div class="input-group">
                 <input class="input--style-1" type="text" placeholder="ID" name="id" style="width: 50%">
                 <button class="btn btn--radius btn--green" type="button" onclick="idCheck(this.form.id.value)" style="float: right;height: 36px;;">ID중복확인</button>
            </div>
			<div class="input-group">
                 <input class="input--style-1" type="password" placeholder="PassWord" name="pass" >
            </div>
			<div class="input-group">
                 <input class="input--style-1" type="password" placeholder="RePassWord" name="repass" >
            </div>
			<div class="input-group">
                 <input class="input--style-1" type="text" placeholder="name" name="name" >
            </div>
			<div class="input-group">
				<div style="height: 25px">
				<span style="float: left;margin-right: 20px; color:#555555;">성별</span>  
                <span style="float: left; color:#555555;">남</span><input type="radio" name="sex" value="1" style="width: 20px;float: left;margin-top: 2px; margin-right: 15px;" checked >
                <span style="float: left; color:#555555;">여</span><input type="radio" name="sex" value="2" style="width: 20px;float: left;margin-top: 2px;">
                </div>
            </div>
            
            <div class="input-group">
	             <input class="input--style-1" type="text" placeholder="birthday" name="birthday" >
         	</div>
            
           	<div class="input-group">
	             <input class="input--style-1" type="text" placeholder="email" name="email" >
         	</div>
         	
			<div class="input-group">
                 <input class="input--style-1" type="text" placeholder="zipcode" name="zipcode" style="width: 50%">
                 <button class="btn btn--radius btn--green" type="button" onclick="zipCheck()" style="float: right;height: 36px;;">우편번호찾기</button>
            </div>
            
           	<div class="input-group">
	             <input class="input--style-1" type="text" placeholder="address" name="address" >
         	</div>
         	
         	
			<div class="input-group">
				<div style="height: 25px">
				<span style="float: left;margin-right: 20px; color:#555555;">취미</span>  
                <span style="float: left; color:#555555;">음악</span><input type="checkbox" name="hobby" value="음악" style="width: 20px;float: left;margin-top: 2px; margin-right: 5px;" >
                <span style="float: left; color:#555555;">미술</span><input type="checkbox" name="hobby" value="미술" style="width: 20px;float: left;margin-top: 2px; margin-right: 5px;" >
                <span style="float: left; color:#555555;">체육</span><input type="checkbox" name="hobby" value="체육" style="width: 20px;float: left;margin-top: 2px; margin-right: 5px;" >
                <span style="float: left; color:#555555;">문학</span><input type="checkbox" name="hobby" value="문학" style="width: 20px;float: left;margin-top: 2px; margin-right: 5px;" >
                <span style="float: left; color:#555555;">정치</span><input type="checkbox" name="hobby" value="정치" style="width: 20px;float: left;margin-top: 2px; margin-right: 5px;" >
                </div>
            </div>         	

           	<div class="input-group">
	             <input class="input--style-1" type="text" placeholder="job" name="job" >
         	</div>         	

			<div class="input-group">
				<div style="height: 25px">
				<span style="float: left;margin-right: 20px; color:#555555;">회원상세정보</span>  
                <span style="float: left; color:#555555;">일반</span><input type="radio" name="memberLevel" value="1" style="width: 20px;float: left;margin-top: 2px; margin-right: 15px;" checked >
                <span style="float: left; color:#555555;">관리자</span><input type="radio" name="memberLevel" value="5" style="width: 20px;float: left;margin-top: 2px;">
                </div>
            </div>
			
			<div style="text-align: center;margin-bottom: 20px;">
		  	<button onclick="inputCheck()" class="button" style="width: 80px;height: 30px">확인</button>
		  	<input type="reset" value="다시쓰기" class="button"  style="width: 80px;height: 30px">
		  	<input type="button" value="로그인" onclick="javascript:location.href='../login.jsp'" class="button" style="width: 80px;height: 30px">
			</div>



  		</form>
  	</div>
  </body>
</html>









