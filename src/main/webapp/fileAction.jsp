<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="user.UserDAO"%>
<%@ page import="user.UserDTO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %> <!-- request 대신 -->
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %> <!-- 파일이름 중복을 피할 수 있도록 -->
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
 // 해당 폴더에 이미지를 저장시킨다

	 	 String uploadDir =this.getClass().getResource("").getPath();
	// /C:/Java/JSP_week1/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/work/Catalina/localhost/Emotion_Diary/org/apache/jsp/
    System.out.println(uploadDir);
    uploadDir = uploadDir.substring(1,uploadDir.indexOf(".metadata"))+"Emotion_Diary/src/main/webapp/img";
    System.out.println(uploadDir);
	 out.println("절대경로 : " + uploadDir + "<br/>"); 

	// 총 100M 까지 저장 가능하게 함

			int maxSize = 1024 * 1024 * 100;

			String encoding = "UTF-8";

			
	 // 웹 프로젝트 위치에 넣어도 된다 (이클립스에서 사진 추가되는 것을 실시간으로 확인 가능)
 	// MultipartRequest mr = new MultipartRequest(request, "C:/Users/fjdks/Desktop/erp/WebContent/image", 1024*1024*1024, "utf-8", new DefaultFileRenamePolicy());
    MultipartRequest multipartRequest

	= new MultipartRequest(request, uploadDir, maxSize, encoding,

			new DefaultFileRenamePolicy());

	

            // 중복된 파일이름이 있기에 fileRealName이 실제로 서버에 저장된 경로이자 파일

            // fineName은 사용자가 올린 파일의 이름이다
 // 중복된 파일이름이 있기에 fileRealName이 실제로 서버에 저장된 경로이자 파일

                // fineName은 사용자가 올린 파일의 이름이다

		// 이전 클래스 name = "file" 실제 사용자가 저장한 실제 네임

		String u_img = multipartRequest.getOriginalFileName("u_img");

		// 실제 서버에 업로드 된 파일시스템 네임

		String u_imgReal = multipartRequest.getFilesystemName("u_img");
	UserDAO dao = new UserDAO();
	UserDTO dto = new UserDTO();

	String email = request.getParameter("email");
	String name = request.getParameter("name");
	String phone = request.getParameter("phone");
	String w_intro = request.getParameter("w_intro");

	// DB연결에 필요한 변수 선언
	String dbURL = "jdbc:mysql://localhost:3306/USER?serverTimezone=Asia/Seoul";
   //    String dbURL = "jdbc:mysql://34.64.212.229:3306/USER?serverTimezone=Asia/Seoul";
   String dbID="root";
   // String dbID="inhatc";
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

	int result = dao.updateU_img(u_img, u_imgReal, dto.getEmail());
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
	out.write("파일명 : " + u_img + "<br>");

	out.write("실제파일명 : " + u_imgReal + "<br>");
%>
</body>
</html>