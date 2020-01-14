package item;

public class itemVo {
	private String ITEM_NM; // 아이탬 명
	private String ITEM_CONT; // 아이탬 설명
	private int TOT_CNT; // 아이탬 총개수

	public itemVo(int TOT_CNT,String ITEM_NM,String ITEM_CONT){
		this.TOT_CNT = TOT_CNT;
		this.ITEM_NM = ITEM_NM;
		this.ITEM_CONT = ITEM_CONT;
	}

	public void setITEM_NM(String iTEM_NM) {
		ITEM_NM = iTEM_NM;
	}

	public void setITEM_CONT(String iTEM_CONT) {
		ITEM_CONT = iTEM_CONT;
	}

	public void setTOT_CNT(int tOT_CNT) {
		TOT_CNT = tOT_CNT;
	}

	public String getITEM_NM() {
		return ITEM_NM;
	}

	public String getITEM_CONT() {
		return ITEM_CONT;
	}

	public int getTOT_CNT() {
		return TOT_CNT;
	}

}
