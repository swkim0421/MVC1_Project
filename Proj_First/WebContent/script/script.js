$( document ).ready(function() {
	$("#navPass").keydown(function(key) {
		if (key.keyCode == 13) {
			loginCheck2();
		}
	});
	$("#passModyfiy").keydown(function(key) {
		if (key.keyCode == 13) {
			myinfos_2();
		}
	});
	$("#myInfos").on("click",function(){
		myInfos();
	});
	
	$("#loginPass").keydown(function(key) {
		if (key.keyCode == 13) {
			loginCheck();
		}
	});
	
	$("#moon").mouseover(function() {
		$("#moon + div").slideDown(500)
	});
	$("#bae").mouseover(function() {
		$("#bae + div").slideDown(500)
	});
	$("#hong").mouseover(function() {
		$("#hong + div").slideDown(500)
	});
	$("#kim").mouseover(function() {
		$("#kim + div").slideDown(500)
	});
	$("#lee").mouseover(function() {
		$("#lee + div").slideDown(500)
	});
	
	$(".faqB").on("click",function(){
		
		$(".faqT").hide();
		$("#"+$(this).attr("id")+"C").show();
		var height = $("#"+$(this).attr("id")+"C").find("td:last").height()+2; 
		$("#"+$(this).attr("id")+"C").find("td:first").height(height);
		$("#"+$(this).attr("id")+"C").find("td:first").css("margin-top","-3px");
	});
	
	var targetPage = getParam("target");
	if(targetPage != null && targetPage != ""){
		targetAjax(targetPage);
	}
});

function targetAjax(str, str2){
	var url;
	if(str == "faq_write"){
		url = "faq_write.jsp";
		if(str2 != null && str2 != ""){
			url = "faq_write.jsp?num="+str2;
		}
	}
	location.href = url;
	
	
//	if(str == "faq_write"){
//		$.ajax({url:"faq_write.jsp?num="+str2+"",
//			success:function(result) {
//			$("#main").html(result);
//		}})
//	}
}


function loginCheck2(){

	var id = $("#navFrm #navId").val();
	var pass = $("#navFrm #navPass").val();
	
	
	if(id == "" || id == null){
		alert("아이디를 입력하세요");
		$("#navFrm #navId").focus();
		return;
	}
	
	if(pass == "" || pass == null){
		alert("비밀번호를 입력하세요");
		$("#navFrm #navPass").focus();
		return
	}

	
	
	document.navFrm.submit();
}
function logOut(){
	console.log(1);
	document.navFrm.submit();
}

function myInfos(){
	$.ajax({url:"my_infos.jsp",
		success:function(result) {
		$("#main").html(result);
	}});
}
function myinfos_2(){
	$.ajax({url:"my_infosProc.jsp?passModyfiy="+$("#passModyfiy").val(),
		success:function(result) {
			result = $.trim(result);
			if(result == "true"){
				$.ajax({url:"my_info.jsp",
					success:function(result2) {
						$("#main").html(result2);
					}
				});
			}else{
				alert("비밀번호가 올바르지 않습니다.");
			}
	}});
}

function navzipCheck() {
		var url = "zipCheck.jsp?check=y";
		var w = screen.width;
		var left = (w - 500)/2;
		var h = screen.height;
		var top = (h - 350)/2;
		window.open(url, "ZipCodeSearch",
				"width=500,height=350,scrollbars=no,left="+left+",top="+top+"");
}


function myInfosUpadate(){
	document.multiForm.submit();
}
function mainPageChange(url){
	location.href = url+".jsp";
}
function getParam(key){
	
	var _parammap = {};	
	document.location.search.replace(/\??(?:([^=]+)=([^&]*)&?)/g, function () {
    function decode(s) {
        return decodeURIComponent(s.split("+").join(" "));
     }
    _parammap[decode(arguments[1])] = decode(arguments[2]);
    });
	console.log(_parammap[key]);
    return _parammap[key];
}