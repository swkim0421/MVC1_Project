<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@  page import = "packA.*,java.util.Vector" %>
<jsp:useBean id="mMgr" class="packA.mainMgr" scope = "page"/>
<%
	request.setCharacterEncoding("UTF-8");
%>


<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">

<title>우편번호 검색</title>
<script>
//페이지에 직접 스크립트 작성시 이곳에 입력

//동이 입력되지 않았을때
function dongCheck(){
	
	var frm = doncument.zipFrm;
	if(frm.area3.value==""){
		alert("주소를 입력해 주세요");
		frm.area3.focus();
		return false;
	}
	frm.action = "zipCheck.jsp";
	frm.submit();
}

//완성된 데이터들을 불러오게한 부모요소에 저장
function sendAdd(zipcode,area1,area2,area3,area4){
	var addr = area1+" "+area2+" "+area3+" "+area4;
	//opener 창을 연 객체
	opener.document.regFrm.zipcode.value = zipcode;
	opener.document.regFrm.address.value = addr;
	self.close();
}

</script>
<style>
<!-- 페이지에 직접 css 작성시 이곳에 입력 -->


</style>
</head>
<body>
<%
	String check = request.getParameter("check");
	String area3= "";
	Vector<ZipcodeBean> vlist = null;
	if(check.equals("n")){
		area3 = request.getParameter("area3");
		vlist = mMgr.zipcodeRead(area3);
	}
%>

<div>
<form  method="get" name  = "zipFrm">
<table>
<tr>
<th>동 이름 입력
<input type ="text" name = "area3" value = "<%=area3 %>" required>
<button onclick = "dongCheck()">검색</button>
</th>
</tr>
<!-- 검색결과 시작 -->
<%
	if(check.equals("n")){
		if(vlist.isEmpty()){
%>
<tr>
<td>검색결과가 없습니다.</td>
</tr>
<%}else{ %>
<tr>
<td>검색후 우편번호를 클릭하면 자동입력</td>
</tr>
<%
	for(int i=0; i<vlist.size();i++){
		ZipcodeBean bean = vlist.get(i);
		String rZipcode = bean.getZipcode();
		String rArea1 = bean.getArea1();
		String rArea2 = bean.getArea2();
		String rArea3 = bean.getArea3();
		String rArea4 = bean.getArea4();
%>
<tr>
<td>
<a href = "#"  title =""onclick="sendAdd(
'<%=rZipcode%>','<%=rArea1%>','<%=rArea2%>','<%=rArea3%>','<%=rArea4%>',
)">
<%=rZipcode %>
<%=rArea1 %>
<%=rArea2 %>
<%=rArea3 %>
<%=rArea4 %>
</a>
</td>
</tr>
<%
	}//end for
}
	}
%>
<tr>
<td>
<span onclick="self.close()" style="cursor: pointer">[닫기]</span>
</td>
</tr>
</table>
 <input type = "hidden" name = "check" value="n">
 </form>
 </div>
</body>
</html>