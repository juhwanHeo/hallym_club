package hallym.league.user.vo;

public class UserVO {
	private String id;
	private int conditioncode;
	private String conditionname;
	private String name;
	private String major;
	private String grade;
	private String gender;
	private String phoneNumber;
	private String e_mail;
	private String birthday;

	@Override
	public String toString() {
		return "UserVO [id=" + id + ", conditioncode=" + conditioncode + ", conditionname=" + conditionname + ", name=" + name + ", major=" + major + ", grade=" + grade + ", gender=" + gender
				+ ", phoneNumber=" + phoneNumber + ", e_mail=" + e_mail + ", birthday=" + birthday + "]";
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	public int getConditioncode() {
		return conditioncode;
	}

	public void setConditioncode(int conditioncode) {
		this.conditioncode = conditioncode;
	}

	public String getConditionname() {
		return conditionname;
	}

	public void setConditionname(String conditionname) {
		this.conditionname = conditionname;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getMajor() {
		return major;
	}

	public void setMajor(String major) {
		this.major = major;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getE_mail() {
		return e_mail;
	}

	public void setE_mail(String e_mail) {
		this.e_mail = e_mail;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
}
