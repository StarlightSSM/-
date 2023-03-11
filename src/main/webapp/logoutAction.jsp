<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

<%
  //1.session scope에 "id"라는 키값으로 저장된 값을 삭제한다.
   session.removeAttribute("id");
    //2. 응답(특정페이지로 요청을 다시 하라는 리다이렉트로 응답)
    String cPath = request.getContextPath();
    PrintWriter script = response.getWriter();
          script.println("<script>");
      script.println("alert('로그아웃에 성공하셨습니다.');");
      script.println("location.href='Home.html'");
      script.println("</script>");
%>
</body>
</html>