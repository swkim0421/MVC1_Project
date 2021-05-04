# 🏵️ 김성원의 프로젝트
- Team Project

## 🎖️ MVC1패턴 기반 웹 프로젝트

:computer: 프로젝트 과정

◎ 기간 : 2019. 04. 15 ~ 2019. 04. 30

◎ 총 팀원 수 : 5명

◎ 내용 : MVC1 패턴 기반 게시판의 웹 홈페이지 프로젝트

◎ 프로젝트 사용 언어 : Html, JSP, Java, Javascript, CSS, My-SQL(DB)..등

1. 본인 - 자유 게시판
* 내용 : 게시글 작성 및 등록, 수정, 게시글 업로드 및 삭제, 게시글의 파일 업로드 및 다운로드, 게시글 등록 시간, 게시글 조회수, 게시글 작성의 로그인 권한, 답변글, DB에 게시글 등록 데이터

2. 나머지 팀원들 - 갤러리 게시판, 공지 게시판, 익명 게시판,로그인창, 회원가입 등

### 🥇 환경 :
⊙ JDK  : 1.8.version

⊙ TOMCAT : 8.5.version

⊙ Eclipse : Eclipse IDE for Enterprise Java Developers & 2018-12 (4.10.0)

⊙ 인코딩 : UTF-8

⊙ My-SQL Workbench : 8.0

### 🥈 환경 변수 :  
⊙ JDK 1.8version 설치
 
 1. 제어판 > 시스템 및 보안 > 시스템 >  고급 시스템 설정 > 환경 변수(N) > 시스템 변수(S) > [세로만들기(W)] >
변수 이름(N): JAVA_HOME > 변수 값(V): jdk 1.8version이 설치된 파일 경로 > [확인]
 
 1.1 환경변수 > 시스템 변수(S) > Path 선택 > [편집(I)] > 시스템 변수 편집 > 변수 이름(N): Path > 변수 값(V) > %JAVA_HOME%\bin; > [확인]
 
 2. 시작 버튼(Win) + X > 명령 프롬프트(C) [CMD] > java -version > java version 1.8.0_291
 
 2.1  시작 버튼(Win) + X > 명령 프롬프트(C) [CMD] > javac -version > 1.8.0_221

My-SQL 스키마 생성

+  mydb : 스키마 생성
+  use mydb : 스키마 선택

create database mydb;

use mydb;

My-SQL 테이블 생성 및 데이터 추가

+ tblMember 테이블 생성

  ⊙CREATE TABLE `tblMember` (
  
  `id` char(20) NOT NULL,
  
  `pass` char(20) NOT NULL,
  
  `name` char(20) NOT NULL,
  
  `sex` char(1) NOT NULL,
  
  `birthday` char(6) NOT NULL,
  
  `email` char(30) NOT NULL,
  
  `zipcode` char(7) NOT NULL,
  
  `address` char(50) NOT NULL,
  
  `hobby` char(5) NOT NULL,
  
  `job` char(20) NOT NULL,
  
  `memberLevel` int(3) not null,
  
  PRIMARY KEY (`id`)
);
 
+ tblZipcode 테이블 생성 //우편번호 찾기
 
  CREATE TABLE `tblZipcode` (
  
  `zipcode` char(7) NOT NULL,
  
  `area1` char(10) DEFAULT NULL,
  
  `area2` char(20) DEFAULT NULL,
  
  `area3` char(40) DEFAULT NULL,
  
  `area4` char(20) DEFAULT NULL
);
  
  //우편번호 찾기의 정보 추가
 
insert into tblZipcode values('14506','부천시','원미구','상동 다정한마을','500-5번지');

insert into tblZipcode values('14507','부천시','원미구','상동 진달래마을','526-4번지');

insert into tblZipcode values('14536','부천시','원미구','중동 덕유마을','1040번지');

insert into tblZipcode values('14539','부천시','원미구','중동 중흥마을','1054번지');

