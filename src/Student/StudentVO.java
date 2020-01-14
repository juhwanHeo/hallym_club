package Student;

public class StudentVO {

    private String username;
    private String password;
    private String input_date;
    private String input_ip;
    
    public StudentVO(){}
    public StudentVO(String username, String password, String input_date, String input_ip){
    	this.username = username;
    	this.password = password;
    	this.input_date = input_date;
    	this.input_ip = input_ip;
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

	public String getInput_date() {
		return input_date;
	}


	public void setInput_date(String input_date) {
		this.input_date = input_date;
	}

	public String getInput_ip() {
		return input_ip;
	}


	public void setInput_ip(String input_ip) {
		this.input_ip = input_ip;
	}
}
