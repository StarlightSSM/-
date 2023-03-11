<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.DiaryDAO"%>
<%@ page import="user.DiaryDTO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.io.File"%>
<%@ page import="java.util.ArrayList"%>
<%
	// 프로필 영역 데이터가져오기 부분
   // 이전화면에서 전달받은 데이터를 받습니다.
   // 화면에 미리 보여지도록 처리를 하세요~
request.setCharacterEncoding("utf-8");

UserDAO dao = new UserDAO();

String email = null;
if (session.getAttribute("email") != null) {
	email = (String) session.getAttribute("email");
	String name = (String) session.getAttribute("name");
	String w_intro = (String) session.getAttribute("w_intro");
} else if (session.getAttribute("email") == null) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인을 하세요.')");
	script.println("location.href='login.html'");
	script.println("</script>");
}
dao = new UserDAO();
dao.getUser(email);
UserDTO userdto = new UserDAO().getUser(email);
if (!email.equals(userdto.getEmail())) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('권한이 없습니다..')");
	script.println("location.href='contents.jsp'");
	script.println("</script>");
}
%>
<%
// 이전화면에서 전달받은 데이터를 받습니다.
// 화면에 미리 보여지도록 처리를 하세요~
DiaryDAO diaryDAO = new DiaryDAO();
DiaryDTO dto = new DiaryDTO();
request.setCharacterEncoding("UTF-8");

email = (String) session.getAttribute("email");
String w_id = (String) session.getAttribute("w_id");
String w_day = (String) session.getAttribute("w_day");
String w_title = (String) session.getAttribute("w_title");
String w_content = (String) session.getAttribute("w_content");
String w_img = (String) session.getAttribute("w_img");
String w_emotion = (String) session.getAttribute("w_emotion");

%>
<%
// 메인페이지로 이동했을 때 세션에 값이 담겨잇는지 체크
if (session.getAttribute("email") != null) {
	email = (String) session.getAttribute("email");
}
int pageNumber = 1; // 기본은 1페이지를 할당
// 만약 파라미터로 넘어온 오브젝트 타입 'pageNumber'가 존재한다면
// int 타입으로 캐스팅을 해주고 그 값을 'pageNumber' 변수에 저장한다.
if (request.getParameter("pageNumber") != null) {
	pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
}

// 해당 w_id에 대한 일기를 가져온 다음 세션을 통하여 작성자 본인이 맞는지 확인한다.
if (request.getParameter("w_id") != null) {
	w_id = request.getParameter("w_id");
}

dao = new UserDAO();
dao.getUser(email);

if (w_id == null) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('유효하지 않은 글입니다.')");
	script.println("location.href='contents.jsp'");
	script.println("</script>");
}

DiaryDTO diary = new DiaryDAO().getDiary(w_id);
if (!email.equals(diary.getEmail())) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('권한이 없습니다')");
	script.println("location.href='contents.jsp'");
	script.println("</script>");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일기장 내용 페이지</title>
</head>
<link rel="stylesheet" href="./static/font.css">
<link rel="stylesheet" href="./static/layout.css">
<link rel="stylesheet" href="./static/home.css">


<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>
<style>

/*ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ*/
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
	width: 140px;
	background-color: white;
	color: black;
	font-weight: bold;
	font-family: 'KyoboHand';
	font-size: 17px;
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
	flex-direction: row;
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

.update_font { /*Updated news 폰트*/
	flex: 0.1;
	border-bottom: 2px solid #4aaac7;
	font-family: 'KOTRA_BOLD-Bold';
	font-size: 20px;
	color: #4aaac7;
}

.update_left {
	width: 50%;
	float: left;
	box-sizing: border-box
}

.update_right {
	width: 50%;
	float: right;
	box-sizing: border-box;
}

.miniroom_box { /*미니룸 박스*/
	flex: 0.8;
	margin: 10px;
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

/*-----------------------------------------------------------------*/
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
	margin: 20px 20px 20px 0px;
}
/*------------------------------------------------------------------------------------ 이 아래는 그 안에 부분0*/
.calendar {
	border: 1px solid rgb(221, 221, 221);
	display: flex;
	flex-direction: row;
	flex: 1;
	margin: 20px 20px 0px 20px;
	font-family: 'NeoDunggeunmo';
}

.mainday {
	flex: 0.1;
	color: #3a81a3;
	margin: 8px 5px 8px 10px;
	text-align: center;
}

.subday {
	flex: 0.9;
	color: rgb(78, 78, 78);
	margin: 8px 5px 8px 10px;
}

.saturday {
	color: blue;
}

.sunday {
	color: red;
}

.diarybox1 {
	border: 1px solid rgb(221, 221, 221);
	margin: 0px 0px 0px 20px;
	font-family: 'NeoDunggeunmo';
}

.diarybox {
	border: 1px solid rgb(221, 221, 221);
	margin: 30px 0px 0px 20px;
	font-family: 'NeoDunggeunmo';
}

.day {
	flex: 0.1;
	color: #3a81a3;
	margin: 30px 0px 10px 15px;
}

.diarycontents {
	color: black;
	flex: 0.9;
	text-align: center;
	margin: 30px 50px 30px 50px;
	line-height: 150%;
	font-size: 85%;
}

.secret {
	margin: 30px 0px 30px 150px;
}

button {
	background-color: white;
	color: white;
	border: 0;
	font-family: 'NeoDunggeunmo';
}

.icon {
	font-size: 20px;
	color: white;
	margin: 5px 15px 5px 0px;
}

