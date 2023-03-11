<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="user.UserDAO"%>
<%@ page import="user.UserDTO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
	<%
	UserDAO dao = new UserDAO();
	UserDTO dto = new UserDTO();

	String email = request.getParameter("email");
	String name = request.getParameter("name");
	String phone = request.getParameter("phone");
	String w_intro = request.getParameter("w_intro");
	String u_img = request.getParameter("u_img");

	// DB연결에 필요한 변수 선언
	 String dbURL = "jdbc:mysql://localhost:3306/USER?serverTimezone=Asia/Seoul";
     // String dbURL = "jdbc:mysql://34.64.212.229:3306/USER?serverTimezone=Asia/Seoul";
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
			name = rs.getString("name");
			phone = rs.getString("phone");
			u_img = rs.getString("u_img");
			w_intro = rs.getString("w_intro");

			// 포워드로 전달하기 위해
			request.setAttribute("email", email);
			request.setAttribute("pw", pw);
			request.setAttribute("name", name);
			request.setAttribute("phone", phone);
			request.setAttribute("u_img", u_img);
			request.setAttribute("w_intro", w_intro);

			// 포워드 이동
			request.getRequestDispatcher("Home2.jsp").forward(request, response);
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

	dto.setU_img(u_img);
	dto.setW_intro(w_intro);
	if (session.getAttribute("email") != null) {
		dto.setEmail((String) session.getAttribute("email"));
		email = (String) session.getAttribute("email");
	}
	if (email == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href='login.html'");
		script.println("</script>");
	}
	if (request.getParameter("name") != null) {
		dto.setName(request.getParameter("name"));
	}
	if (request.getParameter("phone") != null) {
		dto.setBirth(request.getParameter("phone"));
	}
	if (request.getParameter("w_intro") != null) {
		dto.setW_intro(request.getParameter("w_intro"));
	}

	int result = dao.updateProfile(name, phone, w_intro, dto.getEmail());
	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('수정에 실패했습니다.')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		System.out.println("update 성공!!");
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'Home2.jsp'");
		script.println("</script>");
	}
	%>
</body>
</html>