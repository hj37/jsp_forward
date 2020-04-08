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
<%--주제 : 최초 로그인화면 접속시 오류메세지 출력하지 않기 --%>
<%
	//한글 처리 
	request.setCharacterEncoding("UTF-8");
	
	//웹브라우저에서 접속시에는 msg값을 가져와 표시하고,
	//최초 접속시에는 null이므로 아무것도 표시 하지 않게 하기 
	String msg = request.getParameter("msg");
	
	if(msg != null){
%>
		<h1><%=msg %></h1>
<% 
	}
%>

	<form action="result2.jsp" method="post">
		아이디 : <input type="text" name="userID"><br>
		비밀번호 : <input type="password" name="userPw"><br>
		<input type="submit" value="로그인">
		<input type="reset" value="다시입력">
	</form>

</body>
</html>