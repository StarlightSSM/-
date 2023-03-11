<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.UserDAO"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.DiaryDAO"%>
<%@ page import="user.DiaryDTO"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

UserDAO dao = new UserDAO();

DiaryDAO diaryDAO = new DiaryDAO();
DiaryDTO diaryDTO = new DiaryDTO();
String email = (String) session.getAttribute("email");
String day = (String) session.getAttribute("day");
String emotion = (String) session.getAttribute("emotion");
String title = (String) session.getAttribute("title");
String img = (String) session.getAttribute("img");
String content = (String) session.getAttribute("content");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일기작성페이지</title>
<link rel="stylesheet" href="./static/font.css">
<link rel="stylesheet" href="./static/layout.css">
<link rel="stylesheet" href="./static/home.css">
<!-- 부트스트랩 링크 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
/* 폰트 설정 */
@import
	url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap')
	;

body {
	background-color: #F2E7DC;
	background-size: 100px;
	position: fixed;
	left: 0;
	top: 0;
	right: 0;
	bottom: 0;
}

.bookcover {
	/*배경색 설정*/
	background-color: #F2E7DC;
	/*모서리 약간 둥글게 설정*/
	border-radius: 10px;
	/*윤곽선*/
	border: 1px solid white;
	width: 1274px;
	height: 640px;
	/** 좌우 마진을 auto(중앙에 배치), 상하 마진을 35px로 지정 */
	margin: 35px auto;
	/** .bookdot 요소에서 absolute 속성값을 이용하기 위해 position: relative 로 설정 */
	position: relative;
}

.bookdot {
	border-radius: 10px;
	border: 2px dashed white;
	width: 1250px;
	height: 620px;
	position: absolute;
	top: 10px;
	left: 10px;
}

.page {
	background-color: #F2E7DC;
	border-radius: 10px;
	border: 1px solid white;
	width: 1214px;
	height: 590px;
	position: absolute;
	top: 15px;
	left: 15px;
	display: flex;
}

/*왼쪽 박스*/
.left-container {
	flex: 0.2;
	flex-direction: column;
	margin: 20px 20px 20px 20px;
	display: flex;
}

.total_visitor {
	flex: 0.05;
	text-align: center;
	font-family: 'NeoDunggeunmo';
	font-size: 15px;
}

.visitor {
	color: red;
}

.profile_box {
	flex: 1;
	border: 2px solid rgb(173, 188, 202);
	background-color: white;
	border-radius: 20px;
	display: flex;
	flex-direction: column;
	align-items: center;
	width: 250px;
}

.profile_img {
	flex: 0.3;
	margin: 15px 0 0 0;
}

.img { /*프로필 사진 설정*/
	border-radius: 10px;
}

.intro { /*소개 글*/
	flex: 0.5;
	margin: 0px 15px;
	font-family: 'KyoboHand';
	font-size: 14px;
}

.name { /*마지막줄 닉네임*/
	flex: 0.1;
	margin: 0px 15px;
	font-family: 'KyoboHand';
	font-size: 20px;
}

.dropdown {
	flex: 0.25;
}

#pado {
	background-color: white;
	color: black;
	font-weight: bold;
	font-family: 'KyoboHand';
	font-size: 17px;
	width: 135px;
}

.dropdown-item {
	font-family: 'KyoboHand';
	font-size: 17px;
}

/*가운데 박스*/
.mid-container {
	flex: 0.84;
	flex-direction: column;
	margin: 20px 0px 20px 0px;
	display: flex;
}

.home_top {
	flex: 0.05;
	display: flex;
}

.home_title { /*미니홈피 소개이름*/
	flex: 1;
	font-family: 'Noto Sans KR', sans-serif;
}

.home_url { /*url 주소*/
	flex: 1;
	text-align: right;
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 12px;
}

.layout_box {
	width: 100%;
	flex: 1;
	border-radius: 20px;
	background-color: white;
	border: 2px solid #4092ac;
	display: flex;
}

.diary_box {
	width: 100%;
	margin: 20px;
	float: left;
}

