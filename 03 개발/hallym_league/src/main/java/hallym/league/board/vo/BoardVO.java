package hallym.league.board.vo;

public class BoardVO {

	private String BOARD_CD;
	private int SEQ_NO;
	private int UP_SEQ_NO;
	private String TITLE;
	private String CONTENTS;
	private int OPEN_CNT;
	private int BBSAVAILABLE;
	private String FIX_YN;
	private String ATTACH_YN;
	private String START_DATE;
	private String END_DATE;
	private String INPUT_ID;
	private String INPUT_IP;
	private String INPUT_DATE;
	private String UPDATE_ID;
	private String UPDATE_IP;
	private String UPDATE_DATE;
	
	@Override
	public String toString() {
		return "BoardVO [BOARD_CD=" + BOARD_CD + ", SEQ_NO=" + SEQ_NO + ", UP_SEQ_NO=" + UP_SEQ_NO +
				", TITLE=" + TITLE +"," + " CONTENTS=" + CONTENTS + "OPEN_CNT=" + OPEN_CNT +
				", BBSAVAILABLE=" + BBSAVAILABLE + ", FIX_YN=" + FIX_YN + ", ATTACH_YN=" + ATTACH_YN + ", START_DATE=" + START_DATE + ", END_DATE=" + END_DATE +
				", INPUT_ID=" + INPUT_ID + ", INPUT_IP=" + INPUT_IP + "INPUT_DATE=" + INPUT_DATE +
				", UPDATE_ID=" + UPDATE_ID + ", UPDATE_IP=" + UPDATE_IP + "UPDATE_DATE=" + UPDATE_DATE + "]";
	}

	public String getBOARD_CD() {
		return BOARD_CD;
	}

	public void setBOARD_CD(String bOARD_CD) {
		BOARD_CD = bOARD_CD;
	}

	public int getSEQ_NO() {
		return SEQ_NO;
	}

	public void setSEQ_NO(int sEQ_NO) {
		SEQ_NO = sEQ_NO;
	}

	public int getUP_SEQ_NO() {
		return UP_SEQ_NO;
	}

	public void setUP_SEQ_NO(int uP_SEQ_NO) {
		UP_SEQ_NO = uP_SEQ_NO;
	}

	public String getTITLE() {
		return TITLE;
	}

	public void setTITLE(String tITLE) {
		TITLE = tITLE;
	}

	public String getCONTENTS() {
		return CONTENTS;
	}

	public void setCONTENTS(String cONTENTS) {
		CONTENTS = cONTENTS;
	}

	public int getOPEN_CNT() {
		return OPEN_CNT;
	}

	public void setOPEN_CNT(int oPEN_CNT) {
		OPEN_CNT = oPEN_CNT;
	}

	public int getBBSAVAILABLE() {
		return BBSAVAILABLE;
	}

	public void setBBSAVAILABLE(int bBSAVAILABLE) {
		BBSAVAILABLE = bBSAVAILABLE;
	}

	public String getFIX_YN() {
		return FIX_YN;
	}

	public void setFIX_YN(String fIX_YN) {
		FIX_YN = fIX_YN;
	}
	
	public String getATTACH_YN() {
		return ATTACH_YN;
	}

	public void setATTACH_YN(String aTTACH_YN) {
		FIX_YN = aTTACH_YN;
	}
	
	public String getSTART_DATE() {
		return START_DATE;
	}
	
	public void setSTART_DATE(String sTART_DATE) {
		START_DATE = sTART_DATE;
	}
	
	public String getEND_DATE() {
		return END_DATE;
	}
	
	public void setEND_DATE(String eND_DATE) {
		END_DATE = eND_DATE;
	}

	public String getINPUT_ID() {
		return INPUT_ID;
	}

	public void setINPUT_ID(String iNPUT_ID) {
		INPUT_ID = iNPUT_ID;
	}

	public String getINPUT_IP() {
		return INPUT_IP;
	}

	public void setINPUT_IP(String iNPUT_IP) {
		INPUT_IP = iNPUT_IP;
	}

	public String getINPUT_DATE() {
		return INPUT_DATE;
	}

	public void setINPUT_DATE(String iNPUT_DATE) {
		INPUT_DATE = iNPUT_DATE;
	}

	public String getUPDATE_ID() {
		return UPDATE_ID;
	}

	public void setUPDATE_ID(String uPDATE_ID) {
		UPDATE_ID = uPDATE_ID;
	}

	public String getUPDATE_IP() {
		return UPDATE_IP;
	}

	public void setUPDATE_IP(String uPDATE_IP) {
		UPDATE_IP = uPDATE_IP;
	}

	public String getUPDATE_DATE() {
		return UPDATE_DATE;
	}

	public void setUPDATE_DATE(String uPDATE_DATE) {
		UPDATE_DATE = uPDATE_DATE;
	}
	
}
