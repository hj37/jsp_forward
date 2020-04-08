<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		//한글 깨짐 방지를 위한 문자셋방식 지정
		request.setCharacterEncoding("UTF-8");
		//입력한 아이디 얻기
		String userID = request.getParameter("userID");
		//아이디를 입력하지 않은 경우 자바코드중..RequestDispatcher를 사용하지 않고
		//포워드 액션태그를 사용해 다시 로그인창을 재요청해 이동하도록 작성 
		if(userID.length() == 0){
		/* 	//디스패치 방식의 포워딩 기술(자바코드의 경우)
			RequestDispatcher dispatch	= request.getRequestDispatcher("login.jsp");
			//실제 포워딩
			dispatch.forward(request,response); */
		
		//아이디를 입력 했을 경우
	%>
		<jsp:forward page="login.jsp"></jsp:forward>
	<%		
		}
	%>


		<h1>환영합니다. <%=userID %>님!!</h1>



</body>
</html>