package clubMember;

public class clubMemberVo {
   private int CLUB_ID; 
   private String STUDENT_ID; 
   private String NM; 
   private String MAJOR;
   private String GRADE;
   private String GENDER_CD;
   private String STAFF_CD; //회장,부회장
   private String PHONE_NO;
   private String ADDRESS; 
   private String EMAIL;
   private String join_dt;
   private String BIRTH_DT;
   private String JOIN_CD;
   private String input_id;
   private String input_ip;
   private String input_date;
   private String update_id;
   private String update_ip;
   private String update_date;
   private String plan;
   private String hope;
   private int row_count;
   
   public int getCLUB_ID() {
      return CLUB_ID;
   }
   public void setCLUB_ID(int cLUB_ID) {
      CLUB_ID = cLUB_ID;
   }
   public String getSTUDENT_ID() {
      return STUDENT_ID;
   }
   public void setSTUDENT_ID(String sTUDENT_ID) {
      STUDENT_ID = sTUDENT_ID;
   }
   public String getNM() {
      return NM;
   }
   public void setNM(String nM) {
      NM = nM;
   }
   public String getMAJOR() {
      return MAJOR;
   }
   public void setMAJOR(String mAJOR) {
      MAJOR = mAJOR;
   }
   public String getGRADE() {
      return GRADE;
   }
   public void setGRADE(String gRADE) {
      GRADE = gRADE;
   }
   public String getGENDER_CD() {
      return GENDER_CD;
   }
   public void setGENDER_CD(String gENDER_CD) {
      GENDER_CD = gENDER_CD;
   }
   public String getPHONE_NO() {
      return PHONE_NO;
   }
   public void setPHONE_NO(String pHONE_NO) {
      PHONE_NO = pHONE_NO;
   }
   public String getADDRESS() {
      if (ADDRESS == null)
         ADDRESS ="";
      return ADDRESS;
   }
   public void setADDRESS(String aDDRESS) {
      ADDRESS = aDDRESS;
   }
   public String getEMAIL() {
      if (EMAIL == null)
         EMAIL ="";
      return EMAIL;
   }
   public void setEMAIL(String eMAIL) {
      EMAIL = eMAIL;
   }
   public String getBIRTH_DT() {
      if (BIRTH_DT == null)
         BIRTH_DT ="";
      return BIRTH_DT;
   }
   public void setBIRTH_DT(String bIRTH_DT) {
      BIRTH_DT = bIRTH_DT;
   }
   public String getPlan() {
      if (plan == null)
         plan ="";
      return plan;
   }
   public void setPlan(String plan) {
      this.plan = plan;
   }
   public String getHope() {
      if (hope == null)
         hope ="";
      return hope;
   }
   public void setHope(String hope) {
      this.hope = hope;
   }
   public String getSTAFF_CD() {
/*      if(STAFF_CD == null)
         STAFF_CD = "회원";
      else if(STAFF_CD.equals("004001")) 
         STAFF_CD = "회장";
      else if(STAFF_CD.equals("004002")) 
         STAFF_CD = "부회장";
      else if(STAFF_CD.equals("004003")) 
         STAFF_CD = "총무";
      return STAFF_CD;*/
	   return STAFF_CD;
   }
   public void setSTAFF_CD(String sTAFF_CD) {
      STAFF_CD = sTAFF_CD;   
   }
   public String getJOIN_CD() {
      return JOIN_CD;
   }
   public void setJOIN_CD(String jOIN_CD) {
      JOIN_CD = jOIN_CD;
   }
   public String getJoin_dt() {
      return join_dt;
   }
   public void setJoin_dt(String join_dt) {
      this.join_dt = join_dt;
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
   public int getRow_count() {
      return row_count;
   }
   public void setRow_count(int row_count) {
      this.row_count = row_count;
   }

   
   
                    
}