.diary_font { /*식물 텍스트*/
	border-bottom: 2px solid #4aaac7;
	font-family: 'KOTRA_BOLD-Bold';
	font-size: 20px;
	color: #4aaac7;
}

/*오른쪽 박스(메뉴 표시 박스)*/
.right-container {
	flex: 0.1;
	margin: 20px 20px 20px 0px;
}

.plant_record {
	background-color: rgb(255, 186, 129);
	width: 90px;
	font-family: 'NeoDunggeunmo';
	margin: 13px 0 0 0;
	text-align: left;
	border: 1px solid #F61414;
	border-top-right-radius: 7px;
	border-bottom-right-radius: 7px;
}

.profile {
	background-color: rgb(255, 87, 87);
	width: 90px;
	font-family: 'NeoDunggeunmo';
	margin: 13px 0 0 0;
	text-align: left;
	border: 1px solid #F61414;
	border-top-right-radius: 7px;
	border-bottom-right-radius: 7px;
}

.calender {
	background-color: rgb(194, 238, 226);
	width: 90px;
	font-family: 'NeoDunggeunmo';
	margin: 13px 0 0 0;
	text-align: left;
	border: 1px solid #4092ac;
	border-top-right-radius: 7px;
	border-bottom-right-radius: 7px;
}

.diary {
	background-color: rgb(240, 238, 175);
	width: 90px;
	font-family: 'NeoDunggeunmo';
	margin: 13px 0 0 0;
	text-align: left;
	border: 1px solid #4092ac;
	border-top-right-radius: 7px;
	border-bottom-right-radius: 7px;
}

input {
	margin-top: 0.4rem;
}

.home {
	background-color: rgb(231, 187, 232);
	width: 90px;
	font-family: 'NeoDunggeunmo';
	margin: 13px 0 0 0;
	text-align: left;
	border: 1px solid #4092ac;
	border-top-right-radius: 7px;
	border-bottom-right-radius: 7px;
}

.home {
	margin: 50px 0 0 0;
}

.menu a {
	text-decoration-line: none;
	color: white;
}

.menu div:hover {
	background-color: #b4d1da;
}

