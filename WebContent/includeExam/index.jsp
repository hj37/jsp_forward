<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
int i;
i = 10;
%>

<%-- 헤더부분 --%>
<%@ include file="/includes/header.jsp" %>


<hr/>
<%-- 본문부분 --%>
<h1>include액션태그 예제</h1>
이 페이지는 action tag를 이용한 include를 사용하고 있습니다.
<hr/>


<%-- 하단부분 --%>
<jsp:include page="../includes/footer.jsp"/>

<hr/>

footer.jsp 구문 실행 후 제어권이 되돌아와 실행될 코드~~~~<br>