package test;

// 자바빈 테스트를 위한 클래스로 이름(name)과 성별(gender)을 저장하는 클래스
public class BeanTest {
	private String name = "Hong-GillDong", gender = "남자";
	// 정보를 저장하기 위한 멤버변수 선언

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}
	


}
