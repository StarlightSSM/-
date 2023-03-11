<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.UserDAO"%>
<%@ page import="user.DiaryDAO"%>
<%@ page import="user.DiaryDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// w_id를 초기화시키고
	// w_id라는 데이터가 넘어온 것이 존재한다면 캐스팅을 하여 변수에 담는다.
	String w_id = (String)session.getAttribute("w_id");
	int id = 0;
	if (request.getParameter("w_id") != null) {
		id = Integer.parseInt(request.getParameter("w_id"));
	}
	
	// 만약 넘어온 데이터가 없다면
	if (id == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href='contents.jsp'");
		script.println("</script>");
	}

%>
<%
   // 정보수정 화면으로 가기전에
   // 아이디 기준으로 회원정보를 조회해서 다음 화면으로 전달
   
   String email = (String)session.getAttribute("email");
       //DB연결에 필요한 변수 선언
    String dbURL = "jdbc:mysql://localhost:3306/USER?serverTimezone=Asia/Seoul";
    //   String dbURL = "jdbc:mysql://34.64.212.229:3306/USER?serverTimezone=Asia/Seoul";
    String dbID="root";
   //String dbID="inhatc";
   String dbPassword="inha1958";
   
   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;
   
   String sql = "select * from writing where w_id = ?";
   
   try{
      // 드라이버 호출
      Class.forName("com.mysql.jdbc.Driver");
      
      // conn 생성
	  conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
      
      // pstmt 생성
      pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, email);
      
      // sql실행
      rs = pstmt.executeQuery();
      
      if(rs.next()){
         email = rs.getString("email");
         id = Integer.parseInt(rs.getString("w_id"));
         String w_day = rs.getString("w_day");
         String w_title = rs.getString("w_title");
         String w_emotion = rs.getString("w_emotion");
         String w_content = rs.getString("w_content");
         String w_intro = rs.getString("w_intro");
         
         // 포워드로 전달하기 위해
         request.setAttribute("email", email);
         request.setAttribute("w_id", w_id);
         request.setAttribute("w_day", w_day);
         request.setAttribute("w_emotion", w_emotion);
         request.setAttribute("w_content", w_content);
         request.setAttribute("w_intro", w_intro);
      
         
         // 포워드 이동
         request.getRequestDispatcher("Home2.jsp").forward(request, response);
         
      } else{ // 세션이 만료된 경우
         response.sendRedirect("Home2.jsp");
      }
   } catch(Exception e){
      e.printStackTrace();
      response.sendRedirect("Home2.jsp");
   } finally{
      try{
         if(conn != null) conn.close();
         if(pstmt != null) pstmt.close();
         if(rs != null) rs.close();
      } catch(Exception e){
         e.printStackTrace();
      }
   }
   
// 유효한 글이라면 구체적인 정보를 diaryDAO라는 인스턴스에 담는다.
	DiaryDAO diaryDAO = new DiaryDAO();
	DiaryDTO dto = new DiaryDAO().getDiary(w_id);
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