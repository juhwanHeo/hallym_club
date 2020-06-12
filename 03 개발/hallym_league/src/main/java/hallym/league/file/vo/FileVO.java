package hallym.league.file.vo;

public class FileVO {

	private int FILE_NO;
	private String BOARD_CD;
	private int SEQ_NO;
	private String FILE_NM; 
	private String FILE_SAVE_NM;
	private String FILE_PATH;
	private String ENCLUDE_YN;
	private String INPUT_ID;
	private String INPUT_IP;
	private String INPUT_DATE;
	private String UPDATE_ID;
	private String UPDATE_IP; 
	private String UPDATE_DATE;
	
	@Override
	public String toString() {
		return "FileVO [FILE_NO=" + FILE_NO + ", BOARD_CD=" + BOARD_CD + ", SEQ_NO=" + SEQ_NO + ", FILE_NM=" + FILE_NM
				+ ", FILE_SAVE_NM=" + FILE_SAVE_NM + ", FILE_PATH=" + FILE_PATH + ", ENCLUDE_YN=" + ENCLUDE_YN
				+ ", INPUT_ID=" + INPUT_ID + ", INPUT_IP=" + INPUT_IP + ", INPUT_DATE=" + INPUT_DATE + ", UPDATE_ID="
				+ UPDATE_ID + ", UPDATE_IP=" + UPDATE_IP + ", UPDATE_DATE=" + UPDATE_DATE + "]";
	}

	public int getFILE_NO() {
		return FILE_NO;
	}

	public void setFILE_NO(int fILE_NO) {
		FILE_NO = fILE_NO;
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

	public String getFILE_NM() {
		return FILE_NM;
	}

	public void setFILE_NM(String fILE_NM) {
		FILE_NM = fILE_NM;
	}

	public String getFILE_SAVE_NM() {
		return FILE_SAVE_NM;
	}

	public void setFILE_SAVE_NM(String fILE_SAVE_NM) {
		FILE_SAVE_NM = fILE_SAVE_NM;
	}

	public String getFILE_PATH() {
		return FILE_PATH;
	}

	public void setFILE_PATH(String fILE_PATH) {
		FILE_PATH = fILE_PATH;
	}

	public String getENCLUDE_YN() {
		return ENCLUDE_YN;
	}

	public void setENCLUDE_YN(String eNCLUDE_YN) {
		ENCLUDE_YN = eNCLUDE_YN;
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
