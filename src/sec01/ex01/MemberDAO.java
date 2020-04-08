package sec01.ex01;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


//오라클 DBMS(데이터베이스 매니저시스템 프로그램)의 데이터베이스의 테이블과 연결하여 작업할 클래스 
//
public class MemberDAO {
	
	//데이터베이스 관련 작업에 필요한 객체들을 저장할 변수 선언 
	//(삼총사들...) 
	private	Connection con;	//<-- DAO클래스와 DB와의 연결정보를 담고있는 접속을 나타내는 객체를 저장할 변수 
	private PreparedStatement pstmt;//<-- SQL문을 만들어서 DB테이블에 전송하여 실행하는 역할을 하는 객체를 저장할 변수 
	private ResultSet rs;	//<--DB테이블로부터 검색한 회원정보를 임시로 저장할 객체를 저장할 변수 
	
	//커넥션풀 역할을 하는 객체를 저장할 변수 선언 
	private DataSource dataFactory;
	
	//커넥션풀(DataSource)객체를 얻는 생성자 
	public MemberDAO() {
		try {
			//톰캣이 실행되면 context.xml파일의 <Resource>설정을 읽어와서 톰캣 메모리에 프로젝트별로 Context객체들을 생성합니다.
			//이때 InitialContext객체가 하는 역할은 톰캣 실행 시.. context.xml에 의해서 생성된 Context객체들에 접근하는 역할을 합니다.
			Context ctx = new InitialContext();
			
			//JNDI방법으로 접근하기 위해 기본경로(java:/comp/env)를 설정합니다.
			//lookup("java:/comp/env");는 그중 환경 설정에 관련된 컨텍스 자체에 접근하기 위한 기본 주소입니다.
			Context envContext = (Context)ctx.lookup("java:/comp/env");
			
			//그런 후 다시 톰캣은 context.xml에 설정한 <Resource name="jdbc/oracle"...>태그의
			//name속성값 "jdbc/oracle"을 이용해 톰캣이 미리 DB에 연결해 놓은 DataSource객체(커넥션을 역할을 하는 객체)를 받아옵니다. 
			dataFactory = (DataSource)envContext.lookup("jdbc/oracle");
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}//생성자 끝 
	
	//DB에 새 회원정보를 추가할 메소드 
	//MemberBean객체의 각 변수에 저장된 입력한 회원정보가 전달되어 옴 
	public void addMember(MemberBean memberBean) {	//MemberBean객체에 각변수에 저장된 입력한 회원정보가 전달되어 옴. 
		try {
			//DataSource(커넥션풀)을 이용해 데이터베이스에 연결함 
			con = dataFactory.getConnection();
			
			//매개변수로 전달받은 MemberBean객체의 각 변수값을 얻자 
			//getter메소드를 호출!
			String id = memberBean.getId();
			String pwd = memberBean.getPwd();
			String name = memberBean.getName();
			String email = memberBean.getEmail();
			
			//DB에 전송하여 실행할 SQL문 작성 
			String query = "insert into t_member(id,pwd,name,email)values(?,?,?,?)";
			
			//?기호에 대응되는 값을 제외한 insert전체 문장을 임시로 OraclePreparedStatementWrapper실행객체에 담아...
			//OraclePreparedStatementWrapper실행객체 자체를 반환해서 얻기 
			//<-------insert문장을 DB에 전송하여 실행할 객체 
			pstmt = con.prepareStatement(query);
			
			//OraclePreparedStatementWrapper실행객체 ?기호들에 대응되는 값 4개를 설정 
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			pstmt.setString(3, name);
			pstmt.setString(4, email);
			
			//OraclePreparedStatementWrapper실행객체를 이용하여 DB에 insert실행!
			pstmt.executeUpdate();

			
		}catch(Exception e) {
			System.out.println("addMember메소드내부에서 오류: " + e.getMessage());
		}finally {
			//자원해제 (무조건 한 번 이상 실행됨)
			try {
				if(pstmt != null) {
					pstmt.close();
				}
				
				if(con != null) {
					con.close();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}//finally끝 
	}//addMember메소드 끝 
	
	public ArrayList listMembers() {	//MemberBean객체에 각변수에 저장된 입력한 회원정보가 전달되어 옴. 
		ArrayList list = new ArrayList();
		try {
			
			//커넥션풀(DataSource)공간에서 DB와 미리 연결은 맺은 Connection객체를 빌려옴 
			//DB연결작업 
			con = dataFactory.getConnection();
			
			//5.Query작성하기 
			String query ="select * from t_member";
			
			//4. Connection객체의 PreparedStatement()메소드 호출시 ...SQL문을 전달해 
			//미리 로딩한 OraclePreparedStatementWrapper실행객체 얻기 
			pstmt = con.prepareStatement(query);
			
			//6.Query를 DB의 테이블에 전송하여 실행하기
			//->Statement객체의 executeQuery메소드 호출시...select구문을 전달하면...
			//검색한 회원정보를 테이블형식으로
			//ResultSet인터페이스의 자식객체인? OracleResultSetImpl 임시 메모리 공간에 저장하여 반환받는다.
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {	//검색할 줄이 존재할때까지 반복 
				//7.select문일 경우 검색할 결과값 데이터들이 ResultSet일시 메모리 저장소에 저장되어 있기때문에 
				//rs.next()메소드를 호출하여 그 다음 줄의 검색한 한 줄의 레코드를 가리키게 해야함.
				//현재 가리키고 있는 한 줄의 정보를 얻어올때...ResultSet객체의 get으로 시작하는 메소드 활용함.
				String id = rs.getString("id");
				String pwd = rs.getString("pwd");
				String name = rs.getString("name");
				String email = rs.getString("email");
				
				//위 변수에 저장된 각 컬럼값을 다시 MemberVo객체를 생성하여
				//각 변수에 저장 
				MemberBean vo = new MemberBean();
				//setter메소드 호출~! 
				vo.setId(id);
				vo.setPwd(pwd);
				vo.setName(name);
				vo.setEmail(email);
				
				//MemberVO객체 자체를? ArrayList가변길이 배열에 추가해서 저장
				list.add(vo);
			}//while반복문 끝
			
			//자원해제~ 
			con.close(); //Connection객체를 DataSource커넥션풀로 반납! 
			pstmt.close();
			rs.close();
			
			}catch(Exception e) {
										// 오류 메세지 출력 
				System.out.println("listMembers메소드 내부에서 오류: " + e);
			}
			return list; //DB로부터 검색한 레코드의 갯수만큼 MemberVO객체들이 저장되어 있는 ArrayList배열공간을 반환함.
	
	}
	
}//MemberDAO클래스 끝 