button:hover {
	color: black;
	background-color: rgb(132, 184, 226);
	border: 1px solid black;
}

.fourth {
	width: 100%;
	height: 500px;
}

.maindiarybox {
	overflow: auto;
	width: 96.3%;
	height: 450px;
	margin-top: 15px;
}

.subdiarybox {
	flex: 0.9;
}

.diarybox {
	border: 1px solid #BFBFBF;
	background-color: #F2E7DC;
	height: 420px;
}

div.calendar {
	border: 1px solid #BFBFBF;
	background-color: white;
}

.container4 {
	border-radius: 1px;
	background-color: white;
}
.select  {
	text-decoration: none; /* 링크의 밑줄 제거 */
           color: inherit; /* 링크의 색상 제거 */
           color: black;
           background-color: white;
           margin-left: 15px;
           margin-top: 10px;
}

.diarycontents {
	font-size: 18px;
	text-align: left;
}

</style>

<style>
@import
	url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap')
	;
</style>
<body>
	<div class="header">
		감정일기
		<div class="header-items">
			<div class="header-item">
				<a href="logout.jsp">로그아웃</a>
			</div>
			&nbsp;&nbsp;&nbsp;|
			<div class="header-item">
				<a href="privacy.jsp">개인정보수정</a>
			</div>
		</div>
	</div>
</head>
<body>
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
                               <h4>닉네임:<%=userdto.getName()%></h4>
                               <hr>
                                   <%=userdto.getW_intro()%>
                               </div>
						<div class="name">by me (O)</div>


						<div class="dropdown">
							<button class="btn btn-secondary btn-sm dropdown-toggle"
								type="button" id="pado" data-bs-toggle="dropdown"
								aria-expanded="false">프로필 수정하기</button>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="profile.jsp"
									target="_blanked">프로필 수정하기</a></li>
								<li><a class="dropdown-item" href="privacy.jsp"
									target="_blanked">개인정보 수정하기</a></li>
							</ul>
						</div>
					</div>
				</div>


				<div class="mid-container">
					<div class="home_top">
						<div class="home_title">나의 감정일기..★( ･ิᴥ･ิ)..(ง •̀_•́)ง</div>

					</div>


					<div class="container4">
						<div class="second box">
							<div class="fourth">
								<div class="maindiarybox">
									<div class="subdiarybox">
										<div class="diarybox">
											<div class="day">
												작성일자 :
												<%=diary.getW_day().substring(0, 11) + diary.getW_day().substring(11, 13) + "시"
													+ diary.getW_day().substring(14, 16) + "분"%></div>
											<div class="diarycontents">
												제목 :
												<%=diary.getW_title()%><br>
												<hr>
												작성자 :
												<%=diary.getEmail()%><br>
												<hr>
												내용 :
												<%=diary.getW_content() %>
											</div>
										</div>
										<!-- <div class="diarybox">
											<div class="day">2012.07.05 화 20:50</div>
											<div class="diarycontents">
												울ㅈㅣ않ㄱㅣ<br>아프ㅈㅣ않ㄱㅣ<br>씩씩ㅎrㄱㅣ<br>억ㅈㅣ로ㄹr도웃ㄱㅣ<br>ㅌㅣㄴㅐㅈㅣ말ㄱㅣ<br>.<br>.<br>오늘도
												괜찮은 듯<br>그렇ㄱㅔ ㅈㅣㄴㅐㄱㅣ
											</div>
										</div>
										<div class="diarybox">
											<div class="day">2013.12.20 수 21:30</div>
											<div class="diarycontents">
												난...ㄱㅏ끔<br>눈물을 흘린ㄷㅏ...<br>ㄱㅏ끔은 눈물을 참을 수 없는 ㄴㅐ가
												별루ㄷㅏ...<br>많이 ㅇㅏㅍㅏㅅㅓ...<br>소ㄹㅣ치며...울 수 있ㄷr는 것...<br>좋은ㄱㅓㅇㅑ...<br>ㅁ
												ㅓ...꼭 슬ㅍㅓㅇㅑ만 우는 건 ㅇr니잖ㅇr...^^<br>난...눈물ㅇㅣ....좋다....<br>ㅇr니...<br>ㅁㅓ리가
												ㅇㅏ닌<br>맘으로....우는 ㄴㅐㄱㅏ 좋ㄷ ㅏ...
											</div>
										</div>  -->
									</div>

								</div>
								<!--  페이징 처리 영역 -->
								<%
								if (pageNumber != 1) {
								%>
								<a href="contents.jsp?pageNumber=<%=pageNumber - 1%>"
									class="btn btn-success btn-arrow-left">이전</a>
								<%
								}
								if (diaryDAO.nextPage(pageNumber + 1)) {
								%>
								<a href="contents.jsp?pageNumber=<%=pageNumber + 1%>"
									class="btn btn-success btn-arrow-right">다음</a>
								<%
								}
								%>
							</div>

						</div>

					</div>



				</div>
				<div class="right-container">
					<div class="menu">
						<a href="Home2.jsp"><div class="home">&nbsp홈</div></a> <a
							href="profile.jsp">
							<div class="profile">&nbsp프로필</div>
						</a> <a href="diary.jsp"><div class="diary">&nbsp일기작성</div></a> <a
							href="./plant_record.html"><div class="plant_record">&nbsp식물기록</div></a>
						<a href="contents.jsp"><div class="calender">&nbsp일기목록</div></a>

					</div>
				</div>
			</div>
		</div>
</body>
</html>