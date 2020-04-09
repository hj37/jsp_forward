<%@page import="sec01.ex01.MemberBean"%>
<%@page import="java.util.List"%>
<%@page import="sec01.ex01.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	//1.한글 꺠짐 방지를 위한 인코딩 방식 지정
	request.setCharacterEncoding("UTF-8");

	//2. memberForm.html에서 입력한 회원정보 얻기 (요청한 값 얻기)
	//3.MemberBean객체 생성한 후 입력한 회원정보를 각변수에 저장
%>     
    <jsp:useBean id="mb" class="sec01.ex01.MemberBean" scope="page"/>

   <%--
   		회원가입창(memberForm.html)에서 입력하여 전달된..값을 얻어 set메소드 의 매개변수로 전달할떄
        <input>태그의 name속성값과...  <jsp:setProperty>액션태그의 param속성의 값이 같으면?    
        MemberBean객체의 각변수에 자동으로 저장됨.     
               단! MemberBean의 각변수 이름과  param속성의 값이름이 동일 해야 하는 조건이 있습니다. 		
    --%>
	<jsp:setProperty property="id"   name="mb"  param="id"  />
	<jsp:setProperty property="pwd"  name="mb"  param="pwd" />
	<jsp:setProperty property="name"  name="mb" param="name" />
	<jsp:setProperty property="email" name="mb" param="email" />
<%
	
 	//4.MemberDAO객체의 addMember()메소드를 호출해 인자로 MemberBean객체자체를 전달 합니다.
 	//  MemberBean객체 전달 이유 : 새 회원정보를 DB의 테이블에 추가(INSERT) 하기 위함.
 	MemberDAO memberDAO = new MemberDAO();
 			  memberDAO.addMember(mb);       
 	
 	//5. 새 회원를 DB에 추가한 후에는  다시 MemberDAO객체의 listMembers()메소드를 호출해....
	//   모든 회원정보를 조회
   	List	membersList	=  memberDAO.listMembers();  	
 %>   
<table align="center" width="100%">
	<tr align="center" bgcolor="pink">
		<td width="7%">아이디</td>
		<td width="7%">비밀번호</td>
		<td width="5%">이름</td>
		<td width="11%">이메일</td>
		<td width="5%">가입일</td>
	</tr>
<%
  if(membersList.size() == 0){ //DB의 테이블에서 조회한 회원이 없으면?
%>	 
	<tr>
  		<td cospan="5">
  			<b><span stype="font-size:9pt;"> 등록된 회원이 없습니다.</span></b>
  		</td>
	</tr>	  
<%	
  }else{//DB로 부터 조회한 회원이 있으면?
		
	//for반복문을 이용해 ArrayList에 저장되어있는 MemberBean객체의 갯수만큼 반복하여
	//MemberBean객체를 하나씩 가져온후..
	for(int i=0; i<membersList.size(); i++){
		
		MemberBean bean = (MemberBean)membersList.get(i);
		//MemberBean객체의 각변수에 저장된 회원정보를 다시 getter메소드를 호출해 얻은후 출력함.
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
