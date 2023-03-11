<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// 개인정보수정 페이지로 가기 전에
// 아이디 기준으로 회원정보를 조회해서 다음 화면으로 전달

UserDAO dao = new UserDAO();

String email = (String) session.getAttribute("email");
// DB연결에 필요한 변수 선언
String dbURL = "jdbc:mysql://localhost:3306/USER?serverTimezone=Asia/Seoul";
      // String dbURL = "jdbc:mysql://34.64.212.229:3306/USER?serverTimezone=Asia/Seoul";
   String dbID="root";
   //String dbID="inhatc";
String dbPassword = "inha1958";

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

String sql = "delete from user where email = ?";

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

		// 포워드로 전달하기 위해
		request.setAttribute("email", email);

		// 포워드 이동
		request.getRequestDispatcher("Home.html").forward(request, response);
	} else {
		// 세션이 만료된 경우
		response.sendRedirect("login.html");
	}
} catch (Exception e) {
	e.printStackTrace();
	response.sendRedirect("Home.html");
}

//회원탈퇴
int result = dao.delete(email);
if (result == -1) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('회원탈퇴에 실패했습니다.')");
	script.println("history.back()");
	script.println("</script>");
} else {
	System.out.println("회원탈퇴 성공!!");
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("location.href = 'Home.html'");
	script.println("</script>");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>