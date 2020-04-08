<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="sec01.ex01.MemberDAO"%>
<%@page import="sec01.ex01.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%--
	member.jsp 설명 
	- memberForm.html로부터 전송된 회원정보를 request내장객체의 getParameter()메소드를 이용해 가져온 후 ....
	  MemberBean객체를 생성하여 전송된 회원정보들을 MemberBean의 변수에 저장합니다.
	  그런 다음 MemberDAO객체의 addMember()메소드를 호출해 인자로 MemberBean객체자체를 전달합니다.
	새 회원을 DB에 추가한 후에는 다시 MemberDAO객체의 listMembers()메소드를 호출해....
	모든 회원정보를 조회하고 조회한 회원정보를 현재 member.jsp페이지에 출력합니다.
 --%>    
    
<%
	//1. 한글 인코딩 설정 
	request.setCharacterEncoding("UTF-8");
	
	//2. memberForm.html에서 입력한 회원정보 얻기 (요청한 값 얻기)
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	
	//3. MemberBean객체 생성한 후 입력한 회원정보를 각 변수에 저장 
	MemberBean m = new MemberBean(id,pwd,name,email);
	
	//4. MemberDAO객체의 addMember()메소드를 호출해 인자로 MemberBean객체자체를 전달합니다.
	// MemberBean객체 전달 이유 : 새 회원정보를 DB의 테이블에 추가(INSERT) 하기 위함 
 	MemberDAO memberDAO = new MemberDAO();
			  memberDAO.addMember(m);	
			  
	//5. 새 회원을 DB에 추가한 후에는 다시 MemberDAO객체의 listMembers()메소드를 호출해....
	// 모든 회원정보를 조회
		List membersList = memberDAO.listMembers();
%>
<html>
<body>
<table border=1>
<tr align='center' bgcolor ='lightgreen'>
<td>아이디</td><td>비밀번호</td><td>이름</td><td>이메일</td>
</tr>

<%
	for (int i = 0; i < membersList.size(); i++) {
		MemberBean memberVO = (MemberBean)membersList.get(i);
		
		String _id = memberVO.getId();
		String _pwd = memberVO.getPwd();
		String _name = memberVO.getName();
		String _email = memberVO.getEmail();		
		out.print("<tr>");
		out.print("<td>" + _id + "</td><td>" + _pwd + "</td><td>" + _name + "</td>" + "<td>" + _email + "</td>"
			 );
		out.print("</tr>");
	} 
out.print("사이즈 : " + membersList.size());

%>
</table>
</body>    
</html>
    
