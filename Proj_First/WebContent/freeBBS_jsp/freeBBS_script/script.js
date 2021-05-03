function list(){
	document.listFrm.action = "../jsp/free.jsp"
	document.listFrm.submit();
}

function pageing(page){
	document.readFrm.nowPage.value = page;
	document.readFrm.submit();
}

function read(num){
	document.readFrm.num.value=num;
	document.readFrm.action="read.jsp";
	document.readFrm.submit();
}

function check() {
	if(document.searchFrm.keyWord.value == "") {
		alert("검색어를 입력하세요.");
		document.searchFrm.keyWord.focus();
		return 0;
	}
	document.searchFrm.submit();
}

function down(filename){
	document.downFrm.filename.value=filename;
	document.downFrm.submit();
}

function postCheck(id){
	if (id != null){
			document.postFrm.action = "post.jsp";
			document.postFrm.submit();
	}else{
			alert("로그인을 하신후에 게시글을 작성하실수 있습니다.")
		}
	}
