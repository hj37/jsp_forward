package sec01.ex01;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

//오라클 DBMS(데이터베이스 매니저시스템 프로그램)의 데이터베이스의 테이블과 연결하여 작업할 클래스 
//
public class MemberDAO {

	// 데이터베이스 관련 작업에 필요한 객체들을 저장할 변수 선언
	// (삼총사들...)
	private Connection con; // <-- DAO클래스와 DB와의 연결정보를 담고있는 접속을 나타내는 객체를 저장할 변수
	private PreparedStatement pstmt;// <-- SQL문을 만들어서 DB테이블에 전송하여 실행하는 역할을 하는 객체를 저장할 변수
	private ResultSet rs; // <--DB테이블로부터 검색한 회원정보를 임시로 저장할 객체를 저장할 변수

	// 커넥션풀 역할을 하는 객체를 저장할 변수 선언
	private DataSource dataFactory;

	// 커넥션풀(DataSource)객체를 얻는 생성자
	public MemberDAO() {
		try {
			// 톰캣이 실행되면 context.xml파일의 <Resource>설정을 읽어와서 톰캣 메모리에 프로젝트별로 Context객체들을 생성합니다.
			// 이때 InitialContext객체가 하는 역할은 톰캣 실행 시.. context.xml에 의해서 생성된 Context객체들에 접근하는
			// 역할을 합니다.
			Context ctx = new InitialContext();

			// JNDI방법으로 접근하기 위해 기본경로(java:/comp/env)를 설정합니다.
			// lookup("java:/comp/env");는 그중 환경 설정에 관련된 컨텍스 자체에 접근하기 위한 기본 주소입니다.
			Context envContext = (Context) ctx.lookup("java:/comp/env");

			// 그런 후 다시 톰캣은 context.xml에 설정한 <Resource name="jdbc/oracle"...>태그의
			// name속성값 "jdbc/oracle"을 이용해 톰캣이 미리 DB에 연결해 놓은 DataSource객체(커넥션을 역할을 하는 객체)를
			// 받아옵니다.
			dataFactory = (DataSource) envContext.lookup("jdbc/oracle");

		} catch (Exception e) {
			e.printStackTrace();
		}
	}// 생성자 끝

