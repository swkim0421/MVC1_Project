# π΅οΈ κΉμ±μμ νλ‘μ νΈ
- Team Project

## ποΈ MVC1ν¨ν΄ κΈ°λ° μΉ νλ‘μ νΈ

:computer: νλ‘μ νΈ κ³Όμ 

β κΈ°κ° : 2019. 04. 15 ~ 2019. 04. 30

β μ΄ νμ μ : 5λͺ

β λ΄μ© : MVC1 ν¨ν΄ κΈ°λ° κ²μνμ μΉ ννμ΄μ§ νλ‘μ νΈ

β νλ‘μ νΈ μ¬μ© μΈμ΄ : Html, JSP, Java, Javascript, CSS, My-SQL(DB)..λ±

1. λ³ΈμΈ - μμ  κ²μν
* λ΄μ© : κ²μκΈ μμ± λ° λ±λ‘, μμ , κ²μκΈ μλ‘λ λ° μ­μ , κ²μκΈμ νμΌ μλ‘λ λ° λ€μ΄λ‘λ, κ²μκΈ λ±λ‘ μκ°, κ²μκΈ μ‘°νμ, κ²μκΈ μμ±μ λ‘κ·ΈμΈ κΆν, λ΅λ³κΈ, DBμ κ²μκΈ λ±λ‘ λ°μ΄ν°

2. λλ¨Έμ§ νμλ€ - κ°€λ¬λ¦¬ κ²μν, κ³΅μ§ κ²μν, μ΅λͺ κ²μν,λ‘κ·ΈμΈμ°½, νμκ°μ λ±

### π₯ νκ²½ :
β JDK  : 1.8.version

β TOMCAT : 8.5.version

β Eclipse : Eclipse IDE for Enterprise Java Developers & 2018-12 (4.10.0)

β μΈμ½λ© : UTF-8

β My-SQL Workbench : 8.0

### π₯ νκ²½ λ³μ :  
β JDK 1.8version μ€μΉ
 
 1. μ μ΄ν > μμ€ν λ° λ³΄μ > μμ€ν >  κ³ κΈ μμ€ν μ€μ  > νκ²½ λ³μ(N) > μμ€ν λ³μ(S) > [μΈλ‘λ§λ€κΈ°(W)] >
λ³μ μ΄λ¦(N): JAVA_HOME > λ³μ κ°(V): jdk 1.8versionμ΄ μ€μΉλ νμΌ κ²½λ‘ > [νμΈ]
 
 1.1 νκ²½λ³μ > μμ€ν λ³μ(S) > Path μ ν > [νΈμ§(I)] > μμ€ν λ³μ νΈμ§ > λ³μ μ΄λ¦(N): Path > λ³μ κ°(V) > %JAVA_HOME%\bin; > [νμΈ]
 
 2. μμ λ²νΌ(Win) + X > λͺλ Ή νλ‘¬ννΈ(C) [CMD] > java -version > java version 1.8.0_291
 
 2.1  μμ λ²νΌ(Win) + X > λͺλ Ή νλ‘¬ννΈ(C) [CMD] > javac -version > 1.8.0_221

My-SQL μ€ν€λ§ μμ±

+  mydb : μ€ν€λ§ μμ±
+  use mydb : μ€ν€λ§ μ ν

create database mydb;

use mydb;

My-SQL νμ΄λΈ μμ± λ° λ°μ΄ν° μΆκ°