@font-face {
	font-family: 'KyoboHand';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-04@1.0/KyoboHand.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

@font-face {
	font-family: 'NeoDunggeunmo';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.3/NeoDunggeunmo.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

@font-face {
	font-family: 'KOTRA_BOLD-Bold';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-10-21@1.1/KOTRA_BOLD-Bold.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

.header {
	font-size: 15px;
	height: 50px;
	border-bottom: 1px solid black;
	display: flex;
	align-items: center;
	color: white;
	background-color: #F2E7DC;
}

.header-items {
	font-size: 10px;
	color: #4B4952;
	display: flex;
	margin-left: auto;
	margin-right: 10px;
}

.header-item {
	margin-left: 10px;
}

.header-item>a {
	text-decoration: none; /* 링크의 밑줄 제거 */
	color: inherit; /* 링크의 색상 제거 */
	color: #4B4952;
}

.nav {
	background-color: #F2E7DC;
}

.right-container {
	flex: 0.1;
}

table {
	margin-top: 5px;
}

.t1 {
	width: 700px;
	height: 190px;
	border: none;
}

td input {
	height: 23px;
}

td {
	margin-left: 5px;
	height: 25%;
}

td>p {
	width: 100px;
	text-align: center;
	background-color: #BFBFBF;
	margin-right: 10px;
}

.date {
	width: 18%;
	margin-bottom: 5px;
}

#date {
	margin-bottom: 18px;
}

td input[type="checkbox"] {
	width: 30px;
	margin-top: -3px;
	margin-bottom: 15px;
}

td input[type="file"] {
	margin-bottom: 15px;
	height: 30px;
}

td input[name="InsertTitle"] {
	margin-bottom: 15px;
}

.t2 {
	margin-top: 10px;
}

textarea {
	margin-top: 5px;
}

.update {
	border: 1px solid;
}
</style>

</head>
<body>
	<div class="header">
		감정일기
		<div class="header-items">
			<div class="header-items">
				<div class="header-item">
					<a href="logout.jsp">로그아웃</a>
				</div>
				&nbsp;&nbsp;|
				<div class="header-item">
					<a href="privacy.jsp">개인정보수정</a>
				</div>
			</div>
		</div>
	</div>

	<div class="bookcover">
		<div class="bookdot">
			<div class="page">
				<div class="left-container">
					<div class="total_visitor">
						<script>
							date = new Date();
							year = date.getFullYear();
							month = date.getMonth() + 1;
							day = date.getDate();
							document.getElementById("current_date").innerHTML = month
									+ "/" + day + "/" + year;
						</script>
						<div>
							<script>
								date = new Date().toLocaleDateString();
								document.write(date);
							</script>
						</div>
					</div>
					<div class="profile_box">
						<div class="profile_img">
							<img
								src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRc7GjusCTHNS79O2UTOU33rba3NfPWo__0Ew&usqp=CAU"
								class="img" width="180" height="180">
						</div>
						<br>
						<div class="intro">
							<h4>닉네임:추춘봉</h4>
							<hr>
							안녕, 나는 대컴정과의 컴퓨터야.<br> 내 꿈은 좋은 프로그래머가 되는것이양. 하지만, 난 프로그래머가
							될수없어 왜냐면 난 기계이기때문이야.<br> 그래서 나는 매우슬퍼...
						</div>
						<div class="name">by me (O)</div>
						<div class="dropdown">
							<button class="btn btn-secondary btn-sm dropdown-toggle"
								type="button" id="pado" data-bs-toggle="dropdown"
								aria-expanded="false">프로필 수정하기</button>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item"
									href="https://cafe.naver.com/codeuniv" target="_blanked">프로필
										수정하기</a></li>
								<li><a class="dropdown-item"
									href="https://www.instagram.com/" target="_blanked">개인정보
										수정하기</a></li>
							</ul>
						</div>
					</div>
				</div>
				<div class="mid-container">
					<div class="home_top">
						<div class="home_title">나의 감정일기..★( ･ิᴥ･ิ)..(ง •̀_•́)ง</div>
					</div>
					<div class="layout_box">
						<form action="diaryAction.jsp" method="post">
							<div class="diary_box">
								<div class="diary_font">일기장 작성</div>
								<table class="t1" border=1>
									<tr>
										<td class="date"><p>날짜</p></td>
										<td class="dateInput"><input type="date" id="date"
											name="day" max="2030-12-31" min="2022-01-01" value="today"></td>
									</tr>
									<tr>
										<td class="emotion"><p>오늘의 감정</p></td>
										<td class="emotionInput"><input type="checkbox"
											name="emotion" id="joyful" value="즐거운">즐거운&nbsp;<input
											type="checkbox" name="emotion" id="sad" value="슬픈">슬픈&nbsp;<input
											type="checkbox" name="emotion" id="unsatisfied"
											value="불만이 있는">불만이 있는</td>
									</tr>
									<tr>
										<td class="title"><p>제목</p></td>
										<td><input type="text" name="title" value="<%=diaryDTO.getW_title()%>"></td>
									</tr>
									<tr>
										<td class="picture"><p>이미지 첨부</p></td>
										<td><input type="file" name="img" value="<%=diaryDTO.getW_img()%>"></td>
									</tr>
								</table>
								<table class="t2">
									<tr>
										<td class="content">★오늘의 내가 남기고 싶은 생각 또는 경험은?</td>
									</tr>
									<tr>
										<td><textarea cols="100%" rows="5" name="content"
												placeholder="오늘의 이야기"><%=diaryDTO.getW_content() %></textarea></td>
									</tr>
								</table>
								<!-- 저장 버튼 구현 -->
								<br> <input class="save" type="submit" value="저장">
							</div>
						</form>
					</div>
				</div>
				<div class="right-container">
					<div class="menu">
						<a href="home.html"><div class="home">&nbsp홈</div></a> <a
							href="profile.html">
							<div class="profile">&nbsp프로필</div>
						</a> <a href="./diary.html"><div class="diary">&nbsp일기작성</div></a> <a
							href="./plant_record.html"><div class="plant_record">&nbsp식물기록</div></a>
						<a href="calender.html"><div class="calender">&nbsp캘린더</div></a>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>