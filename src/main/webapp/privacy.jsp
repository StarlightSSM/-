<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="user.UserDTO"%>
<%@ page import="java.io.PrintWriter"%>
<%
request.setCharacterEncoding("utf-8");

UserDAO dao = new UserDAO();

String email = null;
if (session.getAttribute("email") != null) {
	email = (String) session.getAttribute("email");
	String pw = (String) session.getAttribute("pw");
	String name = (String) session.getAttribute("name");
	String birth = (String) session.getAttribute("birth");
} else if (session.getAttribute("email") == null) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인을 하세요.')");
	script.println("location.href='login.html'");
	script.println("</script>");
}

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
<title>개인정보수정 페이지</title>
<link rel="stylesheet" href="css/Information.css">
<style>
/* 폰트 설정 */
@import
	url('https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Jua&display=swap')
	;

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
	width: 1274px;
	height: 900px;
	/* 좌우 마진을 auto(중앙에 배치), 상하 마진을 35px로 지정 */
	margin: 39px auto;
	margin-top: 20px;
	text-align: center;
	/* .bookdot 요소에서 absolute 속성값을 이용하기 위해 position: relative 로 설정 */
	position: relative;
}

h1 {
	padding-top: 50px;
	color: #7B7B7B;
}

p {
	margin-right: 10px;
	margin-bottom: 10px;
}

input {
	height: 30px;
}

.informationForm {
	margin-top: 30px;
	text-align: left;
	padding-left: 430px;
}

.informationForm input {
	width: 400px;
	margin-bottom: 5px;
}

.informationForm save {
	width: 80px;
}

.email>p {
	margin-bottom: 5px;
}

.email input {
	margin-bottom: 15px;
}

.save {
	/*폰트 설정*/
	font-family: 'Gowun Dodum', sans-serif;
	width: 150px;
	height: 30px;
	background-color: #EBCCCC;
	border: none;
	border-radius: -1px;
	background-color: white;
}

input.save {
	width: 150px;
	margin-left: 135px;
	margin-top: 10px;
}

.delete {
	/*폰트 설정*/
	font-family: 'Gowun Dodum', sans-serif;
	width: 150px;
	height: 30px;
	background-color: #EBCCCC;
	border: none;
	border-radius: -1px;
	background-color: white;
}

input.delete {
	width: 150px;
	margin-left: 7px;
	margin-top: 10px;
}
</style>
</head>
<body>
	<div class="bookcover">
		<h1>개인정보 수정 페이지</h1>
		<form class="informationForm" action="privacyAction.jsp" method="post">
			<div class="email">
				<p>이메일</p>
				<%=dto.getEmail()%>
			</div>
			<p>현재 비밀번호</p>
			<%=dto.getPassword()%>
			<p>새 비밀번호</p>
			<input type="password" name="pw" placeholder="새 비밀번호를 입력해 주세요">
			<p>새 비밀번호 확인</p>
			<input type="password" name="pw2" placeholder="새 비밀번호를 다시 입력해 주세요">
			<p>생년월일</p>
			<input type="text" name="birth" pattern="[0-9]{8}"
				title="yyyy-mm-dd에 맞게 생년월일을 입력해주세요" value="<%=dto.getBirth()%>"
				placeholder="YYYY / MM / DD">
			<p>이름</p>
			<input type="text" name="name" value=<%=dto.getName()%>> <br>
			<input class="save" type="submit" value="저장">
		</form>
		<form action="deleteAction.jsp">
			<input class="delete" onclick="deleteAction.jsp"
				type="submit" value="탈퇴하기">
		</form>
	</div>
</body>
</html>