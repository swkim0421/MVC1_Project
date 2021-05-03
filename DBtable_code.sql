#스케마 생성
create database mydb;

#스케마 선택
use mydb;

#회원가입의 맴버 '계정' 생성 
CREATE TABLE `tblMember` (
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

#로그인의 계정을 추가 하는 데이터
insert tblmember
values(
'kim0421', '1234', '김성원', '1', '890207', 'swkim042@naver.com', '420-080',
'경기도 부천시 원미구 상동', '컴퓨터', '리버', 5
);

#로그인이 가능한 회원의 정보 결과
select * from tblmember;

#게시판 우편번호 테이블 생성
CREATE TABLE `tblZipcode` (
  `zipcode` char(7) NOT NULL,
  `area1` char(10) DEFAULT NULL,
  `area2` char(20) DEFAULT NULL,
  `area3` char(40) DEFAULT NULL,
  `area4` char(20) DEFAULT NULL
);

#회원가입 중에서 우편번호 찾기 정보 추가
insert into tblZipcode values('14506','부천시','원미구','상동 다정한마을','500-5번지');
insert into tblZipcode values('14507','부천시','원미구','상동 진달래마을','526-4번지');
insert into tblZipcode values('14536','부천시','원미구','중동 덕유마을','1040번지');
insert into tblZipcode values('14539','부천시','원미구','중동 중흥마을','1054번지');
insert into tblZipcode values('14538','부천시','원미구','중동 은하마을','1036번지');
insert into tblZipcode values('14535','부천시','원미구','중동 설악마을','1051-12번지');
insert into tblZipcode values('14511','부천시','원미구','중동 한라마을','1027-3번지');

select * from tblzipcode;

#게시판 테이블 생성
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

#게시판의 게시글 데이터
select * from tblBoard; 

#게시판의  리스트의 ref를 오름차순 정렬
SELECT * FROM tblboard ORDER BY ref asc;     

#게시판 답변 테이블 생성
create table tblReply(
	lino		int(20) not null auto_increment,
	name  		varchar(25),
    id 			varchar(15),
    content		text,
    regdate		date,
    Ref			int(20),
    primary key(lino)
);

select * from tblreply;