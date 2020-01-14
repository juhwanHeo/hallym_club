package exam.jdbc;

public class MemberVO {

    private String username;
    private String password;
    private String cpassword; 
   
    public MemberVO(){}
    public MemberVO(String username, String password, String cpassword){
    	this.username = username;
    	this.password = password;
    	this.cpassword = cpassword;
    }

	public String getUsername() {
		return username;
	}


	public void setUsername(String username) {
		this.username = username;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}


	public String getCpassword() {
		return cpassword;
	}


	public void setCpassword(String cpassword) {
		this.cpassword = cpassword;
	}

}
