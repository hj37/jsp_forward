package sec01.ex01;

import java.sql.Date;

//1. 사용자가 입력한 가입할 회원정보를 저장할 용도의 클래스 또는  db에 전달할 용도의 클래스
//2. db에 저장된 한 사람의 회원정보를 검색해서 가져와서 임시로 저장하는 용도의 클래스 

public class MemberBean {

	
	/* 회원테이블의 컬럼 이름과 동일하게 변수이름과 자료형을 선언합니다 */
	private String id;        
	private String pwd;     
	private String name;     
	private String email;             
	private Date joinDate;                  
								
	/*아무런 일도 하지 않는 기본생성자 */
	public MemberBean() {}
	public MemberBean(String id, String pwd, String name, String email ) {
		//super(); Object를 상속받는 지우면 됨
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.email = email;
	}
	
	/*getter,setter메소드 */
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}
	
	/*getter,setter 메소드*/
	
	
}