	// DB에 새 회원정보를 추가할 메소드
	// MemberBean객체의 각 변수에 저장된 입력한 회원정보가 전달되어 옴
	public void addMember(MemberBean memberBean) { // MemberBean객체에 각변수에 저장된 입력한 회원정보가 전달되어 옴.
		try {
			// DataSource(커넥션풀)을 이용해 데이터베이스에 연결함
			con = dataFactory.getConnection();

			// 매개변수로 전달받은 MemberBean객체의 각 변수값을 얻자
			// getter메소드를 호출!
			String id = memberBean.getId();
			String pwd = memberBean.getPwd();
			String name = memberBean.getName();
			String email = memberBean.getEmail();

			// DB에 전송하여 실행할 SQL문 작성
			String query = "insert into t_member(id,pwd,name,email)values(?,?,?,?)";

			// ?기호에 대응되는 값을 제외한 insert전체 문장을 임시로 OraclePreparedStatementWrapper실행객체에 담아...
			// OraclePreparedStatementWrapper실행객체 자체를 반환해서 얻기
			// <-------insert문장을 DB에 전송하여 실행할 객체
			pstmt = con.prepareStatement(query);

			// OraclePreparedStatementWrapper실행객체 ?기호들에 대응되는 값 4개를 설정
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			pstmt.setString(3, name);
			pstmt.setString(4, email);

			// OraclePreparedStatementWrapper실행객체를 이용하여 DB에 insert실행!
			pstmt.executeUpdate(); // insert에 성공하면 1 반환 실패하면 0을 반환 예외가 발생하면 알아서 exception찾아감

		} catch (Exception e) {
			System.out.println("addMember메소드내부에서 오류: " + e.getMessage());
		} finally {
			// 자원해제 (무조건 한 번 이상 실행됨)
			try {
				if (pstmt != null) {
					pstmt.close();
				}

				if (con != null) {
					con.close();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} // finally끝
	}// addMember메소드 끝

	// DB의 모든 회원정보를 조회(검색)하는 역할의 메소드

	public List listMembers() { // MemberBean객체에 각변수에 저장된 입력한 회원정보가 전달되어 옴.

		// DB의 모든 회원정보를 조회(검색)하여 나타난 데이터들을 회원한 사람의 정보씩 MemberBean객체에 저장 후
		// MemberBean객체들을 ArrayList배열공간에 저장하기 위해...
		// ArrayList객체 생성
		List list = new ArrayList(); // 업캐스팅
		// 업캐스팅 : 조상인터페이스 타입의 참조변수에 자식 객체를 생성해서 저장
		// 조상클래스 타입의 참조변수에 자식객체를 생성해서 저장

		try {
			// 커넥션풀(DataSource)로부터 DB와 미리연결을 맺은 Connection 객체 빌려오기
			// DB연결작업
			con = dataFactory.getConnection(); // DB와의 연결 부분(DB 접속부분)

			// 회원정보를 최근 가입일순으로 내림차순 정렬하여 조회(검색)할 SQL문 만들기
			String query = "select * from t_member order by joinDate desc";

			// ?를 제외한 select문장을 임시로 OraclePreparedStatementWrapper 실행객체에 담아..
			// OraclePreparedStatementWrapper실행객체를 얻기 <-select문장을 DB에 전송하여 검색하는 역할을 하는 객체 얻기
			pstmt = con.prepareStatement(query);

			// 위의 query변수에 저장된 select문장을 DB에 전송하여 검색한 그 결과를 MemberDAO.java페이지로 전달 받기 위해..
			// 검색결과를 Table형식 구조로 저장할 임시 저장소 역할을 하는 객체가 필요하다.
			// 그 객체가 바로 OracleResultSetImpl객체인것이다.
			// OracleResultSetImpl객체에 검색한 결과데이터들을 테이블 형식의 구조로 똑같이 저장하여
			// OracleResultSetImpl객체 자체를 리턴받는다.

			rs = pstmt.executeQuery();

			// OracleResultSetImpl객체의 구조는 테이블 형식의 구조로써 처음에는 커서가 테이블 구조의 컬럼명이 있는
			// 줄을 가리키고 있다.rs.next()메소드를 호출하면 커서위치가 한 줄 아래로 내려오면서
			// 그 다음줄에 검색한 레코드가 존재하는지 묻게 된다.
			// next()메소드는 그 다음줄에 레코드가 존재하면 true를 반환하고
			// 존재하지 않으면 false를 반환한다.

			while (rs.next()) {

				// 오라클 DB의 t_member테이블에 검색한 레코드의 각컬럼 값을
				// OracleResultSetImpl객체에서 꺼내와 변수에 저장
				String id = rs.getString("id"); // rs.getString(1)이렇게 적어도 됨
				String pwd = rs.getString("pwd");
				String name = rs.getString("name");
				String email = rs.getString("email");
				Date joinDate = rs.getDate("joinDate"); // 요까지가 검색한 한 줄임

				// 검색한 회원 한 사람의 회원 정보를 MemberBean객체의 각변수에 저장함
				MemberBean vo = new MemberBean();
				// setter메소드 호출~!
				vo.setId(id);
				vo.setPwd(pwd);
				vo.setName(name);
				vo.setEmail(email);
				vo.setJoinDate(joinDate);

				// ArrayList가변길이 배열의 인덱스 위치에 MemberBean객체를 추가하여 반납함
				list.add(vo); // Object타입이므로 업캐스팅이 일어나고 있음
			} // while반복문 끝

			

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {

			try {// 자원해제~
				if (pstmt != null) {
					pstmt.close();
				}

				if (con != null) {
					con.close();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list; // listMember()메소드를 호출한 페이지인? member.jsp로 ArrayList를 반환

	}// listMembers()메소드 닫는 기호

}// MemberDAO클래스 끝