insert into tblZipcode values('14538','부천시','원미구','중동 은하마을','1036번지');

insert into tblZipcode values('14535','부천시','원미구','중동 설악마을','1051-12번지');

insert into tblZipcode values('14511','부천시','원미구','중동 한라마을','1027-3번지');

+ tblBoard 테이블 생성 //게시판 리스트 및 게시글
  
  create table `tblBoard`(

`num` int(11) not null auto_increment,

`name` varchar(25) ,

`subject` varchar(100),

`content` text,

`pos` int(7) unsigned,

`ref` int(7),

`depth` int(7) unsigned,

`regdate` date,

`pass` varchar(20),

`ip` varchar(15),

`count` int(7) unsigned,

`filename` varchar(35),

`filesize` int(11),

`tblcode` int(5),

`id` varchar(30),

primary key(`num`)
);


### 프로젝트 기능 구현 및 결과 내용 설명:

0. 로그인 방법 : 회원가입 버튼 실행 > 회원가입 절차중 우편번호 검색은 DBtable_code.sql파일안에 우편번호 정보 추가는 insert into tblZipcode values('14506','부천시','원미구','상동 다정한마을','500-5번지');이다
  
  0.1 회원가입 버튼 : Proj_First > jsp > index.jsp파일을 실행 하면 회원가입 버튼이 좌측 우측상단에 있고, 
     회원가입 버튼을 실행 하면 결과는 ->
     
   <img src="https://user-images.githubusercontent.com/83484877/116871213-e091a500-ac4e-11eb-8e23-665d43614ef8.jpg" width="700" height="300">
  
  0.2 회원가입 창 : 회원가입 창은 Proj_First > jsp > index.jsp에서 member_jsp > member.jsp가 실행 ->
    
   <img src="https://user-images.githubusercontent.com/83484877/116867386-05cee500-ac48-11eb-8288-4321d2a2367f.jpg" width="650" height="500">

  0.3 회원가입 절차 중 우편번호 정보 추가는 SQL에서 insert into tblZipcode values('14506','부천시','원미구','상동 다정한마을','500-5번지');코드를 실행 > SQL에 우편번호 추가(검색)의 데이터 결과는 ->
  
  <img src="https://user-images.githubusercontent.com/83484877/116866688-cfdd3100-ac46-11eb-81fd-1b8d44a55cc4.jpg" width="350" height="200">
  
  0.4 회원가입 창에서 우편번호 찾기 버튼 ->
    
   <img src="https://user-images.githubusercontent.com/83484877/116867578-6e1dc680-ac48-11eb-9538-e0a07d576439.jpg" width="650" height="500">

  0.5 우편번호 찾기 검색 창 : SQL에서 추가한 insert구문을 우편번호 검색창에서 동_이름을 검색 후 뵤여지는 결과 -> 
  
 <img src="https://user-images.githubusercontent.com/83484877/116867902-c654c880-ac48-11eb-9fa1-44e56fe59e58.jpg" width="600" height="450">

  0.6 회원가입 등록 : 회원가입 절차 대로 아이디, 비밀번호, 이름, 생년월일, 우편번호, 취미 등 입력 후 > 마지막에는 회원상세정보가 일반 과 관리자가 있다
    -> 일반 과 관리자 둘중 1개를 선택을 해 가입 등록 하면 알림 메세지 창이 뜸
    
   일반 과 관리자 둘중 선택 > 회원가입 결과 ->
   
   <img src="https://user-images.githubusercontent.com/83484877/116872162-67934d00-ac50-11eb-9762-4c2347342cb0.jpg" width="350" height="200">

   일반을 선택 > 로그인 결과 ->
   
   <img src="https://user-images.githubusercontent.com/83484877/116872423-d2dd1f00-ac50-11eb-817d-f75ff454cc53.jpg" width="600" height="300">

   관리자를 선택 > 회원가입 결과 ->
   
   <img src="https://user-images.githubusercontent.com/83484877/116872739-6282cd80-ac51-11eb-8ec9-70a341972eeb.jpg" width="650" height="500">
   
   관리자를 선택 > 로그인 결과[우측 상단에 내글 (관리자)] ->
   
   <img src="https://user-images.githubusercontent.com/83484877/116873159-28fe9200-ac52-11eb-8809-190b1d266189.jpg" width="600" height="300">

