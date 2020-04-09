<%@page import="sec01.ex01.MemberBean"%>
<%@page import="java.util.List"%>
<%@page import="sec01.ex01.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

	//한글 깨짐 방지를 위한 인코딩 방식 지정
	request.setCharacterEncoding("UTF-8");
	
	//2.memberForm.html에서 입력한 회원정보 얻기 (요청값 얻기 ) 
		
	//3.MemberBean객체 생성한 후 입력한 회원정보를 각 변수에 저장 
%>
<%-- 
	<jsp:useBean id="참조변수이름(생성한 객체를 식별할 수 있는 고유ID)" class="생성할 객체의 클래스 위치(패키지명 포함)"/>
  
 	useBean액션태그로 id속성값이 m인 MemberBean객체를 생성합니다.
 	생성된 MemberBean객체를 참조할 내장객체영역의 범위! scope속성의 값을 page로 지정하면...
 	현재 member2.jsp페이지 내에서란? 생성한 MemberBean객체를 공유해서 사용할 수 있다.
 --%>    
	<jsp:useBean id="mb" class="sec01.ex01.MemberBean" scope="page"/>  

	<%--memberForm.html에서 전송된 요청값들을 setter메소드를 호출하여 MemberBean객체의 각 변수에 저장  --%>	
	<jsp:setProperty property="id" value='<%=request.getParameter("id")%>' name="mb"/>  
 	<jsp:setProperty property="pwd" value='<%=request.getParameter("pwd")%>' name="mb"/>  
  	<jsp:setProperty property="name" value='<%=request.getParameter("name")%>' name="mb"/>  
 	<jsp:setProperty property="email" value='<%=request.getParameter("email")%>' name="mb"/>  
 	
<%
	//-> 위의 setProperty 액션태그 사용을 위한 주석처리 
	/* mb.setId(id);
	mb.setPwd(pwd);
	mb.setName(name);
	mb.setEmail(email); */
	
	//4. MemberDAO객체의 addMember()메소드를 호출해 인자로 MemberBean객체자체를 전달합니다.
	// MemberBean객체 전달 이유 : 새 회원정보를 DB의 테이블에 추가(INSERT) 하기 위함 
 	MemberDAO memberDAO = new MemberDAO();
			  memberDAO.addMember(mb);	
			  
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

