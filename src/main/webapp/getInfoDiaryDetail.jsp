<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="user.UserDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   // 정보수정 화면으로 가기전에
   // 아이디 기준으로 회원정보를 조회해서 다음 화면으로 전달
   
   String email = (String)session.getAttribute("email");
   String w_id = (String)session.getAttribute("w_id");
       //DB연결에 필요한 변수 선언
   String dbURL = "jdbc:mysql://localhost:3306/USER?serverTimezone=Asia/Seoul";
   //  String dbURL = "jdbc:mysql://34.64.212.229:3306/USER?serverTimezone=Asia/Seoul";
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
      pstmt.setString(1, w_id);
      
      // sql실행
      rs = pstmt.executeQuery();
      
      if(rs.next()){
         email = rs.getString("email");
         w_id = rs.getString("w_id");
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
         request.getRequestDispatcher("view.jsp").forward(request, response);
         
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