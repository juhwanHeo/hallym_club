package user;

public class UserVO {

	/*
	 * 		
	 * 
	 * 
	 * 
	 * IDNO, NAME, MAJORNAME, GRADE, GENDER, PHONENUMBER, E_MAIL, RESIDENTNO
	 * 
	 */
	private String id;
	private String name;
	private String major;
	private String grade;
	private String gender;
	private String phoneNumber;
	private String e_mail;
	private String birthday;
	private String admin_cd;




	
	@Override
	public String toString() {
		return "UserVO [id=" + id + ", name=" + name + ", major=" + major + ", grade=" + grade + ", gender=" + gender
				+ ", phoneNumber=" + phoneNumber + ", e_mail=" + e_mail + ", birthday=" + birthday + ", admin_cd="
				+ admin_cd + "]";
	}

	public String getAdmin_cd() {
		return admin_cd;
	}

	public void setAdmin_cd(String admin_cd) {
		this.admin_cd = admin_cd;
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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
