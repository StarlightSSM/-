<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.Sign_upDTO" %>
<%@ page import="user.Sign_upDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
<link rel="stylesheet" href="./css/Sign_up.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
<style>
/* 폰트 설정 */
@import url('https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Jua&display=swap');

body {
	font-family: 'Gowun Dodum', sans-serif;
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
	height: 940px;
	/* 좌우 마진을 auto(중앙에 배치), 상하 마진을 35px로 지정 */
	margin: 39px auto;
	text-align: center;
	/* .bookdot 요소에서 absolute 속성값을 이용하기 위해 position: relative 로 설정 */
	position: relative;
}

h2 {
	padding-top: 50px;
	color: #7B7B7B;
}

p {
	margin-bottom: 10px;
}

.sign_upForm {
	margin-top: 30px;
	text-align: left;
	padding-left: 400px;
}

.sign_upForm  input {
	width: 450px;
}

.label {
	font-size: 13px;
	color: #79717A;
}

.submit {
	margin-top: 30px;
}

.line {
	margin-top: 19px;
	margin-bottom: 20px;
	width: 450px;
	margin-left: 400px;
	border-bottom: 1px solid #7B7B7B;
}

.btn {
	margin-left: -50px;
	margin-bottom: 3px;
	width: 400px;
}

.namePhone {
	display: flex;
}

.namePhone input {
	width: 210px;
}

.name {
	margin-right: 30px;
}
</style>
</head>
<body>
	<div class="bookcover">
		<h2>회원가입을 환영합니다!</h2>
		<div class="sign_upForm">
			<form action="UserJoinAction.jsp" method="post">
				<p>이메일</p>
				<input type="text" name="email">
				<p>비밀번호</p>
				<input type="password" name="pw">
				<p class="label">8자 이상이면서 최소한 숫자 하나와 글자 하나를 포함해야 합니다</p>
				<p>비밀번호 재확인</p>
				<input type="password" name="pw">
				<p class="label">비밀번호를 다시 입력해주세요</p>
				<div class="namePhone">
					<div class="name">
						<p>이름</p>
						<input type="text" name="name">
					</div>
					<div class="phone">
						<p>전화번호</p>
						<input type="text" name="phone">
					</div>
				</div>
				<input class="submit"
					style="background-color: #EBCCCC; border: 0.3px solid"
					class="btn btn-light" type="submit" value="가입하기">
			</form>
		</div>
		<div class="line"></div>
		<div class="API">
			<button class="btn btn-light"
				style="background-color: white; display: none; border: 0.3px solid #BFBFBF"
				width="400" type="submit">구글 계정으로 로그인하기</button>
			<br>
			<button class="btn btn-light"
				style="background-color: white; display: none; border: 0.3px solid #BFBFBF"
				width="400" type="submit">네이버 계정으로 로그인하기</button>
		</div>
	</div>
</body>
</html>