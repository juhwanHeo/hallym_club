package bbs;

public class Bbs {
	private int club_id;

	private int BOARD_NO;

	private String TITLE; 

	private String board_cd; 

	private String INPUT_ID; 

	private String INPUT_DATE; 

	private String CONTENTS;
	private int bbsAvailable;

	private int OPEN_CNT;
	private int row_count;

	private String start_date;
	private String end_date;
	
	
	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	public String getEnd_date() {
		return end_date;
	}

	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}

	public int getRow_count() {
		return row_count;
	}

	public void setRow_count(int row_count) {
		this.row_count = row_count;
	}

	public int getOPEN_CNT() {
		return OPEN_CNT;
	}

	public void setOPEN_CNT(int oPEN_CNT) {
		OPEN_CNT = oPEN_CNT;
	}

	public int getClub_id() {
		return club_id;
	}

	public void setClub_id(int club_id) {
		this.club_id = club_id;
	}

	public int getBOARD_NO() {
		return BOARD_NO;
	}

	public void setBOARD_NO(int bOARD_NO) {
		BOARD_NO = bOARD_NO;
	}

	public String getTITLE() {
		return TITLE;
	}

	public void setTITLE(String tITLE) {
		TITLE = tITLE;
	}

	public String getBoard_cd() {
		return board_cd;
	}

	public void setBoard_cd(String board_cd) {
		this.board_cd = board_cd;
	}

	public String getINPUT_ID() {
		return INPUT_ID;
	}

	public void setINPUT_ID(String iNPUT_ID) {
		INPUT_ID = iNPUT_ID;
	}

	public String getINPUT_DATE() {
		return INPUT_DATE;
	}

	public void setINPUT_DATE(String iNPUT_DATE) {
		INPUT_DATE = iNPUT_DATE;
	}

	public String getCONTENTS() {
		return CONTENTS;
	}

	public void setCONTENTS(String cONTENTS) {
		CONTENTS = cONTENTS;
	}

	public int getBbsAvailable() {

		return bbsAvailable;

	}

	public void setBbsAvailable(int bbsAvailable) {

		this.bbsAvailable = bbsAvailable;
	}

}