package budget;

import java.text.SimpleDateFormat;
import java.util.Date;

public class BudgetVO {
	private int club_id;
	private int seq_no;
	private String io_gb_cd;
	private String use_dt;
	private String contents;
	private int price;
	private String input_id;
	private String input_ip;
	private String input_date;
	private String update_id;
	private String update_ip;
	private String update_date;
	
	public BudgetVO(){}
	
    public BudgetVO(int club_id, int seq_no, String io_gb_cd, String use_dt, String contents, int price, String input_id, String input_ip, String input_date){
    	this.club_id = club_id;
    	this.seq_no = seq_no;
    	this.io_gb_cd = io_gb_cd;
    	this.use_dt = use_dt;
    	this.contents = contents;
    	this.price = price;
    	this.input_id = input_id;
    	this.input_ip = input_ip;
    	this.input_date = input_date;
    }
    
	public int getClub_id() {
		return club_id;
	}
	public void setClub_id(int club_id) {
		this.club_id = club_id;
	}
	public int getSeq_no() {
		return seq_no;
	}
	public void setSeq_no(int seq_no) {
		this.seq_no = seq_no;
	}
	public String getIo_gb_cd() {
		return io_gb_cd;
	}
	public void setIo_gb_cd(String io_gb_cd) {
		this.io_gb_cd = io_gb_cd;
	}
	public String getUse_dt() {
		Date today = new Date();
	    SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");

		if(use_dt == null){
			use_dt = date.format(today);
		}else{
			String y = use_dt.substring(0,4);
			String m = use_dt.substring(4,6);
			String d = use_dt.substring(6);
			
			use_dt = y +"-" + m +"-" + d;
		}
		
		return use_dt;
	}
	public void setUse_dt(String use_dt) {
		this.use_dt = use_dt;
	}
	public String getContents() {
		if(contents == null){
			contents = "";
		}
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getInput_id() {
		return input_id;
	}
	public void setInput_id(String input_id) {
		this.input_id = input_id;
	}
	public String getInput_ip() {
		return input_ip;
	}
	public void setInput_ip(String input_ip) {
		this.input_ip = input_ip;
	}
	public String getInput_date() {
		return input_date;
	}
	public void setInput_date(String input_date) {
		this.input_date = input_date;
	}
	public String getUpdate_id() {
		return update_id;
	}
	public void setUpdate_id(String update_id) {
		this.update_id = update_id;
	}
	public String getUpdate_ip() {
		return update_ip;
	}
	public void setUpdate_ip(String update_ip) {
		this.update_ip = update_ip;
	}
	public String getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
	}
	


}
