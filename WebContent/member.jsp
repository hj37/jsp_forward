<%@page import="java.sql.Date"%>
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
<table align="center" width="100%">
<tr align='center' bgcolor ='lightgreen'>
<td width="7%">아이디</td>
<td width="7%">비밀번호</td>
<td width="5%">이름</td>
<td width="11%">이메일</td>
<td width="5%">가입날짜</td>
</tr>

<%
	if(membersList.size() == 0){ //DB의 테이블에서 조회한 회원이 없으면?
%>
		<tr>
			<td colspan="5">
				<b><span style="font-size:9pt;">등록된 회원이 없습니다.</span></b>
			</td>
		</tr>
<% 
	}else{//DB로부터 조회한 회원이 있으면?
		//for반복문을 이용해 ArrayList에 저장되어있는 MemberBean객체의 갯수만큼 반복하여
		//MemberBean객체를 하나씩 가져온 후...
		for (int i = 0; i < membersList.size(); i++) {
			MemberBean bean = (MemberBean)membersList.get(i);
%>		
		<tr align="center">
			<td><%=bean.getId()%></td>
			<td><%=bean.getPwd()%></td>
			<td><%=bean.getName()%></td>
			<td><%=bean.getEmail()%></td>
			<td><%=bean.getJoinDate()%></td>
		</tr>
<% 	
		}//for
	}//else
%>

<tr height="1" bgcolor="#99ccff">
		<td colspan="5"></td>
	</tr>
</table>
</body>
</html>

