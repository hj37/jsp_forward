<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<h2>여기는 footer.jsp의 내용입니다.</h2>
<div align="center">
	&Copyright reserved
</div>

<%
	// <jsp:include page=.../>액션태그는...
	// footer.jsp페이지와 index.jsp페이지에 int i; 변수를 중복으로 선언 가능하다.
	//그 이유는 index.jsp -> index_jsp.java -> index_jsp.class컴파일 되고,
	//		 footer.jsp -> footer_jsp.java -> footer_jsp.class컴파일이 각각 되므로 
	int i;
	i = 20;
%>

i = <%=i%>