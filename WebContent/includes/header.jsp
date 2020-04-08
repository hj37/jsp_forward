<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h1>여기는 header.jsp의 내용입니다.</h1>
<b>작성자 : XXX</b> <br/>

<%
/*
	index.jsp페이지 내에서 사용된 <%@ include file="" % > 지시자 태그는...
	header.jsp페이지와 index.jsp페이지는 서로 합쳐져서 하나의 페이지가 완성된 후 
	한번만 컴파일 되므로 header.jsp와 index.jsp페이지에 int i;변수를 중복으로 선언할 수 없다.
*/

//중복 선언 한 경우!! 에러 발생!!! 
/* 	int i;
	i= 20;
 */
%>
<%-- i = <%=i%> --%>