<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.Sign_upDTO" %>
<%@ page import="user.Sign_upDAO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.UserDTO" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <%
//String email, String pw, String name, String phone, String w_intro, String u_img, String birth => join 매개변수에다 이걸로 고치기
 	request.setCharacterEncoding("UTF-8");
	UserDAO userdao = new UserDAO();
	UserDTO userdto = new UserDTO();
 	String email = null;
 	String pw= null;
 	String name =null;
 	String phone = null;
 	String birth = "1";
 	String w_intro = "2";
 	String u_img = "3";
 	String u_imgReal = "4";
 	if(request.getParameter("email")!=null){
 		email=(String) request.getParameter("email");
 	}
 	if(request.getParameter("pw")!=null){
 		pw =(String) request.getParameter("pw");
 	}
 	if(request.getParameter("name")!=null){
 		name=(String) request.getParameter("name");
 	}
 	if(request.getParameter("phone")!=null){
 		phone=(String) request.getParameter("phone");
 	}	
 	if(email ==null || pw ==null || name==null || phone==null){
 		PrintWriter script = response.getWriter();
 		script.println("<script>");
 		script.println("alert('입력이 안된 사항이 있습니다.');");
 		script.println("history.back();");
 		script.println("</script>");
 		script.close();
 		return;
 	}
 	Sign_upDAO sign_upDAO =new Sign_upDAO();
 	int result = sign_upDAO.join(email,pw,name,phone,birth,w_intro,u_img,u_imgReal);
 	// int result = sign_upDAO.join(email,pw,name,phone,w_intro,u_img,birth);로 고치기
 	if (result==1){
 		PrintWriter script = response.getWriter();
 		script.println("<script>");
 		script.println("alert('회원가입에 성공하셨습니다.');");
 		script.println("location.href='Home.html'");
 		script.println("</script>");
 		script.close();
 		return;
 	}
 %>
</body>
</html> 