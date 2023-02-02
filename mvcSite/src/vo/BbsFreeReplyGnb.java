package vo;

public class BbsFreeReplyGnb {
// 특정 댓글에 좋아요/싫어요를 선택한 정보를 저장할 클래스
	private int frg_idx, bfr_idx;
	private String mi_id, frg_gnb, frg_ip, frg_date;
	
	public int getFrg_idx() {
		return frg_idx;
	}
	public void setFrg_idx(int frg_idx) {
		this.frg_idx = frg_idx;
	}
	public int getBfr_idx() {
		return bfr_idx;
	}
	public void setBfr_idx(int bfr_idx) {
		this.bfr_idx = bfr_idx;
	}
	public String getMi_id() {
		return mi_id;
	}
	public void setMi_id(String mi_id) {
		this.mi_id = mi_id;
	}
	public String getFrg_gnb() {
		return frg_gnb;
	}
	public void setFrg_gnb(String frg_gnb) {
		this.frg_gnb = frg_gnb;
	}
	public String getFrg_ip() {
		return frg_ip;
	}
	public void setFrg_ip(String frg_ip) {
		this.frg_ip = frg_ip;
	}
	public String getFrg_date() {
		return frg_date;
	}
	public void setFrg_date(String frg_date) {
		this.frg_date = frg_date;
	}

}
