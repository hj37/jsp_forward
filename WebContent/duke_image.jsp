<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//param액션태그로 전달된 매개변수값을 request객체의 getParameter()메소드를 이용해 가져옴
	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	String imgName = request.getParameter("imgName");
%>    
    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<br><br>
	<h1>이름은 <%=name%>입니다.</h1> <br><br>
	<img src="./image/<%=imgName%>"> <br>

</body>
</html>