1. 게시판 리스트 : Proj_First > jsp > free.jsp 실행 후 > ../freeBBS_jsp > list.jsp(리스트 파일이 실행됨)
  
2. 게시판 글쓰기(게시물 작성) : 1번(list.jsp)에서 String id = (String)session.getAttribute("idKey"); 로그인의 아이디를 세션으로.
   <%if(id != null){%> <%} a태그의 글작성 ../freeBBS_jsp/post.jsp 경로와, input 태그의 글작성 버튼 타입 생성 %>의 jsp코드를 입력시, 세션으로 로그인시 글작성 버튼이 생성됨
   
   <img src="https://user-images.githubusercontent.com/83484877/116841269-a22ac480-ac13-11eb-99fb-0e6cc5ff3d87.jpg" width="600" height="300">

  단, 비 로그인시 버튼이 사라짐 
  
  <img src="https://user-images.githubusercontent.com/83484877/116841369-f170f500-ac13-11eb-9e1e-cbaeaccc8fe2.jpg" width="600" height="300">

   -> 로그인 후 글작성 버튼 실행 > freeBBS_jsp > post.jsp이 실행됨
   
   <img src="https://user-images.githubusercontent.com/83484877/116843598-6267db00-ac1b-11eb-8a3a-818ccc5a966e.jpg" width="700" height="500">

 2.1 게시글의 작성자 : 작성자 표시는 input 태그 안에 value="<%=userName %>"를 넣어 주면 로그인 계정의 이름이 표시가 됨 그 전에 String id = (String) session.getAttribute("idKey"); 과	String userName = bMgr.getWriterName(id);가 있어야 하고, getWriterName(id)는 Proj_First > src > packFreeBBS > BoardMgr.java의 public String getWriterName(String id)에서 try catch구문안에 sql="select * from tblMember where id=?";를 통해서 실행 되어 작성자 이름이 표시 됨 ->
 
