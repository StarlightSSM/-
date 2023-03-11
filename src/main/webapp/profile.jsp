<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="user.UserDAO"%>
<%@ page import="user.UserDTO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.Enumeration" %>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%
   // 이전화면에서 전달받은 데이터를 받습니다.
   // 화면에 미리 보여지도록 처리를 하세요~
   request.setCharacterEncoding("UTF-8");
   
   String email = (String) session.getAttribute("email");
   String name = (String) session.getAttribute("name");
   String phone = (String) session.getAttribute("phone");
   String w_intro = (String) session.getAttribute("w_intro");

UserDAO dao = new UserDAO();

UserDTO dto = new UserDAO().getUser(email);
if (!email.equals(dto.getEmail())) {
   PrintWriter script = response.getWriter();
   script.println("<script>");
   script.println("alert('권한이 없습니다..')");
   script.println("location.href='login.html'");
   script.println("</script>");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필 페이지</title>
<body>
	<link rel="stylesheet" href="./static/font.css">
	<link rel="stylesheet" href="./static/font.css">
	<link rel="stylesheet" href="./static/layout.css">
	<link rel="stylesheet" href="./static/home.css">
	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
		rel="stylesheet"
		integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
		crossorigin="anonymous">
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>

	<style>
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

.diary_box {
	width: 200px;
	margin: 20px;
	float: left;
}

.diary_font { /*식물 텍스트*/
	border-bottom: 2px solid #4aaac7;
	font-family: 'KOTRA_BOLD-Bold';
	font-size: 20px;
	color: #4aaac7;
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
	margin-bottom: -13px;
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

.wrap {
	margin-top: 35px;
	margin-bottom: -15px;
}

.content {
	/*배경색 설정*/
	background-color: white;
	/*모서리 약간 둥글게 설정*/
	border-radius: 10px;
	/*윤곽선*/
	border: 1px solid white;
	width: 800px;
	height: 300px;
	/** 좌우 마진을 auto(중앙에 배치), 상하 마진을 35px로 지정 */
	margin: 15px auto;
	margin-top: -30px;
	text-align: center;
	/** .bookdot 요소에서 absolute 속성값을 이용하기 위해 position: relative 로 설정 */
	position: relative;
}

.line {
	position: absolute;
	top: 0px;
	width: 200px;
	height: 1px;
	border-bottom: 2px solid #4aaac7;
}

.img {
	position: absoulte;
	top: 10px;
	left: 20px;
}

img {
	width: 200px;
	height: 200px;
}

.img_upload {
	position: absolute;
	width: 100px;
	top: 220px;
	left: 70px;
	margin-left: -15px;
}

.form {
	left: 330px;
	top: 120px;
	position: absolute;
}

input {
	font-family: 'Gowun Dodum', sans-serif;
	margin-top: 20px;
	height: 27px;
}

.btn {
	font-family: 'Gowun Dodum', sans-serif;
}

.input {
	width: 230px;
}

input.input[name="name"] {
	margin-left: 5px;
}
.input[name="name"] {
	margin-left: 5px;
}
.input:nth-of-type(2) {
	margin-left: 65px;
}

.textarea {
	margin-right: 100px;
}

.introduce_label {
	position: absolute;
	left: -100px;
}

.label_name {
	margin-right: -3px;
	margin-left: 8px;
	text-align: right;
}
.label_tel {
	margin-left: -8px;
	margin-bottom: 10px;
}
.label_email {
	margin-left: 3px;
}
textarea {
	position: absolute;
	top: 170px;
	left: -100px;
	width: 500px;
	height: 100px;
	margin-top: 10px;
}

.submit {
	background-color: #EBCCCC;
	border: none;
	border-radius: -1px;
	position: absolute;
	top: 300px;
	left: 350px;
	width: 130px;
	height: 35px;
	margin-left: -74px;
}

input[name="u_img"] {
	font-size: 13px;
}
/*폰트 설정 링크*/
@import
	url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap')
	;
</style>
</head>
<body>
	<div class="header">
		감정일기
		<div class="header-items">
				
				<form action="logout.jsp" method="post">
             <div class="header-item"><a href="logoutAction.jsp">로그아웃</a></div>&nbsp;&nbsp;
             </form>
				<div class="header-item">
					<a href="privacy.jsp">|  개인정보수정</a>
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
                                   <img src="img/<%=dto.getU_img()%>"
                                 alt="프로필 사진" class="img" width="180" height="180">
                               </div>
                               <br> 
                               <div class="intro">
                               <h4>닉네임:<%=dto.getName()%></h4>
                               <hr>
                                   <%=dto.getW_intro()%>
                               </div>
                              <div class="name">
                                   by me    (O)
                               </div>


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
					<div class="layout_box">
						<div class="wrap">
							<div class="content">

								<div class="diary_box">
									<div class="diary_font">Profile</div>
									<form action="fileAction.jsp" enctype="multipart/form-data" method="post">
                           <div class="img">
                              <img
                                  src="img/<%=dto.getU_img()%>"
                                 alt="프로필 사진">
                              <input type="file" name="u_img">
                              <input class="submitimg" type="submit" value="이미지 등록">
                           </div>
                           </form>
                           <form action="profileAction.jsp" method="post">
                           <div class="form">
                              
                                 <label class="label_email">&nbsp;이메일 : </label> <input
                                    class="input" type="email" name="email" value=<%=dto.getEmail()%> disabled/> <br> <label
                                    class="label_name">&nbsp;&nbsp;&nbsp;이름 : </label> <input class="input"
                                    type="text" name="name" value=<%=dto.getName() %>> <br> <label
                                    class="label_tel">&nbsp;전화번호 : </label> <input class="input"
                                    type="tel" name="phone" value=<%=dto.getPhone()%>> <br>
                                 <p class="introduce_label">소개 :</p>
                                 <textarea name="w_intro"><%=dto.getW_intro()%></textarea>
                              	<input class="submit" type="submit" value="정보 저장">
                              </form>
                               
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="right-container">
                           <div class="menu">
                               <a href="./Home2.jsp"><div class="home">&nbsp홈</div></a>
                              <a href="./profile.jsp"> <div class="profile">&nbsp프로필</div></a>
                               <a href="./diary.jsp"><div class="diary">&nbsp일기작성</div></a>
                               <a href="./Plant_record.jsp"><div class="plant_record">&nbsp식물기록</div></a>
                               <a href="./contents.jsp"><div class="calender">&nbsp일기목록</div></a>

					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>