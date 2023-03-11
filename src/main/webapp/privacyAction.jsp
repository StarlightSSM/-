<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="user.UserDTO"%>
<%@ page import="java.io.PrintWriter"%>
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
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
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
	if (request.getParameter("pw") != null) {
		dto.setPassword(request.getParameter("pw"));
	}
	if (request.getParameter("name") != null) {
		dto.setName(request.getParameter("name"));
	}
	if (request.getParameter("birth") != null) {
		dto.setBirth(request.getParameter("birth"));
	}

	int result = dao.update(pw, name, birth, email);
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