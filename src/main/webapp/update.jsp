<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.io.PrintWriter"%>
    <%@ page import = "user.*" %>
    <%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	
	request.setCharacterEncoding("UTF-8");
	String userID = (String)session.getAttribute("userID"); //로그인 상태를 불러옮 비어있으면 null로 저장될거임
	DiaryDAO Diary = new DiaryDAO();//DB 연동
	String diaryID = null; //초기값 설정
	diaryID = request.getParameter("diaryID");//상세 페이지 코드 받기 (URL);
	/*
		if(userID == null){ //로그인 상태가 비어있으면
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		
		
		if(request.getParameter("diaryID") != null) {
			diaryID = request.getParameter("diaryID");//상세 페이지 코드 받기 (URL);
		}
		if(Diary.select(diaryID)) { //if 는 true일때 실행해서 자바코드 보면 rs.next로 받았기때문에 값이 존재하면 true로 리턴함
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'diary.jsp'");
			script.println("</script>");
		}
		 if(!userID.equals(Diary.getUserID())) {// 권한 코드가 없어서 굳이 ?
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'diary.jsp");
			script.println("</script>");
			
		} */
		
	%>
	
	<div class="header">
		감정일기
		<div class="header-items">
			<div class="header-item">
				<a href="login.html">로그인</a>
			</div>
			&nbsp;&nbsp;&nbsp;|
			<div class="header-item">
				<a href="Sign_up.html">회원가입</a>
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
						<div class="diary_box">
							<div class="diary_font">일기장 작성</div>
							<form method = "post" action = "updateAction.jsp?diaryID=<%=diaryID %>">
						<% ResultSet rs = Diary.RSselect(diaryID);
							if (rs.next()) {%>
							<table class="t1" border=1 >
								<tr>
									<td class="date"><p>날짜</p></td>
									<td class="dateInput"><input type="date"
     							    id="date"
        						 max="2030-12-31"
        						 min="2022-01-01"
        						 value="today"></td>
								</tr>
						<tr>
									<td class="emotion"><p>오늘의 감정</p></td>
									<td class="emotionInput"><input type="checkbox"
										name="sentiment" id="joyful">즐거운&nbsp;<input
										type="checkbox" name="sentiment" id="sad">슬픈&nbsp;<input
										type="checkbox" name="sentiment" id="unsatisfied">불만이
										있는</td>
								</tr>
								<tr>
									<td class="title"><p>제목</p></td>
									<td><input type="text" name="InsertTitle" value = "<%=rs.getString("w_title")%>"></td>
								</tr>
								<tr>
									<td class="picture"><p>이미지 첨부</p></td>
									<td><input type="file"></td>
								</tr>
							</table>
							<table class="t2">
								<tr>
									<td class="content">★오늘의 내가 남기고 싶은 생각 또는 경험은?</td>
								</tr>
								<tr>
									<td><textarea cols="100%" rows="5" placeholder="오늘의 이야기" name ="intro" ><%=rs.getString("w_intro") %></textarea></td>
								</tr>
							</table>
							<% } %>
							<br> <input type="submit" value="저장"> <input
								type="reset" value="초기화"> <input type="button"
								value="수정">
								</form>
						</div>
					</div>
				</div>
				<div class="right-container">
					<div class="menu">
						<a href="home.html"><div class="home">&nbsp홈</div></a> <a href="profile.html">
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