<img src="https://user-images.githubusercontent.com/83484877/116858225-03b15a00-ac39-11eb-9a05-470d10b341d1.jpg" width="350" height="200">


 2.2 게시글 작성 후 : 등록 버튼 실행 > form 태그의 action에서 postProc.jsp파일이 실행되고 > postProc.jsp파일에서 response.sendRedirect("../jsp/free.jsp"); 코드가 실행하면 게시판 리스트 파일로 돌아가게 되고, 게시판 리스트에는 작성된 글의 순서, 제목, 날짜 등이 표시 됨
 
 <img src="https://user-images.githubusercontent.com/83484877/116848223-1884f200-ac27-11eb-8a6e-7bb3ca07626d.jpg" width="600" height="300">

 2.3 게시글의 데이터 저장 : 게시글 등록 후 데이터 저장은 Proj_First > src > packFreeBBS > BoardMgr.java의 public void insertFreeBoard가 실행되고 My-SQL에 데이터에 저장 된다.
 결과는 ->
 
 ![sql코드에 등록된 게시글의 데이터가 저장](https://user-images.githubusercontent.com/83484877/116848317-4bc78100-ac27-11eb-9847-8170db7b6625.jpg)
 
3. 작성된 게시글 보기 : 1번의 게시판 리스트에서 게시글의 제목을 클릭 후 > a태그의 href="javascript:read('<%=num%>')"><%=subject%> 실행 됨
 
 <img src="https://user-images.githubusercontent.com/83484877/116849399-a8c43680-ac29-11eb-8339-b0226b8cad62.jpg" width="600" height="350">
   
 3.1 게시글의 수정 : 3번의 게시글의 read.jsp에서 수정버튼 실행 > update.jsp실행 > 변경할 내용을 수정과 비밀번호 입력후 수정완료 실행 시 > updateProc.jsp파일이 실행되고, 자신의 게시글 내용이 수정 됨
  
  read.jsp에 게시글에서 수정 버튼 실행 ->
 
 <img src="https://user-images.githubusercontent.com/83484877/116857164-538f2180-ac37-11eb-9119-78f8bc5f401d.jpg" width="600" height="350">
  
  게시글의 내용을 수정 및 변경을 내용칸에 작성 가능
 
 <img src="https://user-images.githubusercontent.com/83484877/116844079-f2f2eb00-ac1c-11eb-8b3e-a2b5762d7c46.jpg" width="700" height="500">

  게시글의 내용 변경 후
 
  <img src="https://user-images.githubusercontent.com/83484877/116849874-8383f800-ac2a-11eb-8eb3-49a8fc7974eb.jpg" width="600" height="300">

 게시글의 내용 변경은 Proj_First > src > packFreeBBS > BoardMgr.java의 public void updateBoard에서 try catch구문안에 sql코드가(update tblBoard set name=?,subject=?,content=? where num=?)실행되서 > SQL에 보여지는 수정 게시글 결과
 
 ![sql코드에 등록된 게시글의  수정 데이터가 저장](https://user-images.githubusercontent.com/83484877/116850279-57b54200-ac2b-11eb-83d8-b145045535c7.jpg)

 3.2 게시글의 답변 : 3번의 게시글의 read.jsp에서 답변버튼의 reply.jsp가 실행 > 답변버튼은 a태그의 href="reply.jsp?nowPage=<%=nowPage%>" class="button 페이지가 실행 후 > 답변 내용을 입력하고 답변등록 버튼 실행 > 게시글 답변 등록은 Proj_First > src > packFreeBBS > BoardMgr.java의 public void replyFreeBoard에서 실행 되어 My-SQL에 데이터가 저장 됨
   
   게시글의 답변 버튼 실행 ->
 
 <img src="https://user-images.githubusercontent.com/83484877/116857334-92bd7280-ac37-11eb-95ab-5eb56ac51c82.jpg" width="600" height="350">

   게시글의 답변 페이지 ->
 
 <img src="https://user-images.githubusercontent.com/83484877/116849489-cd201300-ac29-11eb-8c99-7bf795d1b4fe.jpg" width="700" height="500">

 3.3 게시글의 답변 등록 : reply.jsp에서 답변등록 실행 후 > replyProc.jsp가 실행 됨 > response.sendRedirect("../jsp/free.jsp?nowPage="+nowPage);의 구문이 실행 됨 > list.jsp에 원본글 밑에 └ 아이콘과 답변: 계시글의 제목이 표시 됨 > 게시글 답변 표시는 Proj_First > src > packFreeBBS > BoardMgr.java의 public List<BoardBean> getFreeBoardList에서 try and catch구문 안에 있는 sql = "select * from tblBoard order by ref asc limit ?, ?;";코드로 ref(게시글 그룹)를 오름차순 해서 정렬 되어 list.jsp에 답변이 원본글 아래에 표시 됨
 
 <img src="https://user-images.githubusercontent.com/83484877/116849991-c47c0c80-ac2a-11eb-998b-da9d1dd14477.jpg" width="650" height="350">
 
  게시글의 답변의 데이터는 Proj_First > src > packFreeBBS > BoardMgr.java의 public void replyFreeBoard에 try catch구문 안에 있는 sql코드를 실행 후 데이터가 저장 되고, SQL에서 보여지는 답변 게시글의 데이터 결과 ->
 
 ![sql코드에 등록된 게시글의 답변 데이터가 저장](https://user-images.githubusercontent.com/83484877/116850201-2dfc1b00-ac2b-11eb-95c6-8c6c11940de9.jpg)

4. 게시글 삭제 : list.jsp에 등록된 게시글의 제목을 클릭 > read.jsp에 보여지는 게시글의 삭제 버튼 실행 > delete.jsp의 a태그 href="delete.jsp?nowPage=<%=nowPage%>&num=<%=num%>가 실행 됨
 
 원본 게시글 > 삭제 버튼 실행 -> 
 
  <img src="https://user-images.githubusercontent.com/83484877/116850668-fd68b100-ac2b-11eb-820a-c276a997b72c.jpg" width="600" height="350">
  
  삭제 버튼 실행 > 기존에 등록된 게시물의 비밀번호 입력 창 ->
  
 <img src="https://user-images.githubusercontent.com/83484877/116851015-9e576c00-ac2c-11eb-8be7-87e1bb5060dd.jpg" width="600" height="350">

 4.1 게시글 삭제 완료 : delete.jsp에서 게시글의 비밀번호가 sql의 데이터에 저장된 비밀번호와 일치 하면 삭제 할 게시글의 sql 데이터(게시글 데이터)가 삭제 됨 > 삭제 완료후 list.jsp로 이동 됨
 
 <img src="https://user-images.githubusercontent.com/83484877/116851212-f68e6e00-ac2c-11eb-918d-37bfea472a89.jpg" width="600" height="300">

 삭제 된 게시글은 Proj_First > src > packFreeBBS > BoardMgr.java에서 public void deleteFreeBoard의 sql = "delete from tblBoard where num=?"; 코드를 My-SQL에서 실행 후 > SQL에 보여지는 삭제 게시 글(원본의 게시글이 삭제된 데이터의 SQL 결과) ->

![sql코드에 등록된 게시글의 데이터가 삭제](https://user-images.githubusercontent.com/83484877/116851310-1de53b00-ac2d-11eb-9e00-a73f9723703f.jpg)
  
 5. 첨부파일이 포함된 게시글 등록 : post.jsp에서 글작성 후 > 첨부파일란에서 파일찾기 버튼 실행 후 원하는 파일 선택 > 옆에 선택된 파일이 보여 짐

<img src="https://user-images.githubusercontent.com/83484877/116851951-63eece80-ac2e-11eb-9b93-3a995a6d9636.jpg" width="700" height="500">

  5.1 게시글를 첨부파일 첨부와 등록 : post.jsp에서 글작성과 첨부파일 첨부후 게시글을 등록 > read.jsp에서 첨부된 파일이 표시 됨 > 첨부 파일을 클릭 후 download.jsp가 실행 됨 > 첨부 된 파일은 업로드 파일에 저장

<img src="https://user-images.githubusercontent.com/83484877/116852124-baf4a380-ac2e-11eb-8dfa-2102eb323141.jpg" width="600" height="300">

   5.2 게시글의 내용과 첨부파일이 Proj_First > src > packFreeBBS > BoardMgr.java의 public void insertFreeBoard의 multi = new MultipartRequest등의 코드를 실행 > 새 게시글과 첨부파일이 포함된 게시글의 SQL 결과(첨부파일의 filesize 와 filename이 생성됨) 

![sql코드에 등록된 게시글의 데이터와 첨부파일 저장](https://user-images.githubusercontent.com/83484877/116852881-1b381500-ac30-11eb-90cc-553468fdb90a.jpg)

   5.3 첨부된 파일 클릭 후 > 첨부 된 파일 원하는 저장 위치를 선택해 다운로드 ->

<img src="https://user-images.githubusercontent.com/83484877/116852382-32c2ce00-ac2f-11eb-8634-8e6bcc44b71f.jpg" width="650" height="400">

🏆 웹 프로젝트 과정 내용 간략하게 구현 [PPT]

[김성원.pptx](https://github.com/swkim0421/swkimProject/files/6419255/default.pptx)

