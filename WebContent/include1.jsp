<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	//웹브라우저 주소창에 주소를 입력하여 현재 include1.jsp를 요청함 
	//요청주소 : http://localhost:8070/pro12/include1.jsp로 요청 
	
	request.setCharacterEncoding("UTF-8");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	안녕하세요. 쇼핑몰 중심 JSP 시작부분입니다!!! <br>
	<!-- duke_image.jsp를 동적으로 포워딩합니다. -->
	<jsp:include page="duke_image.jsp">
	
		<jsp:param name="name" value="듀크"/>
		<jsp:param name="imgName" value="duke.png"/>
	
	
	</jsp:include>

	<!-- param액션태그를 이용해 duke_image.jsp로 이름과 파일이름을 전달함. -->
	
	안녕하세요. 쇼핑몰 중심 JSP 끝 부분입니다!!! 
</body>
</html>