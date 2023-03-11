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
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	// 개인정보수정 페이지로 가기 전에
	// 이메일 기준으로 회원정보를 조회해서 다음 화면으로 전달
	UserDAO dao = new UserDAO();
	String email = request.getParameter("email");
	DiaryDTO diaryDTO = new DiaryDTO();
	String day = request.getParameter("day");
	String title = request.getParameter("title");
	String img = request.getParameter("img");
	String content = request.getParameter("content");
	// DB연결에 필요한 변수 선언
	String dbURL = "jdbc:mysql://localhost:3306/USER?serverTimezone=Asia/Seoul";
   //    String dbURL = "jdbc:mysql://34.64.212.229:3306/USER?serverTimezone=Asia/Seoul";
   String dbID="root";
   //String dbID="inhatc";
	String dbPassword = "inha1958";

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	String sql = "select * from user where email = ?";

	try {
		// 드라이버 호출
		Class.forName("com.mysql.jdbc.Driver");

		// conn 생성
		conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

		// pstmt 생성
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, email);

		// sql 실행
		rs = pstmt.executeQuery();

		if (rs.next()) {
			email = rs.getString("email");
			String pw = rs.getString("pw");
			String name = rs.getString("name");
			String phone = rs.getString("phone");
			String birth = rs.getString("birth");

			// 포워드로 전달하기 위해
			request.setAttribute("email", email);
			request.setAttribute("pw", pw);
			request.setAttribute("name", name);
			request.setAttribute("phone", phone);
			request.setAttribute("birth", birth);

			// 포워드 이동
			request.getRequestDispatcher("diary.jsp").forward(request, response);
		} else {
			// 세션이 만료된 경우
			response.sendRedirect("Home2.jsp");
		}
	} catch (Exception e) {
		e.printStackTrace();
		response.sendRedirect("Home2.jsp");
	} finally {
		try {
			if (conn != null)
		conn.close();
			if (pstmt != null)
		pstmt.close();
			if (rs != null)
		rs.close();
		} catch (Exception e) {
			e.printStackTrace();
			;
		}
	}

	UserDTO dto = new UserDTO();
	if (session.getAttribute("email") != null) {
		dto.setEmail((String) session.getAttribute("email"));
		email = (String) session.getAttribute("email");
	}
	// 현재 세션 상태를 체크한다.

	//감정 부분은 별도로 읽어드려 다시 빈 클래스에 저장(여러개이기 때문에 배열로 받아서 저장해 줘야 한다.) 
	String[] emotions = request.getParameterValues("emotion");
	//배열에 있는 내용을 하나의 스트링으로 저장
	String emotion = new String();

	for (int i = 0; i < emotions.length; i++) {
		emotion += emotions[i] + " ";
	}
	
	diaryDTO.setW_emotion(emotion);
	
	// 로그인을 한 사람만 글을 볼 수 있도록 코드를 수정한다.
	DiaryDAO diaryDAO = new DiaryDAO();
	int result = diaryDAO.write(dto.getEmail(), diaryDTO.getW_id(), day, title, emotion, img, content);
	// 데이터베이스 오류인 경우
	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('일기작성에 실패했습니다.')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('일기작성 성공')");
		script.println("location.href = 'contents.html'");
		script.println("</script>");
	}
	%>
</body>
</html>