+ tblMember νμ΄λΈ μμ±

  βCREATE TABLE `tblMember` (
  
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
 
+ tblZipcode νμ΄λΈ μμ± //μ°νΈλ²νΈ μ°ΎκΈ°
 
  CREATE TABLE `tblZipcode` (
  
  `zipcode` char(7) NOT NULL,
  
  `area1` char(10) DEFAULT NULL,
  
  `area2` char(20) DEFAULT NULL,
  
  `area3` char(40) DEFAULT NULL,
  
  `area4` char(20) DEFAULT NULL
);
  
  //μ°νΈλ²νΈ μ°ΎκΈ°μ μ λ³΄ μΆκ°
 
insert into tblZipcode values('14506','λΆμ²μ','μλ―Έκ΅¬','μλ λ€μ νλ§μ','500-5λ²μ§');

insert into tblZipcode values('14507','λΆμ²μ','μλ―Έκ΅¬','μλ μ§λ¬λλ§μ','526-4λ²μ§');

insert into tblZipcode values('14536','λΆμ²μ','μλ―Έκ΅¬','μ€λ λμ λ§μ','1040λ²μ§');

insert into tblZipcode values('14539','λΆμ²μ','μλ―Έκ΅¬','μ€λ μ€ν₯λ§μ','1054λ²μ§');

insert into tblZipcode values('14538','λΆμ²μ','μλ―Έκ΅¬','μ€λ μνλ§μ','1036λ²μ§');

insert into tblZipcode values('14535','λΆμ²μ','μλ―Έκ΅¬','μ€λ μ€μλ§μ','1051-12λ²μ§');

insert into tblZipcode values('14511','λΆμ²μ','μλ―Έκ΅¬','μ€λ νλΌλ§μ','1027-3λ²μ§');

+ tblBoard νμ΄λΈ μμ± //κ²μν λ¦¬μ€νΈ λ° κ²μκΈ
  
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


### νλ‘μ νΈ κΈ°λ₯ κ΅¬ν λ° κ²°κ³Ό λ΄μ© μ€λͺ:

0. λ‘κ·ΈμΈ λ°©λ² : νμκ°μ λ²νΌ μ€ν > νμκ°μ μ μ°¨μ€ μ°νΈλ²νΈ κ²μμ DBtable_code.sqlνμΌμμ μ°νΈλ²νΈ μ λ³΄ μΆκ°λ insert into tblZipcode values('14506','λΆμ²μ','μλ―Έκ΅¬','μλ λ€μ νλ§μ','500-5λ²μ§');μ΄λ€
  
  0.1 νμκ°μ λ²νΌ : Proj_First > jsp > index.jspνμΌμ μ€ν νλ©΄ νμκ°μ λ²νΌμ΄ μ’μΈ‘ μ°μΈ‘μλ¨μ μκ³ , 
     νμκ°μ λ²νΌμ μ€ν νλ©΄ κ²°κ³Όλ ->
     
   <img src="https://user-images.githubusercontent.com/83484877/116871213-e091a500-ac4e-11eb-8e23-665d43614ef8.jpg" width="700" height="300">
  
  0.2 νμκ°μ μ°½ : νμκ°μ μ°½μ Proj_First > jsp > index.jspμμ member_jsp > member.jspκ° μ€ν ->
    
   <img src="https://user-images.githubusercontent.com/83484877/116867386-05cee500-ac48-11eb-8288-4321d2a2367f.jpg" width="650" height="500">

  0.3 νμκ°μ μ μ°¨ μ€ μ°νΈλ²νΈ μ λ³΄ μΆκ°λ SQLμμ insert into tblZipcode values('14506','λΆμ²μ','μλ―Έκ΅¬','μλ λ€μ νλ§μ','500-5λ²μ§');μ½λλ₯Ό μ€ν > SQLμ μ°νΈλ²νΈ μΆκ°(κ²μ)μ λ°μ΄ν° κ²°κ³Όλ ->
  
  <img src="https://user-images.githubusercontent.com/83484877/116866688-cfdd3100-ac46-11eb-81fd-1b8d44a55cc4.jpg" width="350" height="200">
  
  0.4 νμκ°μ μ°½μμ μ°νΈλ²νΈ μ°ΎκΈ° λ²νΌ ->
    
   <img src="https://user-images.githubusercontent.com/83484877/116867578-6e1dc680-ac48-11eb-9538-e0a07d576439.jpg" width="650" height="500">

  0.5 μ°νΈλ²νΈ μ°ΎκΈ° κ²μ μ°½ : SQLμμ μΆκ°ν insertκ΅¬λ¬Έμ μ°νΈλ²νΈ κ²μμ°½μμ λ_μ΄λ¦μ κ²μ ν λ΅€μ¬μ§λ κ²°κ³Ό -> 
  
 <img src="https://user-images.githubusercontent.com/83484877/116867902-c654c880-ac48-11eb-9fa1-44e56fe59e58.jpg" width="600" height="450">

  0.6 νμκ°μ λ±λ‘ : νμκ°μ μ μ°¨ λλ‘ μμ΄λ, λΉλ°λ²νΈ, μ΄λ¦, μλμμΌ, μ°νΈλ²νΈ, μ·¨λ―Έ λ± μλ ₯ ν > λ§μ§λ§μλ νμμμΈμ λ³΄κ° μΌλ° κ³Ό κ΄λ¦¬μκ° μλ€
    -> μΌλ° κ³Ό κ΄λ¦¬μ λμ€ 1κ°λ₯Ό μ νμ ν΄ κ°μ λ±λ‘ νλ©΄ μλ¦Ό λ©μΈμ§ μ°½μ΄ λΈ
    
   μΌλ° κ³Ό κ΄λ¦¬μ λμ€ μ ν > νμκ°μ κ²°κ³Ό ->
   
   <img src="https://user-images.githubusercontent.com/83484877/116872162-67934d00-ac50-11eb-9762-4c2347342cb0.jpg" width="350" height="200">

   μΌλ°μ μ ν > λ‘κ·ΈμΈ κ²°κ³Ό ->
   
   <img src="https://user-images.githubusercontent.com/83484877/116872423-d2dd1f00-ac50-11eb-817d-f75ff454cc53.jpg" width="600" height="300">

   κ΄λ¦¬μλ₯Ό μ ν > νμκ°μ κ²°κ³Ό ->
   
   <img src="https://user-images.githubusercontent.com/83484877/116872739-6282cd80-ac51-11eb-8ec9-70a341972eeb.jpg" width="650" height="500">
   
   κ΄λ¦¬μλ₯Ό μ ν > λ‘κ·ΈμΈ κ²°κ³Ό[μ°μΈ‘ μλ¨μ λ΄κΈ (κ΄λ¦¬μ)] ->
   
   <img src="https://user-images.githubusercontent.com/83484877/116873159-28fe9200-ac52-11eb-8809-190b1d266189.jpg" width="600" height="300">

1. κ²μν λ¦¬μ€νΈ : Proj_First > jsp > free.jsp μ€ν ν > ../freeBBS_jsp > list.jsp(λ¦¬μ€νΈ νμΌμ΄ μ€νλ¨)
  
2. κ²μν κΈμ°κΈ°(κ²μλ¬Ό μμ±) : 1λ²(list.jsp)μμ String id = (String)session.getAttribute("idKey"); λ‘κ·ΈμΈμ μμ΄λλ₯Ό μΈμμΌλ‘.
   <%if(id != null){%> <%} aνκ·Έμ κΈμμ± ../freeBBS_jsp/post.jsp κ²½λ‘μ, input νκ·Έμ κΈμμ± λ²νΌ νμ μμ± %>μ jspμ½λλ₯Ό μλ ₯μ, μΈμμΌλ‘ λ‘κ·ΈμΈμ κΈμμ± λ²νΌμ΄ μμ±λ¨
   
   <img src="https://user-images.githubusercontent.com/83484877/116841269-a22ac480-ac13-11eb-99fb-0e6cc5ff3d87.jpg" width="600" height="300">

  λ¨, λΉ λ‘κ·ΈμΈμ λ²νΌμ΄ μ¬λΌμ§ 
  
  <img src="https://user-images.githubusercontent.com/83484877/116841369-f170f500-ac13-11eb-9e1e-cbaeaccc8fe2.jpg" width="600" height="300">

   -> λ‘κ·ΈμΈ ν κΈμμ± λ²νΌ μ€ν > freeBBS_jsp > post.jspμ΄ μ€νλ¨
   
   <img src="https://user-images.githubusercontent.com/83484877/116843598-6267db00-ac1b-11eb-8a3a-818ccc5a966e.jpg" width="700" height="500">

 2.1 κ²μκΈμ μμ±μ : μμ±μ νμλ input νκ·Έ μμ value="<%=userName %>"λ₯Ό λ£μ΄ μ£Όλ©΄ λ‘κ·ΈμΈ κ³μ μ μ΄λ¦μ΄ νμκ° λ¨ κ·Έ μ μ String id = (String) session.getAttribute("idKey"); κ³Ό	String userName = bMgr.getWriterName(id);κ° μμ΄μΌ νκ³ , getWriterName(id)λ Proj_First > src > packFreeBBS > BoardMgr.javaμ public String getWriterName(String id)μμ try catchκ΅¬λ¬Έμμ sql="select * from tblMember where id=?";λ₯Ό ν΅ν΄μ μ€ν λμ΄ μμ±μ μ΄λ¦μ΄ νμ λ¨ ->
 
<img src="https://user-images.githubusercontent.com/83484877/116858225-03b15a00-ac39-11eb-9a05-470d10b341d1.jpg" width="350" height="200">


 2.2 κ²μκΈ μμ± ν : λ±λ‘ λ²νΌ μ€ν > form νκ·Έμ actionμμ postProc.jspνμΌμ΄ μ€νλκ³  > postProc.jspνμΌμμ response.sendRedirect("../jsp/free.jsp"); μ½λκ° μ€ννλ©΄ κ²μν λ¦¬μ€νΈ νμΌλ‘ λμκ°κ² λκ³ , κ²μν λ¦¬μ€νΈμλ μμ±λ κΈμ μμ, μ λͺ©, λ μ§ λ±μ΄ νμ λ¨
 
 <img src="https://user-images.githubusercontent.com/83484877/116848223-1884f200-ac27-11eb-8a6e-7bb3ca07626d.jpg" width="600" height="300">

 2.3 κ²μκΈμ λ°μ΄ν° μ μ₯ : κ²μκΈ λ±λ‘ ν λ°μ΄ν° μ μ₯μ Proj_First > src > packFreeBBS > BoardMgr.javaμ public void insertFreeBoardκ° μ€νλκ³  My-SQLμ λ°μ΄ν°μ μ μ₯ λλ€.
 κ²°κ³Όλ ->
 
 ![sqlμ½λμ λ±λ‘λ κ²μκΈμ λ°μ΄ν°κ° μ μ₯](https://user-images.githubusercontent.com/83484877/116848317-4bc78100-ac27-11eb-9847-8170db7b6625.jpg)
 
3. μμ±λ κ²μκΈ λ³΄κΈ° : 1λ²μ κ²μν λ¦¬μ€νΈμμ κ²μκΈμ μ λͺ©μ ν΄λ¦­ ν > aνκ·Έμ href="javascript:read('<%=num%>')"><%=subject%> μ€ν λ¨
 
 <img src="https://user-images.githubusercontent.com/83484877/116849399-a8c43680-ac29-11eb-8339-b0226b8cad62.jpg" width="600" height="350">
   
 3.1 κ²μκΈμ μμ  : 3λ²μ κ²μκΈμ read.jspμμ μμ λ²νΌ μ€ν > update.jspμ€ν > λ³κ²½ν  λ΄μ©μ μμ κ³Ό λΉλ°λ²νΈ μλ ₯ν μμ μλ£ μ€ν μ > updateProc.jspνμΌμ΄ μ€νλκ³ , μμ μ κ²μκΈ λ΄μ©μ΄ μμ  λ¨
  
  read.jspμ κ²μκΈμμ μμ  λ²νΌ μ€ν ->
 
 <img src="https://user-images.githubusercontent.com/83484877/116857164-538f2180-ac37-11eb-9119-78f8bc5f401d.jpg" width="600" height="350">
  
  κ²μκΈμ λ΄μ©μ μμ  λ° λ³κ²½μ λ΄μ©μΉΈμ μμ± κ°λ₯
 
 <img src="https://user-images.githubusercontent.com/83484877/116844079-f2f2eb00-ac1c-11eb-8b3e-a2b5762d7c46.jpg" width="700" height="500">

  κ²μκΈμ λ΄μ© λ³κ²½ ν
 
  <img src="https://user-images.githubusercontent.com/83484877/116849874-8383f800-ac2a-11eb-8eb3-49a8fc7974eb.jpg" width="600" height="300">

 κ²μκΈμ λ΄μ© λ³κ²½μ Proj_First > src > packFreeBBS > BoardMgr.javaμ public void updateBoardμμ try catchκ΅¬λ¬Έμμ sqlμ½λκ°(update tblBoard set name=?,subject=?,content=? where num=?)μ€νλμ > SQLμ λ³΄μ¬μ§λ μμ  κ²μκΈ κ²°κ³Ό
 
 ![sqlμ½λμ λ±λ‘λ κ²μκΈμ  μμ  λ°μ΄ν°κ° μ μ₯](https://user-images.githubusercontent.com/83484877/116850279-57b54200-ac2b-11eb-83d8-b145045535c7.jpg)

 3.2 κ²μκΈμ λ΅λ³ : 3λ²μ κ²μκΈμ read.jspμμ λ΅λ³λ²νΌμ reply.jspκ° μ€ν > λ΅λ³λ²νΌμ aνκ·Έμ href="reply.jsp?nowPage=<%=nowPage%>" class="button νμ΄μ§κ° μ€ν ν > λ΅λ³ λ΄μ©μ μλ ₯νκ³  λ΅λ³λ±λ‘ λ²νΌ μ€ν > κ²μκΈ λ΅λ³ λ±λ‘μ Proj_First > src > packFreeBBS > BoardMgr.javaμ public void replyFreeBoardμμ μ€ν λμ΄ My-SQLμ λ°μ΄ν°κ° μ μ₯ λ¨
   
   κ²μκΈμ λ΅λ³ λ²νΌ μ€ν ->
 
 <img src="https://user-images.githubusercontent.com/83484877/116857334-92bd7280-ac37-11eb-95ab-5eb56ac51c82.jpg" width="600" height="350">

   κ²μκΈμ λ΅λ³ νμ΄μ§ ->
 
 <img src="https://user-images.githubusercontent.com/83484877/116849489-cd201300-ac29-11eb-8c99-7bf795d1b4fe.jpg" width="700" height="500">

 3.3 κ²μκΈμ λ΅λ³ λ±λ‘ : reply.jspμμ λ΅λ³λ±λ‘ μ€ν ν > replyProc.jspκ° μ€ν λ¨ > response.sendRedirect("../jsp/free.jsp?nowPage="+nowPage);μ κ΅¬λ¬Έμ΄ μ€ν λ¨ > list.jspμ μλ³ΈκΈ λ°μ β μμ΄μ½κ³Ό λ΅λ³: κ³μκΈμ μ λͺ©μ΄ νμ λ¨ > κ²μκΈ λ΅λ³ νμλ Proj_First > src > packFreeBBS > BoardMgr.javaμ public List<BoardBean> getFreeBoardListμμ try and catchκ΅¬λ¬Έ μμ μλ sql = "select * from tblBoard order by ref asc limit ?, ?;";μ½λλ‘ ref(κ²μκΈ κ·Έλ£Ή)λ₯Ό μ€λ¦μ°¨μ ν΄μ μ λ ¬ λμ΄ list.jspμ λ΅λ³μ΄ μλ³ΈκΈ μλμ νμ λ¨
 
 <img src="https://user-images.githubusercontent.com/83484877/116849991-c47c0c80-ac2a-11eb-998b-da9d1dd14477.jpg" width="650" height="350">
 
  κ²μκΈμ λ΅λ³μ λ°μ΄ν°λ Proj_First > src > packFreeBBS > BoardMgr.javaμ public void replyFreeBoardμ try catchκ΅¬λ¬Έ μμ μλ sqlμ½λλ₯Ό μ€ν ν λ°μ΄ν°κ° μ μ₯ λκ³ , SQLμμ λ³΄μ¬μ§λ λ΅λ³ κ²μκΈμ λ°μ΄ν° κ²°κ³Ό ->
 
 ![sqlμ½λμ λ±λ‘λ κ²μκΈμ λ΅λ³ λ°μ΄ν°κ° μ μ₯](https://user-images.githubusercontent.com/83484877/116850201-2dfc1b00-ac2b-11eb-95c6-8c6c11940de9.jpg)

4. κ²μκΈ μ­μ  : list.jspμ λ±λ‘λ κ²μκΈμ μ λͺ©μ ν΄λ¦­ > read.jspμ λ³΄μ¬μ§λ κ²μκΈμ μ­μ  λ²νΌ μ€ν > delete.jspμ aνκ·Έ href="delete.jsp?nowPage=<%=nowPage%>&num=<%=num%>κ° μ€ν λ¨
 
 μλ³Έ κ²μκΈ > μ­μ  λ²νΌ μ€ν -> 
 
  <img src="https://user-images.githubusercontent.com/83484877/116850668-fd68b100-ac2b-11eb-820a-c276a997b72c.jpg" width="600" height="350">
  
  μ­μ  λ²νΌ μ€ν > κΈ°μ‘΄μ λ±λ‘λ κ²μλ¬Όμ λΉλ°λ²νΈ μλ ₯ μ°½ ->
  
 <img src="https://user-images.githubusercontent.com/83484877/116851015-9e576c00-ac2c-11eb-8be7-87e1bb5060dd.jpg" width="600" height="350">

 4.1 κ²μκΈ μ­μ  μλ£ : delete.jspμμ κ²μκΈμ λΉλ°λ²νΈκ° sqlμ λ°μ΄ν°μ μ μ₯λ λΉλ°λ²νΈμ μΌμΉ νλ©΄ μ­μ  ν  κ²μκΈμ sql λ°μ΄ν°(κ²μκΈ λ°μ΄ν°)κ° μ­μ  λ¨ > μ­μ  μλ£ν list.jspλ‘ μ΄λ λ¨
 
 <img src="https://user-images.githubusercontent.com/83484877/116851212-f68e6e00-ac2c-11eb-918d-37bfea472a89.jpg" width="600" height="300">

 μ­μ  λ κ²μκΈμ Proj_First > src > packFreeBBS > BoardMgr.javaμμ public void deleteFreeBoardμ sql = "delete from tblBoard where num=?"; μ½λλ₯Ό My-SQLμμ μ€ν ν > SQLμ λ³΄μ¬μ§λ μ­μ  κ²μ κΈ(μλ³Έμ κ²μκΈμ΄ μ­μ λ λ°μ΄ν°μ SQL κ²°κ³Ό) ->

![sqlμ½λμ λ±λ‘λ κ²μκΈμ λ°μ΄ν°κ° μ­μ ](https://user-images.githubusercontent.com/83484877/116851310-1de53b00-ac2d-11eb-9e00-a73f9723703f.jpg)
  
 5. μ²¨λΆνμΌμ΄ ν¬ν¨λ κ²μκΈ λ±λ‘ : post.jspμμ κΈμμ± ν > μ²¨λΆνμΌλμμ νμΌμ°ΎκΈ° λ²νΌ μ€ν ν μνλ νμΌ μ ν > μμ μ νλ νμΌμ΄ λ³΄μ¬ μ§

<img src="https://user-images.githubusercontent.com/83484877/116851951-63eece80-ac2e-11eb-9b93-3a995a6d9636.jpg" width="700" height="500">

  5.1 κ²μκΈλ₯Ό μ²¨λΆνμΌ μ²¨λΆμ λ±λ‘ : post.jspμμ κΈμμ±κ³Ό μ²¨λΆνμΌ μ²¨λΆν κ²μκΈμ λ±λ‘ > read.jspμμ μ²¨λΆλ νμΌμ΄ νμ λ¨ > μ²¨λΆ νμΌμ ν΄λ¦­ ν download.jspκ° μ€ν λ¨ > μ²¨λΆ λ νμΌμ μλ‘λ νμΌμ μ μ₯

<img src="https://user-images.githubusercontent.com/83484877/116852124-baf4a380-ac2e-11eb-8dfa-2102eb323141.jpg" width="600" height="300">

   5.2 κ²μκΈμ λ΄μ©κ³Ό μ²¨λΆνμΌμ΄ Proj_First > src > packFreeBBS > BoardMgr.javaμ public void insertFreeBoardμ multi = new MultipartRequestλ±μ μ½λλ₯Ό μ€ν > μ κ²μκΈκ³Ό μ²¨λΆνμΌμ΄ ν¬ν¨λ κ²μκΈμ SQL κ²°κ³Ό(μ²¨λΆνμΌμ filesize μ filenameμ΄ μμ±λ¨) 

![sqlμ½λμ λ±λ‘λ κ²μκΈμ λ°μ΄ν°μ μ²¨λΆνμΌ μ μ₯](https://user-images.githubusercontent.com/83484877/116852881-1b381500-ac30-11eb-90cc-553468fdb90a.jpg)

   5.3 μ²¨λΆλ νμΌ ν΄λ¦­ ν > μ²¨λΆ λ νμΌ μνλ μ μ₯ μμΉλ₯Ό μ νν΄ λ€μ΄λ‘λ ->

<img src="https://user-images.githubusercontent.com/83484877/116852382-32c2ce00-ac2f-11eb-8634-8e6bcc44b71f.jpg" width="650" height="400">

π μΉ νλ‘μ νΈ κ³Όμ  λ΄μ© κ°λ΅νκ² κ΅¬ν [PPT]

[ν¬νΈν΄λ¦¬μ€_κΉμ±μ.pptx](https://github.com/swkim0421/MVC1_Project/files/6440716/_.pptx)


